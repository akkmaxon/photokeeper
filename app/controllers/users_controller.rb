class UsersController < ApplicationController
  before_action :set_username, except: :index

  def index
    @users = search(params[:search])
  end

  def feed
    all = []
    %w[ photos comments albums ].each do |obj|
      find_objects(obj).each do |o|
	all << o
      end
    end
    @objects = all.sort { |a,b| b.updated_at <=> a.updated_at }
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
      user.photos.where("updated_at > ?", not_before_date)
    when 'albums'
      user.albums.where("updated_at > ?", not_before_date)
    when 'comments'
      user.comments.where("updated_at > ?", not_before_date)
    end
  end

  def not_before_date(days = 3)
    seconds_in_one_day = 86400
    Time.now - seconds_in_one_day * days
  end
end
