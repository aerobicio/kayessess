require_relative "../../lib/kayessess/styleguide"

describe Kayessess::Styleguide do
  let(:styleguide) { Kayessess::Styleguide.new(parser) }
  let(:section1) { double(:section) }
  let(:section2) { double(:section) }
  let(:section3) { double(:section) }
  let(:parser) {
    double(:parser,
      sections: [
        ["Root.Widgets.Buttons", section1],
        ["Root.Widgets.Panels", section2],
        ["Root.Forms.Inputs", section3]
      ]
    )
  }

  describe "#to_partial_path" do
    subject { styleguide.to_partial_path }
    it { should == "styleguide" }
  end

  describe "#sections" do
    it "should build a tree based on styleguide section structure" do
      styleguide.sections().should == {
        :root => {
          :widgets => {
            :buttons => section1,
            :panels => section2,
          },
          :forms => {
            :inputs => section3
          }
        }
      }
    end

    it "should raise an exception if the tree contains two identical styleguide references" do
      pending()
    end
  end
end
