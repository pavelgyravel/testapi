module Validators
  class RateContract < BaseContract
    params do
      required(:post_id).filled(:integer, gt?: 0)
      required(:rate).filled(:integer, included_in?: [1,2,3,4,5])
    end
  end
end