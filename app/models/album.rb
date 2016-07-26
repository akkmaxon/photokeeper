class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy
  default_scope -> { order(updated_at: :desc) }

  validates :user_id, presence: true
  validates :title, length: { maximum: 128 }

  def newest_photo_thumb
    photos.first.thumb_url
  end

  def photos_count
    photos.count
  end

  def owner_name
    user.full_name
  end
end
