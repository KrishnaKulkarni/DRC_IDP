class CreateTerritories < ActiveRecord::Migration
  def change
    create_table :territories do |t|
      t.integer   :province_id
      t.string    :code
      t.string    :name
      
      t.timestamps
    end
  end
end
