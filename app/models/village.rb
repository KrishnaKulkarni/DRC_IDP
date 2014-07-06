class Village < ActiveRecord::Base
  belongs_to :group
  has_many :gold_standard_identities, inverse_of: :village
end
