module Validators
  class PostShowContract < BaseContract
    params do
      required(:id).value(:integer, gt?: 0)
    end
  end
end