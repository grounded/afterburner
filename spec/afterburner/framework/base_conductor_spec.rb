require 'shared/callable'
require 'afterburner/framework/base_conductor'

module Afterburner
  module Framework
    describe BaseConductor do
      subject { BaseConductor }
      it_behaves_like "a callable"
    end
  end
end
