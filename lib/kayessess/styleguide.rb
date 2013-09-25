module Kayessess

  # The Styleguide object is responsible for massaging a KSS parser object
  # into a more useful structure for display in a UI
  class Styleguide
    attr_accessor :sections

    def initialize(parser)
      @parser = parser
    end

    def sections
      @section_tree ||= build_section_tree(@parser.sections)
    end

    def to_partial_path
      "styleguide"
    end

    private

    def build_section_tree(sections)
      sections.inject({}) {|tree, section|
        ref_parts = split_styleguide_ref(section.first)
        ref_parts.inject(tree) {|branch, key|
          branch[key] ||= ((key == ref_parts.last) ? section.last : {})
          branch[key]
        }
        tree
      }
    end

    def split_styleguide_ref(ref)
      ref.split(".").map {|e| e.downcase.to_sym}
    end
  end
end
