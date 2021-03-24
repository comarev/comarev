source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'aws-sdk-s3', '~> 1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'devise-jwt'
gem 'pg'
gem 'puma', '~> 4.1'
gem "pundit"
gem 'rails', '~> 6.0.3', '>= 6.0.3.5'
gem 'rubocop', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
