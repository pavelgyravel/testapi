require 'dry-types'
# require 'dry-struct'

class BaseStruct < Dry::Struct
  module Types
    include Dry.Types()
  end

  def self.attribute(name, type = nil, &block)
    super
    define_attribute_setter(name)
  end

  def self.define_attribute_setter(name)
    define_method("#{name}=") do |value|
      self.attributes = attributes.merge(name => value)
    end
  end

  def attributes=(new_attributes)
    @attributes = self.class.input[new_attributes]
  end
end