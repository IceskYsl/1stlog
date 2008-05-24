class CreateUserGroups < ActiveRecord::Migration
  def self.up
    create_table :user_groups do |t|
      t.column :title, :string        #人群分类名  管理员 设计师 用户等 
      t.column :description, :string  #人群分类描述
      t.column :users_count, :integer, :default => 0 #用户数,计数器缓存
    end
    UserGroup.new(:title=>'管理员', :description=>'管理员').save 
  end

  def self.down
    drop_table :user_groups
  end
end
