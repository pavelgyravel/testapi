source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'

gem 'pg'

gem 'trailblazer-operation'
gem 'fast_jsonapi'
gem 'faker'
gem 'dotenv', '~> 2.4'

gem 'rake-progressbar'
group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
  gem 'awesome_print'
  gem 'thin'
  gem "capistrano", "~> 3.14", require: false
  gem "capistrano-hanami"
  gem "capistrano-rvm"
	gem "capistrano-bundler"	
	gem "capistrano-passenger"
	
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'rspec'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
