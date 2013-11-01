module Kayessess
  class Tree

    Node = Struct.new(:parent, :children, :sections)

    def initialize(sections)
      @tree = build_tree(sections) if sections
    end

    def root_sections
      @tree.children
    end

    def node_for_path(path)
      puts path.map(&:downcase).map(&:to_sym).reduce(@tree) {|branch, path|
        branch.children[path]
      }.inspect
    end

    private

    def build_tree(sections)
      root = Node.new(nil, {}, {})
      last_node = root

      sections.inject(root) {|tree, section|
        path = path_components(section.first)
        path.inject(tree) {|branch, node|

          # If this is the final item in a styleguide path then it should be a
          # styleguide section.
          if node == path.last
            branch.sections[node] = Kayessess::Section.new(section)

          # Add the new node to the branch.
          else
            new_node = Node.new(last_node, {}, {})
            branch.children[node] ||= new_node
            last_node = branch.children[node]
          end

          branch.children[node]
        }
        tree
      }
    end

    def path_components(path)
      path.split(".").map(&:downcase).map(&:to_sym)
    end
  end
end
