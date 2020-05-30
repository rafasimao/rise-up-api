source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.1'

gem 'rack', '~> 2.2.2'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 4.3.5'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker', '~> 2.7'
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
