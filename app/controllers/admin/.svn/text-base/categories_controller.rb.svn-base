class Admin::CategoriesController < Admin::IndexController
  before_filter :authorize
  layout "admincp"

  def index
    @categories = Category.get_all_items(params[:id])
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
#    @category_pages, @categories = paginate :categories, :per_page => 10
    render :layout => false
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @types = Type.find(:all)
    @category = Category.new
    render :layout => false
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @types = Type.find(:all)
    @category = Category.find(params[:id])
    render :layout => false
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category was successfully updated.'
      redirect_to :action => 'show', :id => @category
    else
      render :action => 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
