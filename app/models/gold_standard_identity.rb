class GoldStandardIdentity < ActiveRecord::Base
  require 'csv'
  require 'fileutils'
  belongs_to :household, inverse_of: :gold_standard_identities
  has_many :gold_standard_matches, inverse_of: :gold_standard_identity
  belongs_to :village, inverse_of: :gold_standard_identities
  has_one :group, through: :village, source: :group
  has_one :collective, through: :group, source: :collective
  has_one :territory, through: :collective, source: :territory
  has_one :province, through: :territory, source: :province
  
  # Toggle true/false to turn off/on the validation
  validates :first_name, :last_name, :sex, presence: true, if: "true"
  validates_format_of :first_name, :last_name, with: /[a-z]/, message: "lettres uniquement"
  validates_format_of :alternate_name, with: /[a-z]/, message: "lettres uniquement", if: 'alternate_name.present?'
  attr_accessor :alternate_village_status
  
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
