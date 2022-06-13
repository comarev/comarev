source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'active_model_serializers', '~> 0.10.6'
gem 'aws-sdk-s3', '~> 1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'carrierwave', '~> 2.0'
gem 'devise'
gem 'devise-jwt'
gem 'fog-aws'
gem 'mini_magick'
gem 'money-rails', '~> 1.12'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'pundit'
gem 'rack-cors'
gem 'rails', '~> 6.0.3', '>= 6.0.3.5'

group :test do
  gem 'simplecov'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'shoulda-matchers', '~> 4.0'
end

group :development do
  gem 'letter_opener'
  gem 'letter_opener_web', '~> 2.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
