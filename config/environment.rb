require 'bundler/setup'
require 'hanami/setup'

require 'erb'
require 'active_record'
db_config = YAML::load(ERB.new(File.read('config/database.yml')).result)[ENV['RACK_ENV']]
require_relative '../lib/models/application_record'
ApplicationRecord.establish_connection(db_config)
require_relative '../apps/api/application'


Hanami.configure do
  mount Api::Application, at: '/api'

  # model do
  #   ##
  #   # Database adapter
  #   #
  #   # Available options:
  #   #
  #   #  * SQL adapter
  #   #    adapter :sql, 'sqlite://db/api_development.sqlite3'
  #   #    adapter :sql, 'postgresql://localhost/api_development'
  #   #    adapter :sql, 'mysql://localhost/api_development'
  #   #
  #   adapter :sql, ENV.fetch('DATABASE_URL', "postgresql://postgres@localhost/api_#{ENV['HANAMI_ENV']}")

  #   ##
  #   # Migrations
  #   #
  #   migrations 'db/migrations'
  #   schema     'db/schema.sql'
  # end

  # mailer do
  #   root 'lib/api/mailers'

  #   # See https://guides.hanamirb.org/mailers/delivery
  #   delivery :test
  # end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :info
  end

  environment :production do
    logger level: :info, stream: 'log/production.log' 

    # mailer do
    #   delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    # end
  end
end
