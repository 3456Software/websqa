source 'https://rubygems.org'
ruby '2.0.0'

# most importantly, rails!
gem 'rails', '~> 4.0.0'
# other important gems
gem 'pg', '~> 0.17.0'
gem 'haml-rails', '~> 0.4'
gem 'unicorn', '~> 4.6.3'
gem 'foreman', '~> 0.63.0'
gem 'bcrypt-ruby', '~> 3.0.1'
# style/assets gems
gem 'anjlab-bootstrap-rails', require: 'bootstrap-rails',
                              github: 'anjlab/bootstrap-rails'
gem 'font-awesome-rails', '~> 3.2.1.3'

group :development, :test do
  gem 'rspec-rails', '~> 2.14.0'
end

group :development do
  gem 'pry-rails'
  gem 'awesome_print'     # recommended for pry
  gem 'better_errors'
  gem 'binding_of_caller' # improves better_errors
  gem 'rubocop'
end

group :test do
  gem 'selenium-webdriver', '~> 2.35.1'
  gem 'capybara', '~> 2.1.0'
  gem 'factory_girl_rails', '~> 4.2.1'
end

# some rails defaults
gem 'sass-rails', '~> 4.0.1'
gem 'uglifier', '~> 2.2.1'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '~> 3.0.4'
gem 'turbolinks', '~> 1.3.0'
gem 'jbuilder', '~> 1.5.2'

group :production do
  gem 'rails_12factor'
end
