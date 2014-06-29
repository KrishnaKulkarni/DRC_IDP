class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.timestamps
    end
  end
end
