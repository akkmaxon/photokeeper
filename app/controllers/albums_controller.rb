class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = current_user.albums
  end

  def show
    @photos = @album.photos
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end
end
