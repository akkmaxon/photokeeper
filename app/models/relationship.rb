class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: 'User', touch: true
  belongs_to :followed, class_name: 'User', touch: true
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
