class AddAltVillagesToIdentities < ActiveRecord::Migration
  def change
    add_column :iom_identities, :alternate_village, :string
    add_column :gold_standard_identities, :alternate_village, :string
    add_column :iom_identities, :village_of_origin, :string
    add_column :gold_standard_identities, :village_of_origin, :string
  end
end
