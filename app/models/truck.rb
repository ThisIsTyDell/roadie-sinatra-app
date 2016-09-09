class Truck < ActiveRecord::Base
  belongs_to :user
  has_many :items

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end