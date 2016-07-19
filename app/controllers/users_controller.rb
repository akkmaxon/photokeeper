class UsersController < ApplicationController
  def feed
  end

  def following
    @users = current_user.following
  end

  def followers
    @users = current_user.followers
  end
end
