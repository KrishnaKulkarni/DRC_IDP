class AddIomIdentityCard < ActiveRecord::Migration
  def change
  	add_column :iom_identities, :iom_identity_card, :string
    add_column :gold_standard_identities, :iom_identity_card, :string
  end
end
