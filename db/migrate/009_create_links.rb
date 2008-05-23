class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
    t.column :parent_id, :integer ,:default => 0     #小分类的父类 0代表是父类
    t.column :title, :string
    t.column :description, :string
    t.column :weburl, :string, :default => "http://"
    t.column :position ,:integer
    t.column :visible, :integer ,:default => 1 #可见？
    end
  end

  def self.down
    drop_table :links
  end
end
