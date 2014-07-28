class AddTrajectoryGeoIds < ActiveRecord::Migration
  def change
	remove_column :idp_trajectories, :village_id

  	add_column :idp_trajectories, :village_id, :integer
  	add_column :idp_trajectories, :group_id, :integer
  	add_column :idp_trajectories, :collective_id, :integer
  	add_column :idp_trajectories, :territory_id, :integer
  	add_column :idp_trajectories, :province_id, :integer

  	add_column :idp_trajectories, :alternate_village, :string

  	add_column :idp_trajectories, :stop_type, :string
  end
end