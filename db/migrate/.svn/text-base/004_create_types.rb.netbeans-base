class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types do |t|
      t.column :title, :string  #大类分类名 新闻 博客 公告
      t.column :description, :string  #大类分类描述
      t.column :topics_count, :integer, :default => 0 #文章数
      t.column :position, :integer ,:default => 0     #排列顺序
    end
    Type.new(:title=>'一级分类', :description=>'默认的种类',:position=>'0').save 
  end

  def self.down
    drop_table :types
  end
end
