source 'https://rubygems.org'



ruby '2.1.2'
gem 'rails', '4.1.1'

gem 'pg'
gem 'unicorn'
gem 'foreman'

gem 'quiet_assets'
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'jquery-rails'
gem 'haml'
gem 'meta-tags', '~> 2.0.0'
gem 'devise', '~> 3.2.4'
gem 'simple_form', '~> 3.1.0.rc1'
gem 'cancancan', '~> 1.8.4'
gem 'bitmask_attributes', '~> 1.0.0'
gem 'virtus', '~> 1.0.2'
gem 'draper'
gem 'aasm', '~> 3.2.1'


group :development do
  gem 'spring'
  gem "erb2haml"
  gem "html2haml"
  gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'pry-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara'
  gem 'shoulda'
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
end
