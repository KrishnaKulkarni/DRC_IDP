class GoldStandardIdentity < ActiveRecord::Base
  belongs_to :household, inverse_of: :gold_standard_identities
  has_many :gold_standard_matches, inverse_of: :gold_standard_identity
  belongs_to :village, inverse_of: :gold_standard_identities
  
  #Alter implementation appropriately later
  def iom_identity_matches
    IomIdentity.all.select { |iom_identity| match_score(iom_identity) >= 3.5 }
  end
  
  private
  def match_score(iom_identity)
    3.5
  end
end
