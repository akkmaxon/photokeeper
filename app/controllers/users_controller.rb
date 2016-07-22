class UsersController < ApplicationController
  before_action :set_username, except: :index
  OBJECTS_ON_PAGE = 20

  def index
    @users = search(params[:search])
  end

  def feed
    @page = params[:page].to_i
    all = []
    %w[ photos comments albums ].each do |obj|
      find_objects(obj).each do |o|
	all << o
      end
    end
    all = all.sort { |a,b| b.updated_at <=> a.updated_at }
    @objects = all[@page * OBJECTS_ON_PAGE,OBJECTS_ON_PAGE]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def following
    @users = find_user.following
  end

  def followers
    @users = find_user.followers
  end

  private

  def search(keywords)
    User.where('full_name ilike ? and full_name != ?', "%#{keywords}%", current_user.full_name)
  end

  def find_objects(objects)
    result = []
    followings_objects = []
    own_objects = extract_objects(find_user, objects)
    find_user.following.each do |following|
      followings_objects << extract_objects(following, objects)
    end
    [own_objects, followings_objects.flatten].each do |obj|
      obj.each { |o| result << o }
    end
    result
  end

  def extract_objects(user, table)
    case table
    when 'photos'
      user.photos
    when 'albums'
      user.albums
    when 'comments'
      user.comments
    end
  end
end
