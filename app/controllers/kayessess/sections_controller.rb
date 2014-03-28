module Kayessess

  # The SectionsController is responsible for providing actions for listing and
  # showing sections of the styleguide
  class SectionsController < Kayessess::ApplicationController
    before_filter :find_node, only: [:show, :example]

    def index
      @tree_root = @styleguide.tree.root
    end

    def show;
    end

    def example
      @example = true
      render layout: 'kayessess/example'
    end

    private

    def find_node
      @node = @styleguide.section(params[:id])

      raise not_found if @node.nil?
    end
  end
end
