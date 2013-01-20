shared_examples_for "protocols" do
  let(:dummy_class) { nil }
  let(:other_dummy_class) { nil }
  let(:protocol) { nil }
  let(:protocol_method) { nil }
  let(:protocol_action_method) { nil }

  describe "interface" do
    let(:dummy) { 'dummy' }
    context "at Afterburner level" do
      let(:rummy) { 'rummy' }

      it "stores a reference to the default_protocol_action method" do
        protocol.send "#{protocol_method}=", dummy
        protocol.send(protocol_method).should == dummy
        dummy_class.send(protocol_method).should == dummy
      end

      it "doesn't override the default protocol when set locally" do
        protocol.send("#{protocol_method}=", dummy)
        dummy_class.send("#{protocol_method}=", rummy)

        protocol.send(protocol_method).should == dummy
        dummy_class.send(protocol_method).should == rummy
      end
    end

    context "at model level" do
      it "stores a reference to the protocol method" do
        dummy_class.send "#{protocol_method}=", dummy
        dummy_class.send(protocol_method).should == dummy
      end

      context 'with stub' do
        let(:dummy_method) { :some_scope }
        before do
          dummy_class.stub! dummy_method
          dummy_class.send "#{protocol_method}=", dummy_method
        end

        it "wraps a protocol method" do
          dummy_class.should_receive dummy_method
          dummy_class.send protocol_action_method
        end

        it "passes on all arguments to the protocol method" do
          dummy_class.should_receive(dummy_method).with 1, [], {}
          dummy_class.send(protocol_action_method, 1, [], {})
        end

        context "with local override" do
          let(:new_default) { :some_random_method }
          before { protocol.send "#{protocol_method}=", new_default }

          it "uses local protocol" do
            dummy_class.should_receive protocol_method
            dummy_class.should_not_receive new_default
            protocol.should_not_receive new_default

            dummy_class.send protocol_method, 'cats'
          end

          it "doesn't override other model's protocols" do
            other_dummy_class.should_receive(protocol_method).with 'cats'
            other_dummy_class.send protocol_method, 'cats'
          end
        end
      end
    end
  end
end
