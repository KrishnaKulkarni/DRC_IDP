class GoldStandardIdentity < ActiveRecord::Base
  require 'csv'
  require 'fileutils'

  attr_reader :date_of_birth, :age, :head_of_household_status, :alternate_village_status

  belongs_to :household, inverse_of: :gold_standard_identities
  has_many :gold_standard_matches, inverse_of: :gold_standard_identity
  belongs_to :village, inverse_of: :gold_standard_identities
  has_one :group, through: :village, source: :group
  has_one :collective, through: :group, source: :collective
  has_one :territory, through: :collective, source: :territory
  has_one :province, through: :territory, source: :province

  # Toggle true/false to turn off/on the validation
  validates_presence_of :first_name, :last_name, :sex, :household_size,
            :arrival_from_village, :province_id, :territory_id, :village_of_origin, message: "rempliseez cette case", if: "true"
  # BUG**: validates_presence_of :date_of_birth, message: "rempliseez cette case", if: "true"
  # BUG**: validates :alternate_village, presence: true, if: "alternate_village_status"
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

  attr_accessor :alternate_village_status
  attr_accessor :head_of_household_status

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
end
