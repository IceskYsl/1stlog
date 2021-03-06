require 'net/http'
require 'uri'
require 'rexml/document'
require 'rss/1.0'
require 'rss/2.0'

class PublishController < ApplicationController
  before_filter :nav
  before_filter :authorize,:only=>['index','create_by_rss']
  layout "index"

  def index
    @tags = Tag.find(:all)
    @topic = Topic.new
  end


  #根据提交的RSS 的URL 来创建文章，并加上原文的地址等信息
  def create_by_rss
    @topic = Topic.new(params[:topic])
    if  @topic.tag_id == 0 
      @tag = Tag.new
      @tag.title = params[:tag_title]
      @tag.save
      @topic.tag_id = @tag.id
    else
    
    end
    @topic.user_id = session[:user_id]
    @topic.remote_ip=request.remote_ip
    #    bodydate = fetch_data(params[:uri])
    #    
    #    result = RSS::Parser.parse(bodydate,false)
    #    @topic.body +=  '<br />' + result.channel.title
    #    result.items.each_with_index do |item,i|
    #      @topic.body +=  '<br />' + item.description if i<2
    #    end 
    @topic.body = '引言:' + @topic.body + '<br/>'
    feed = RSS::Parser.parse(open(params[:uri]).read, false) 
    @topic.body +=  '<br />*来源:*' + feed.channel.title 
    @topic.body +=  '<br />*地址:*' + feed.channel.link  
    feed.items.each do |item| 
      @topic.body += '<br />*标题:*' + item.title 
      @topic.body += '<br />*内容摘要:*<br />' + item.description
    end 
    #@topic.user_id =
    if @topic.save
      flash[:notice] = 'Topic was successfully created.'
      redirect_to(:controller=>"index",:action => 'index')
    else
      render :action => 'index'
    end
  end


  def save_feed(url)
    feed = RSS::Parser.parse(open(url).read, false) 
    puts "=== blog名称: #{feed.channel.title} ===" 
    feed.items.each do |item| 
      puts item.title 
      puts " (#{item.link})"
      puts  item.description
    end 
  end



  def fetch_data(uri_str)
    uri = URI.parse(uri_str)
  
    http = Net::HTTP.new uri.host, 80
    resp, data = http.get uri.path, nil
    aString = ''
    aString += 'Code = ' + resp.code.to_s + '<br />'
    aString += 'Message = ' + resp.message + '<br />'
    resp.each { |key, val| aString += key + ' = ' + val + '<br />' }
    aString += 'Datagram Length : '+ data.length.to_s + '<br />'
    #render_text aString
    data.inspect      # real http data packet
  end 
  #  Code = 200
  #  Message = OK
  #  last-modified = Thu, 18 Aug 2005 14:08:33 GMT
  #  connection = close
  #  content-type = text/xml;charset=utf-8
  #  etag = BwYHNkx/OBe7DlAfqnqxeOKjuoE
  #  date = Fri, 19 Aug 2005 05:36:01 GMT
  #  server = Apache
  #  transfer-encoding = chunked
  #  
  #  
end
