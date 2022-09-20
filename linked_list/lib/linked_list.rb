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
    #returns the value of the node with that value
    # nil if it does not exist
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
    #represent the list with following format
    # ( value ) -> ( value ) -> ( value ) -> nil
    str = ''
    bloq = lambda {|node| str += node.value.nil? ? 'nil' : "( #{node.value} ) -> "}
    iterate_list(&bloq) 
    str + 'nil'
  end

  #EXTRAS
  #insert_at(value, index) that 
  #inserts a new node with the provided value at the given index.

  ##remove_at(index) that removes the node at the given index.
end

list1 = LinkedList.new
list1.append("hola")
list1.append(123)
list1.prepend("otro")
p list1.pop
list1.append(999)
puts list1
p list1.at(0)
p list1.size
p list1.contains?("perro")

p list1.find('otro')