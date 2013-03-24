shared_examples "a callable" do

  describe "instantiation" do
    it "merges options onto defaults" do
      instance = subject.new("blah", {:params => "value"})
      instance.send(:options).keys.should include(:params)
    end

    it "overwrites defaults with options" do
      subject.any_instance.stub(:defaults).and_return({:param => "value"})
      instance = subject.new("blah", {:params => "new value"})
      instance.send(:options)[:params].should == "new value"
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
end
