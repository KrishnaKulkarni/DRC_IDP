class Collective < ActiveRecord::Base
  default_scope { order(:name) }

  belongs_to :territory
  has_many :groups
  has_many :villages, through: :groups, source: :villages
  has_many :gold_standard_identities, through: :villages, source: :gold_standard_identities

end
