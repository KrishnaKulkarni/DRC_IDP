class AddOtherNameFields < ActiveRecord::Migration
  def change
  	add_column :iom_identities, :other_last_name, :string
  	add_column :gold_standard_identities, :other_last_name, :string

  	add_column :iom_identities, :other_alternate_name, :string
  	add_column :gold_standard_identities, :other_alternate_name, :string
  end
end
