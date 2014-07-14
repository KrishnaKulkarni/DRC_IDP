class AddHeadHouseholdAlternateName < ActiveRecord::Migration
  def change
  	add_column :iom_identities, :head_of_household_alternate_name, :string
  	add_column :gold_standard_identities, :head_of_household_alternate_name, :string
  end
end
