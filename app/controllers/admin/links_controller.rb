class Admin::LinksController < Admin::IndexController
  before_filter :authorize
  layout "admincp"

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ], :redirect_to => { :action => :index }

  def list
    visible =params[:visible]
    if visible
      @links = Link.get_all_items_in_visible(visible,params[:page],10)
    else
      @links = Link.get_all_items(params[:page],10)
    end
  end

 

  def new
    @plink = Link.find(:all,:conditions => "parent_id = 0")
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      flash[:notice] = "链接'#{@link.title}'添加成功."
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @plink = Link.find(:all,:conditions => "parent_id = 0")
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      flash[:notice] = '链接更新成功.'
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Link.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
end
