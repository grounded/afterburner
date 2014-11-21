shared_examples_for "adapters/paginator" do

  let(:dummy_class) { nil }
  let(:per_page_alias) { nil }
  let(:total_pages_alias) { nil }

  it 'redirects with_items_per_page properly' do
    expect(dummy_class).to receive(per_page_alias).once.with(1).and_return true
    expect(dummy_class.with_items_per_page(1)).to be_truthy
  end

  it 'redirects with_total_pages properly' do
    expect(dummy_class).to receive(total_pages_alias).once.with(5).and_return true
    expect(dummy_class.with_total_pages(5)).to be_truthy
  end

end
