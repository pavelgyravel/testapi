module Validators
  class BaseContract < Dry::Validation::Contract
    config.messages.load_paths << 'config/locale/errors.yml'

  end
end