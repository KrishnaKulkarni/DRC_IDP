class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :username
      t.string    :computer
      t.timestamps
    end
    
    add_index :users, :username, unique: true
    add_index :users, :computer, unique: true
  end
end
