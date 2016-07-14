class AlbumsController < ApplicationController
  def index
    @albums = current_user.albums
  end
end
