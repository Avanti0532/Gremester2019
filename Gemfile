ruby '2.4.4'
source 'https://rubygems.org'
gem 'thredded', '~> 0.16.10'
gem 'where-or'
gem 'autoprefixer-rails', '8.6.5'
gem 'rails-ujs', '~> 5.1.0.beta1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11'
gem 'mysql2'
gem 'jasmine'
gem 'jasmine-jquery-rails'
# Added haml file
gem 'haml'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 2.7.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use devise for storing password and authentication
gem "devise", ">= 4.6.0"
# Use bcrypt for password encryption
gem 'bcrypt'
gem 'bootstrap-datepicker-rails'
# Use dotenv-rails to include .env file
gem 'dotenv-rails'
gem 'twitter-bootswatch-rails', '~> 3.3.4'
gem 'twitter-bootswatch-rails-helpers'
gem "therubyracer"
gem 'rails_admin'
gem 'poltergeist'
# Use jquery as the JavaScript library
gem "shrine", "~> 2.0"
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'gon'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# travis for continous integration setup
gem 'travis'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'shrine-google_cloud_storage'
gem 'puma'
# Use Unicorn as the app server
# gem 'unicorn'
gem 'rails-assets-jquery', source: 'https://rails-assets.org'
gem 'rails-assets-datatables', source: 'https://rails-assets.org'

gem 'jquery-datatables-rails'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  #Use sqlite3 as the database for Active Record
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'rspec', '~>3.5'
  gem 'rspec-rails'
  gem 'simplecov', :require=>false
  gem 'sqlite3', '~> 1.3.6'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'shoulda-matchers', '~> 3.1'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :test do
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner'
  gem 'rspec-expectations'
  gem 'factory_girl_rails'
  gem 'factory_girl'
  gem 'faker'
  gem 'regressor', '~> 0.6.2'
end

group :production do
  #for Heroku production deployment
  # Note rails prior to 5.15 do not support the pg 1.0.0 module
  gem 'pg', '~> 0.21'
  gem 'rails_12factor'
  gem 'shrine-google_cloud_storage'
end