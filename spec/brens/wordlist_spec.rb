require "spec_helper"

module Brens
  describe Wordlist do
    let(:words) { %w{This is a This test. test.} }
    let(:wlist) { Wordlist.new(words) }

    subject { wlist }

    it { should == %w{This is a test.} }

    its([0])    { should == "This" }
    its([0.33]) { should == "is" }
    its([0.66]) { should == "a" }
    its([1])    { should == "test." }

    its(["This"])  { should == 0.0 }
    its(["is"])    { should be_within(0.01).of(0.33) }
    its(["a"])     { should be_within(0.01).of(0.66) }
    its(["test."]) { should == 1.0 }

    it "keeps list unique" do
      expect { wlist << "is" }.not_to change { wlist }
    end

    it "accepts words that aren't already in the list" do
      expect { wlist << "peach" }.to change { wlist }
    end
  end
end
