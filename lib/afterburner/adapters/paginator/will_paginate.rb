module Afterburner
  module Adapters
    module Paginator
      module WillPaginate

        def with_items_per_page(*args)
          per_page *args
        end
        def with_total_pages(*args)
          total_pages *args
        end

      end
    end
  end
end
