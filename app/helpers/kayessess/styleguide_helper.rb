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
        nav << link_to(section.id, section_path(section.to_path), class: 'kayessess__navigation__item')
      }.join('').html_safe
    end

    def reference_breadcrumb_links(node)
      nav = []
      nav_divider = content_tag(:span, " > ", class: 'kayessess__breadcrumb__divider')

      content_tag :span, class: 'kayessess__breadcrumb' do
        node.parents.inject([]) {|crumbs, parent_node|
          unless parent_node.parent.nil?
            crumbs << link_to(section_path(parent_node.to_path)) do
              "#{parent_node.name}#{nav_divider}".html_safe
            end
          end
          crumbs
        }.reverse.join('').html_safe
      end
    end
  end
end
