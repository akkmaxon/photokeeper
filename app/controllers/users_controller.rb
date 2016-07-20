class UsersController < ApplicationController
  before_action :set_username

  def feed
    @objects = []
    [find_photos, find_comments, find_albums].each do |obj|
      obj.each do |o|
	@objects << o
      end
    end
    @objects.sort { |a,b| b.updated_at <=> a.updated_at }
  end

  def following
    @users = find_user.following
  end

  def followers
    @users = find_user.followers
  end

  private

  def find_photos
    photos = []
    followings_photos = []
    own_photos = find_user.photos.where("updated_at > ?", not_before_date).to_a
    find_user.following.each do |following|
      followings_photos << following.photos.where("updated_at > ?", not_before_date).to_a
    end
    [own_photos, followings_photos.flatten].each do |photo|
      photo.each { |p| photos << p }
    end
    photos
  end

  def find_comments
    comments = []
    followings_comments = []
    own_comments = find_user.comments.where("updated_at > ?", not_before_date).to_a
    find_user.following.each do |following|
      followings_comments << following.comments.where("updated_at > ?", not_before_date).to_a
    end
    [own_comments, followings_comments.flatten].each do |comment|
      comment.each { |c| comments << c }
    end
    comments
  end

  def find_albums
    albums = []
    followings_albums = []
    own_albums = find_user.albums.where("updated_at > ?", not_before_date).to_a
    find_user.following.each do |following|
      followings_albums << following.albums.where("updated_at > ?", not_before_date).to_a
    end
    [own_albums, followings_albums.flatten].each do |album|
      album.each { |a| albums << a }
    end
    albums
  end

  def not_before_date(days = 3)
    seconds_in_one_day = 86400
    Time.now - seconds_in_one_day * days
  end
end
