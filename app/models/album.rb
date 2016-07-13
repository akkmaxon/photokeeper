class Album < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :title, length: { maximum: 64 }
end
