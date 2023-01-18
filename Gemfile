source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails', '~> 6.1.1'

gem 'rack', '~> 2.2.6'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 5.1.1'
gem 'bootsnap', '>= 1.5.1', require: false

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0'
  gem 'simplecov', require: false
  gem 'fuubar'
end

gem 'tzinfo-data', '~> 1.2'
