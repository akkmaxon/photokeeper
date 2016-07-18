module ApplicationHelper
  def avatar_for(user)
    avatar_url = if user.avatar.url.nil? or user.gravatar
		   gravatar_id = Digest::MD5::hexdigest user.email.downcase
		   "https://secure.gravatar.com/avatar/#{gravatar_id}?s=180"
		 else
		   user.avatar.url
		 end
    image_tag avatar_url, alt: user.full_name, id: 'avatar'
  end
end
