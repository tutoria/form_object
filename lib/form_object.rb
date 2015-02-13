require 'active_support/dependencies/autoload'

module FormObject
  class << self
    attr_accessor :field_types
  end

  @field_types = {}

  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Mixin
    autoload :Coercions
  end
end
