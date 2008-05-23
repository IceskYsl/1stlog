class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.column :name, :string  #名
      t.column :title, :string  #看到的名
      t.column :description, :string  #描述
      t.column :value, :text  #值
      t.column :group, :string  #值
    end
    
    #系统显示信息配置
    Configuration.new(:group=>'String',:name=>"name",:title=>'博客名称', :description=>'填写您的博客标题',:value=>"My 1stlog site").save 
    Configuration.new(:group=>'String',:name=>"url",:title=>'地址', :description=>'填写您的博客地址',:value=>'http://1stlog.1sters.com').save 
    Configuration.new(:group=>'String',:name=>"title",:title=>'标题', :description=>'填写您的博客标题',:value=>'My 1stlog Title').save 
    Configuration.new(:group=>'String',:name=>"subtitle",:title=>'副标题', :description=>'填写您的博客副标题',:value=>'Here is my 1stlog subTitle..').save 
    Configuration.new(:group=>'String',:name=>"key",:title=>'密匙', :description=>'填写您Tacback的密匙',:value=>'myownkeys').save 
    Configuration.new(:group=>'String',:name=>"icp",:title=>'备案', :description=>'填写您的备案信息',:value=>'备案信息').save 
    
    
    Configuration.new(:group=>'Text',:name=>"about",:title=>'关于我们', :description=>'填写您的博客描述',:value=>'这个博客是做什么的，或者说这里是您的表述信息等等.').save 
    Configuration.new(:group=>'Text',:name=>"about_authors",:title=>'贡献者描述', :description=>'填写你对网站贡献者的描述信息',:value=>'A little something about the author. Nothing lengthy, just an overview.').save 
    Configuration.new(:group=>'Text',:name=>"powered_by",:title=>'网站标识', :description=>'填写你的网站标识,支持HTML',:value=>'© 2007 by 1stlog  <br/> Powered by 1sters.com | Designed for 1stlog by IceskYsl').save 

    

    Configuration.new(:group=>'Select',:name=>"viewmode",:title=>'显示模式', :description=>'选择您的显示模式',:value=>'normal').save 




    #显示条数配置信息
    Configuration.new(:group=>'Integer',:name=>"normal_shownum",:title=>'常规显示文章数', :description=>'每页显示的文章数,只能是数字',:value=>'10').save 
    Configuration.new(:group=>'Integer',:name=>"list_shownum",:title=>'列表显示文章数', :description=>'列表显示的文章数,只能是数字',:value=>'50').save 
    Configuration.new(:group=>'Integer',:name=>"comment_shownum",:title=>'每页显示评论数', :description=>'每页显示的评论数,只能是数字',:value=>'10').save 
    Configuration.new(:group=>'Integer',:name=>"trackback_num",:title=>'每页显示引用数', :description=>'每页显示的引用数,只能是数字',:value=>'10').save 
    Configuration.new(:group=>'Integer',:name=>"last_entries_num",:title=>'最新文章数', :description=>'侧边栏显示的最新文章数,只能是数字',:value=>'10').save 
    Configuration.new(:group=>'Integer',:name=>"hot_entries_num",:title=>'最热文章数', :description=>'侧边栏显示的最热文章数,只能是数字',:value=>'10').save 
    Configuration.new(:group=>'Integer',:name=>"last_comments_num",:title=>'最新评论数', :description=>'侧边栏显示的最新评论数,只能是数字',:value=>'10').save 
    Configuration.new(:group=>'Integer',:name=>"hot_tags_num",:title=>'最热门标签数', :description=>'侧边栏显示的最热门标签数,只能是数字',:value=>'25').save   
	
    #显示区域设置
    Configuration.new(:group=>'Boolean',:name=>"show_natures",:title=>'显示文章性质', :description=>'是否显示文章性质分类',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_categories",:title=>'显示分类', :description=>'是否显示分类',:value=>'1').save 	
    Configuration.new(:group=>'Boolean',:name=>"show_archives",:title=>'显示归档', :description=>'是否显示归档',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_links",:title=>'显示链接', :description=>'是否显示友情链接',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_statistics",:title=>'显示统计信息', :description=>'是否显示统计信息',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_hot_entries",:title=>'显示最热文章', :description=>'是否显示最热文章',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_last_entries",:title=>'显示最新文章', :description=>'是否显示最新文章',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_hot_tags",:title=>'显示最新标签', :description=>'是否显示最热门标签',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_last_comments",:title=>'显示最新评论', :description=>'是否显示最新评论',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_authors",:title=>'显示作者列表', :description=>'是否显示作者列表',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_metas",:title=>'显示Meta信息', :description=>'是否显示Meta信息',:value=>'1').save 
    Configuration.new(:group=>'Boolean',:name=>"show_visitors",:title=>'显示访问者', :description=>'是否显示访问者位置',:value=>'0').save 
    Configuration.new(:group=>'Boolean',:name=>"show_adsense",:title=>'显示广告', :description=>'是否显示广告',:value=>'0').save 
    Configuration.new(:group=>'Boolean',:name=>"show_noisy_image",:title=>'显示验证码', :description=>'是否显示验证码',:value=>'0').save
  end

  def self.down
    drop_table :configurations
  end
end
