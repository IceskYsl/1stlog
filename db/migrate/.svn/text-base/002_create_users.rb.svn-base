class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login_name, :string  #登录名
      t.column :nickname, :string#现实名
      t.column :hashed_pass,:string  #密码
      t.column :email,:string     #油箱
      t.column :im,:string        #IM
      t.column :personality,:text #个性签名
      t.column :data,:blob        #个性头像
      t.column :content_type,:string        #个性头像格式
      t.column :user_group_id, :integer, :default => 1   #用户等级（管理员，文档写作，用户，UI设计）
      t.column :topics_count, :integer, :default => 0     #发表文章数
      t.column :comments_count, :integer, :default => 0     #发表回复数
      t.column :created_at, :datetime,:default => Time.now #注册时间
      t.column :updated_at, :datetime  #更新时间
      t.column :note,:text #备注
    end
  end

  def self.down
    drop_table :users
  end
end
