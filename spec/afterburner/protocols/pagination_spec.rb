require 'afterburner/protocols/paginator'
require 'spec_helper'

module Afterburner
  module Protocols
    describe Paginator do
      it_should_behave_like "protocols" do
        let(:dummy_class) {
          class DummyClass
            extend Paginator
          end
        }
        let(:other_dummy_class) {
          class AnotherDummyClass
            extend Paginator
          end
        }
        let(:protocol) { Paginator }
        let(:protocol_method) { :paginating_method }
        let(:protocol_action_method) { :as_pages }
      end
    end
  end
end
