module Afterburner
  module Protocols
    class << self
      def define(protocol_module, protocol_method)
        protocol_module.class.send :attr_accessor, protocol_method

        define_base_accessors protocol_module, protocol_method
      end

      private
      def define_base_accessors(protocol_module, protocol_method)
        protocol_module.define_singleton_method(:extended) do |base|
          base.send :attr_accessor, protocol_method

          define_method(protocol_method) do
            instance_variable_get("@#{protocol_method}") || protocol_module.send(protocol_method)
          end
        end
      end
    end
  end
end
