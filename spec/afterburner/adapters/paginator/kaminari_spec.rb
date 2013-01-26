require 'spec_helper'
require 'afterburner/adapters/paginator/kaminari'
require 'shared/afterburner/adapters/paginator'

module Afterburner
  module Adapters
    module Paginator
      describe Kaminari do

        it_should_behave_like "adapters/paginator" do
          let(:dummy_class) do
            class Dummy
              extend Kaminari
            end
          end
          let(:per_page_alias) { :per }
          let(:total_pages_alias) { :num_pages }
        end

      end
    end
  end
end
