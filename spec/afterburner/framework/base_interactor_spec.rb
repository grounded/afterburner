require 'shared/callable'
require 'afterburner/framework/base_interactor'

module Afterburner
  module Framework
    describe BaseInteractor do
      subject { BaseInteractor }

      it_behaves_like "a callable"

      describe "instantiation" do
        it "stores data" do
          instance = subject.new("blah", {})
          instance.send(:data).should == "blah"
        end
      end

    end
  end
end
