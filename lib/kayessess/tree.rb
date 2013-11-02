require_relative "section"
require_relative "node"

module Kayessess
  class SectionNotFound < StandardError; end

  class Tree
    def initialize(sections)
      @tree = build_tree(sections)
    end

    def root
      @tree
    end

    def root_sections
      root.children
    end

    def node_for_path(path)
      path.map(&:downcase).map(&:to_sym).reduce(@tree) {|branch, path|
        if branch
          branch = branch.children_hash[path] || branch.sections_hash[path]
        else
          raise Kayessess::SectionNotFound
        end
      }
    end

  private

    def build_tree(sections)
      root = Kayessess::Node.new(:root, "Styleguide")
      last_node = root

      sections.inject(root) {|tree, section|
        path = path_components(section.first)
        path.inject(tree) {|branch, node|
          node_id = node.first
          node_name = node.last

          # If this is the final item in a styleguide path then it should be a
          # styleguide section.
          if node_id == path.keys.last
            branch.sections_hash[node_id] = Kayessess::Section.new(node_id, path.values.last, section.last)

          # Add the new node to the branch.
          else
            new_node = Kayessess::Node.new(node_id, node_name, last_node)
            branch.children_hash[node_id] ||= new_node
            last_node = branch.children_hash[node_id]
          end

          branch.children_hash[node_id]
        }
        tree
      }
    end

    def path_components(path)
      paths = path.split(".").map {|path| [path.downcase.to_sym, path] }
      Hash[*paths.flatten]
    end
  end
end

