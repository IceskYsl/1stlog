class Configuration < ActiveRecord::Base

  #重新刷新缓存
  def self.refresh_configs_cache
    $cached_configs.clear
    load_configs
  end
  
  #从DB中加载系统配置信息
  def self.load_configs
    logger.info("start load_configs:$cached_configs.size=#{$cached_configs.size}")
    get_all_config.each do |config|
      $cached_configs[config.name] = config.value
    end
    $cached_configs['theme_id'] = Theme.get_use_item.id
    logger.info("end load_configs:$cached_configs.size=#{$cached_configs.size}")
  end
  
 
  
  #根据名字取一个配置
  def self.get_a_config_by_name(name)
    find_by_name(name)
  end
  
  def self.get_all_config
    find(:all)
  end
  
end
