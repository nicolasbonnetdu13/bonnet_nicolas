class Post < ActiveRecord::Base

  include Juixe::Acts::Commentable

  acts_as_taggable
  acts_as_commentable
  acts_as_likeable
  # mount_uploader :image,:image_uploader

  self.paginates_per 10

  belongs_to :user
  # ==============x
  # = Attributes =
  # ==============

  attr_accessible :title, :description, :tag_list, :post_type, :created_at, :comments, :user_id, :image, :gallery_images, :video_url

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] }
  validates :image, :presence => { :message => ": It is required for this kind of post" }, if: :is_image?

  validates :title, presence: true, length: { minimum: 3, maximum: 66 }
  validates :description, presence: true, length: { minimum: 10, maximum: 10000 }

  validates :post_type, presence:true, format: {
    with: %r{\A(standard|image|video|status|quote|link|gallery|crew)\Z},
    # with: %r{\A(standard|image|video|status|quote|link|gallery|aside|audio)\Z},
    message: 'must me a type from the list'
  }

  scope :for_index, lambda { |page_no = 1| order("created_at DESC").page(page_no) }

  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :gallery_images, :dependent => :destroy

  validates :gallery_images, :presence => { :message => ": It is required for this kind of post" }, if: :is_gallery?

  validates :video_url, :presence => { :message => ": It is required for this kind of post" }, if: :is_video?
  def is_video?
    (self.post_type == 'video')
  end

  def is_gallery?
    (self.post_type == 'gallery')
  end

  def is_image?
    (self.post_type == 'image')
  end

  def short_body
    truncate(body, length: 400, separator: "\n")
  end

  # ===============
  # = Validations =
  # ===============

  # =================
  # = Assosciations =
  # =================

  # ==========
  # = Scopes =
  # ==========

  # Returns the blog posts paginated for the index page
  # @scope class
  def comments_ordered_by_submitted
    Comment.find_comments_for_commentable(self.class.name, id)
  end

  def add_comment(comment)
    comments << comment
  end

  def self.find_comments_for(obj)
    Comment.find_comments_for_commentable(self.to_s, obj.id)
  end

  def self.find_comments_by_user(user)
    Comment.where(["user_id = ? and commentable_type = ?", user.id, self.to_s]).order("created_at DESC")
  end

end
