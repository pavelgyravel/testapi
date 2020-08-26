class PostStruct < BaseStruct
  attribute :id, Types::Integer
  attribute :title, Types::String
  attribute :content, Types::String
  attribute :author_ip, Types::String
  attribute :rate, Types::Float
  attribute :login, Types::String
end

class ErrorStruct < BaseStruct
  attribute :errors, Types::Hash
end

class IpAurhorsStruct < BaseStruct
  attribute :author_ip, Types::String
  attribute :logins, Types::Array.of(Types::String)
end
