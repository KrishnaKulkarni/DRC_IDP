class IomIdentity < ActiveRecord::Base
  
  # belongs_to(
  # :household,
  # class_name: 'Household',
  # foreign_key: :household_id,
  # primary_key: :id
  # )
  
  # Because we named the foreign key 'household_id', Rails is smart enough to know how to fill in the rest of the configuration to map this IOMIdentity to a Household
  has_many :gold_standard_matches, inverse_of: :iom_identity
  belongs_to :household, inverse_of: :iom_identities
  belongs_to :village, inverse_of: :iom_identities
  has_one :group, through: :village, source: :group
  has_one :collective, through: :group, source: :collective
  has_one :territory, through: :collective, source: :territory
  has_one :province, through: :territory, source: :province
  
  attr_accessor :alternate_village_status
  
end
