class Group < ActiveRecord::Base
  default_scope { order(:name) }

  belongs_to :collective
  has_many :villages
  has_many :gold_standard_identities, through: :villages, source: :gold_standard_identities
end
