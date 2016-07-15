class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :album
  default_scope -> { order(updated_at: :desc) }

  validates :title, length: { maximum: 128 }
  validates :caption, length: { maximum: 512 }
end
