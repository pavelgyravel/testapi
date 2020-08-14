module Validators
  module CustomValidationPredicates
    include Dry::Logic::Predicates

    predicate(:ip?) do |value|
      ! /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.match(value).nil?
    end
  end
end