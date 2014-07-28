class AddTrajectorySites < ActiveRecord::Migration
  def change
  	add_column :idp_trajectories, :site_id, :string
  end
end
