class Post < ActiveRecord::Base
  
  include Juixe::Acts::Commentable
  
    acts_as_taggable
    acts_as_commentable
 # mount_uploader :image,:image_uploader
 
    self.paginates_per 10
 
  belongs_to :user
 # ==============x
  # = Attributes =
  # ==============
  
  attr_accessible :title, :description, :tag_list, :post_type, :created_at, :comments, :user_id, :image
  
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/gif", "image/png"] }
  validates :image, :presence => { :message => ": It is required for this kind of post" }, if: :is_not_image?
  
  def is_not_image?
     (:post_type != 'image')
  end
  
  def short_body
    truncate(body, length: 400, separator: "\n")
  end

  # ===============
  # = Validations =
  # ===============

  validates :title, presence: true, length: { minimum: 3, maximum: 66 }
  validates :description, presence: true, length: { minimum: 10 }

  validates :post_type, presence:true, format: {
    with: %r{\A(standard|image|video|status|quote|link)\Z},
    # with: %r{\A(standard|image|video|status|quote|link|gallery|aside|audio)\Z},
    message: 'must me a type from the list'
  }

    # =================
    # = Assosciations =
    # =================

    # ==========
    # = Scopes =
    # ==========

    # Returns the blog posts paginated for the index page
    # @scope class

    scope :for_index, lambda { |page_no = 1| order("created_at DESC").page(page_no) }
    
    has_many :comments, :as => :commentable, :dependent => :destroy
  
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
