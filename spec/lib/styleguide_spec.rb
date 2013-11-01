require_relative "../../lib/kayessess/styleguide"

describe Kayessess::Styleguide do
  subject { Kayessess::Styleguide.new(parser) }
  let(:parser) { double() }
  let(:tree) { double(Kayessess::Tree) }

  before { parser.should_receive(:sections) }

  describe "#sections" do
    pending
  end

  describe "#section" do
    pending
  end

  describe "#to_partial_path" do
    its(:to_partial_path) { should == "styleguide" }
  end
end
