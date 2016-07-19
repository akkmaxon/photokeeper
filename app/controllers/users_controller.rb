class UsersController < ApplicationController
  def feed
  end

  def following
    @users = find_user.following
  end

  def followers
    @users = find_user.followers
  end
end
