class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def welcome
    redirect_to feed_url(username: snake_case(current_user.full_name)) if user_signed_in?
  end
end
