class ChangeTrajectoryArriveDepart < ActiveRecord::Migration
  def change
  	remove_column :idp_trajectories, :arrival_date

    add_column :idp_trajectories, :departure_date, :date
  end
end