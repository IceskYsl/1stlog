class Topic < ActiveRecord::Base

  belongs_to :category ,:counter_cache => true
  belongs_to :type ,:counter_cache => true
  belongs_to :nature ,:counter_cache => true
  belongs_to :user ,:counter_cache => true
  belongs_to :tag ,:counter_cache => true
  has_many :comments ,:dependent => :destroy, :order => "created_at ASC"
  has_many :attachments ,:dependent => :destroy, :order => "created_at ASC"
  
  
  def self.try_to_trackback(id,time)
    find(:first,
      :conditions => ["id = ? and created_at.to_s() = ?",id,time]
    )
  end
  
  #列举全部文章
  def self.get_all_items(page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :order => 'created_at DESC ,updated_at  DESC'
  end
  
  #首页上显示最近提交的项目
  def self.find_index_last_update( page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :conditions =>[" created_at > ? and visible = 1",Time.now-15*7*24*60*60],
      :order => 'created_at DESC ,updated_at  DESC'
  end
  
  # 一个性质下的
  def self.get_items_in_nature(nature_id, page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :conditions =>[" nature_id =? and created_at > ? and visible = 1",nature_id,Time.now-15*7*24*60*60],
      :order => 'created_at DESC ,updated_at  DESC'
  end
  
  # 一个分类下的
  def self.get_items_in_category(category_id, page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :conditions =>[" category_id =? and created_at > ? and visible = 1",category_id,Time.now-15*7*24*60*60],
      :order => 'created_at DESC ,updated_at  DESC'
  end
  
  #获取指定visible的文章
  def self.get_items_in_visible(visible, page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :conditions =>[" visible = ?",visible],
      :order => 'created_at DESC ,updated_at  DESC'
  end
  
  #置顶的文章
  def self.get_items_in_top(top, page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :conditions =>[" istop = ?",top],
      :order => 'created_at DESC ,updated_at  DESC'
  end
  
end
