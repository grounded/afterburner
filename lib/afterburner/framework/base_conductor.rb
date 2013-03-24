module Afterburner
  module Framework
    # The Base Conductor is the conductor that all other conductors inherit
    # from. Its primary role is to decipher the parameters, retrieve or save
    # data to or from data-facing APIs like a database or a third-party API,
    # and to optionally wrap what it plans to return in an object that provides
    # methods for access (in some cases, abstracting complex logic away from
    # the view).
    #
    # The Conductor is not responsible, however, for validating or wrapping the
    # data it retrieves. That task is delegated down to the application. Nor,
    # however, is it responsible for selecting which data-facing APIs it uses;
    # instead, it has its dependencies injected by its calling controller. The
    # conductor should simply `call` them as appropriate.
    class BaseConductor
      # Create a new conductor.
      #
      # @param params [HashWithIndifferentAccess] The request parameters.
      # @param options [Hash] A series of options that are merged over
      #   defaults, used to configure the object.
      # @return [Conductor] An instance of the conductor.
      def initialize(params, options = {})
        self.params = params
        self.options = defaults.merge(options)
      end

      # Transforms the data returned by the #data method into an acceptable
      # format to return to the controller. Should begin the conductor's work
      # beyond setting options.
      #
      # @return [Hash] An associative array of data to be passed to the view
      #   (usually presenters or entities).
      def call
        raise NotImplementedError,
          "#call must be overridden when subclassing BaseConductor"
      end

      protected
      attr_accessor :params, :options

      # Passes data retrieved from somewhere down to Interactors and returns
      # something to be wrapped by #to_response -- by convention, an
      # associative array.
      #
      # This method can also assume responsibility for retrieving objects, but
      # it may choose to delegate that to other methods of this class.
      #
      # @return [Object] Data to be wrapped to send in response to the request
      def data
        raise NotImplementedError,
          "#data must be overridden when subclassing BaseConductor."
      end

      # Provides a frozen hash of sane defaults that can be overridden to change
      # class behaviour. Highly useful for dependency injection to simplify
      # testing. For instance, instead of hard-coding a repository object,
      # specify a default for it so that you can pass in a mock when testing.
      #
      # @return [Hash] An associative array of defaults.
      def defaults
        Hash.new.freeze
      end
    end
  end
end
