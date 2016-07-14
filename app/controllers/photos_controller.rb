class PhotosController < ApplicationController
  before_action :set_album, only: [:show]
  before_action :set_photo, only: [:show]

  def index
    @photos = current_user.photos
  end

  def show
  end

  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_photo
    @photo = @album.photos.find(params[:id])
  end
end
