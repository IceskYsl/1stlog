
class Admin::ConfigurationsController < Admin::IndexController
  before_filter :authorize
  layout "admincp"
  def index
    @configurations = Configuration.find_all_by_group("String") 
  end
  
  
  def config_show
    @show_items = Configuration.find_all_by_group("Boolean")
    render :layout => false
  end
  
  def base
    @configurations = Configuration.find_all_by_group("String")
    render :layout => false
  end
  
  def config_num
    @nums = Configuration.find_all_by_group("Integer")
    render :layout => false
  end
  
  def editer
    @select_items = Configuration.find_all_by_group("Select")
    render :layout => false
  end
  
  def desc
    @descs = Configuration.find_all_by_group("Text")
    render :layout => false
  end
  
  def comment
    render :layout => false
  end
  
  def config_theme
    @app_theme = Configuration.find_by_name("theme")
    @thems = themes_file
  end 
  
  def selected_theme
    #      themes_root =Dir.pwd +  "#{RAILS_ROOT}/themes/#{params['theme']}"
    #      desc_root = Dir.pwd +  "#{RAILS_ROOT}"
    themes_root = "#{RAILS_ROOT}/themes/#{params['theme']}"
    desc_root =  "#{RAILS_ROOT}"
    logger.error("themes_root: #{themes_root}")
    logger.error("desc_root: #{desc_root}")
      
    #     @qq = FileUtils.cp_r Dir.glob("#{RAILS_ROOT}/themes/#{params['theme']}/public/*.*"), "#{RAILS_ROOT}/public",{:noop, :verbose}
    #     @path = "#{RAILS_ROOT}/themes/#{params['theme']}/public/*.*"
    #     @file = Dir.glob("C:/")
     
    #      themes_root = "F:/webroot/1stlog/log"
    public_glob = "#{themes_root}/public/[a-zA-Z0-9]*"
    view_glob = "#{themes_root}/views/[a-zA-Z0-9]*"
      
    logger.error("public_glob: #{public_glob}")
    logger.error("view_glob: #{view_glob}")
      
    desc_public_root = "#{desc_root}/public" 
    desc_view_root = "#{desc_root}/app/views" 
      
    logger.error("desc_public_root: #{desc_public_root}")
    logger.error("desc_view_root: #{desc_view_root}")
      
    FileUtils.rm_r Dir.glob(desc_public_root+"/images/theme_images")
    FileUtils.rm_r Dir.glob(desc_public_root+"/javascripts/theme_js")
    FileUtils.rm_r Dir.glob(desc_public_root+"/stylesheets/theme_css")
    #      FileUtils.rm_r Dir.glob(view_glob)    
    #      FileUtils.cp_r Dir.glob(glob), desc_root,{:noop, :verbose}
    Dir.glob(public_glob).select do |file|
      #      FileUtils.rm_r Dir.glob(file)    
      FileUtils.cp_r file, desc_public_root
    end
    Dir.glob(view_glob).select do |file|
      FileUtils.cp_r file, desc_view_root
    end
    #      p @theme_cache 
     
    #     FileUtils.cp_r Dir.glob("#{RAILS_ROOT}/themes/#{params[:theme]}/views/*.*"), "#{RAILS_ROOT}/app/views" 
    #    flash[:notice] = "#{params[:theme]}"
    update

  end
  
=begin
  ==实现思路==
  =选择一个模板的时候，把这个模板的相关资源Copy到相约的目录下
  =目前需要Copy的资源有images下、javascripts下、stylesheets下的以此Copy
  =到public目录下相应的目录下；
  =然后把layouts目录下的Copy到原来app/layouts目录下。
=end
  
  
  #  def editor_config
  #  
  #  end
  
  def search_theme_directory
    Dir.glob("#{RAILS_ROOT}/themes/[-_a-zA-Z0-9 ]*").collect do |file|
      file if File.directory?(file)      
    end.compact
  end  
  
  def themes_file
    glob = "#{RAILS_ROOT}/themes/[-_a-zA-Z0-9 ]*"
    @theme_cache = Dir.glob(glob).select do |file|
      File.readable?("#{file}/about.theme")
    end.compact 
  end
  # def update
  #
  #     Configuration.find_by_name("app_name").update_attribute("value",params[:app_name])
  #     Configuration.find_by_name("app_url").update_attribute("value",params[:app_url])
  #     Configuration.find_by_name("app_title").update_attribute("value",params[:app_title])
  #     Configuration.find_by_name("app_subtitle").update_attribute("value",params[:app_subtitle])
  #     
  #     Configuration.find_by_name("about_authors").update_attribute("value",params[:about_authors])
  #     Configuration.find_by_name("about").update_attribute("value",params[:about])
  #     Configuration.find_by_name("powered_by").update_attribute("value",params[:powered_by])
  #     
  #     flash[:notice] = 'Configuration updata  succ...'
  #     redirect_to :action => 'index'
  ##    @user = User.find(params[:id])
  ##    if @user.update_attributes(params[:user])
  ##      flash[:notice] = 'User was successfully updated.'
  ##      redirect_to :action => 'show', :id => @user
  ##    else
  ##      render :action => 'edit'
  ##    end
  #  end
  def update
    params.each {|a| 
      @config = Configuration.find_by_name(a[0].to_s)
      @config.update_attribute("value",a[1]) if !@config.blank?
    }
    Configuration.refresh_configs_cache 
    flash[:notice] = '配置修改成功...'
    redirect_to(:controller=>"admin/configurations",:action => 'index')
  end
   
  #模板预览图
  def preview
    theme_img_preview_path = RAILS_ROOT + "/themes/#{params[:theme]}/preview.png"
    send_file theme_img_preview_path, :type => 'image/png', :disposition => 'inline'
  end
end
