require 'afterburner/protocols'

module Afterburner
  module Protocols
    # Wraps pagination so that users can swap out pagination models with the use
    # of any one pagination plugin. At present, it only supports a single
    # pagination method, but it will pass along any arguments given to that
    # method.
    #
    # Simply set Afterburner::Pagination.paginating_method equal to the symbol
    # name of your paginating method, and then use the as_pages method on queries.
    # For example, if you are wrapping will_paginate, the pagination method there
    # is called 'paginate'. Thus:
    #
    #     Afterburner::Paginator.paginating_method = :paginate
    #     MyModel.where('field' => true).as_pages(:per_page => 10, :blah => false)
    #
    # You can also set paginating_method on the model itself to use a different
    # paginator for just that model. For example:
    #
    #     MyModel.paginating_method = :page
    #     MyModel.where(:field => true).as_pages("cats") # uses 'local' page method
    #
    # This won't interrupt other models' ability to use the default paginator.

    module Paginator
      Protocols.define Paginator, :paginating_method

      def as_pages(*args)
        send paginating_method, *args
      end
    end
  end
end
