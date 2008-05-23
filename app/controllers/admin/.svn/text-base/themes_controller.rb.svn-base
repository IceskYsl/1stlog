class Admin::ThemesController < Admin::IndexController
  layout "admincp"
  
  def index
    
  end
  
  #  def list
  #    themes_file
  #  end

  def show
  end
  

  
  def list
    @themes = Theme.find(:all,:order=>"useit DESC")
    @theme = Theme.get_use_item
  end
  
  def preview
    send_file(Theme.find(params[:id]).preview)
  end
  
end
