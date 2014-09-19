class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  def like
    if params[:likeable_type] == "Post"
        @likeable = Post.find(params[:likeable_id])
    else
        @likeable = Comment.find(params[:likeable_id])
    end
    current_user.like!(@likeable)
  end
  
  def unlike
    if params[:likeable_type] == "Post"
        @likeable = Post.find(params[:likeable_id])
    else
        @likeable = Comment.find(params[:likeable_id])
    end
    current_user.unlike!(@likeable)
  end
  
end
