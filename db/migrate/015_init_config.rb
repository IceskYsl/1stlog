class InitConfig < ActiveRecord::Migration
  def self.up
  Configuration.new(:group=>'Select',:name=>"editor_style",:title=>'编辑器风格', :description=>'选择你喜欢的编辑器,有四种风格',:value=>'default').save 
  Configuration.new(:group=>'Select',:name=>"editor_mode",:title=>'编辑器模式', :description=>'选择你喜欢的编辑器模式,简单模式还是完全模式',:value=>'简单模式').save 
  end

  def self.down
  end
end
