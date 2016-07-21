module AlbumsHelper
  def current_album
    Album.find(params[:album_id])
  end

  def default_album_title
    "Album ##{current_user.albums.size + 1}"
  end
end
