class GalleryImage < ActiveRecord::Base
  
  belongs_to :post
  
  attr_accessible :title, :post_id, :image
  
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] }
  
end
