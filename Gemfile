source 'http://rubygems.org'

gem "warden"
gem "bcrypt-ruby", "~> 2.1.4"

gem 'sinatra', '1.2.6'
gem "thor"
gem "rack-flash"
gem "sinatra-redirect-with-flash"

#gem 'ruby-mysql', "2.9.3", :group => [:development, :test]
gem "redis"
#gem "data_mapper"
group :production do
#  gem "pg"
#  gem "dm-postgres-adapter"
  gem "jsmin"
  gem "cssmin"
  gem "remote_syslog_logger"
end
#gem "resque"

#gem "dm-mysql-adapter", :group => [:development, :test]

gem "rails_config"

gem "haml"
#gem "less"

# Use unicorn as the web server
gem 'unicorn'

# keep running server up to date
gem "shotgun", :group => :development

gem 'ruby-debug19', :require => 'ruby-debug'

gem 'nokogiri'
