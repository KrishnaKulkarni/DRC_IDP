class GoldStandardMatch < ActiveRecord::Base
  belongs_to :iom_identity, inverse_of: :gold_standard_matches
  belongs_to :gold_standard_identity, inverse_of: :gold_standard_matches
end
