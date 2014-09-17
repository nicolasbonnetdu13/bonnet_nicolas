class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    if @post.nil?
      redirect_to action: :index
    end
    if @post.post_type == "crew"
      if current_user.is? :normal or current_user.is? :banned or current_user.is? :guest 
        redirect_to action: :index
      end 
    end
    @comment = @post.comments.build
    @post.comments.pop
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    authorize! :edit, @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    authorize! :create, @post
    
    if ( post_params[:post_type] == "video" )
      query_string = URI.parse(post_params[:video_url]).query
      parameters = Hash[URI.decode_www_form(query_string)]
      @post.video_url = parameters['v'] # => aNdMiIAlK0g
      if ( @post.video_url.nil? )
        respond_to do |format|
          format.html { render action: 'new' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
    

    respond_to do |format|
      if @post.save
        if params[:gallery_images]
          #===== The magic is here ;)
          params[:gallery_images].each { |image|
            @post.gallery_images.create(image: image, post_id: params[:id])
          }
        end
        
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    
    authorize! :update, @post
    
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authorize! :destroy, @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
      params.require(:post).permit( :title, :description, :image, :post_type, :tag_list, :gallery_images, :video_url )
  end

  def index
    authorize! :index, Post
    if current_user.is? :admin or current_user.is? :crew 
      @posts = Post.all
    else 
      @posts = Post.where.not(["post_type = ?", "crew"])
    end
    respond_to do |format|
      format.xml {
        @posts = @posts.order('created_at DESC')
      }
      format.html {
        @posts = @posts.for_index(params[:page])
      }
      format.rss {
        @posts = @posts.order('created_at DESC')
      }
    end
  end

  def tagged
    if params[:tag].present? 
      @posts = Post.for_index(params[:page]).tagged_with(params[:tag])
      @tag = params[:tag]
    else 
      @posts = Post.for_index(params[:page]).postall
    end  
    render :index
  end
  
end
