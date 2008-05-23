class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.string :name
      t.string :value
      t.timestamps
    end
    
    #初始化统计信息
    %w{
    viewed_count tags_count categories_count tags_count 
    links_count topics_count usergroups_count 
    users_count comments_count trackbacks_count 
    attachments_count}.each do |s|
      Statistic.new(:name=>s,:value=>"0").save
    end
    
    #初始化建站时间
    { 'start' =>Time.now.to_s(:db)}.each do |k,v|
      Statistic.new(:name=>k,:value=>v).save
    end
    
    #初始化版权信息等
    YAML::load(File.open("#{RAILS_ROOT}/config/appconfig.yml")).each do |k,v|
      Statistic.new(:name=>k,:value=>v).save
    end
    
  end

  def self.down
    drop_table :statistics
  end
end
 