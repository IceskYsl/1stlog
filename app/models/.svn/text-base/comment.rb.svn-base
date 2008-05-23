class Comment < ActiveRecord::Base
  belongs_to :topic ,:counter_cache => true
  
  validates_presence_of :name,:body
  validates_length_of :body, :minimum => 2
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
    :on => :create,
    :message=>"邮件地址格式不正确，请检查..." 

 
    #列举全部评论
  def self.get_all_items(page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :order => 'created_at DESC '
  end
  
  def self.get_all_items_in_visible(visible,page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :order => 'created_at DESC '
  end

end
