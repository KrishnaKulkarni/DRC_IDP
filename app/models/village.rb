class Village < ActiveRecord::Base
  has_many :gold_standard_identities, inverse_of: :village
end
