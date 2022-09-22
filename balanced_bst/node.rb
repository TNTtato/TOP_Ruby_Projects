class Node 
  def initialize(value)
    attr_accessor :left, :right
    
    @value = value
    @left = nil
    @right = nil
  end
end