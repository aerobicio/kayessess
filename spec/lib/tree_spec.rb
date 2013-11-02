require_relative "../../lib/kayessess/tree"

describe Kayessess::Tree do
  subject(:tree) { Kayessess::Tree.new(sections) }
  let(:section1) { double(Kayessess::Section) }
  let(:section2) { double(Kayessess::Section) }
  let(:sections) do
    [
      ["Buttons.Primary Button", section1],
      ["Buttons.Secondary Button", section2]
    ]
  end

  describe "#initialize" do
    before { tree.stub(:build_tree) }

    it { should_receive(:build_tree) }
  end

  describe "#root_sections" do
    pending
  end

  describe "#node_for_path" do
    subject {
      tree.node_for_path(section_path)
    }

    context "when the path exists" do

      context "for a child node" do
        let(:section_path) { "Buttons".split('.') }

        it "returns the node that matches the path passed in" do
          subject.id.should == :buttons
          subject.parent.id.should == :root
          subject.children.should == []
          expect(subject.sections).to include :"primary button"
          expect(subject.sections).to include :"secondary button"
        end
      end

      context "for a styleguide section" do
        let(:section_path) { "Buttons.Primary Button".split('.') }

        it "returns the node that matches the path passed in" do
          subject.id.should == :"primary button"
        end
      end
    end

    context "when the section does not exist" do
      let(:section_path) { ["buttons", "herp", "derp"] }

      it "throws an error if the path isn't found" do
        expect { subject }.to raise_error Kayessess::SectionNotFound
      end
    end
  end
end
