class AddHeadOfHouseholdTwo < ActiveRecord::Migration
  def change
  	add_column :iom_identities, :head_of_household_two_first_name, :string
  	add_column :gold_standard_identities, :head_of_household_two_first_name, :string

  	add_column :iom_identities, :head_of_household_two_last_name, :string
  	add_column :gold_standard_identities, :head_of_household_two_last_name, :string

  	add_column :iom_identities, :head_of_household_two_alternate_name, :string
  	add_column :gold_standard_identities, :head_of_household_two_alternate_name, :string

  	add_column :iom_identities, :relation_to_head_of_household_two, :string
  	add_column :gold_standard_identities, :relation_to_head_of_household_two, :string
  end
end
