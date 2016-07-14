module ApplicationHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=180"
    image_tag gravatar_url, alt: user.full_name, id: 'gravatar'
  end
end
