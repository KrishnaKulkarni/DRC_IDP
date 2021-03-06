class GoldStandardMatch < ActiveRecord::Base
  belongs_to :iom_identity, inverse_of: :gold_standard_matches
  belongs_to :gold_standard_identity, inverse_of: :gold_standard_matches

  validates_presence_of :iom_identity, :gold_standard_identity

  def self.match_exists?(gold_id, iom_id)
  	GoldStandardMatch.any? do |gsm|
  	 (gsm.gold_standard_identity_id == gold_id) && (gsm.iom_identity_id == iom_id)
  	end
  end

  def self.as_csv
    CSV.generate do |csv|
        csv << column_names
        all.each do |item|
          csv << item.attributes.values_at(*column_names)
        end
    end
  end
end
