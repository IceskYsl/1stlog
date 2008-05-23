require "digest/sha1"
class User < ActiveRecord::Base
  validates_confirmation_of :password, :message => "两次输入的密� �不一致，请确认..."
  belongs_to :user_group #,:counter_cache => true
  has_many :topics
  
  attr_accessor :password,:password_confirmation
  validates_uniqueness_of :login_name,:nickname
  validates_presence_of :login_name,:email,:nickname,:password,:on => :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
                      :on => :create,
                      :message=>"邮件地址� �式不正确，请检查..."  
                      
  validates_format_of :content_type,
                      :with=>/(^image|)/,
                      :message=>"只能上� 图片..."

  def before_create
    self.hashed_pass= User.hash_password(self.password)
  end
  
  #所有用户
  def self.get_all_items(page,per_page="10")
    paginate :per_page => per_page, :page => page
  end


  def after_create
    @password=nil
  end
  
  def self.login(name,password)
    hashed_password = hash_password(password || "")
    find(:first,
         :conditions => ["login_name = ? and hashed_pass = ?",name,hashed_password]
    )
  end
  
  def try_to_login
    User.login(self.login_name,self.hashed_pass)
  end
  
  def self.can_login(user_id,password)
    hashed_password = self.hash_password(password || "")
    find(:first,
         :conditions => ["id = ? and hashed_pass = ?",user_id,hashed_password]
    )
  end
  
  private
  def self.hash_password(password)
    Digest::SHA1.hexdigest(password)
  end
end
