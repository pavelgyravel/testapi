require 'bundler/setup'
require 'hanami/setup'

require 'erb'
require 'active_record'
db_config = YAML::load(ERB.new(File.read('config/database.yml')).result)[ENV['RACK_ENV']]
require_relative '../lib/models/application_record'
ActiveRecord::Base.establish_connection(db_config)

require_relative '../apps/api/application'




Hanami.configure do
  mount Api::Application, at: '/api'

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug

  end

  environment :production do
    logger level: :info, stream: 'log/production.log' 

  end
end
