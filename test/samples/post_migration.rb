class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :null => false, :default => 'Untitled', :limit => 255
      t.text :body, :null => true, :default => ''
      t.integer :user_id, :null => false, :default => 0

      t.timestamps
    end

    add_index :posts, :user_id
  end

  def self.down
    remove_index :posts, :user_id
    drop_table :posts
  end
end