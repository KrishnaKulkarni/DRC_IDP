class AddTrajectoryArrivalType < ActiveRecord::Migration
  def change
  	add_column :idp_trajectories, :arrival_from_type, :string
  end
end
