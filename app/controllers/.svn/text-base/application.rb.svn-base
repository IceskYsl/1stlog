# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
#require 'related_select_form_options_helper'
class ApplicationController < ActionController::Base
  layout 'index'
  theme :initialize_theme 
 
  #选择模板
  def initialize_theme 
    "simple" 
  end
    
  #model :noisy_image
#  before_filter :initdata
#  before_filter :init_show_item
  before_filter :configure_charsets
  caches_action :initdata, :init_show_item,:nav

  # Pick a unique cookie name to distinguish our session data from others'
  #session :session_key => '_1stlog_session_id'


  
  def configure_charsets
    response.headers["Content-Type"] = "text/html; charset=utf-8"
  end
    
  #身份验证
  def authorize
    unless session[:user_id]
      session[:jumpto] = request.parameters
      flash[:notice]="您所做得操作需要登录,请登录..!"
      redirect_to(:controller=>"index",:action=>"login")
    else 
      if request.request_uri =~ %r{/admin/}      
        online_users = $application[:online_users] || {}
        online_user = online_users[:user_id] || {}
        online_user[:ip] = request.remote_ip
        online_user[:active_time] = Time.now
        online_users[session[:user_id]] = online_user
        $application[:online_users] = online_users
      end
    end
  end
   

  
  #取配置信息
  def getconfig(name)
    Configuration.find_by_name(name)
  end
  
  #初始化数据
#  def initdata
#    @app_title=Configuration.find_by_name("title")
#    @app_subtitle=Configuration.find_by_name("subtitle")
#    @app_name=Configuration.find_by_name("name")
#    @app_url=Configuration.find_by_name("url")
#    @key =Configuration.find_by_name("key")
#    @viewmode = Configuration.find_by_name("viewmode")
#    @about =Configuration.find_by_name("about") 
#    @about_authors = Configuration.find_by_name("about_authors") 
#    @powered_by = Configuration.find_by_name("powered_by")
#    @app_theme = Configuration.find_by_name("theme")
#    @app_editor_style = Configuration.find_by_name("editor_style")
#    @app_editor_mode = Configuration.find_by_name("editor_mode")
#    @icp = Configuration.find_by_name("icp")
#  end
  
#  def init_show_item
#    @show_natures = Configuration.find_by_name("show_natures")
#    @show_categories = Configuration.find_by_name("show_categories")
#    @show_archives = Configuration.find_by_name("show_archives")
#    @show_links = Configuration.find_by_name("show_links")
#    @show_statistics = Configuration.find_by_name("show_statistics")
#    @show_hot_entries = Configuration.find_by_name("show_hot_entries")
#    @show_last_entries = Configuration.find_by_name("show_last_entries")
#    @show_hot_tags = Configuration.find_by_name("show_hot_tags")
#    @show_last_comments = Configuration.find_by_name("show_last_comments")
#    @show_authors = Configuration.find_by_name("show_authors")
#    @show_metas = Configuration.find_by_name("show_metas")
#    @show_visitors = Configuration.find_by_name("show_visitors")
#    @show_adsense = Configuration.find_by_name("show_adsense")
#    @show_noisy_image = Configuration.find_by_name("show_noisy_image")
#    
#  end
  
  def init_show_nums
  
  end
  
  #侧边栏
  def nav
    #分类
    @types = Type.find(:all)
    @category_of_type = []  
    for type in @types  
      @category_of_type << Category.find(:all,:conditions=>['type_id=?',type.id],:order => "position DESC")
    end 
     
    #链接
    @plinks = Link.find(:all,:conditions=>['parent_id=0'])
    @links = []  
    for plink in @plinks  
      @links << Link.find(:all,:conditions=>['parent_id=?',plink.id],:order => "position DESC")
    end  
     
    @natures = Nature.find(:all)
    @hot_topics=Topic.find(:all,:order => "comments_count DESC",:limit => getconfig("hot_entries_num").value) 
    @new_topics=Topic.find(:all,:order => "created_at DESC",:limit => getconfig("last_entries_num").value) 
    @new_comments=Comment.find(:all,:order => "created_at DESC",:limit => getconfig("last_comments_num").value) 
    @hot_tags=Tag.find(:all,:order => "topics_count DESC",:limit => getconfig("hot_tags_num").value) #热门TAG
     
    @users = User.find(:all)
    ###
      
    @start_topic=Topic.find(:first,:order =>"created_at").created_at.to_date if Topic.count > 0
    @start_topic ||= Date.today
    @last = Date.new(@start_topic.year,@start_topic.mon,1)
    @start=Date.today
    #
    ##

    ######

  end
    
    
  def archives
    #s=Date.new(2006,1,1)
    start=Topic.find(:first,:order =>"created_at").created_at.to_date  
    last=Date.today
    #      start.step(last,Time.days_in_month(start.mon)) do |archive|
    #        puts archive.strftime("%B,%Y")
    #      end
  end
  


end
