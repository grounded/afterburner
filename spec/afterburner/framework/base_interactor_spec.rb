require 'shared/callable'
require 'afterburner/framework/base_interactor'

module Afterburner
  module Framework
    describe BaseInteractor do
      subject { BaseInteractor }

      it_behaves_like "a callable"
    end
  end
end
