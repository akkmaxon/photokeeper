class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def welcome
    redirect_to feed_url(username: snake_case(current_user.full_name)) if user_signed_in?
  end
  
  def login_as_default_user
    user = User.find_by email: 'dyadya_fyodor@prostokvashino.com'
    sign_in user
    redirect_to root_path
  end
end
