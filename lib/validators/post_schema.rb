module Validators
  PostSchema = Dry::Validation.Schema(BaseSchema) do
    required(:title).filled(:str?)
    required(:content).filled(:str?)
    required(:author_ip).filled(:ip?)
    required(:login).filled(:str?)
  end
end