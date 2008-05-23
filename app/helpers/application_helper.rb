# Methods added to this helper will be available to all templates in the application.
#require 'related_select_form_options_helper'
#ActionView::Base.load_helpers(File.dirname(__FILE__) + "/../../lib/")
module ApplicationHelper
  #    def textilize(text)
  #      require_library_or_gem "superredcloth" unless Object.const_defined?(:SuperRedCloth)
  #      if text.blank?
  #      ""
  #      else
  #      textilized = SuperRedCloth.new(text)
  #      textilized.to_html
  #      end
  #    end # def textilize 
  #  def app_name
  #    @app_name.value
  #  end
  #  
  #取得当前的类
  def  get_cure_class(cotroller_name,cure)
    if cotroller_name  == cure
      "cpnavmenu_cure"
    else
      "cpnavmenu"
    end
  end
  
  #版权
  def current_year
    Time.now.year
  end

  def year_range( start_year = current_year )
    [start_year, current_year].sort.uniq.join('-')
  end

  
  def name
    @app_name.value  ||= "Ruby On Rails Techlogs v1.0.0  --1ster..!"
    @app_name.value << " --Powered By 1stlog"
   
    if !@topic_title.blank?
      @topic_title << "::" << @app_name.value 
    else
      @app_name.value
    end
  end
  
  def title
    @app_title.value ||="Ruby On Rails Techlogs"
  end
  
  def subtitle
    @app_subtitle.value ||= "我们就这样抱着笑着还流着泪..."
  end
  
  def url
    @app_url.value ||= "http://www.1ster.cn"
  end
  
  def about
    @about.value ||= "Techlogs,撰写、翻译、收集整理一些RubyOnRails的相关资料、文章、技巧,做一个实用的ROR知识库,我们力求多记录一些，多给后来者提供更多的参考资料,如果你想为ROR贡献一份自己的 力量,请联系我们，一起完善这个大家的知识库!"
  end
  
  def about_authors
    @about_authors.value ||= "A little something about the author. Nothing lengthy, just an overview."
  end
  
  def powered_by
    @powered_by.value ||= "© 2007 by Techlog <br/> Powered by Techlog | Designed for Chungo by Cordobo"
  end
  
  
  def ischecked(name)
    name.value.to_i==1? true : false
  end
  

  
end
