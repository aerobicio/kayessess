require_relative "../../lib/kayessess/styleguide"

describe Kayessess::Styleguide do
  let(:styleguide) { Kayessess::Styleguide.new(parser) }
  let(:section1) { "section1" }
  let(:section2) { "section2" }
  let(:section3) { "section3" }
  let(:section4) { "section4" }
  let(:parser) {
    double(:parser,
      sections: [
        ["Widgets.Buttons", section1],
        ["Widgets.Panels", section2],
        ["Forms", section3],
        ["Forms.Inputs", section4]
      ]
    )
  }

  describe "#to_partial_path" do
    its(:to_partial_path) { should == "styleguide" }
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
            :inputs => section4
          }
        }
      }
    end

    it "should raise an exception if the tree contains two identical styleguide references" do
      pending()
    end
  end
end
