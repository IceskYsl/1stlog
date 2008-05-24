class NaturesController < ApplicationController
 before_filter :nav
# layout "index"
# layout :theme_layout_func
 
  def show
    nature_id = params[:id]
    @topics = Topic.get_items_in_nature(nature_id,params[:page],10)
    rescue => err
    logger.error("Attempt to access invalid Nature #{params[:id]},error=#{err}")
    flash[:notice] = '注意,你所要找到属性并不存在...'
    redirect_to(:controller=>"index",:action => 'index')
  end
  
end
