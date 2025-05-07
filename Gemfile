source 'https://rubygems.org'
git_source(:github) { |_repo| 'https://github.com/#{repo}.git' }

ruby '3.4.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.0', '7.0.8.1'

gem 'sprockets-rails'

gem 'pg', '~> 1.1'
gem 'pg_search'

# Use Puma as the app server
gem 'puma', '~> 6.4'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0'

gem 'kredis'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

#roo gem use to read xlsx files
gem 'roo'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'annotate'
  gem 'letter_opener'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  gem 'shoulda'
  gem 'vcr', '~> 6.1'
  gem 'webmock'
  gem 'drb'
  gem 'faker'

  gem 'rails-controller-testing', '~> 1.0'
end

# Agent logon management
gem 'devise'

gem 'name_of_person'

# ActiveJob runner
# gem 'sidekiq', '<7'
gem 'sidekiq', '~> 7.2'
gem 'sidekiq-cron'

gem 'tailwindcss-rails'

gem 'view_component'

gem 'faraday', '~> 1.8'
gem 'httparty'

gem 'net-ftp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false

gem 'hotwire-rails', '~> 0.1.3'
gem 'importmap-rails', '~> 1.0'
gem 'requestjs-rails'
gem 'turbo-rails', '~> 1.0'

# Pagination
gem 'pagy', '~> 5.10'

# Gems needed for EwsRails
gem 'httpclient'

# Library for looking up geographical addresses
gem 'geocoder'

# PDF generation
# See https://github.com/mileszs/wicked_pdf
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'mutex_m'
gem 'kamal'
gem 'strong_migrations', '~> 1.6'

gem 'aws-sdk-s3', require: false
