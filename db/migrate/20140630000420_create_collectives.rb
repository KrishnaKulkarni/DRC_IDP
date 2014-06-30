class CreateCollectives < ActiveRecord::Migration
  def change
    create_table :collectives do |t|
      t.integer   :territory_id
      t.string    :code
      t.string    :name
      
      t.timestamps
    end
  end
end
