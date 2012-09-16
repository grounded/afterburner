require 'protocols/paginator'

class DummyClass
  extend Afterburner::Paginator
  def initialize
  end
end

module Afterburner
  describe Paginator do
    describe "interface" do
      it "stores a reference to the pagination method" do
        dummy = "dummy"
        Paginator.paginating_method = dummy
        Paginator.paginating_method.should == dummy
      end

      it "wraps a paging method" do
        DummyClass.stub!(:paginate)
        Paginator.paginating_method = 'paginate'
        DummyClass.should_receive(:paginate)
        DummyClass.paged
      end
    end
  end
end
