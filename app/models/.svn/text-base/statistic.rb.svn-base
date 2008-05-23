class Statistic < ActiveRecord::Base

  #从DB中加载统计信息
  def self.load_statistics
    logger.info("start load_statistics:$cached_statistics.size=#{$cached_statistics.size}")
    get_all_statistics.each do |config|
      $cached_statistics[config.name] = config.value
    end
    logger.info("end load_statistics:$cached_statistics.size=#{$cached_statistics.size}")
  end
  
  def self.get_all_statistics
    find(:all)
  end
  
end
