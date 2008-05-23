class Category < ActiveRecord::Base
  has_many :topics
  belongs_to :type
  
  #
  def self.get_all_items(page,per_page="10")
    paginate :per_page => per_page, :page => page
  end
  
end
