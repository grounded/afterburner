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
        expect(protocol.send(protocol_method)).to eq(dummy)
        expect(dummy_class.send(protocol_method)).to eq(dummy)
      end

      it "doesn't override the default protocol when set locally" do
        protocol.send("#{protocol_method}=", dummy)
        dummy_class.send("#{protocol_method}=", rummy)

        expect(protocol.send(protocol_method)).to eq(dummy)
        expect(dummy_class.send(protocol_method)).to eq(rummy)
      end
    end

    context "at model level" do
      it "stores a reference to the protocol method" do
        dummy_class.send "#{protocol_method}=", dummy
        expect(dummy_class.send(protocol_method)).to eq(dummy)
      end

      context 'with stub' do
        let(:dummy_method) { :some_scope }
        before do
          allow(dummy_class).to receive dummy_method
          dummy_class.send "#{protocol_method}=", dummy_method
        end

        it "wraps a protocol method" do
          expect(dummy_class).to receive dummy_method
          dummy_class.send protocol_action_method
        end

        it "passes on all arguments to the protocol method" do
          expect(dummy_class).to receive(dummy_method).with 1, [], {}
          dummy_class.send(protocol_action_method, 1, [], {})
        end

        context "with local override" do
          let(:new_default) { :some_random_method }
          before { protocol.send "#{protocol_method}=", new_default }

          it "uses local protocol" do
            expect(dummy_class).to receive protocol_method
            expect(dummy_class).not_to receive new_default
            expect(protocol).not_to receive new_default

            dummy_class.send protocol_method, 'cats'
          end

          it "doesn't override other model's protocols" do
            expect(other_dummy_class).to receive(protocol_method).with 'cats'
            other_dummy_class.send protocol_method, 'cats'
          end
        end
      end
    end
  end
end
