source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'


gem 'rails', '~> 5.2.4', '>= 5.2.4.5'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false

# ===============================================================
#                      we added these gems
# ===============================================================

gem 'devise'
gem 'rails_admin'
gem 'faker'
gem 'rubocop', require: false
gem 'sprockets-rails', :require => 'sprockets/railtie'

gem 'hirb'
gem 'cancancan'
gem 'pg'
gem 'multiverse'
gem 'rails_admin_import', '~> 2.2'

gem 'chartkick'
gem 'groupdate'
gem 'figaro'
gem 'slack-notifier'
gem 'date'
gem 'sendgrid-ruby'
gem 'ibm_watson'

gem "zendesk_api", '1.28.0'
#gem "dropbox-api"
gem 'gmaps4rails'

#gem "twilio-ruby"
#gem 'dropbox_api'






# ===============================================================
# ===============================================================


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.1.0'
  gem 'capybara', '>= 2.15'
  
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-bundler', '>= 1.1.0'
  gem 'rvm1-capistrano3', require: false
  gem 'capistrano3-puma'
end

group :test do
  
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'underscore-rails', '~> 1.8', '>= 1.8.3'

gem "newrelic_rpm"


gem 'httparty'

gem 'simplecov', require: false, group: :test

gem 'excon'


# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'json'
gem 'jquery-rails'
gem 'google-analytics-rails', '~> 1.1', '>= 1.1.1'
gem 'newrelic_rpm'
