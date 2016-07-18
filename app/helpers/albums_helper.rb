module AlbumsHelper
  def current_album
    Album.find(params[:album_id])
  end
end
