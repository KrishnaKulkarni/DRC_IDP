class AddHouseholdAndArrivalFieldsToIdentities < ActiveRecord::Migration
  def change
    add_column :iom_identities, :head_of_household_first_name, :string
    add_column :gold_standard_identities, :head_of_household_first_name, :string
    
    add_column :iom_identities, :head_of_household_last_name, :string
    add_column :gold_standard_identities, :head_of_household_last_name, :string

    add_column :iom_identities, :relation_to_head_of_household, :string
    add_column :gold_standard_identities, :relation_to_head_of_household, :string
    
    add_column :iom_identities, :household_size, :integer
    add_column :gold_standard_identities, :household_size, :integer
    
    add_column :iom_identities, :arrival_date, :date
    add_column :gold_standard_identities, :arrival_date, :date
    
    add_column :iom_identities, :arrival_from_village, :string
    add_column :gold_standard_identities, :arrival_from_village, :string
  end
end
