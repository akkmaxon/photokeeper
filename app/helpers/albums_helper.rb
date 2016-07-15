module AlbumsHelper
  def current_album
    Album.find(params[:id])
  end
end
