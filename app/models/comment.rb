class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  default_scope -> { order(updated_at: :desc) }

  validates :body, presence: true

  def owner_name
    user.full_name
  end

  def date_of_creating
    created_at.strftime "%d %B %Y"
  end

  def photo_title
    photo.title
  end

  def photo_owner_name
    photo.owner_name
  end

  def photo_album
    photo.album
  end
end
