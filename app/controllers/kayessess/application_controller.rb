module Kayessess

  # The ApplicationController is the class which all Kayessess rails controllers inherit from.
  class ApplicationController < ActionController::Base
    before_filter :parse_styles

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
