class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name, :null => false, :default => '', :limit => 255
      t.string :last_name, :null => false, :default => '', :limit => 255
      t.string :email, :null => false, :default => '', :limit => 255

      t.timestamps
    end

  end

  def self.down
    drop_table :users
  end
end