require_relative "../../lib/kayessess/styleguide"

describe Kayessess::Styleguide do
  subject(:styleguide) { Kayessess::Styleguide.new(parser) }
  let(:parser) { double(sections: []) }
  let(:tree) { double(Kayessess::Tree) }

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
