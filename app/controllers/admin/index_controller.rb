#require "importenv"
class Admin::IndexController < ApplicationController
  before_filter :authorize,:init_user  
  layout "admincp"
  
  def index
  end
  
  def show_env
    render :layout => false
  end
  
  def init_user
    @user = User.find(session[:user_id])
  end
  
end
