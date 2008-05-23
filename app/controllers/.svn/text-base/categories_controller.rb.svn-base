class CategoriesController < ApplicationController
  before_filter :nav
  #layout "index"
  # layout :theme_layout_func
 
  def show
    nature_id = params[:id]
    @topics = Topic.get_items_in_category(nature_id,params[:page],10)
  rescue => err
    logger.error("Attempt to access invalid Category #{params[:id]},msg=#{err}")
    flash[:notice] = '注意,你所要找到分类并不存在...'
    redirect_to(:controller=>"index",:action => 'index')
  end
  
end
