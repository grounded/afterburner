module Afterburner
  module Adapters
    module Paginator
      module Kaminari

        def with_items_per_page(*args)
          per *args
        end

        def with_total_pages(*args)
          num_pages *args
        end

      end
    end
  end
end
