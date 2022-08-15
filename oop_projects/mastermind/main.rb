require_relative 'board'
require_relative 'interface'
require_relative 'game'

Interface.instructions
game = Game.new
board = Board::StackOfRows.new

game.play(board)
