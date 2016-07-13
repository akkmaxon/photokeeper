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
    :lockable

  validates :full_name, length: { maximum: 128 }
end
