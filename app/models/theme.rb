class Theme < ActiveRecord::Base

  #初始化
  def self.load_theme_directory
    themes_root = "#{RAILS_ROOT}/themes/[-_a-zA-Z0-9 ]*"
    Dir.glob(themes_root).each do |file|
      if File.readable?("#{file}/about.markdown") && File.directory?(file) 
        theme = YAML::load(File.open("#{file}/about.markdown"))
        t = Theme.new(:name=>theme['NAME'],:pwd=>"#{file}",:time=>theme['TIME'],:description=>theme['DESCRIPTION'],:preview=>"#{file}/images/preview.png",:author=>theme['AUTHOR'],:homepage=>theme['HOMEPAGE'])
        t.useit = '1' if get_use_item.blank?
        t.save
      end
    end
    $cached_configs['theme_id'] = get_use_item.id
  end  
  
  
  def self.get_use_item
    find(:first,:conditions=>["useit = 1"])
  end
  
  
  
end

