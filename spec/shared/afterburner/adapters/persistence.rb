shared_examples_for "adapters/persistence" do

  let(:dummy_class) { nil }
  let(:receiving_class) { nil }
  let(:store_alias) { nil }
  let(:find_alias) { nil }
  let(:search_alias) { nil }
  let(:kind) { dummy_class.to_s.downcase }

  context 'delegates' do
    specify '#store' do
      receiving_class.should_receive(store_alias).once.
                      with(:kind => kind, :foo => :bar).
                      and_return Hash.new

      dummy_class.new.store(:foo => :bar).should be_kind_of(Hash)
    end

    specify '#find' do
      receiving_class.should_receive(find_alias).once.with(:key).and_return Hash.new
      dummy_class.new.find(:key).should be_kind_of(Hash)
    end

    specify '#search' do
      receiving_class.should_receive(search_alias).once.
                      with(kind, :for => :this).and_return []
      dummy_class.new.search(:for => :this).should be_kind_of(Array)
    end

    describe "#entity_kind" do
      it "should raise an error if not implented" do
        expect(lambda { dummy_class.new.send(:kind) }).to raise_error NotImplementedError
      end
    end

  end

end
