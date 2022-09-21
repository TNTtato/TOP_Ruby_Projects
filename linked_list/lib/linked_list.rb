require_relative 'node'

class LinkedList
  attr_reader :size, :head, :tail 

  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new
    node.value = value
    @head = node if @size.zero?
    @tail.next_node = node unless @tail.nil?
    @tail = node
    @tail.index = @size
    @size += 1
  end

  def prepend(value)
    node = Node.new
    node.value = value
    node.next_node = @head
    bloq = lambda {|node| node.index += 1}
    iterate_list(&bloq)
    @head = node
    @size += 1
  end

  def at(index = 0)
    bloq = Proc.new {|node| return node.value if node.index == index}
    iterate_list(&bloq)
  end

  def pop
    @size -= 1
    bloq = Proc.new do|node| 
      if node.next_node == @tail
        node.next_node = nil
        temp_node = @tail
        @tail = node
        return temp_node.value
      end
    end

    iterate_list(&bloq)
  end

  def contains?(value)
    contain = false
    bloq = Proc.new {|node| return contain = true if node.value == value}
    iterate_list(&bloq)
    contain
  end

  def find(value)
    bloq = Proc.new {|node| return node.index if value == node.value }
    iterate_list(&bloq)
  end

  def iterate_list(node = @head, &bloq)
    return if node.nil?
    bloq.call(node)

    return if node.next_node.nil?

    iterate_list(node.next_node, &bloq)
  end

  def to_s
    str = ''
    bloq = lambda {|node| str += node.value.nil? ? 'nil' : "( #{node.value} ) -> "}
    iterate_list(&bloq) 
    str + 'nil'
  end

  #EXTRAS
  def insert_at(value, index) 
    bloq1 = lambda {|node| node.index += 1}
    bloq = Proc.new do |node| 
      if node.index == index - 1
        insert_node_at(node, value, index)
        iterate_list(node.next_node.next_node, &bloq1) #update idxs
        return
      end
    end
    iterate_list(&bloq)
  end

  def insert_node_at(node, value, index)
    new_node = Node.new
    new_node.value = value
    new_node.next_node = node.next_node
    node.next_node = new_node
    new_node.index = index
    @size += 1
  end

  def remove_at(index)
    bloq1 = lambda {|node| node.index -= 1}
    bloq = Proc.new do |node|
      if node.index == index - 1
        node.next_node = node.next_node.next_node
        @size -= 1
        iterate_list(node.next_node, &bloq1) #update idxs
      end
    end
    iterate_list(&bloq)
  end
end
