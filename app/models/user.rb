class User < ActiveRecord::Base
  has_many :albums, dependent: :destroy
  has_many :photos, dependent: :destroy
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

  validates :full_name, length: { maximum: 128 }

  def self.from_omniauth(auth)
    where(omni_provider: auth.provider, omni_uid: auth.uid).first_or_create do |user|
      user.email = if auth.info.email then auth.info.email
		   elsif auth.info.nickname then "#{auth.info.nickname}@__edit__your.mail__"
		   elsif auth.info.name then "#{auth.info.name}@__edit__your.mail__"
		   end
      user.password = Devise.friendly_token[0,20]
    end
  end
end
