require_relative "../../lib/kayessess/tree"

describe Kayessess::Tree do
  subject(:tree) { Kayessess::Tree.new(sections) }
  let(:section1) { double(Kayessess::Section) }
  let(:section2) { double(Kayessess::Section) }
  let(:section3) { double(Kayessess::Section) }
  let(:sections) do
    [
      ["Buttons.Primary Button", section1],
      ["Buttons.Secondary Button", section2],
      ["Components.Headers", section3]
    ]
  end

  describe "#root_sections" do
    subject { tree.root_sections }

    it "returns the children of the styleguide root" do
      expect(subject.length).to be 2
      expect(subject[0].sections[0].id).to eq "primary-button"
      expect(subject[0].sections[1].id).to eq "secondary-button"
      expect(subject[1].sections[0].id).to eq "headers"
    end
  end

  describe "#node_for_path" do
    subject { tree.node_for_path(section_path) }

    context "when the path exists" do
      context "for a child node" do
        let(:section_path) { "Buttons".split('.') }

        it "returns the node that matches the path passed in" do
          expect(subject.id).to eq "buttons"
          expect(subject.parent.id).to eq :root
          expect(subject.children).to eq []
          expect(subject.sections.map(&:id)).to include "primary-button"
          expect(subject.sections.map(&:id)).to include "secondary-button"
        end
      end

      context "for a styleguide section" do
        let(:section_path) { "Buttons.Primary Button".split('.') }

        it "returns the node that matches the path passed in" do
          expect(subject.id).to eq "primary-button"
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
