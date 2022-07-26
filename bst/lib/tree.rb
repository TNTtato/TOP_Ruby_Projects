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

    root
  end

  def insert(data, root = @root)
    return data if root.data == data

    if data < root.data 
      root.left.nil? ? root.left = Node.new(data) : insert(data, root.left)
    else
      root.right.nil? ? root.right = Node.new(data) : insert(data, root.right)
    end
    rebalance unless balanced?
  end

  def delete(data, root = @root)
    return root if root.nil?

    if data <  root.data
      root.left = delete(data, root.left)
    elsif data > root.data
      root.right = delete(data, root.right)
    else
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end

      root.data = minim(root.right)
      root.right = delete(root.data, root.right)
    end
    rebalance unless balanced?
    root
  end

  def minim(root)
    minv = root.data
    while root.left != nil
      minv = root.left.data
      root = root.left
    end
    minv
  end

  def find(data, root = @root)
    return root if data == root.data
    return if root.left.nil? && root.right.nil?

    data < root.data ? find(data, root.left) : find(data, root.right)
  end

  def level_order(root = @root)
    return if root.nil?

    queue = [root]
    nb_result = []
    until queue.empty?
      current = queue.shift
      block_given? ? yield(current) : nb_result << current.data
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
    nb_result
  end

  def preorder(root = @root, &block)
    return if root.nil?
    
    block.call(root) unless block.nil?
    preorder(root.left, &block)
    preorder(root.right, &block)
  end

  def inorder(root = @root, &block)
    return if root.nil?

    inorder(root.left, &block)
    block.call(root) unless block.nil?
    inorder(root.right, &block)
  end

  def postorder(root = @root, &block)
    return if root.nil?

    preorder(root.left, &block)
    preorder(root.right, &block)
    block.call(root) unless block.nil?
  end

  def height(root = @root)
    return 0 if root.nil?

    left_height = height(root.left)
    right_height = height(root.right)

    [left_height, right_height].max{ |a, b| a <=> b} + 1
  end

  def depth(x, node = @root, dp = 0)
    return -1 if node.nil?
    return dp + 1 if node.data == x

    if node.data > x
      depth(x, node.left, dp + 1)
    elsif node.data < x
      depth(x, node.right, dp + 1)
    end
  end

  def balanced?(root = @root)
    return true if root.nil?

    hl = height(root.left)
    hr = height(root.right)

    (hl - hr)**2 <= 1 && balanced?(root.right) && balanced?(root.left)
  end

  def rebalance
    nodes = level_order
    nodes.sort!
    @root = build_tree(nodes)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
