class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = current_user.albums
  end

  def show
    @photos = @album.photos
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notice] = "Album '#{@album.title}' has been successfully created"
    else
      flash[:alert] = "Ooops, something went wrong, album has not been saved. Repeat with other options"
    end
    redirect_to albums_path
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

  def album_params
    album = params.require(:album).permit(:title)
    album.merge(user_id: current_user.id)
  end
end
