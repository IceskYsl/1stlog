class TagsController < ApplicationController
 before_filter :nav
 #layout "index"
 layout :theme_layout_func
 
  def index
    topic_tag_id = params[:id]
    @lastest_topic = Topic.find(:first,:conditions => [ "tag_id = ?", topic_tag_id],:order => "created_at DESC")
    @topics__pages=Topic.find(:all,:conditions => [ "tag_id = ?", topic_tag_id],:order => "created_at DESC") 
    @topic_pages, @topics = paginate_collection @topics__pages, {:page => @params[:page],:per_page => 10,:order => "created_at DESC" }
  end
end
