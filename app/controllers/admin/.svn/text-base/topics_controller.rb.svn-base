class Admin::TopicsController < Admin::IndexController
  
  before_filter :authorize,:init_categories
  
  layout "admincp" ,:except=>['notop']
  
  def init_categories
    @topic_categories = Category.find(:all)
    @topic_natures = Nature.find(:all)
  end

  def index
    @topics = Topic.get_all_items(params[:page],10)
  end
  
  def view_by_category
    category_id = (params[:c_id])
    @topics_pages=Topic.find(:all,:conditions=>["category_id=?",category_id]) 
    @topic_pages, @topics = paginate_collection @topics_pages, {:page => params[:page],:per_page => 10,:order => "created_at DESC" }
    render :layout => false
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
    :redirect_to => { :action => :list }

  def list
    category_id = params[:category_id]
    nature_id = params[:nature_id]
    top = params[:top]
    visible =params[:visible]
    if category_id
      @topics = Topic.get_items_in_category(category_id,params[:page],10)
    elsif nature_id
      @topics = Topic.get_items_in_nature(nature_id,params[:page],10)
    elsif visible
      @topics = Topic.get_items_in_visible(visible,params[:page],10)
    elsif top
      @topics = Topic.get_items_in_top(top,params[:page],10)
    else
      @topics = Topic.get_all_items(params[:page],10)
    end
    
  end
  
  def notop
    @topic=Topic.find(params[:id])
    @topic.update_attributes(:istop => 0 )
    flash[:notice] = '解除置顶成功...'
    redirect_to :action => 'list' #,:layout => false
    #  render :action => "list", :layout => false
  end

  def show
    @topic = Topic.find(params[:id])
    render :layout => false
  end

  def new
    @app_theme = Configuration.find_by_name("theme")
    @tags = Tag.find(:all)
    @topic_categories = Category.find(:all)
    @topic = Topic.new
    # render :layout => false
  end

  def create
    @topic = Topic.new(params[:topic])
    if  @topic.tag_id == 0
      @tag = Tag.new
      @tag.title = params[:tag_title]
      @tag.save
      @topic.tag_id = @tag.id
    else
    
    end
    @topic.user_id = session[:user_id]
    @topic.remote_ip=request.remote_ip
    @attachment = SingleFile.save(@topic) if !params[:topic][:attachment_id].blank?
    @topic.attachment_id = @attachment.id if @attachment
    #@topic.user_id =
    if @topic.save
      @attachment.update_attributes(:topic_id => @topic.id ) if @attachment
      flash[:notice] = 'Topic was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @tags = Tag.find(:all)
    @topic = Topic.find(params[:id])
    @attachment = Attachment.find(@topic.attachment_id) if !@topic.attachment_id.blank?
    render :layout => false
  end

  def update
    @topic = Topic.find(params[:id])
    #@attachment = SingleFile.save(@topic) if !params[:topic][:attachment_id].blank?
    #@topic.attachment_id = @attachment.id if @attachment
    if @topic.update_attributes(params[:topic])
      flash[:notice] = 'Topic was successfully updated.'
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  


  def destroy
    Topic.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  

  
end
