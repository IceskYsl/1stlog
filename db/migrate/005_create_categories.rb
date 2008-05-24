class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :parent_id, :integer, :default => 0      #大类别 新闻 博客  文章
      t.column :title, :string  #小类分类名 新闻 博客 公告的二级分类
      t.column :desc, :string  #小分类分类描述
      t.column :position, :integer ,:default => 0     #排列顺序
      t.column :topics_count, :integer, :default => 0 #文章数
    end
    
    Category.new(:parent_id => 0,:title=>'默认分类', :desc => '默认的分类',:position=>'0').save 
    Category.new(:parent_id => 1,:title=>'二级分类', :desc => '默认的二级分类',:position=>'0').save 
  end

  def self.down
    drop_table :categories
  end
end
