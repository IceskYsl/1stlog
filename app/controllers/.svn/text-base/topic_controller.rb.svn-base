class TopicController < ApplicationController
 #model :noisy_image
 before_filter :nav
 layout "index"
 #layout :theme_layout_func
    
  def index
#    session[:noisy_image] = NoisyImage.new(4) #生成一个有4字符的图片
#    session[:code] = session[:noisy_image].code
    @topic = Topic.find(params[:id])
    @topic.update_attribute(:views_count,@topic.views_count+1)
    @attachment = Attachment.find_by_id(@topic.attachment_id) if !@topic.attachment_id.blank?
    @comments__pages=Comment.find(:all,:conditions => "topic_id=#{@topic.id}",:order => "created_at DESC") 
    @comment_pages, @comments = paginate_collection @comments__pages, {:page => @params[:page],:per_page => getconfig("comment_shownum").value.to_i,:order => "created_at DESC" }
    rescue
    logger.error("Attempt to access invalid topic #{params[:id]}")
    flash[:notice] = '注意:你所要找到文章并不存在...'
    redirect_to(:controller=>"index",:action => 'index')
  end

  def view
  end
  
  def comment
    @topic=Topic.find(params[:id])
    website = params[:comment][:website]
    @show_noisy_image = Configuration.find_by_name("show_noisy_image")
    @params['comment']['type_id'] = @topic.type_id
    @params['comment']['remote_ip'] = @request.remote_ip
    @params['comment']['website'] =  (website.blank? || website.starts_with?('http')) ? website : "http://#{website}" 
    if @params['comment']['email'].blank? || @params['comment']['body'].blank? || @params['comment']['name'].blank? || ((@show_noisy_image.value == "1" and params[:code]!= session[:noisy_image].code)  ) 
    logger.error("回复的信息不正确")
    flash[:notice] = '注意,用户名和邮件不能为空，验证码你可能写错了..'
    redirect_to(:conditions =>"index",:action => 'index')
    else
    @topic.comments.create(params[:comment])
    @topic.update_attributes(:comments_count=>@topic.comments_count+1,:updated_at=>Time.now)
    flash[:notice] = "3Q,You Post a comment..."
    redirect_to :action =>"index" ,:id => params[:id]
    end
    rescue
    logger.error("Attempt to access invalid topic #{params[:id]}")
    flash[:notice] = '注意:你所要找到文章并不存在...'
    redirect_to(:conditions =>"index",:action => 'index')

  end
  
  def trackback 
    key = LOG_APP_CONFIG["KEY"]
    @topic=Topic.find(params[:id])
    code_1 = @topic.id.to_s << key.to_s << @topic.created_at.strftime("%Y%m%d%I%M")
    code = encode64(code_1)
     render :text => "TrackBack地址:<br/><small>http://www.1ster.cn/trackback/#{code}</small>",:layout => false
    rescue
    logger.error("Attempt to trackback invalid topic #{params[:id]}")
    flash[:notice] = '注意:你所要找到文章并不存在...'
    render :text => "您所找的文章并不存在...",:layout => false
  end
  
#  def code_image
#    image = session[:noisy_image].code_image
#    send_data image, :type => 'image/jpeg', :disposition => 'inline'
#  end
   
  def code_image
    session[:noisy_image] = NoisyImage.new(4)
    session[:code] = session[:noisy_image].code
    image = session[:noisy_image].code_image
    send_data image, :type => 'image/jpeg', :disposition => 'inline'
  end
  
  def attachment
  @attachment = Attachment.find(params[:id])
  @attachment.update_attribute(:downloads,@attachment.downloads+1)
  send_file @attachment.filepath, :type => @attachment.filetype, :disposition => 'inline'
  end
  
end
