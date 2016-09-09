class Item < ActiveRecord::Base
  belongs_to :truck

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end