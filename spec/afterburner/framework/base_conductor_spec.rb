require 'shared/callable'
require 'afterburner/framework/base_conductor'

module Afterburner
  module Framework
    describe BaseConductor do
      subject { BaseConductor }
      it_behaves_like "a callable"

      describe "instantiation" do
        it "stores parameters" do
          instance = subject.new("blah", {})
          instance.send(:params).should == "blah"
        end
      end

      describe "retrieval" do
        it "raises an error if not implemented" do
          instance = subject.new({}, {})
          expect(lambda { instance.send(:data) }).to raise_error NotImplementedError
        end
      end
    end
  end
end
