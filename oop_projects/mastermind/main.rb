require_relative 'board'
require_relative 'interface'

board = Board::Stack_of_Rows.new

Interface.draw_board(board)