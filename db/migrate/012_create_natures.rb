class CreateNatures < ActiveRecord::Migration
  def self.up
    create_table :natures do |t|
      t.column :title, :string  #性质 原创 转载 翻译
      t.column :description, :string  #描述
      t.column :topics_count, :integer, :default => 0 #文章数
      t.column :position, :integer ,:default => 0     #排列顺序
    end
    Nature.new(:title=>'原创', :description=>'原创的文章',:position=>'0').save 
    Nature.new(:title=>'翻译', :description=>'翻译的文章',:position=>'1').save 
    Nature.new(:title=>'转载', :description=>'转载的文章',:position=>'2').save 
  end

  def self.down
    drop_table :natures
  end
end
