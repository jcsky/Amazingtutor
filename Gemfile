source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'json'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# backend
#devise
gem 'clipboard-rails', '~> 1.5', '>= 1.5.10'
gem 'devise'
# omniauth
gem 'omniauth-facebook'
gem 'sinatra'
gem 'omniauth-google-oauth2'

gem 'sidekiq'

# database
gem 'mysql2', '0.3.18'

# frontend
gem "select2-rails"
gem 'font-awesome-sass'
gem 'bootstrap-slider-rails'
gem 'bootstrap-sass' ,' ~>3.3.6'
gem 'bootstrap-datepicker-rails'
# fullcalendar
gem 'fullcalendar-rails'
gem 'momentjs-rails', '>= 2.9.0'
gem 'jquery-ui-rails'
gem 'kaminari'

# country and money
gem 'rails-i18n'
gem 'iso_country_codes'
gem 'country_select' # seems no use
gem 'money'
gem 'google_currency'

#paperclip + S3
gem 'figaro'
gem "paperclip", '~> 4.3.6'
gem 'aws-sdk', '< 2.0'

# tools
gem 'rest-client' # http連線
gem 'rails_admin'
gem "nested_form"
gem 'awesome_rails_console'
gem 'populator' # seem no use

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  gem 'growl'
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'capistrano-rails', :group => :development
  gem 'capistrano-passenger', :group => :development
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'

  gem 'annotate'
  gem 'web-console', '~> 2.0'
  gem 'powder'
  gem 'spring'
  gem 'letter_opener'
  gem 'better_errors'
end
