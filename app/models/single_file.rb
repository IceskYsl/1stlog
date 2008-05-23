class SingleFile < ActiveRecord::Base


   def self.save(topic)
    @attachment = Attachment.new
    @uploaded_file = topic['attachment_id']
    @filename = sanitize_filename(@uploaded_file.original_filename)
    @attachment.filename = @filename
    @attachment.filetype = @uploaded_file.content_type
    if @attachment.filetype =~ /^image/
    @attachment.isimage = 1
    else
     @attachment.isimage = 0
    end
    @attachment.filesize = @uploaded_file.size
    ##
    if !File.exists?(File.dirname(self.path))
      FileUtils.mkdir_p(File.dirname(self.path))
    end
    if @uploaded_file.instance_of?(Tempfile)
      FileUtils.copy(@uploaded_file.local_path, self.path)
    else
      File.open(self.path, "wb") { |f| f.write(@uploaded_file.read) }
    end
    #write_attribute(:file, self.simple_path)
    @attachment.filepath = self.path
    if @attachment.save 
        @attachment
    else

    end

    #  
  end
  


  def after_destroy
    if File.exists?(self.file)
      File.delete(self.file)
      Dir.rmdir(File.dirname(self.file))
    end
  end

  def self.simple_path
    "upload/#{@user_id}/#{@filename}"
  end

  def self.path
    File.expand_path("#{RAILS_ROOT}/upload/#{@user_id}/#{@filename}")
  end

private
  def self.sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name) 
    # replace all none alphanumeric, underscore or perioids with underscore
    just_filename.gsub(/[^\w\.\_]/,'_') 
  end
end

