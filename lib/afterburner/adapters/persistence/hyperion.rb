module Afterburner
  module Adapters
    module Persistence
      module Hyperion
        # Persist a hash to the datastore.
        #
        # @param values [Hash] The values to persist.
        # @return [Hash] The values persisted plus the resource identifier (key).
        def store(values)
          ::Hyperion.save({:kind => entity_kind}.merge(values))
        end

        # Find an entity's attributes by its key.
        #
        # @param key [String] The resource's identifier.
        # @return [Hash] The entity's attributes.
        def find(key)
          ::Hyperion.find_by_key(key)
        end

        # Search for one or more entities.
        #
        # @param options [Hash] A series of options to be passed to the adapter.
        # @return [Array] A collection of entity attribute hashes.
        def search(options = {})
          ::Hyperion.find_by_kind(entity_kind, options)
        end

        protected
        def entity_kind
          raise "entity_kind was not specified by this repository."
        end
      end
    end
  end
end
