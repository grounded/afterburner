require 'afterburner/protocols/paginator'
require 'spec_helper'

module Afterburner
  describe Paginator do
    it_should_behave_like "protocols" do
      let(:dummy_class) {
        class DummyClass
          extend Afterburner::Paginator
        end
      }
      let(:other_dummy_class) {
        class AnotherDummyClass
          extend Afterburner::Paginator
        end
      }
      let(:protocol) { ::Afterburner::Paginator }
      let(:protocol_method) { :paginating_method }
      let(:protocol_action_method) { :as_pages }
    end
  end
end
