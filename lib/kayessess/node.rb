module Kayessess
  class Node
    attr_reader :id, :name, :parent
    attr_accessor :children_hash, :sections_hash

    def initialize(id, name, parent = nil, children_hash = {}, sections_hash = {})
      @id            = id
      @name          = name
      @parent        = parent
      @children_hash = children_hash
      @sections_hash = sections_hash
    end

    def to_param
      name.to_slug
    end

    def to_path
      paths = parents.reduce([self.to_param]) {|paths, node|
        paths << node.to_param unless node.parent.nil?
        paths
      }.reverse
      File.join(paths)
    end

    def parents(&block)
      return to_enum(:parents) unless block_given?
      node = self
      while node = node.parent do
        break if node.nil?
        yield node
      end
    end

    def children
      @children_hash.values
    end

    def sections
      @sections_hash.values
    end

    def is_section?
      false
    end
  end
end
