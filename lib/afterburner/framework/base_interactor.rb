module Afterburner
  module Framework
    class BaseInteractor
      # Runs the interactor and returns a hash of objects (presenter or
      # otherwise) that are passed to the view.
      #
      # @param data [Hash] Data supplied to the interactor.
      # @param options [Hash] A series of options that override default values.
      # @return [Hash] An associative array of presenter objects to be passed to the view.
      def self.call(data, options = {})
        new(data, options).to_response
      end

      def to_response
        raise "#to_response must be specified!"
      end

      protected
      attr_accessor :data, :options
      def initialize(data, options = {})
        self.data = data
        self.options = defaults.merge(options)
      end

      # Provides a frozen hash of sane defaults that can be overridden to change class
      # behaviour. Highly useful for dependency injection to simplify testing. For
      # instance, instead of hard-coding a repository object, specify a default for it
      # so that you can pass in a mock when testing.
      #
      # @return [Hash] An associative array of defaults.
      def defaults
        Hash.new.freeze
      end
    end
  end
end
