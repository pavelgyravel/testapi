module Validators
  RateSchema = Dry::Validation.Schema(BaseSchema) do
    required(:id).filled(:int?, gt?: 0)
    required(:post_id).filled(:int?, gt?: 0)
  end
end