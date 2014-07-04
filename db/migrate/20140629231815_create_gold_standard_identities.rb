class CreateGoldStandardIdentities < ActiveRecord::Migration
  def change
    create_table :gold_standard_identities do |t|
      t.integer   :household_id
      t.string    :first_name
      t.string    :last_name
      t.string    :alternate_name
      t.string    :sex
      t.date      :date_of_birth
      t.integer   :village_id
      t.integer   :group_id
      t.integer   :collective_id
      t.integer   :territory_id
      t.integer   :province_id
      
      t.timestamps
    end
    
    add_index :gold_standard_identities, :household_id
    add_index :gold_standard_identities, :first_name
    add_index :gold_standard_identities, :last_name
  end
end
