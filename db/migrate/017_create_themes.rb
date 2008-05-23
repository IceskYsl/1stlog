class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string :name,:time,:author,:description,:homepage
      t.string :preview,:pwd
      t.string :useit, :default => '0' #
      t.timestamps
    end
    Theme.load_theme_directory
    
  end

  def self.down
    drop_table :themes
  end
  
end
