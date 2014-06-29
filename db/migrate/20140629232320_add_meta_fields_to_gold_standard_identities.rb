class AddMetaFieldsToGoldStandardIdentities < ActiveRecord::Migration
  def change
    add_column :gold_standard_identities, :recorded_in_village_id, :integer
    add_column :gold_standard_identities, :recorded_by, :string        
  end
end
