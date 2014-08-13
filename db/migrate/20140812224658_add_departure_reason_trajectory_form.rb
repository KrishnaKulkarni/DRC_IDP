class AddDepartureReasonTrajectoryForm < ActiveRecord::Migration
  def change
  	add_column :idp_trajectories, :departure_reason_id, :integer
  end
end
