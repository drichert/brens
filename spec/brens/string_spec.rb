require "spec_helper"

module Brens
  describe String do
    let(:str) { "This   is a\ntest.\t" }

    subject { described_class.new(str) }

    its(:to_a) { should == ["This", "is", "a", "test."] }

    describe "#to_a" do
      before { subject.to_a }

      it "memoizes on @words" do
        words = subject.instance_variable_get(:@words)
        words.should == ["This", "is", "a", "test."]

        subject.should_not_receive(:split)
        subject.to_a
      end
    end

    describe "#to_training_data" do
      it "should raise if string length is too short" do
        expect {
          described_class.new("word").to_training_data
        }.to raise_error("Too short")
      end

      context "phrase_length 2" do
        let(:training_data) { described_class.new(str).to_training_data(2) }

        describe "inputs (keys)" do
          describe "@ 0" do
            subject { training_data.keys[0] }

            its([0]) { should == 0.0 }
            its([1]) { should be_within(0.001).of(0.333) }
          end

          describe "@ 1" do
            subject { training_data.keys[1] }

            its([0]) { should be_within(0.001).of(0.333) }
            its([1]) { should be_within(0.001).of(0.666) }
          end

          describe "@ 2" do
            subject { training_data.keys[2] }

            it { should be_nil }
          end
        end

        describe "outputs (values)" do
          describe "@ 0" do
            subject { training_data.values[0] }

            its([0]) { should be_within(0.001).of(0.666) }
          end

          describe "@ 1" do
            subject { training_data.values[1] }

            its([0]) { should == 1.0 }
          end

          describe "@ 2" do
            subject { training_data.values[2] }

            it { should be_nil }
          end
        end
      end

      context "phrase_length 3" do
        let(:training_data) { described_class.new(str).to_training_data(3) }

        describe "inputs (keys)" do
          describe "@ 0" do
            subject { training_data.keys[0] }

            its([0]) { should == 0.0 }
            its([1]) { should be_within(0.001).of(0.333) }
            its([2]) { should be_within(0.001).of(0.666) }
          end

          describe "@ 1" do
            subject { training_data.keys[1] }

            it { should be_nil }
          end
        end

        describe "outputs (values)" do
          describe "@ 0" do
            subject { training_data.values[0] }

            its([0]) { should == 1.0 }
          end

          describe "@ 1" do
            subject { training_data.values[1] }

            it { should be_nil }
          end
        end
      end
    end
  end
end
