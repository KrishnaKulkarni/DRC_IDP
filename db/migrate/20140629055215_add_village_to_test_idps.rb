class AddVillageToTestIdps < ActiveRecord::Migration
  def change
    add_column :test_idps, :village, :string
  end
end
