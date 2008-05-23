class CreateTrackBacks < ActiveRecord::Migration
  def self.up
    create_table :track_backs do |t|
    t.column :topic_id, :integer  #文章ID 
    t.column :title, :string ,:default => "TrackBack Titel"
    t.column :excerpt, :string ,:default => "TrackBack Excerpt"  
    t.column :blog_name, :string ,:default => "Blog Name" 
    t.column :url, :string ,:default => "url" 
    t.column :created_at, :datetime #创建时间
    t.column :updated_at, :datetime #更新时间
    t.column :remote_ip ,:string   , :default =>"" #来源IP
    t.column :visible, :integer,:default => 0  #是否可见 
    end
  end

  def self.down
    drop_table :track_backs
  end
end
