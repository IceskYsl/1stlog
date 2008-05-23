require "digest/sha1"
class Admin::ProfileController < Admin::IndexController
  before_filter :authorize
  layout "admin"
  
  def index
    @user = User.find(session[:user_id])
  end
  
  def update_profile
    #@user = User.new(params[:user])
    @user = User.find(session[:user_id])
    if @user.update_attributes(params[:user])
      flash[:notice] = '您的资料修改成功...'
      redirect_to :action => "index"
    else
      flash[:notice] = '资料修改失败了...'
      render :action => 'index'
    end
  end
  
  def password
  end
  
  def update_password
        old_password = params[:user][:old_password]
        new_password = params[:user][:new_password]
        new_password_confirm = params[:user][:new_password_confirm]
        if (new_password==new_password_confirm) and !new_password_confirm.blank?
        #logged_in_user = @user.try_to_login
          @user = User.find(session[:user_id])
          can_log_in = User.can_login(session[:user_id],old_password)
          if can_log_in
            session[:user_id]=can_log_in.id
            session[:user_group_id] = can_log_in.user_group_id
            @user.update_attribute('hashed_pass', Digest::SHA1.hexdigest(new_password || ""))
            flash[:notic] = "密码更新成功..."
            redirect_to( :controller =>"admin/profile",:action => "index")
          else
            flash[:notice]="对不起,您输入的原始密码不正确，请确认..."
            redirect_to(:action => "password")
          end
        else
          flash[:notice]="你没有输入新密码或者是你两次输入的新密码不一致，请确认..."
          redirect_to(:action => "password")
        end

  end
  
end
