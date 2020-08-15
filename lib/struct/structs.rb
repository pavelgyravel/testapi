class PostStruct < BaseStruct
  attribute :id, Types::Int
  attribute :title, Types::String
  attribute :content, Types::String
  attribute :author_ip, Types::String
  attribute :rate, Types::Float
  attribute :user_id, Types::Int
end



class ErrorStruct < BaseStruct
  attribute :errors, Types::Array 
end