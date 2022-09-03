require_relative 'game'
require_relative 'interface'

Interface.instructions
loop do
  Game.new
  puts 'Do you want to play again? --> Enter: Y or y'
  break unless gets.chomp.downcase == 'y'
end

puts 'Thanks for playing!'