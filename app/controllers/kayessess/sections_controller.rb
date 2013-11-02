module Kayessess

  # The SectionsController is responsible for providing actions for listing and
  # showing sections of the styleguide
  class SectionsController < ApplicationController
    def index
      @sections = @styleguide.sections
    end

    def show
      @node = @styleguide.section(params[:id])
    end
  end
end
