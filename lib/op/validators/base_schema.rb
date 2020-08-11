class BaseSchema < Dry::Validation::Schema

  configure do |config|
    predicates(CustomValidationPredicates)
    config.messages_file = 'config/locale/errors.yml' 
  end

end