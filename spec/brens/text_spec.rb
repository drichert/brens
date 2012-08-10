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
        subject { described_class.new(str).to_training_data(2) }

        its(:keys)   { should == [["This", "is"], ["is", "a"]] }
        its(:values) { should == [["a"], ["test."]] }
      end

      context "phrase_length 3" do
        subject { described_class.new(str).to_training_data(3) }

        its(:keys)   { should == [["This", "is", "a"]] }
        its(:values) { should == [["test."]] }
      end
    end
  end
end
