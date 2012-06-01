require "spec_helper"

module Brens
  describe NN do
    describe "#initialize" do
      it "raises error if argument is not Brens::Words" do
        expect { described_class.new("foo") }.to raise_error(ArgumentError)
      end
    end

    describe "#run" do
      let(:words) { Words.new("The quick brown fox jumps over the lazy dog. Hi.") }

      it "raises error if inputs length diff than phrase length" do
        expect {
          described_class.new(words, 6).run(0.1, 0.3, 0.1)
        }.to raise_error(ArgumentError)
      end
    end
  end
end
