module Afterburner
  # Wraps pagination so that users can swap out pagination models with the use
  # of any one pagination plugin. At present, it only supports a single
  # pagination method, but it will pass along any arguments given to that
  # method.
  #
  # Simply set Afterburner::Pagination.paginating_method equal to the string
  # name of your paginating method, and then use the ::paged method on queries.
  # For example, if you are wrapping will_paginate, the pagination method there
  # is called 'paginate'. Thus:
  #
  #     Afterburner::Paginator.paginating_method = 'paginate'
  #     MyModel.where('field' => true).paged(:per_page => 10, :blah => false)
  #
  # You can also set paginating_method on the model itself to use a different
  # paginator for just that model. For example:
  #
  #     MyModel.paginating_method = 'page'
  #     MyModel.where(:field => true).paged("cats") # uses 'local' page method
  #
  # This won't interrupt other models' ability to use the default paginator.
  module Paginator
    class << self
      attr_accessor :paginating_method
    end
    attr_accessor :paginating_method
    def paginating_method
      @paginating_method || Paginator.paginating_method
    end

    def paged(*args)
      send paginating_method, *args
    end
  end
end
