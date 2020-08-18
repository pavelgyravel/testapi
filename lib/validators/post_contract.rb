module Validators
  class PostContract < BaseContract
    params do
      required(:title).filled(:string)
      required(:content).filled(:string)
      required(:author_ip)
      required(:login).filled(:string)
    end

    rule(:author_ip) do
      if /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.match(value).nil?
        key.failure
      end
    end
  end
end