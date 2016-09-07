class User < ActiveRecord::Base
  has_many :trucks
  has_many :items, through: :trucks

  validates :username, uniqueness: true
  validated :email, uniqueness: true
  has_secure_password
end