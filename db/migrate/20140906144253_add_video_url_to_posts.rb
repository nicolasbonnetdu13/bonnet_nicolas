class AddVideoUrlToPosts < ActiveRecord::Migration
  
  def self.up
    add_column :posts, :video_url, :string
  end
  
  def self.down
    remove_column :posts, :video_url
  end
end
