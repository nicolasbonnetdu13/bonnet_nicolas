class GalleryImagesController < ApplicationController
  before_action :set_gallery_image, only: [:show, :edit, :update, :destroy]

  # GET /gallery_images
  # GET /gallery_images.json
  def index
    @gallery_images = GalleryImage.all
  end

  # GET /gallery_images/1
  # GET /gallery_images/1.json
  def show
  end

  # GET /gallery_images/new
  def new
    @gallery_image = GalleryImage.new
  end

  # GET /gallery_images/1/edit
  def edit
  end

  # POST /gallery_images
  # POST /gallery_images.json
  def create
    @gallery_image = GalleryImage.new(gallery_image_params)

    respond_to do |format|
      if @gallery_image.save
        format.html { redirect_to @gallery_image, notice: 'Gallery image was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gallery_image }
      else
        format.html { render action: 'new' }
        format.json { render json: @gallery_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gallery_images/1
  # PATCH/PUT /gallery_images/1.json
  def update
    respond_to do |format|
      if @gallery_image.update(gallery_image_params)
        format.html { redirect_to @gallery_image, notice: 'Gallery image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gallery_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gallery_images/1
  # DELETE /gallery_images/1.json
  def destroy
    @gallery_image.destroy
    respond_to do |format|
      format.html { redirect_to gallery_images_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery_image
      @gallery_image = GalleryImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_image_params
      params.require(:gallery_image).permit(:title, :image, :post_id)
    end
end
