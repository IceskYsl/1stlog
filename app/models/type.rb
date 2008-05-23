class Type < ActiveRecord::Base
  has_many :categories
  has_many :topics
end
