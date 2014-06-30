class RenameProvinceIdToGroupId < ActiveRecord::Migration
  def change
    rename_column :villages, :province_id, :group_id
  end
end
