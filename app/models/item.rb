class Item < ActiveRecord::Base
  belongs_to :truck
  belongs_to :user
end