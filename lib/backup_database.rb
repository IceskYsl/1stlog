#!/usr/bin/ruby

# Backs up the databases of applications on Rails Machine.
# This script is intended to be called by cron on your Rails Machine.
#
# Andrew Stewart, AirBlade Software Ltd (boss at airbladesoftware dot com)
# Feedback gratefully received.
#
# Version 0.1

require 'rubygems'
require 'logger'
require 'yaml'

# Configure the script here.  You won't need to change anything
# unless you have modified your Rails Machine setup.
# APPS_PATH   = '/var/www/apps'             # Path to all your apps
APPS_PATH   = 'F:\\webroot'             # Path to all your apps

EXCLUSIONS  = %w( 1stlog )                 # Any directories or apps to exclude
BACKUP_PATH = 'F:/webroot/backup/storage'           # Where to store the backups
TIMESTAMP   = '%Y%m%d%H%M%S'              # Timestamp for databases' backup files
LOG_FILE    = 'F:/webroot/backup/backup.log'   # Where to log activity

# The body of the script follows.

log = Logger.new(LOG_FILE, 5, 10*1024)
log.level = Logger::DEBUG

log.info 'Starting database backups'
Dir["#{APPS_PATH}/*"].each do |entry|
  app = File.basename entry
  app_backup_path = "#{BACKUP_PATH}/#{app}"
  next if File.file?(entry) || EXCLUSIONS.include?(app)

  Dir.mkdir app_backup_path unless File.exist? app_backup_path
  config = YAML.load_file(File.join(entry, 'current', 'config', 'database.yml'))['production']
  database, username, password = config['database'], config['username'], config['password']
  db_backup = "#{app_backup_path}/#{database}-#{Time.now.strftime(TIMESTAMP)}.sql.gz"
  db_dump_cmd = "mysqldump -u #{username} -p#{password} -x #{database} | gzip - > #{db_backup}"
  log.debug "Executing: #{db_dump_cmd}"
  `#{db_dump_cmd}`
  log.info "Backed up #{database} to #{db_backup}"
end
log.info 'Finished database backups'

