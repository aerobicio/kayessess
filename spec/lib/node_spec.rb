require_relative "../../lib/kayessess/node"

describe Kayessess::Node do
  subject(:node) { Kayessess::Node.new(id, name, parent, children_hash, sections_hash) }
  let(:id) { 'components' }
  let(:name) { 'Components' }
  let(:parent) { double(Kayessess::Node) }
  let(:children_hash) { double() }
  let(:sections_hash) { double() }

  describe "#id" do
    subject { node.id }
    it { should == id }
  end

  describe "#name" do
    subject { node.name }
    it { should == name }
  end

  describe "#parent" do
    subject { node.parent }
    it { should == parent }
  end

  describe "#to_param" do
    subject { node.to_param }

    context "converts to lowercase" do
      let(:name) { 'FOOBAR' }
      it { should == 'foobar' }
    end

    context "name has spaces" do
      let(:name) { 'Herp Derp' }
      it { should == 'herp-derp' }
    end

    context "name has slashes" do
      let(:name) { 'Herp \/// Derp' }
      it { should == 'herp-derp' }
    end
  end

  describe "#to_path" do
    subject { node.to_path }
    let(:parent) { double(Kayessess::Node, parent: parent1) }
    let(:parent1) { double(Kayessess::Node, parent: nil) }

    before {
      parent.should_receive(:to_param) { 'velociraptor' }
      parent1.should_not_receive(:to_param) { 'decepticon' }
    }

    it "returns a path that is relative to the styleguide root" do
      expect(subject).to eq('velociraptor/components')
    end

    it "excludes the root path from the path" do
      expect(subject).to_not include 'decepticon'
    end
  end

  describe "#parents" do
    subject { node.parents }
    let(:parent) { double(Kayessess::Node, parent: parent1) }
    let(:parent1) { double(Kayessess::Node, parent: parent2) }
    let(:parent2) { double(Kayessess::Node, parent: parent3) }
    let(:parent3) { double(Kayessess::Node, parent: nil) }

    it "allows for enumeration over parent nodes" do
      expect(subject.next).to be parent
      expect(subject.next).to be parent1
      expect(subject.next).to be parent2
      expect(subject.next).to be parent3
    end
  end

  describe "#children" do
    subject { node.children }
    let(:children_hash) { {dinosaurs: child1, robots: child2} }
    let(:child1) { double() }
    let(:child2) { double() }

    it { should == [child1, child2] }
  end

  describe "#sections" do
    subject { node.sections }
    let(:sections_hash) { {dinosaurs: section1, robots: section2} }
    let(:section1) { double() }
    let(:section2) { double() }

    it { should == [section1, section2] }
  end

  describe "#is_section?" do
    subject { node.is_section? }
    it { should == false }
  end
end
