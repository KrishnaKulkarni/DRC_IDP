class ChangeIdentityCardToInt < ActiveRecord::Migration
  def change
  	remove_column :iom_identities, :identity_card
    remove_column :gold_standard_identities, :identity_card

  	add_column :iom_identities, :identity_card, :string
    add_column :gold_standard_identities, :identity_card, :string
  end
end
