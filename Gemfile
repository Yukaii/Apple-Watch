source 'https://rubygems.org'

ruby '2.2.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem "compass-rails", github: "Compass/compass-rails", branch: "master"
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'slim'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'dotenv-rails', :groups => [:development, :test]

gem 'pry-rails'
gem 'awesome_print', :require => false
gem "hirb", :require => false
gem "hirb-unicode", :require => false

gem 'kaminari'

# gem for parsers
gem 'httpclient'
gem 'rest-client'
gem 'nokogiri'

# task runner gem
gem 'whenever', :require => false

gem 'bootstrap-sass', '~> 3.3.4'

gem 'rails-observers'

gem 'newrelic_rpm'

gem 'devise'

gem 'sidekiq'

gem "puma"

gem 'redis'
gem 'redis-namespace'

# gem 'rack-google-analytics'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'better_errors'
  gem "binding_of_caller"
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', require: false
  gem 'guard-rspec', require: false
  gem 'faker'
  gem "factory_girl_rails", "~> 4.0"
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'meta_request'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.6'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'heroku-deflater'
end

gem 'rack-mini-profiler', require: false
gem 'flamegraph'
gem 'stackprof' # ruby 2.1+ only
gem 'memory_profiler'
