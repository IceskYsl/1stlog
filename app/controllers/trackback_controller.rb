  require 'rubygems'
  require 'net/http'
  require 'uri'
  require_gem 'builder'


  
class TrackbackController < ApplicationController
   #before_filter :set_xml_header

  def index
   #接收加密码
   @key = LOG_APP_CONFIG["KEY"]
   @code = params[:id]
   logger.error("code #{@code.to_s}")
   de_code = decode64(@code.to_s).to_s
   logger.debug("de_code: #{de_code}")
   
   de = de_code.to_s.split("#{@key.to_s}")
   logger.error("de: #{de}")
   logger.error("de[0]: #{de[0]}")
   logger.error("de[1]: #{de[1]}")

   if de.length() == 2
     topicid =  de[0]
     logger.error("topicid #{topicid}")
     topic_careted_at =  de[1]
     logger.error("topic_careted_at #{topic_careted_at.to_s}")

    @topic =  Topic.find(:first,
         :conditions => ["id = ?",topicid]
    )
        if @topic.created_at.strftime("%Y%m%d%I%M") == topic_careted_at
           @trackback = TrackBack.new
           @trackback.topic_id = @topic.id
           @trackback.title = whitelist(params["title"])
           @trackback.excerpt = whitelist(params["excerpt"])
           @trackback.blog_name = whitelist(params["blog_name"]) 
           @trackback.url = params["url"]
           @trackback.created_at = Time.now()
           @trackback.updated_at = Time.now()
           @trackback.remote_ip=request.remote_ip
           @trackback.visible = LOG_APP_CONFIG["visible"]
           
           if @trackback.title && @trackback.excerpt && @trackback.blog_name && @trackback.url
              res = fetch("#{@trackback.url}")
              if res.code == 200
                  if @trackback.save
                    res_trackback = builder_trackback_ok_xml
                    send_data res_trackback.to_s, :type => "text/xml", :disposition => 'inline'
                  else
                    res_trackback = builder_trackback_error_xml("保存不成功")
                    send_data res_trackback.to_s, :type => "text/xml", :disposition => 'inline'
                  end
               else
                  res_trackback = builder_trackback_error_xml("can not ping the url...")
                  send_data res_trackback.to_s, :type => "text/xml", :disposition => 'inline'
               end
            else
              res_trackback = builder_trackback_error_xml("some params is null...")
              send_data res_trackback.to_s, :type => "text/xml", :disposition => 'inline'
            end
        else
         res_trackback = builder_trackback_error_xml("time is out..")
         send_data res_trackback.to_s, :type => "text/xml", :disposition => 'inline'
        end
   else
       res_trackback = builder_trackback_error_xml("params is wrong...")
       send_data res_trackback.to_s, :type => "text/xml", :disposition => 'inline'
   end
    rescue 
       logger.error("rescue:")
       res_trackback = builder_trackback_error_xml("rescue..")
       send_data res_trackback.to_s, :type => "text/xml", :disposition => 'inline'
  end
  
  private
  
  def builder_trackback_ok_xml
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, :version=>"1.0",:encoding=>"UTF-8"
    xml.response('version' => '2.0') do
    xml.error("0")
  end
  end
  
  def builder_trackback_error_xml(errmsg)
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, :version=>"1.0",:encoding=>"UTF-8"
    xml.response('version' => '2.0') do
    xml.error("1")
    xml.message("#{errmsg}")
  end
  end
  # create a hash to use when confirming User email addresses
  def confirmation_hash(string)
    Digest::SHA1.hexdigest(string + "1ster")
  end
  
   def set_xml_header
     headers["Content-Type"] = "text/xml; character=utf-8"
     render :layout => false
   end
   
    def fetch(uri_str, limit = 10)
      # You should choose better exception.
      raise ArgumentError, 'HTTP redirect too deep' if limit == 0

      response = Net::HTTP.get_response(URI.parse(uri_str))
      case response
      when Net::HTTPSuccess     then response
      when Net::HTTPRedirection then fetch(response['location'], limit - 1)
      else
        response.error!
      end
    end
  
end
