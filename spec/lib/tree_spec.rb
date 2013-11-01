require_relative "../../lib/kayessess/tree"

describe Kayessess::Tree do
  subject { Kayessess::Tree.new(sections) }
  let(:example1) { "example1" }
  let(:example2) { "example2" }
  let(:example3) { "example3" }
  let(:example4) { "example4" }
  let(:example5) { "example5" }
  let(:sections) {
    double(:sections,
      sections: [
        ["Widgets.Buttons.Primary Button", example1],
        ["Widgets.Buttons.Minor Button", example2],
        ["Widgets.Controls.Slider", example2],
        ["Forms.Label", example3],
        ["Forms.Inputs.Number Input", example4],
        ["Forms.Inputs.Textarea Input", example5]
      ]
    )
  }

  describe "#root_sections" do
    pending
  end

  describe "#node_for_path" do
    pending
  end
end
