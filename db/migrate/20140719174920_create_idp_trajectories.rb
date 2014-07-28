class CreateIdpTrajectories < ActiveRecord::Migration
  def change
    create_table :idp_trajectories do |t|
      t.integer     :gold_standard_identity_id
      t.integer     :stop_number
      t.date		:arrival_date
      t.string		:village_id
      t.string		:mode_of_transport
      
      t.timestamps
    end
    
    add_index :idp_trajectories, :gold_standard_identity_id  
    
  end
end
