class Album < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :user_id, presence: true
  validates :title, length: { maximum: 128 }
end
