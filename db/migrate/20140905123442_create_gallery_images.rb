class CreateGalleryImages < ActiveRecord::Migration
  def self.up
    create_table :gallery_images do |t|
      t.string :title
      t.references :post

      t.timestamps
    end
    add_index :gallery_images, :post_id
  end
  
  def self.down
    drop_table :gallery_images
  end
end
