module Kayessess
  require 'kss'

  # The ApplicationController is the class which all Kayessess rails controllers inherit from.
  class ApplicationController < ActionController::Base
    skip_before_filter :login_required
    before_filter :parse_styles

  private

    def parse_styles
      parser = Kss::Parser.new(File.join(Rails.root, '/app/assets/stylesheets'))
      @styleguide = Kayessess::Styleguide.new(parser)
    end
  end
end
