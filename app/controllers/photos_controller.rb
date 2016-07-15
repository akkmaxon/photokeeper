class PhotosController < ApplicationController
  before_action :set_album, only: [:show]
  before_action :set_photo, only: [:show]

  def index
    @photos = current_user.photos
  end

  def show
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:notice] = "Photo #{@photo.title} has been successfully uploaded"
    else
      flash[:alert] = "Ooops, something went wrong, photo has not been saved. Repeat with other options"
    end
    redirect_to album_photo_path(@photo.album.id, @photo.id)
  end

  def edit
    #from album
  end

  def update
  end

  def destroy
    #from album and from index
  end

  private

  def photo_params
    photo = params.require(:photo).permit(:title, :caption)
    photo.merge(album_id: params[:album_id], user_id: current_user.id)
  end

  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_photo
    @photo = @album.photos.find(params[:id])
  end
end
