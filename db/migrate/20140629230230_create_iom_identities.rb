class CreateIomIdentities < ActiveRecord::Migration
  def change
    create_table :iom_identities do |t|
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
        
    add_index :iom_identities, :household_id
    add_index :iom_identities, :first_name
    add_index :iom_identities, :last_name
  end
end
