require 'afterburner/framework/base_conductor'

module Afterburner
  module Framework
    describe BaseConductor do
      subject { BaseConductor }

      describe "instantiation" do
        it "merges options onto defaults" do
          instance = subject.new("blah", {:pages => "value"})
          instance.send(:options).keys.should include(:pages)
        end

        it "overwrites defaults with options" do
          subject.any_instance.stub(:defaults).and_return({:pages => "value"})
          instance = subject.new("blah", {:pages => "new value"})
          instance.send(:options)[:pages].should == "new value"
        end

        it "stores parameters" do
          instance = subject.new("blah", {})
          instance.send(:params).should == "blah"
        end

        it "prettifies repositories" do
          repository = double "repository"
          instance = subject.new("blah", {:repositories => {:page => repository}})
          instance.send(:repositories).should respond_to(:page)
        end

      end

      describe "invocation" do
        it "raises an error if not implemented" do
          instance = subject.new({}, {})
          expect(lambda { instance.call }).to raise_error NotImplementedError
        end
      end

      describe "defaults" do
        it "should be empty if not implemented" do
          instance = subject.new({}, {})
          instance.send(:defaults).should be_empty
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
