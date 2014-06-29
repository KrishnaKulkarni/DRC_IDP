class CreateGoldStandardMatches < ActiveRecord::Migration
  def change
    create_table :gold_standard_matches do |t|
      t.integer     :gold_standard_identity_id
      t.integer     :iom_identity_id
      
      t.timestamps
    end
    
    add_index :gold_standard_matches, :gold_standard_identity_id
    add_index :gold_standard_matches, :iom_identity_id    
    
  end
end
