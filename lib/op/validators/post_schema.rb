module Validators
  PostSchema = Dry::Validation.Schema do
    configure do
      predicates(CustomValidationPredicates)
      config.messages_file = 'config/locale/errors.yml' 
    end

    required(:title).filled(:str?)
    required(:content).filled(:str?)
    required(:author_ip).filled(:ip?)
    required(:login).filled(:str?)
  end
end