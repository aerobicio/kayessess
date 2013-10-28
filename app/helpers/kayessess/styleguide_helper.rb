module Kayessess
  module StyleguideHelper

    def section_navigation
      @styleguide.sections.inject([]){|nav, (k,v)|
        nav << link_to(k, section_path(k), class: 'kayessess__navigation__item')
      }.join('').html_safe
    end

  end
end
