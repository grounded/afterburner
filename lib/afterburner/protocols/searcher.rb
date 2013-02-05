module Afterburner
  module Protocols
    # Wraps searching so that users can swap out searching models with the use
    # of any one searching plugin. At present, it only supports a single
    # searching method, but it will pass along any arguments given to that
    # method.
    #
    # Simply set Afterburner::Searcher.searching_method equal to the symbol name
    # of your searching method, and then use the :as_search_results method for 
    # queries. For example, if you are wrapping acts_as_indexed, the searching 
    # method there is called 'with_query'. Thus:
    #
    #     Afterburner::Searcher.searching_method = :with_query
    #     MyModel.where(:field => true).as_search_results("cats") # uses with_query
    #
    # You can also set searching_method on the model itself to use a different
    # as_search_results for just that model. For example:
    #
    #     MyModel.searching_method = :local_query
    #     MyModel.where(:field => true).as_search_results("cats") # uses local_query
    #
    # This won't interrupt other models' ability to use the default as_search_results.
    module Searcher
      class << self
        attr_accessor :searching_method
      end

      attr_accessor :searching_method
      def searching_method
        @searching_method || Searcher.searching_method
      end

      def as_search_results(*args)
        send searching_method, *args
      end
    end
  end
end
