require 'spec_helper'
require 'afterburner/adapters/paginator/will_paginate'
require 'shared/afterburner/adapters/paginator'

module Afterburner
  module Adapters
    module Paginator
      describe WillPaginate do

        it_should_behave_like "adapters/paginator" do
          let(:dummy_class) do
            class Dummy
              extend WillPaginate
            end
          end
          let(:per_page_alias) { :per_page }
          let(:total_pages_alias) { :total_pages }
        end

      end
    end
  end
end
