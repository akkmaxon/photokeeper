module PhotosHelper
  def default_photo_title
    Time.now.strftime '%d %b %Y'
  end

  def default_photo_caption
    "#{current_user.full_name} uploaded this photo for some reason"
  end
end
