module PhotosHelper
  def current_photo
    Photo.find(params[:id])
  end
end
