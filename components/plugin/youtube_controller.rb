require 'rubygems'
require 'youtube'
class Plugin::YoutubeController < ActionController::Base
    uses_component_template_root 
#    before_filter :init_youtube

DEVELOPER_ID = "-aUPn8U5FrU"
USERNAME = 'iceskysl'


    def youtube
     youtube = YouTube::Client.new DEVELOPER_ID # Get one here: <http://youtube.com/my_profile_dev>. 
    end
    
    #返回指定用户的信息
    def profile
      @profile = youtube.profile(USERNAME)
#      puts "age: " + profile.age.to_s
    end
    
    #取用户名收藏的Youtube
    def my_favorite_videos
      @videos = youtube.favorite_videos(USERNAME)
    end
    
    def featured_videos
      @featured_videos = youtube.favorite_videos(USERNAME)
    end
    #取回我的好友
    def my_friends
    @friends= youtube.friends(USERNAME)
    end
    
    

end