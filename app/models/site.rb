class Site < ActiveRecord::Base
  default_scope { order(:name) }

  has_many :gold_standard_identities, through: :villages, source: :gold_standard_identities
end