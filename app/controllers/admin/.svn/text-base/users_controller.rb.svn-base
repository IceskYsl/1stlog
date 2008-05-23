class Admin::UsersController < Admin::IndexController
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
    @users = User.get_all_items(params[:page],10)
    #    @user_pages, @users = paginate :users, :per_page => 10
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user_groups = UserGroup.find(:all)
    @user = User.new
  end

  def create
    @params['user']['content_type'] = @params['user']['tmp_file'].content_type 
    # This makes sure filenames are sane
    @params['user']['data'] = @params['user']['tmp_file'].read
    @params['user'].delete('tmp_file') 
    # let's remove the field from the hash, because there's no such field in the DB anyway.
    @user = User.new(@params['user'])
    # then the basic if @person.save ... like in <a href="http://wiki.rubyonrails.org/rails/pages/TutorialFramingOut" class="existingWikiWord">TutorialFramingOut</a>
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @user_groups = UserGroup.find(:all)
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
