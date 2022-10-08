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
