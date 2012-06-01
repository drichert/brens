require "spec_helper"

describe Brens::Words do
  let(:text) { "The quick brown fox jumps over the lazy dog. Hi." }

  subject { described_class.new(text) }

  its([0.0]) { should == "The" }
  its([0.3]) { should == "fox" }
  its([1.0]) { should == "Hi." }

  its([0]) { should == "The" }
  its([7]) { should == "lazy" }
  its([9]) { should == "Hi." }

  describe "#index" do
    let(:words) { described_class.new(text) }

    specify { words.index(9).should == 1.0 }
    specify { words.index(5).should be_within(0.0001).of(0.5555) }
    specify { words.index(0).should == 0.0 }
  end
end

