require_relative 'node'

class Tree
  def initialize(ary)
    ary.sort!.uniq!
    @root = build_tree(ary)
  end

  def build_tree(ary)
    return if ary.empty?

    mid = ary.length / 2
    root = Node.new(ary[mid])
    root.left = build_tree(ary[0...mid])
    root.right = build_tree(ary[mid + 1..])

    return root
  end

  
end

