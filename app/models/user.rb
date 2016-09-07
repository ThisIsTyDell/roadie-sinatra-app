class User < ActiveRecord::Base
  has_many :trucks
  has_many :items, through: :trucks

  has_secure_password
end