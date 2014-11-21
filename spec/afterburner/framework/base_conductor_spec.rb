require 'afterburner/framework/base_conductor'

module Afterburner
  module Framework
    describe BaseConductor do
      subject { BaseConductor }

      describe "instantiation" do
        it "uses defaults" do
          expect_any_instance_of(subject).to receive(:defaults).and_return(
            {:repositories => {:page => double}}.freeze
          )
          instance = subject.new("blah", {})
          expect(instance.send(:repositories)).to respond_to(:page)
        end

        it "merges options onto defaults" do
          instance = subject.new("blah", {:pages => "value"})
          expect(instance.send(:options).keys).to include(:pages)
        end

        it "overwrites defaults with options" do
          allow_any_instance_of(subject).to receive(:defaults).and_return({:pages => "value"})
          instance = subject.new("blah", {:pages => "new value"})
          expect(instance.send(:options)[:pages]).to eq("new value")
        end

        it "stores parameters" do
          instance = subject.new("blah", {})
          expect(instance.send(:params)).to eq("blah")
        end

        it "prettifies repositories" do
          repository = double "repository"
          instance = subject.new("blah", {:repositories => {:page => repository}})
          expect(instance.send(:repositories)).to respond_to(:page)
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
          expect(instance.send(:defaults)).to be_empty
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
