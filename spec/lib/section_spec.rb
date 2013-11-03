require 'spec_helper'
require_relative "../../lib/kayessess"
require_relative "../../lib/kayessess/section"

describe Kayessess::Section do
  subject(:section) { Kayessess::Section.new(id, name, parent, sub_section) }
  let(:id) { 'components' }
  let(:name) { 'Components' }
  let(:parent) { double(Kayessess::Node) }
  let(:sub_section) { double(section: 'Foo.Bar.Hello World', filename: '_foobar.scss') }

  describe "#reference" do
    subject { section.reference }
    it { should == 'Foo.Bar.Hello World' }
  end

  describe "#description" do
    subject { section.description }
    let(:sub_section) { double(description: 'Ice cream is **BEST!**') }
    it { should == "<p>Ice cream is <strong>BEST!</strong></p>\n" }
  end

  describe "#modifiers" do
    subject { section.modifiers }
    pending
  end

  describe "#filename" do
    subject { section.filename }
    it { should == '_foobar.scss' }
  end

  describe "#example_partial_path" do
    subject { section.example_partial_path }
    it { should == "styleguide/examples/foo/bar/hello-world" }
  end

  describe "#to_partial_path" do
    subject { section.to_partial_path }
    it { should == "section" }
  end

  describe "#is_section?" do
    subject { section.is_section? }
    it { should == true }
  end
end
