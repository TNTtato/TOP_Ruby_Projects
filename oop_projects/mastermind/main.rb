require_relative 'board'
require_relative 'interface'
require_relative 'game'

Interface.instructions
loop do
  game = Game.new
  board = Board::StackOfRows.new
  game.play(board)
  puts "If you want to play again, press 'y/Y', else any other"
  break unless gets.chomp.downcase == 'y'
end
puts 'Thanks for playing!'

# ajustar detalles visuales finales