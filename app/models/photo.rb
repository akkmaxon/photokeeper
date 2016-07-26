class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :album
  mount_uploader :source, PhotoUploader
  has_many :comments, dependent: :destroy
  default_scope -> { order(updated_at: :desc) }

  validates :title, length: { maximum: 128 }
  validates :caption, length: { maximum: 512 }

  def original_url
    source.url
  end

  def thumb_url
    source.thumb.url
  end

  def album_title
    album.title
  end

  def comments_count
    comments.count
  end

  def owner_name
    user.full_name
  end
end
