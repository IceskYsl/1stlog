class Attachment < ActiveRecord::Base
  belongs_to :topic 

  def self.get_all_items(page,per_page="10")
    paginate :per_page => per_page, :page => page,
      :order => 'created_at DESC '
  end
  
end
