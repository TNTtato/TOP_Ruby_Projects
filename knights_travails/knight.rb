require_relative 'board'

class Knight
  attr_reader :board, :moves

  def initialize(start, end_pos)
    @start = start
    @end = end_pos
    @moves = [[2, -1], [2, 1], [1, 2], [-1, 2], [-2, -1], [-2, 1], [1, -2], [-1, -2]]
    @board = Board.new
    @board.knight = self
    @board.build_graph
  end

end

k = Knight.new([0,0], [3,5])
k.board.graph.each_with_index {|row, idx| puts "#{idx} --> #{row}"}
