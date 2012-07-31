require "spec_helper"

module Brens
  describe Words do
    let(:words) { %w{This is a This test. test.} }

    subject { described_class.new(words) }

    its(:words) { should == %w{This is a test.} }

    its([0])    { should == "This" }
    its([0.33]) { should == "is" }
    its([0.66]) { should == "a" }
    its([1])    { should == "test." }

    its(["This"])  { should == 0.0 }
    its(["is"])    { should be_within(0.01).of(0.33) }
    its(["a"])     { should be_within(0.01).of(0.66) }
    its(["test."]) { should == 1.0 }

    it "keeps list unique when pushing" do
      expect { subject << "is" }.not_to change { subject.words }
    end

    it "allows unique words to be pushed" do
      expect { subject << "peach" }.to change { subject.words }
    end

    it "keeps list unique when concatenating" do
      (subject + %w{is magic}).words.should == %w{This is a test. magic}
    end
  end
end
