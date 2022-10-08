require_relative 'board'

class Knight
  attr_reader :board, :moves, :src, :dst

  def initialize(src, dst)
    @src = src
    @dst = dst
    @moves = [[2, -1], [2, 1], [1, 2], [-1, 2], [-2, -1], [-2, 1], [1, -2], [-1, -2]]
    @board = Board.new
    @board.knight = self
    @board.build_graph
  end
end
