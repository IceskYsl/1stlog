class AddNatureId < ActiveRecord::Migration
  def self.up
    add_column :topics, :nature_id, :integer , :default => 1 # 分类ID
  end

  def self.down
  remove_column :topics, :nature_id
  end
end
