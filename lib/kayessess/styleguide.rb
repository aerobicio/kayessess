require_relative "section"
require_relative "tree"

module Kayessess

  # The Styleguide object is responsible for massaging a KSS parser object
  # into a more useful structure for display in a UI
  class Styleguide
    attr_accessor :sections

    def initialize(parser)
      @parser = parser
      @tree ||= Kayessess::Tree.new(@parser.sections)
    end

    def sections
      @tree
    end

    def section(section)
      sections.node_for_path(section.split('/'))
    end

    def root_sections
      sections.root_sections
    end

    def to_partial_path
      "styleguide"
    end
  end
end
