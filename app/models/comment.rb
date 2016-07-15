class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  default_scope -> { order(updated_at: :desc) }

  validates :body, presence: true
end
