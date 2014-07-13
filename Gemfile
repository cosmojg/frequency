source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '3.2.13'

group :production do
  gem 'pg'
  gem 'newrelic_rpm'
  gem 'asset_sync'
end

group :test, :development do
  gem 'sqlite3'
  gem 'oink'
  gem 'annotate'
end

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end


gem 'figaro', '~> 1.0.0.rc1'

# Temporarily move these gems out of the
# assets group due to bug with Heroku
gem 'sass-rails',   '~> 3.2.3'
gem 'compass-rails'
gem 'compass'
gem 'jquery-rails', '~> 2.1.4'

gem "paperclip", "~> 3.0"
gem 'aws-sdk'
gem 'authlogic'
gem 'cancan'
gem 'rails_autolink'
gem 'turbolinks', :git => 'git://github.com/rails/turbolinks.git'
# Temporarily use HEAD turbolinks to fix anchor bug
gem 'jquery-turbolinks'
gem 'kaminari'
gem 'acts_as_votable', '~> 0.4.0'
gem 'redcarpet'
gem 'will_paginate', '~> 3.0.0'