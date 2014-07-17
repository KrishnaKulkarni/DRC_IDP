class Village < ActiveRecord::Base
  default_scope { order(:name) }

  belongs_to :group
  has_many :gold_standard_identities, inverse_of: :village
end
