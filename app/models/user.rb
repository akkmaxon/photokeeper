class User < ActiveRecord::Base
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
