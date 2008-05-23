require 'rss/maker'
class FeedController < ApplicationController

  def index
    topics = Topic.find :all, :order => "created_at DESC "
    feed = RSS::Maker.make("2.0") do |maker|
      maker.channel.title = "Ruby On Rails Techlogs --1ster..!"
      maker.channel.description = "Ruby On Rails Techlogs:TopicsRSS"
      maker.channel.link = "http://www.1ster.cn/"
      
      maker.items.do_sort = true
      
      topics.each do |topic|
        item = maker.items.new_item
        item.link = "http://www.1ster.cn/topic/#{topic.id}"
        item.title = topic.title
        item.date = topic.created_at
        item.description = topic.body
      end
    end
    send_data feed.to_s, :type => "application/rss+xml", :disposition => 'inline'
  end

  def category
    @category = Category.find(@params[:id])
    topics = Topic.find :all,:conditions => "category_id=#{@category.id}", :order => "created_at DESC "
    feed = RSS::Maker.make("2.0") do |maker|
      maker.channel.title = "Ruby On Rails Techlogs --1ster..!"
      maker.channel.description = "Ruby On Rails Techlogs:#{@category.title}"
      maker.channel.link = "http://www.1ster.cn/category/#{@category.id}"
      
      maker.items.do_sort = true
      
      topics.each do |topic|
        item = maker.items.new_item
        item.link = "http://www.1ster.cn/topic/#{topic.id}"
        item.title = topic.title
        item.date = topic.created_at
        item.description = topic.body
      end
    end
    send_data feed.to_s, :type => "application/rss+xml", :disposition => 'inline'
  end

  def type
    @type = Type.find(@params[:id])
    topics = Topic.find :all,:conditions => "type_id=#{@type.id}", :order => "created_at DESC "
    feed = RSS::Maker.make("2.0") do |maker|
      maker.channel.title = "Ruby On Rails Techlogs --1ster..!"
      maker.channel.description = "Ruby On Rails Techlogs:#{@type.title}"
      maker.channel.link = "http://www.1ster.cn/category/#{@type.id}"
      
      maker.items.do_sort = true
      
      topics.each do |topic|
        item = maker.items.new_item
        item.link = "http://www.1ster.cn/topic/#{topic.id}"
        item.title = topic.title
        item.date = topic.created_at
        item.description = topic.body
      end
    end
    send_data feed.to_s, :type => "application/rss+xml", :disposition => 'inline'
  end

  def tag
    @tag = Tag.find(@params[:id])
    topics = Topic.find :all,:conditions => "tag_id=#{@tag.id}", :order => "created_at DESC "
    feed = RSS::Maker.make("2.0") do |maker|
      maker.channel.title = "Ruby On Rails Techlogs --1ster..!"
      maker.channel.description = "Ruby On Rails Techlogs:#{@tag.title}"
      maker.channel.link = "http://www.1ster.cn/tag/#{@tag.id}"
      
      maker.items.do_sort = true
      
      topics.each do |topic|
        item = maker.items.new_item
        item.link = "http://www.1ster.cn/topic/#{topic.id}"
        item.title = topic.title
        item.date = topic.created_at
        item.description = topic.body
      end
    end
    send_data feed.to_s, :type => "application/rss+xml", :disposition => 'inline'
  end

  def topic
    @topic = Topic.find(@params[:id])
    feed = RSS::Maker.make("2.0") do |maker|
      maker.channel.title = "Ruby On Rails Techlogs --1ster..!"
      maker.channel.description = "Ruby On Rails Techlogs:#{@topic.title}"
      maker.channel.link = "http://www.1ster.cn/topic/#{@topic.id}"      
      maker.items.do_sort = true
        item = maker.items.new_item
        item.link = "http://www.1ster.cn/topic/#{@topic.id}"
        item.title = @topic.title
        item.date = @topic.created_at
        item.description = @topic.body

    end
    send_data feed.to_s, :type => "application/rss+xml", :disposition => 'inline'
  end
  
  def comments
    comments = Comment.find :all, :order => "created_at DESC "
    feed = RSS::Maker.make("2.0") do |maker|
      maker.channel.title = "Ruby On Rails Techlogs"
      maker.channel.description = "Ruby On Rails Techlogs:CommentsRSS"
      maker.channel.link = "http://www.1ster.cn/"
      
      maker.items.do_sort = true
      
      comments.each do |comment|
        item = maker.items.new_item
        item.link = "http://www.1ster.cn/topic/#{comment.id}"
        item.title = "RE:"+comment.topic.title
        item.date = comment.created_at
        item.description = comment.body
      end
    end
    send_data feed.to_s, :type => "application/rss+xml", :disposition => 'inline'
  end
end
