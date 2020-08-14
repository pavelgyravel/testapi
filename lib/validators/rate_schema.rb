module Validators
  RateSchema = Dry::Validation.Schema(BaseSchema) do
    required(:post_id).filled(:int?, gt?: 0)
    required(:rate).filled(:int?, included_in?: [1,2,3,4,5])
  end
end