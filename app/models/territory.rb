class Territory < ActiveRecord::Base
  belongs_to :province
  has_many :collectives
  has_many :groups, through: :collectives, source: :collective
  has_many :villages, through: :groups, source: :villages
  has_many :gold_standard_identities, through: :villages, source: :gold_standard_identities
  

end
