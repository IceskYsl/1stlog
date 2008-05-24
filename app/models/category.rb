class Category < ActiveRecord::Base
  has_many :topics
  belongs_to :category 
  
  def parent
    if self.parent_id > 0
     Category. find(self.parent_id).title
    else
      "---"
    end
  end
  
  #取得所有父分类
  def self.get_all_parent_items(limit = 10)
    find(:all,:conditions=>["parent_id =?",0],:limit=>limit)
  end
 
  def self.get_all_items(page,per_page="10")
    paginate :per_page => per_page, :page => page
  end
  
  def self.get_all_items_in_parent(parent_id)
    find(:all,:conditions=>['parent_id =?',parent_id],:order => "position DESC")
  end
  
  
  
end
