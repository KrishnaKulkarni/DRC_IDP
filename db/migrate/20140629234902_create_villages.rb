class CreateVillages < ActiveRecord::Migration
  def change
    create_table :villages do |t|
      t.integer   :province_id
      t.string    :code
      t.string    :name
      
      t.timestamps
    end
  end
end
