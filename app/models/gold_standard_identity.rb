class GoldStandardIdentity < ActiveRecord::Base
  require 'csv'
  require 'fileutils'

  after_initialize :synch_dob_components_to_dob

  attr_reader :age
  attr_accessor :alternate_village_status
  attr_accessor :head_of_household_status

  belongs_to :household, inverse_of: :gold_standard_identities
  has_many :gold_standard_matches, inverse_of: :gold_standard_identity
  belongs_to :village, inverse_of: :gold_standard_identities
  has_one :group, through: :village, source: :group
  has_one :collective, through: :group, source: :collective
  has_one :territory, through: :collective, source: :territory
  has_one :province, through: :territory, source: :province
  has_many :idp_trajectories

  # Toggle true/false to turn off/on the validation
  validates_presence_of :first_name, :last_name, :sex, :household_size,
                   :province_id, :territory_id, :village_of_origin, message: "rempliseez cette case", if: "true"
  # Still haven't solved this bug
  # validates_presence_of :date_of_birth, message: "rempliseez cette case", unless: "true"
  validates_presence_of :year_of_birth, message: "rempliseez cette case"

  validates_presence_of :alternate_village, presence: true, message: "rempliseez cette case", if: "alternate_village_status =='1'"
  validates_presence_of :village_id, message: "rempliseez cette case", if: "alternate_village_status!='1'"
  validates_presence_of :head_of_household_first_name, :head_of_household_last_name,
            :relation_to_head_of_household, message: "rempliseez cette case", if: "head_of_household_status!='1'"

  validates_format_of :first_name, :last_name, :head_of_household_first_name,
            :head_of_household_last_name, with: /\A[a-zA-Z'\s]*\z/, message: "lettres uniquement"

  validates_format_of :alternate_name, with: /\A[a-zA-Z'\s]*\z/, message: "lettres uniquement", if: 'alternate_name.present?'
  validates_format_of :nick_name, with: /\A[a-zA-Z'\s]*\z/, message: "lettres uniquement", if: 'nick_name.present?'
  validates_format_of :other_first_name, with: /\A[a-zA-Z'\s]*\z/, message: "lettres uniquement", if: 'other_first_name.present?'
  validates_format_of :other_last_name, with: /\A[a-zA-Z'\s]*\z/, message: "lettres uniquement", if: 'other_last_name.present?'
  validates_format_of :other_alternate_name, with: /\A[a-zA-Z'\s]*\z/, message: "lettres uniquement", if: 'other_alternate_name.present?'
  validates_format_of :head_of_household_alternate_name, with: /\A[a-zA-Z'\s]*\z/, message: "lettres uniquement", if: 'head_of_household_alternate_name.present?'

  validates_numericality_of :identity_card, message: "chiffres uniquement", if: 'identity_card.present?'
  validates_numericality_of :iom_identity_card, message: "chiffres uniquement", if: 'iom_identity_card.present?'

  before_save :sanitize_all_blank_attributes
  before_save :synch_dob_to_dob_components

  #Alter implementation appropriately later
  def iom_identity_matches
    IomIdentity.all.select { |iom_identity| match_score(iom_identity) >= 3.5 }
  end

  def self.as_csv
    CSV.generate do |csv|
        csv << column_names
        all.each do |item|
          csv << item.attributes.values_at(*column_names)
        end
    end
  end

  def self.import_local_csv_imports!
    failed_csvs = []
    Dir.entries("imports").select { |filename| /^(.)+.csv$/ =~ filename }.each do |csv_filename|
      file = File.open("imports/#{csv_filename}")
      succeeded = GoldStandardIdentity.import!(file)
      failed_csvs << csv_file unless succeeded
      file.close

      FileUtils.mv("imports/#{csv_filename}", "imported/#{csv_filename}") if succeeded
    end

    failed_csvs
  end

  def self.import!(file)
    succeeded = true
    GoldStandardIdentity.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        identity_hash = row.to_hash
        identity_hash.delete('id')
        unless GoldStandardIdentity.create(identity_hash)
          succeeded = false
          raise "Importing error"
        end
      end # end CSV.foreach
    end

    succeeded
  end # end self.import(file)

  private
  def match_score(iom_identity)
    3.5
  end

  def sanitize_all_blank_attributes
    self.class.column_names.each do |attribute_name|
      attribute_reader_symbol = attribute_name.to_sym
      attribute_writer_symbol = "#{attribute_name}=".to_sym

      self.send(attribute_writer_symbol, nil)  if self.send(attribute_reader_symbol).blank?
    end
  end

  def synch_dob_components_to_dob
    if date_of_birth.present?
      self.year_of_birth =  date_of_birth.year
      self.month_of_birth =  date_of_birth.month
      self.day_of_birth =  date_of_birth.day
    end
  end

  def synch_dob_to_dob_components
    if year_of_birth.present? && month_of_birth.present? && day_of_birth.present?
      self.date_of_birth = Date.new(year_of_birth, month_of_birth, day_of_birth)
    end
  end
end
