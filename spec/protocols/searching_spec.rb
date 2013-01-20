require 'protocols/searcher'

class DummyClass
  extend Afterburner::Searcher
end

class AnotherDummyClass
  extend Afterburner::Searcher
end

module Afterburner
  describe Searcher do
    describe "interface" do
      context "at class level" do
        let(:dummy) { 'dummy' }
        let(:rummy) { 'rummy' }

        it "stores a reference to the searching method" do
          Searcher.searching_method = dummy
          Searcher.searching_method.should == dummy
          DummyClass.searching_method.should == dummy
        end

        it "doesn't override the default Searcher when set locally" do
          Searcher.searching_method = dummy
          DummyClass.searching_method = rummy

          Searcher.searching_method.should == dummy
          DummyClass.searching_method.should == rummy
        end
      end

      context "at instance level" do
        it "stores a reference to the searching method" do
          dummy = "dummy"
          DummyClass.searching_method = dummy
          DummyClass.searching_method.should == dummy
        end

        before do
          DummyClass.stub! :with_query
          DummyClass.searching_method = :with_query
        end

        it "wraps a searching method" do
          DummyClass.should_receive :with_query
          DummyClass.searcher
        end

        it "passes on all arguments to the searcher method" do
          DummyClass.should_receive(:with_query).with 1, [], {}
          DummyClass.searcher 1, [], {}
        end

        context "with local override" do
          before do
            Searcher.searching_method = :searcher_with_query
          end

          it "uses local searcher" do
            DummyClass.should_receive :with_query
            DummyClass.should_not_receive :searcher_with_query
            Searcher.should_not_receive :searcher_with_query

            DummyClass.searcher 'cats'
          end

          it "doesn't override other model's searchers" do
            AnotherDummyClass.should_receive(:searcher_with_query).with 'cats'
            AnotherDummyClass.searcher 'cats'
          end
        end
      end
    end
  end
end
