class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer   :collective_id
      t.string    :code
      t.string    :name

      t.timestamps
    end
  end
end
