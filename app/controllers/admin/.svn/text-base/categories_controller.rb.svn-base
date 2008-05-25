class Admin::CategoriesController < Admin::IndexController
  before_filter :authorize
  layout "admincp"

  def index
    @categories = Category.get_all_items(params[:id])
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],  :redirect_to => { :action => :index }

  def list
    #    @category_pages, @categories = paginate :categories, :per_page => 10
    render :layout => false
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @parent_categories = Category.get_all_parent_items
    @category = Category.new
    #    render :layout => false
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @parent_categories = Category.get_all_parent_items
    @category = Category.find(params[:id])
  end

  #更新分类
  def update
    @category = Category.find(params[:id])
    logger.info("=============")
    if @category.update_attributes(params[:category])
      flash[:notice] = '分类更新成功.'
      redirect_to :action => 'index'
    else
      flash[:notice] = '分类更新失败.'
      render :action => 'edit'
    end
  end

  #删除分类
  def destroy
    Category.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
