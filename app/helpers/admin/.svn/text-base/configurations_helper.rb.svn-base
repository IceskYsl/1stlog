module Admin::ConfigurationsHelper
  #before_filter :initdata

  
  #  def show_items
  #  items = []
  #  #@tags_of_forum = []
  #  items << @show_natures << @show_categories << @show_archives << @show_links << @show_statistics << @show_hot_entries << @show_last_entries <<
  #  @show_hot_tags << @show_last_comments << @show_authors << @show_metas << @show_visitors << @show_adsense 
  #  end
  
  #  def show_num
  #    show_nums= []
  #    %w{hot_entries_num last_entries_num last_comments_num hot_tags_num trackback_num   comment_shownum normal_shownum list_shownum }.each do |show_num_item|
  #     show_nums << Configuration.find_by_name(show_num_item)
  #    end
  #    show_nums
  #  end
  
  def isradio(name)
    name == @app_theme.value ? true : false
  end
  
  def select_tag_items(sel)
    case sel.to_s
    when "editor_mode" 
      return   select_tag_editor_mode 
    when "editor_style"
      return select_tag_editor_style
    when "viewmode"
      return select_tag_viewmod
    else
      return select_tag_editor_style
    end
  end
  
  def select_tag_viewmod
    {'普通模式' => '1' , '列表模式' => '0'}
  end
  
  def select_tag_editor_mode
    %w{ 简单模式 完全模式 }
  end
  
  def select_tag_editor_style
    %w{ Default TexTile Tiny_MCE FCK}
  end
  
  def yes_not_check
    %w{'开启' => '1'  '关闭' => '0'}
  end
  
end
