require 'flickr'

class Plugin::FlickrController < ActionController::Base
    uses_component_template_root 
EMAIL = 'iceskysl.1sters'    
PASSWORD = '123456123'
    
    def basics
      # basics
      flickr = Flickr.new                           # create a flickr client
      flickr.login(EMAIL, PASSWORD)                 # log in for actions that require it
      @users =  flickr.users                                  # get all users currently online
#      flickr.photos                                 # get the 100 most recent public photos
#      flickr.tag('red')                             # search for photos tagged with 'red'
#      flickr.groups                                 # get all active public groups
    end
end