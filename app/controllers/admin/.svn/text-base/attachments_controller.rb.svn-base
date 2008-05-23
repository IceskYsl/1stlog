class Admin::AttachmentsController < Admin::IndexController
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
    @attachments = Attachment.get_all_items(params[:page],10)
    #    @attachment_pages, @attachments = paginate :attachments, :per_page => 10
  end

  def show
    @attachment = Attachment.find(params[:id])
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(params[:attachment])
    if @attachment.save
      flash[:notice] = 'Attachment was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @attachment = Attachment.find(params[:id])
  end

  def update
    @attachment = Attachment.find(params[:id])
    if @attachment.update_attributes(params[:attachment])
      flash[:notice] = 'Attachment was successfully updated.'
      redirect_to :action => 'show', :id => @attachment
    else
      render :action => 'edit'
    end
  end

  def destroy
    Attachment.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
