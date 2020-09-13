source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'activerecord'
gem 'active_record_migrations',  require: false
gem 'dry-struct'
gem 'dry-validation'
gem 'pg'

gem 'trailblazer-operation'
gem 'roar'
gem 'roar-jsonapi'
gem 'multi_json'
gem 'faker'
gem 'dotenv', '~> 2.4'
gem 'rake-progressbar'
gem 'passenger'
gem 'httparty'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
  gem 'awesome_print'
  gem 'thin'
  gem "capistrano", "~> 3.14", require: false
  # gem "capistrano-hanami", require: false
  gem "capistrano-rvm", require: false
	gem "capistrano-bundler"	, require: false
	gem "capistrano-passenger", require: false
  gem "capistrano-rails", "~> 1.6", require: false
  
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'rspec'
  gem 'factory_bot'
  gem 'database_cleaner-active_record'
end

group :production do
  # gem 'puma'
end
