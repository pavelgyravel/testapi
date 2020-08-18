module Validators
  class PostListContract < BaseContract
    params do
      required(:count).value(:integer, gt?: 0, lteq?: 1000)
    end
  end
end