require_relative 'custom_validation_predicates'
module Validators
  class BaseSchema < Dry::Validation::Schema

    configure do |config|
      predicates(Validators::CustomValidationPredicates)
      config.messages_file = 'config/locale/errors.yml' 
    end

  end
end