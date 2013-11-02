module Kayessess
  class SectionExample
    attr_accessor :section, :html

    def initialize(section, html, options = {})
      @section = section
      @html    = html
      @options = options
    end

    def extra_classes
      @options.class || ''
    end

    def html_unescaped
      cleaned_html = @html
        .gsub('$modifier_class', '')
        .gsub(/class="([\w\s-]+)"/) {|matches| "class=\"#{$1.strip}\"" }
        .gsub(' class=""', '')
        .gsub(' style=".+"', '')
        .gsub(/^$\n/, '')
      Kayessess.markdownerize("```html\n#{cleaned_html}\n```")
    end

    def modifiers
      @section.modifiers
    end

    def html_for_modifier(modifier)
      html.gsub('$modifier_class', "#{modifier.class_name}").html_safe
    end
  end
end
