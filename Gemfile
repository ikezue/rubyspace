source 'https://rubygems.org'
ruby '2.1.0'

gem 'dotenv-rails', '~> 0.9.0', groups: [:development, :test]

gem 'rails',                '4.1.0.beta1'
gem 'bcrypt-ruby',          '~> 3.0.1'
gem 'pg',                   '~> 0.15.1'

gem 'coffee-rails',         '~> 4.0.0'
gem 'compass-rails',        '~> 1.1.3'
gem 'jbuilder',             '~> 1.4.2'
gem 'jquery-rails',         '~> 3.0.2'
gem 'turbolinks',           '~> 1.2.0'
gem 'sass-rails',           '~> 4.0.1'
gem 'uglifier',             '~> 2.1.1'

group :development do
  gem 'better_errors',      '~> 1.1.0'
  gem 'binding_of_caller',  '~> 0.7.2'
  gem 'meta_request',       '~> 0.2.8'
  gem 'pry-rails'
end

group :development, :test do
  gem 'foreman',            '~> 0.63.0'
  gem 'guard-rspec',        '~> 3.0.2'
  gem 'rspec-rails',        '~> 2.14'
  gem 'spring',             '~> 1.0.0'
end

group :test do
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'capybara',           '~> 2.1.0'
  gem 'growl',              '~> 1.0.3'
  gem 'selenium-webdriver', '~> 2.39.0'
end

group :production do
  gem 'rails_12factor',     '~> 0.0.2'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc',       '~> 0.3.20', require: false
end
