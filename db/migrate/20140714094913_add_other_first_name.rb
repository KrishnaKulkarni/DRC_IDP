class AddOtherFirstName < ActiveRecord::Migration
  def change
  	add_column :iom_identities, :other_first_name, :string
  	add_column :gold_standard_identities, :other_first_name, :string
  end
end
