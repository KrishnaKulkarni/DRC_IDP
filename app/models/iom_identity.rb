class IomIdentity < ActiveRecord::Base
  
  # belongs_to(
  # :household,
  # class_name: 'Household',
  # foreign_key: :household_id,
  # primary_key: :id
  # )
  
  # Because we named the foreign key 'household_id', Rails is smart enough to know how to fill in the rest of the configuration to map this IOMIdentity to a Household
  belongs_to :household, inverse_of: :iom_identities
  has_many :gold_standard_matches, inverse_of: :iom_identity
  
end
