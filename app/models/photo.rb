class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :album
  has_many :comments, dependent: :destroy
  default_scope -> { order(updated_at: :desc) }

  validates :title, length: { maximum: 128 }
  validates :caption, length: { maximum: 512 }
end
