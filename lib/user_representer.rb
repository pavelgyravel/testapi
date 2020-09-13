require 'roar/decorator'
require 'roar/json'
# require 'roar/coercion'

class UserRepresenter < Roar::Decorator
  include Roar::JSON
  # include Roar::Hypermedia
  

  property :id
  property :login

end