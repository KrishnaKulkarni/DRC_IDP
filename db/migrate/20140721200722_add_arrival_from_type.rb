class AddArrivalFromType < ActiveRecord::Migration
  def change
  	add_column :iom_identities, :arrival_from_type, :string
    add_column :gold_standard_identities, :arrival_from_type, :string
  end
end
