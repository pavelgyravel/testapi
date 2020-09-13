require 'roar/json/json_api'

class PostRepresenter < Roar::Decorator

  include Roar::JSON::JSONAPI.resource :posts
  
  attributes do
    # property :id
    property :title
    property :content
    property :author_ip
    property :rate
  end

  has_one :user do
    property :login
  end
end