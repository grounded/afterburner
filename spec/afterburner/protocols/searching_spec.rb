require 'afterburner/protocols/searcher'
require 'spec_helper'

module Afterburner
  module Protocols
    describe Searcher do
      it_should_behave_like "protocols" do
        let(:dummy_class) {
          class DummyClass
            extend Searcher
          end
        }
        let(:other_dummy_class) {
          class AnotherDummyClass
            extend Searcher
          end
        }
        let(:protocol) { Searcher }
        let(:protocol_method) { :searching_method }
        let(:protocol_action_method) { :as_search_results }
      end
    end
  end
end
