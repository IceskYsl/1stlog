class Admin::CommentsController < Admin::IndexController
  before_filter :authorize
  layout "admincp" 

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
    :redirect_to => { :action => :list }

  def list
    visible =params[:visible]
    if visible
      @comments = Comment.get_all_items_in_visible(visible,params[:page],10)
    else
      @comments = Comment.get_all_items(params[:page],10)
    end
  end
  
  #删除全部评论
  def deleteall
     Comment.find(:all).each do |c|
       c.destroy
     end     
    redirect_to :action => 'list'
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to :action => 'show', :id => @comment
    else
      render :action => 'edit'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
