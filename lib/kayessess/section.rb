module Kayessess

  # A wrapper around KSS section object
  class Section
    def initialize(section)
      @section = section
    end

    def to_partial_path
      "section"
    end
  end
end
