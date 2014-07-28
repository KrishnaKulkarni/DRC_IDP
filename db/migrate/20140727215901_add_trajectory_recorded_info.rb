class AddTrajectoryRecordedInfo < ActiveRecord::Migration
  def change
  	add_column :idp_trajectories, :recorded_by, :string
  	add_column :idp_trajectories, :recorded_in_village, :string
  end
end
