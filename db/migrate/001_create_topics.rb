class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.column :title, :string  #标题
      t.column :body, :text     #内容
      t.column :created_at, :datetime #发表时间
      t.column :updated_at, :datetime 
      t.column :type_id, :integer, :default => 0      #大类别 新闻 博客  文章
      t.column :category_id, :integer, :default => 0  #小分类 可以二次分类
      t.column :tag_id, :integer, :default => 0  #TAG
      t.column :attachment_id, :string, :default => ""  #附件
      t.column :user_id, :integer, :default => 0      #发表者ID
      t.column :views_count, :integer, :default => 0  #查看次数
      t.column :comments_count, :integer, :default => 0 #计数器缓存，回复数    
      t.column :istop, :integer, :default => 0       #是否是置顶
      t.column :remote_ip ,:string   , :default =>""               #IP地址
      t.column :keys ,:string  , :default =>""                     #关键字
      t.column :visible ,:integer , :default => 1                  #可见性（0、1、2、3）
      t.column :closecomment ,:integer , :default => 0             #关闭评论（0、1）
      t.column :readpassword ,:string, :default =>""               #阅读密码
      t.column :showsnippet ,:integer , :default => 1                 #是否截取
      t.column :snippetcounts ,:integer , :default => 200             #截取字数
    end
  end

  def self.down
    drop_table :topics
  end
end
