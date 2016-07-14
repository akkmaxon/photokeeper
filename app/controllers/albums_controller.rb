class AlbumsController < ApplicationController
  def index
    @albums = current_user.albums
  end

  def show
  end
end
