source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '3.2.19'

group :production do
  gem 'pg', '~> 0.17.1'
  gem 'newrelic_rpm', '~> 3.9.0.229'
  gem 'asset_sync', '~> 1.0.0'
  gem 'rails_12factor', '~> 0.0.2'
end

group :test, :development do
  gem 'oink', '~> 0.10.1'
  gem 'annotate', '~> 2.6.5'
end

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end


gem 'figaro', '~> 1.0.0.rc1'

# Temporarily move these gems out of the
# assets group due to bug with Heroku
gem 'sass-rails',   '~> 3.2.3'
gem 'compass-rails', '~> 1.0.3'
gem 'compass', '~> 0.12.2'
gem 'jquery-rails', '~> 2.1.4'
gem 'thin', '~> 1.6.2'
gem 'paperclip', "~> 3.4.1"
gem 'aws-sdk', '~> 1.9.2'
gem 'authlogic', '~> 3.0.0'
gem 'cancan', '~> 1.6.9'
gem 'rails_autolink', '~> 1.1.6'
gem 'turbolinks', '~> 2.2.2'
gem 'jquery-turbolinks', '~> 2.0.2'
gem 'kaminari', '~> 0.16.1'
gem 'acts_as_votable', '~> 0.4.0'
gem 'redcarpet', '~> 3.1.2'
gem 'will_paginate', '~> 3.0.0'