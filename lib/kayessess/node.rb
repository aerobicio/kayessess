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
