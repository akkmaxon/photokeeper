class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :set_username

  def welcome
    redirect_to feed_url(username: snake_case(current_user.full_name)) if user_signed_in?
  end
end
