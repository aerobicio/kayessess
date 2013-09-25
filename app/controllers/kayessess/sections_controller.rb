module Kayessess
  class SectionsController < ApplicationController
    def index
      @sections = @styleguide.sections
    end

    def show
      @section = @styleguide.section(params[:id])
    end
  end
end
