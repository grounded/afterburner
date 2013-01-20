require 'protocols/paginator'

class DummyClass
  extend Afterburner::Paginator
end

module Afterburner
  describe Paginator do
    describe "interface" do
      it "stores a reference to the pagination method" do
        dummy = "dummy"
        Paginator.paginating_method = dummy
        Paginator.paginating_method.should == dummy
      end

      before(:each) do
        DummyClass.stub!(:paginate)
        Paginator.paginating_method = 'paginate'
      end
      it "wraps a paging method" do
        DummyClass.should_receive(:paginate)
        DummyClass.paged
      end

      it "passes on all arguments to the pagination method" do
        DummyClass.should_receive(:paginate).with(1, [], {})
        DummyClass.paged(1, [], {})
      end
    end
  end
end
