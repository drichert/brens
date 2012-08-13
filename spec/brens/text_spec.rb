require "spec_helper"

module Brens
  describe Text do
    let(:str) { "This   is a\ntest.\t" }

    subject { described_class.new(str) }

    its(:to_a) { should == ["This", "is", "a", "test."] }

    describe "attr methods" do
      describe "readers" do
        it { should respond_to(:words) }
        it { should respond_to(:training_data) }
      end

      describe "accessors" do
        it { should respond_to(:phrase_length) }
        it { should respond_to(:phrase_length=) }
      end
    end

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
      it "memoizes on @training_data" do
        subject.to_training_data
        training_data = subject.instance_variable_get(:@training_data)
        training_data.should be_a(Hash)

        subject.words.should_not_receive(:each_index)
        subject.to_training_data
      end

      it "should raise if string length is too short" do
        expect {
          described_class.new("word").to_training_data
        }.to raise_error("Too short")
      end

      context "phrase_length 2" do
        let(:training_data) { described_class.new(str).to_training_data(2) }

        describe "inputs (keys)" do
          subject { training_data.keys }

          its([0]) { should == [0, 1] }
          its([1]) { should == [1, 2] }
          its([2]) { should be_nil }
        end

        describe "outputs (values)" do
          subject { training_data.values }

          its([0]) { should == [2] }
          its([1]) { should == [3] }
          its([2]) { should be_nil }
        end
      end

      context "phrase_length 3" do
        let(:training_data) { described_class.new(str).to_training_data(3) }

        describe "inputs (keys)" do
          subject { training_data.keys }

          its([0]) { should == [0, 1, 2] }
          its([1]) { should be_nil }
        end

        describe "outputs (values)" do
          subject { training_data.values }

          its([0]) { should == [3] }
          its([1]) { should be_nil }
        end
      end
    end

    describe "#[]" do
      its([0]) { should == "This" }
      its([1]) { should == "is" }
      its([2]) { should == "a" }
      its([3]) { should == "test." }

      its(["This"])  { should == 0 }
      its(["test."]) { should == 3 }
      its(["a"])     { should == 2 }
    end
  end
end
