class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
    t.column :title, :string
    t.column :description, :string
    t.column :topics_count, :integer ,:default => 0 
    end
  end

  def self.down
    drop_table :tags
  end
end
