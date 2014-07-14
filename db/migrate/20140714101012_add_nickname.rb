class AddNickname < ActiveRecord::Migration
  def change
  	add_column :iom_identities, :nick_name, :string
  	add_column :gold_standard_identities, :nick_name, :string
  end
end
