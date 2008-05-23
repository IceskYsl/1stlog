class AddTrackBacksCount < ActiveRecord::Migration
  def self.up
  add_column :topics, :track_backs_count, :integer , :default => 0 # 文章引用数
  end

  def self.down
   remove_column :topics, :track_backs_count
  end
end
