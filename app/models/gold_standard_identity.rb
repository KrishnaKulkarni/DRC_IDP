class GoldStandardIdentity < ActiveRecord::Base
  belongs_to :household, inverse_of: :gold_standard_identities
  has_many :gold_standard_matches, inverse_of: :gold_standard_identity
end
