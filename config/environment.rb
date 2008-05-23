# Be sure to restart your web server when you modify this file.
require 'rubygems'
$KCODE = 'u'
require 'jcode'
require 'yaml'

#gem 'soap4r'
#require_dependency 'rails_patch/text_helper' 
# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'
# ENV['RAILS_ENV'] = 'production' 
RAILS_ENV = 'production' unless defined? RAILS_ENV 
RAILS_GEM_VERSION = '2.0.2'
# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.0.2' unless defined? RAILS_GEM_VERSION
# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')


Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]


  config.load_paths += %W(
    vendor/redcloth/lib
  ).map {|dir| "#{RAILS_ROOT}/#{dir}"}.select { |dir| File.directory?(dir) }
  
  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  config.log_level = :warn
  config.action_controller.perform_caching = true
  # filter_parameter_logging("password") if RAILS_ENV == "production" 
  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.action_controller.session = {
    :session_key => '_1stlog_session',
    :secret      => '716af8b3a296af304333ff73528c71293557816adb77c10a858a138191130f68c735afa743dc3bd90ea6754b673161b9aa9d08f5cec1a4ad4af2830fce0134b8'
  }

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  #  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(:my_format => '%y-%m-%d %H:%M')
  #  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update(:data_ymd => '%Y-%m-%d %H:%M')
  # See Rails::Configuration for more options
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/x-mobile", :mobile

# Include your application configuration below
# Load included libraries.
require 'redcloth'




