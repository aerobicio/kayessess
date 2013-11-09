module Kayessess
  class Engine < ::Rails::Engine

    config.autoload_paths << File.expand_path("../lib", __FILE__)
    isolate_namespace Kayessess
    engine_name "kayessess"

    # Ensure that application helpers are available to kayessess.
    # This is important as we need to make sure that application helpers can be
    # used within styleguide examples.
    config.to_prepare do
      Kayessess::ApplicationController.helper Rails.application.helpers
    end
  end
end
