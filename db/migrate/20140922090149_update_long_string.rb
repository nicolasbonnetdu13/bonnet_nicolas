class UpdateLongString < ActiveRecord::Migration
  
  def self.up
    change_column :posts, :description, :text, :limit => 10000
    change_column :comments, :comment, :text, :limit => 10000
  end
  def self.down
    change_column :posts, :description, :text, :limit => 255
    change_column :comments, :comment, :text, :limit => 255
  end
end
