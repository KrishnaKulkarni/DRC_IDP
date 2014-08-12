class CreateDepartureReasons < ActiveRecord::Migration
  def change
    create_table :departure_reasons do |t|
      t.string    :departure_reason
      
      t.timestamps
    end
  end
end
