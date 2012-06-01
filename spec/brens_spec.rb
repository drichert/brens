require "spec_helper"

describe Brens do
  describe "::VERSION" do
    subject { described_class::VERSION }

    it { should be_a(String) }
  end
end
