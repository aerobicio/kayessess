module Kayessess

  # The ApplicationController is the class which all Kayessess rails controllers inherit from.
  class ApplicationController < ActionController::Base
    skip_before_filter :login_required
    before_filter :parse_styles

    # So dirty.
    # This little hack allows styleguide examples to use path helpers and other
    # fun stuff from the main app.
    def method_missing(name, *args)
      main_app.send(name, *args)
    end

  private

    def parse_styles
      require 'kss'

      parser = Kss::Parser.new(File.join(Rails.root, '/app/assets/stylesheets'))
      @styleguide = Kayessess::Styleguide.new(parser)
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
