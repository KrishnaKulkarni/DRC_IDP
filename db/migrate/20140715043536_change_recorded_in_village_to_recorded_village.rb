class ChangeRecordedInVillageToRecordedVillage < ActiveRecord::Migration
  def change
    remove_column :gold_standard_identities, :recorded_in_village_id
    add_column :gold_standard_identities, :recorded_in_village, :string
  end
end
