class CreateDepartureReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string    :departure_reason
      
      t.timestamps
    end
  end
end
