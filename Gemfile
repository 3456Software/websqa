source 'https://rubygems.org'
ruby '2.0.0'

# most importantly, rails!
gem 'rails', '~> 4.0.1'
# other important gems
gem 'pg', '~> 0.17.0'
gem 'haml-rails', '~> 0.4'
gem 'unicorn', '~> 4.6.3'
gem 'foreman', '~> 0.63.0'
gem 'bcrypt-ruby', '~> 3.1.2'
gem 'faker', '~> 1.2.0'
gem 'will_paginate', '~> 3.0.5'
gem 'will_paginate-bootstrap', '~> 1.0.0'
# style/assets gems
gem 'bootstrap-sass', '~> 3.0.1.0.rc'
gem 'font-awesome-rails', '~> 4.0.1'
# coverage metrics
gem 'coveralls', '~> 0.7.0', require: false
# replace rails console with
gem 'pry-rails', '~> 0.3.2'
gem 'awesome_print', '~> 1.2.0'     # recommended for pry

group :development, :test do
  gem 'rspec-rails', '~> 2.14.0'
end

group :development do
  gem 'better_errors', '~> 1.0.1'
  gem 'binding_of_caller', '~> 0.7.1' # improves better_errors
  gem 'rubocop', '~> 0.14.1'
end

group :test do
  gem 'selenium-webdriver', '~> 2.37.0'
  gem 'capybara', '~> 2.1.0'
  gem 'factory_girl_rails', '~> 4.2.1'
end

# some rails defaults
gem 'sass-rails', '~> 4.0.1'
gem 'uglifier', '~> 2.3.0'
gem 'coffee-rails', '~> 4.0.1'
gem 'jquery-rails', '~> 3.0.4'
gem 'turbolinks', '~> 1.3.0'
gem 'jbuilder', '~> 1.5.2'

group :production do
  gem 'rails_12factor'
end
