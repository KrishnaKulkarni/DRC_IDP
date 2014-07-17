class Province < ActiveRecord::Base
  default_scope { order(:name) }

  has_many :territories
  has_many :collectives, through: :territories, source: :collectives
  has_many :groups, through: :collectives, source: :groups
  has_many :villages, through: :groups, source: :villages
  has_many :gold_standard_identities, through: :villages, source: :gold_standard_identities
end
