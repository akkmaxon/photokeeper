class User < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, {
    class_name: 'Relationship',
    foreign_key: 'follower_id',
    dependent: :destroy }
  has_many :passive_relationships, {
    class_name: 'Relationship',
    foreign_key: 'followed_id',
    dependent: :destroy }
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, 
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    #confirmable,
    :lockable,
    :omniauthable
  mount_uploader :avatar, UserAvatarUploader

  validates :full_name, length: { maximum: 128 }

  def self.from_omniauth(auth)
    where(omni_provider: auth.provider, omni_uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || Faker::Internet.email
      user.full_name = auth.info.name || auth.info.nickname
      user.password = Devise.friendly_token[0,20]
    end
  end

  def following?(user)
    following.include? user
  end

  def follow(other_user)
    active_relationships.create followed_id: other_user.id
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end
