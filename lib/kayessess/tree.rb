require_relative "section"
require_relative "node"

module Kayessess
  class SectionNotFound < StandardError; end

  # Tree is responsible for building a graph that represents the styleguide
  # section heirarchy.
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
      path.map(&:to_slug).reduce(@tree) {|branch, path|
        if branch
          branch = branch.children_hash[path] || branch.sections_hash[path]
        else
          raise Kayessess::SectionNotFound
        end
      }
    end

  private

    def build_tree(sections)
      last_node = root_node
      sections.inject(root_node) {|tree, section|
        path = path_components(section.first)
        path.inject(tree) {|branch, current_node|
          node = last_node = new_node(current_node, last_node, branch, *section)
          node
        }
        tree
      }
    end

    def id_for_node(node)
      node.first.to_slug
    end

    def name_for_node(node)
      node.last
    end

    def new_node(node, last_node, branch, path, section)
      node_id       = id_for_node(node)
      node_name     = name_for_node(node)
      terminator_id = terminator_id_for_path(path)

      if node_id == terminator_id
        new_section_for_branch(branch, node_id, node_name, last_node, section)
      else
        new_node_for_branch(branch, node_id, node_name, last_node)
      end
    end

    def new_section_for_branch(branch, id, name, parent, section)
      branch.sections_hash[id] = Kayessess::Section.new(id, name, parent, section)
    end

    def new_node_for_branch(branch, id, name, parent)
      branch.children_hash[id] ||= Kayessess::Node.new(id, name, parent)
    end

    def root_node
      @root_node ||= Kayessess::Node.new(:root, "Styleguide")
    end

    def terminator_id_for_path(path)
      path_components(path).keys.last
    end

    def path_components(path)
      paths = path.split(".").map {|path| [path.to_slug, path] }
      Hash[*paths.flatten]
    end
  end
end

