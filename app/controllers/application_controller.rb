class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_username

  def set_username
    @username = params[:username]
  end

  def snake_case(name)
    name.gsub(' ', '_').downcase
  end

  def full_name_from_params(username = 'undefined_user')
    names = username.split '_'
    names.map! { |n| n.capitalize }
    names.join ' '
  end
end
