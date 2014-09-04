# comments_controller.rb

class CommentsController < ApplicationController
  # before_filter :authenticate_user!
  load_and_authorize_resource
  
  def create
    @commentable = Comment.find_commentable(params[:comment][:commentable_type], params[:comment][:commentable_id])
    if @commentable
      @comment = @commentable.comments.build(params[:comment])
      @comment.comment = params[:comment][:comment]
      @comment.user_id = current_user.id;
      authorize! :create, @comment
      
      if @comment.save
        redirect_to show_page_url, :notice => "Thanks for the comment."
      else
        flash.now[:alert] = "You had some errors for your comment."  # edited 10/28/10 use 'flash.now' instead of 'flash'
        render_error_page
      end
    else
      redirect_to root_url, :alert => "You can't do that."
    end
  end
  
  private
  
  def show_page_url
    case @commentable.class.name
    when "Post" then post_url(@commentable)
    else @commentable
    end
  end
  
  def render_error_page
    model_name = @commentable.class.name
    instance_variable_set("@#{model_name.downcase}", @commentable)
    render "#{model_name.underscore.downcase.pluralize}/show"
  end
end