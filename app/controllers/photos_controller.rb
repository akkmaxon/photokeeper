class PhotosController < ApplicationController
  before_action :set_album
  before_action :set_photo, only: [:show, :update, :destroy]

  def index
    @photos = @album.photos
  end

  def show
    @comments = @photo.comments
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:notice] = "Photo #{@photo.title} has been successfully uploaded"
    else
      flash[:alert] = "Ooops, something went wrong, photo has not been saved. Repeat with other options"
    end
    redirect_to album_photo_path(@username, @photo.album, @photo)
  end

  def update
    if @photo.update(photo_params)
      flash[:notice] = "Photo #{@photo.title} has been successfully updated"
    else
      flash[:alert] = "Ooops, something went wrong, photo has not been saved. Repeat with other options"
    end
    redirect_to album_photo_path(@username, @photo.album, @photo)
  end

  def destroy
    if @photo.destroy
      flash[:notice] = "Photo '#{@photo.title}' was deleted"
    else
      flash[:alert] = "Photo was not deleted. Errors: #{@photo.errors.full_messages}"
    end
    redirect_to album_path(@username, @photo.album)
  end

  private

  def photo_params
    photo = params.require(:photo).permit(:title, :caption, :source)
    photo.merge(album_id: params[:album_id], user_id: current_user.id)
  end

  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_photo
    @photo = @album.photos.find(params[:id])
  end
end
