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
  module Paginator
    def self.paginating_method
      @@paginating_method
    end

    def self.paginating_method=(paginator)
      @@paginating_method = paginator
    end

    def paged(*args)
      self.send(@@paginating_method.to_sym, *args)
    end
  end
end
