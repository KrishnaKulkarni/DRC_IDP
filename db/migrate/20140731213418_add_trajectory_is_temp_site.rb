class AddTrajectoryIsTempSite < ActiveRecord::Migration
  def change
  	add_column :idp_trajectories, :is_temporary_site, :string
  end
end
