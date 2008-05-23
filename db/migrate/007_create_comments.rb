class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :body,:text    #内容
      t.column :type_id,:integer  #大分类ID
      t.column :topic_id,:integer  #主题ID
      t.column :name,:string #回复者姓名
      t.column :email,:string, :default => " @ " #回复者EAMIL
      t.column :website,:string , :default => "http://" #回复者WEBSITE
      t.column :created_at ,:datetime #回复时间
      t.column :remote_ip ,:string    #回复IP地址
    end
  end

  def self.down
    drop_table :comments
  end
end
