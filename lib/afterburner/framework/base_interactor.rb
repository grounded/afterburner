module Afterburner
  module Framework
    class BaseInteractor
      # Create a new interactor.
      #
      # @param data [Hash] Data to be used to instantiate entities.
      # @param options [Hash] A series of options merged over defaults, used to
      #   configure the object.
      # @return [Interactor] An instance of the interactor.
      def initialize(data, options = {})
        self.data = data
        self.options = defaults.merge(options)
      end

      # Transforms the data received in instantiation into entities to return
      # to the conductor. Return is specific to implementation, but usually one
      # or more entities or collections of entities.
      def call
        raise NotImplementedError,
          "#call must be overridden when subclassing BaseInteractor."
      end

      protected
      attr_accessor :data, :options

      # Provides a frozen hash of sane defaults that can be overridden to
      # change class behaviour. Highly useful for dependency injection to
      # simplify testing. For instance, instead of hard-coding an entity
      # object, specify a default for it so that you can pass in a mock when
      # testing.
      #
      # @return [Hash] An associative array of defaults.
      def defaults
        Hash.new.freeze
      end
    end
  end
end
