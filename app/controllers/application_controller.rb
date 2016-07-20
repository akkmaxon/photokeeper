class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def set_username
    @username = snake_case(find_user.full_name)
  end

  def snake_case(name)
    name = current_user.full_name unless name
    name.gsub(' ', '_').downcase
  end

  def full_name_from_params(params)
    username = params[:username]
    if params[:album_id]
      album_id = params[:album_id]
      owner_of_album = snake_case(Album.find(album_id).user.full_name)
      username = owner_of_album unless username == owner_of_album
    end
    names = username.split '_'
    names.map! { |n| n.capitalize }
    names.join ' '
  end

  def find_user
    User.find_by(full_name: full_name_from_params(params)) || current_user
  end
end
