require_relative "section_example"
require 'pry'

module Kayessess

  # A wrapper around KSS section object
  class Section
    attr_reader :id, :name

    def initialize(id, name, section)
      @id      = id
      @name    = name
      @section = section
    end

    def reference
      @section.section
    end

    def description
      @description ||= Kayessess.markdownerize(@section.description)
    end

    def modifiers
      @modifiers ||= @section.modifiers.map {|modifier|
        if modifier.description
          modifier.description = Kayessess.markdownerize(modifier.description)
        end
        modifier
      }
    end

    def filename
      @section.filename
    end

    def example_partial_path
      reference_path = reference.split('.').map {|s| s.parameterize('_')}
      "styleguide/examples/#{File.join(reference_path)}"
    end

    def to_partial_path
      "section"
    end
  end
end
