require_relative 'node'

class LinkedList
  attr_reader :size, :head, :tail # reads the list size and the head

  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  def append(value)
    # create a new node
    node = Node.new
    # asign the value to the object
    node.value = value
    
    @head = node if @size.zero?
    # the last element will have this node as reference
    @tail.next_node = node unless @tail.nil?
    # is the new tail
    @tail = node
    # index = current size
    @tail.index = @size
    # increase size by one
    @size += 1
    # this node reference is nil
  end

  def prepend(value)
    #create a new node
    node = Node.new
    #asing the value to the object
    node.value = value
    # the reference will be the head
    node.next_node = @head
    # is the new head
    bloq = lambda {|node| node.index += 1}
    iterate_list(&bloq)
    @head = node
    # increase size by one
    @size += 1
  end

  def at(index = 0)
    # returns the node value at that index
    bloq = Proc.new {|node| return node.value if node.index == index}
    iterate_list(&bloq)
  end

  def pop
    # deletes the tail
  end

  def contains?(value)
    #returns true if ths list has that node
    # false other wise
  end

  def find(value)
    #returns the value of the node with that value
    # nil if it does not exist
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
list1.append(999)
puts list1
p list1.at(4)