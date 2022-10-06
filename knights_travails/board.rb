class Board
  attr_accessor :knight, :graph

  def initialize
    @positions = create_board
  end

  def create_board
    Array.new(64) {Array.new(2)}
         .each_with_index do |pos, idx|
           pos[0] = idx / 8
           pos[1] = idx % 8
         end
  end

  def build_graph
    @graph = @positions.map do |pos|
      temp = []
      self.knight.moves.each do |mov|
        pos_change = [pos[0] + mov[0], pos[1] + mov[1]]
        temp << @positions.index(pos_change) if @positions.include? pos_change
      end
      temp
    end
  end
end
