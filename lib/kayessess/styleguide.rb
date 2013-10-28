require_relative "section"
require_relative "tree"

module Kayessess

  # The Styleguide object is responsible for massaging a KSS parser object
  # into a more useful structure for display in a UI
  class Styleguide
    attr_accessor :sections

    def initialize(parser)
      @parser = parser
      @section_tree ||= build_section_tree(@parser.sections)
    end

    def sections
      @section_tree
    end

    def section(section)
      @section_tree[section.to_sym]
    end

    def to_partial_path
      "styleguide"
    end

    private

    def build_section_tree(sections)
      sections.inject(Kayessess::Tree.new) {|tree, section|
        tree.add(section)
      }.root
    end

    def split_styleguide_ref(ref)
      ref.split(".").map {|e| e.downcase.to_sym}
    end
  end
end
