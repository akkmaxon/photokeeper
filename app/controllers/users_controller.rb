class UsersController < ApplicationController
  before_action :find_photos, only: :feed
  before_action :find_comments, only: :feed
  before_action :find_albums, only: :feed
  before_action :set_username

  def feed
    @objects = []
    @photos.each do |p|
      @objects << p
    end
    @albums.each do |a|
      @objects << a
    end
    @comments.each do |c|
      @objects << c
    end
    @objects.sort_by(&:updated_at)
  end

  def following
    @users = find_user.following
  end

  def followers
    @users = find_user.followers
  end

  private

  def find_photos
    @photos = find_user.photos
  end

  def find_comments
    @comments = find_user.comments
  end

  def find_albums
    @albums = find_user.albums
  end
end
