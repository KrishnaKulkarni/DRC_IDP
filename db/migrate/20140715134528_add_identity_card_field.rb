class AddIdentityCardField < ActiveRecord::Migration
  def change
  	add_column :iom_identities, :identity_card, :integer
    add_column :gold_standard_identities, :identity_card, :integer
  end
end
