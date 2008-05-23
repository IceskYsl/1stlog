class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.column :topic_id,:integer  #主题ID
      t.column :filename, :string  #文件名
      t.column :filetype, :string  #类型
      t.column :filesize, :integer, :default => 0  #大小
      t.column :filepath, :string, :default => ""  #路径
      t.column :downloads, :integer, :default => 0  #下载次数
      t.column :created_at, :datetime #上传时间
      t.column :updated_at, :datetime #修改时间
      t.column :isimage, :integer, :default => 0  #下载次数

    end
  end

  def self.down
    drop_table :attachments
  end
end
