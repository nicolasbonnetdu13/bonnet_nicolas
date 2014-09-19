class Comment < ActiveRecord::Base

  acts_as_likeable
  
  default_scope :order => 'created_at ASC'
  scope :in_order, order('created_at ASC')
  scope :recent, order('created_at DESC')

  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  
  validates :comment, :presence => true

  def self.find_comments_by_user(user)
    where(["user_id = ?", user.id]).order("created_at DESC")
  end

  def self.find_comments_for_commentable(commentable_str, commentable_id)
    where(["commentable_type = ? and commentable_id = ?", commentable_str, commentable_id]).order("created_at DESC")
  end

  def self.find_commentable(commentable_str, commentable_id)
    model = commentable_str.constantize
    model.ancestors.include?(Juixe::Acts::Commentable) ? model.find(commentable_id) : nil
  end
  
end
