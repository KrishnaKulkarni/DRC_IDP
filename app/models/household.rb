class Household < ActiveRecord::Base

  has_many :iom_identities, inverse_of: :household
  has_many :gold_standard_identities, inverse_of: :household

end
