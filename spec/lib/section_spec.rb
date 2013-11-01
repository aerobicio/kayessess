require_relative "../../lib/kayessess/section"

describe Kayessess::Section do
  subject { Kayessess::Section.new(section) }
  let(:section) { double() }

  describe "#to_partial_path" do
    its(:to_partial_path) { should == "section" }
  end
end
