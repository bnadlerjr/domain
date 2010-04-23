class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :email, :null => false, :default => 'anonymous', :limit => 255
      t.text :body, :null => false, :default => ''
      t.integer :post_id, :null => false, :default => 0

      t.timestamps
    end

    add_index :comments, :post_id
  end

  def self.down
    remove_index :comments, :post_id
    drop_table :comments
  end
end