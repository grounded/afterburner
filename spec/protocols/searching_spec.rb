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
          DummyClass.as_search_results
        end

        it "passes on all arguments to the as_search_results method" do
          DummyClass.should_receive(:with_query).with 1, [], {}
          DummyClass.as_search_results 1, [], {}
        end

        context "with local override" do
          before do
            Searcher.searching_method = :as_search_results_with_query
          end

          it "uses local as_search_results" do
            DummyClass.should_receive :with_query
            DummyClass.should_not_receive :as_search_results_with_query
            Searcher.should_not_receive :as_search_results_with_query

            DummyClass.as_search_results 'cats'
          end

          it "doesn't override other model's as_search_resultss" do
            AnotherDummyClass.should_receive(:as_search_results_with_query).with 'cats'
            AnotherDummyClass.as_search_results 'cats'
          end
        end
      end
    end
  end
end
