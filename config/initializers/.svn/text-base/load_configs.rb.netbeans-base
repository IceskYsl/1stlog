# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
LOG_APP_CONFIG = YAML::load(File.open("#{RAILS_ROOT}/config/appconfig.yml"))

#申请一个全局变量用来存放系统配置
$cached_configs = Hash.new
$cached_statistics = Hash.new
$application = {}
#初始化的时候加载
begin
  Configuration.load_configs 
  Statistic.load_statistics
rescue 
   #logger.info("load_configs error")
end