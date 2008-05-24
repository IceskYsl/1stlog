class Link < ActiveRecord::Base

  def parent
    if self.parent_id > 0
      Link. find(self.parent_id).title
    else
      "---"
    end
  end
  
  def self.get_all_items(page,per_page="10")
    paginate :per_page => per_page, :page => page
  end
  
  def self.get_all_items_in_visible(visible,page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :conditions => ["visible = ?",visible],
      :order => 'created_at DESC '
  end
  
end
