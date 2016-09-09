class User < ActiveRecord::Base
  has_many :trucks
  has_many :items, through: :trucks

  validates :username, uniqueness: true
  validates :email, uniqueness: true
  has_secure_password

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end