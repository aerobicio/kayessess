module Kayessess
  # Helpers for building styleguides
  module StyleguideHelper
    include Rails.application.routes.url_helpers

    def styleguide_example_for(section, options = {}, &block)
      html = capture(&block)
      section_example = Kayessess::SectionExample.new(section, html, options)
      render(partial: 'kayessess/common/section_example', locals: {
        section_example: section_example})
    end

    def section_navigation
      @styleguide.root_sections.inject([]){|nav, node|
        nav << link_to(node.name, section_path(node.to_path), class: 'kayessess__navigation__item')
        nav
      }.join('').html_safe
    end

    def reference_breadcrumb_links(node)
      content_tag :span, class: 'kayessess__breadcrumb' do
        node.parents.inject([]) {|crumbs, parent_node|
          crumbs << breadcrumb_crumb_for_node(parent_node)
        }.reverse.join('').html_safe
      end
    end

  private

    def breadcrumb_crumb_for_node(node)
      unless node.parent.nil?
        link_to("#{node.name}#{breadcrumb_divider}".html_safe, section_path(node.to_path))
      else
        ''
      end
    end

    def breadcrumb_divider
      content_tag(:span, " > ", class: 'kayessess__breadcrumb__divider')
    end
  end
end
