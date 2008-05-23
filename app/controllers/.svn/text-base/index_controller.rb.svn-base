class IndexController < ApplicationController
  before_filter :frist_time,:except=>['sinup','create']
  before_filter :nav
  #layout "index"
  #layout :theme_layout_func
 
  #首页
  def index
#    @lastest_topic = @topics__pages=Topic.find(:first,:order => "created_at DESC")
#    @topics__pages= Topic.find(:all,:order => "istop DESC,created_at DESC") 
    @topics = Topic.find_index_last_update(params[:page],10)
  end
  
  #第一次
  def frist_time
    if User.count == 0 
      redirect_to(:action => "sinup")
    end
  end
  
  #注册用户
  def sinup
    #@user_groups = UserGroup.find(:all)
    @user = User.new
  end
  
  #创建用户
  def create
    @user = User.new(params['user'])
    @user.user_group_id = 1 if User.count == 0 
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to(:action=>"login")
    else
      flash[:notice] = 'User was not created,try angin..'
      render :action => 'sinup'
    end
  end
  
  def search
    @topics=Topic.find(:all,:conditions=>["title LIKE ? or body like ?","%" + params[:keys]+"%","%" + params[:keys]+"%"],
      :order => "created_at DESC",:limit=>20) 
    render :layout => false
  end
  
  #用户登录
  def login
    if request.get?
      session[:user_id] = nil
      session[:user_group_id] = nil
      @user = User.new
    else
      @user=User.new(params[:user])
      logged_in_user = @user.try_to_login
      if logged_in_user
        session[:user_id]=logged_in_user.id
        session[:user_group_id] = logged_in_user.user_group_id
        jumpto = session[:jumpto] || {:controller=>"admin/index",:action=> "index"}
        session[:jumpto] = nil
        flash[:notic] = "登陆成功，欢迎您..."
        redirect_to(jumpto)
      else
        flash[:notice]="对不起,您输入的账号和密码不匹配..."
        redirect_to(:action => "login")
      end
    end
  end
  
  #用户注销
  def logout
    reset_session
    flash[:notice] ="欢迎您的光临,您已经成功登出,期待您的下次光临..."
    redirect_to(:action=>"index")
  end
 

end
