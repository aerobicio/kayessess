require 'kayessess/engine'
require 'kayessess/styleguide'
require 'to_slug'
require 'redcarpet'
require 'pygments'

module Kayessess
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language)
    end
  end

  class << self
    def markdownerize(text)
      @redcarpet ||= Redcarpet::Markdown.new(Kayessess::HTMLwithPygments,
        :autolink => true,
        :fenced_code_blocks => true,
        :strikethrough => true,
        :footnotes => true)
      @redcarpet.render(text).html_safe
    end
  end
end
