module Afterburner
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
