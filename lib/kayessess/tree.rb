module Kayessess
  class Tree
    require 'pry'
    attr_reader :root

    Node = Struct.new(:parent, :children, :sections, :path)

    def initialize
      @root = Node.new(nil, [], [])
    end

    def add(section)
      recursive_add(@root, path_components(section.first), 'test')
      self
    end

    private

    def path_components(path)
      path.split(".").map(&:to_sym)
    end

    def recursive_add(node, path, value)
      child_node = node[:children].find { |c| c.path.last == path.first }

      unless child_node
        child_node = Node.new(nil, [], [], path)
        node[:children].push(child_node)
      end

      binding.pry

      recursive_add(child_node, path, value)
    end
  end
end
