class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]
  before_action :set_username

  def index
    @albums = find_user.albums
  end

  def show
    redirect_to album_photos_url(@username, @album)
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notice] = "Album '#{@album.title}' has been successfully created"
    else
      flash[:alert] = "Ooops, something went wrong, album has not been saved. Repeat with other options"
    end
    redirect_to album_url(@username, @album)
  end

  def update
    if @album.update(album_params)
      flash[:notice] = "The album has been successfully updated"
    else
      flash[:alert] = "Ooops, something went wrong, album has not been saved. Repeat with other options"
    end
    redirect_to album_url(@username, @album)
  end

  def destroy
    photos_count = @album.photos.count
    if @album.destroy
      flash[:notice] = "Album '#{@album.title}' with #{photos_count} photos was deleted"
    else
      flash[:alert] = "Album was not deleted. Errors: #{@album.errors.full_messages}"
    end
    redirect_to albums_path(@username)
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
