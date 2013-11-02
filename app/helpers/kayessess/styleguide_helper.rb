module Kayessess
  module StyleguideHelper
    def styleguide_example_for(section, options = {}, &block)
      html = capture(&block)
      section_example = Kayessess::SectionExample.new(section, html, options)
      render(partial: 'kayessess/common/section_example', locals: {
        section_example: section_example})
    end

    def section_navigation
      @styleguide.root_sections.inject([]){|nav, section|
        nav << link_to(section.name, section_path(section.id), class: 'kayessess__navigation__item')
      }.join('').html_safe
    end
  end
end
