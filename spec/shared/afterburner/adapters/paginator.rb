shared_examples_for "adapters/paginator" do

  let(:dummy_class) { nil }
  let(:with_per_page_alias) { nil }
  let(:with_total_pages) { nil }

  it 'redirects with_items_per_page properly' do
    dummy_class.should_receive(per_page_alias).once.with(1).and_return true
    dummy_class.with_items_per_page(1).should be_true
  end

  it 'redirects with_total_pages properly' do
    dummy_class.should_receive(total_pages_alias).once.with(5).and_return true
    dummy_class.with_total_pages(5).should be_true
  end

end
