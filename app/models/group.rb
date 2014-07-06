class Group < ActiveRecord::Base
  belongs_to :collective
  has_many :villages
  has_many :gold_standard_identities, through: :villages, source: :gold_standard_identities
end
