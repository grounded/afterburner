require 'spec_helper'
require 'afterburner/adapters/persistence/hyperion'
require 'shared/afterburner/adapters/persistence'

class Hyperion; end
class Dummy
  include Afterburner::Adapters::Persistence::Hyperion

  protected
  def entity_kind; self.class.to_s.downcase end
end

module Afterburner
  module Adapters
    module Persistence
      describe Hyperion do

        it_should_behave_like "adapters/persistence" do
          let(:dummy_class) { Dummy }
          let(:receiving_class) { ::Hyperion }
          let(:store_alias) { :save }
          let(:find_alias) { :find_by_key }
          let(:search_alias) { :find_by_kind }
        end

      end
    end
  end
end
