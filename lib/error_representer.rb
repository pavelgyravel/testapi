require 'roar/json/json_api'

class ErrorRepresenter < Roar::Decorator

  include Roar::JSON

    property :errors

end