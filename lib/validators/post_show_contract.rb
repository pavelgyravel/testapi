module Validators
  class PostShowContract < BaseContract
    params do
      required(:id).value(:integer, gt?: 0, lteq?: 1000)
    end
  end
end