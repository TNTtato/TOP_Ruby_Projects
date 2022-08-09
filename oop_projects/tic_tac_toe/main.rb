# game for two human players, Player class needed

class Player
  @@count_players = 0
  def initialize(name, mark)
    @name = name
    @winner = false
    @mark = mark
    puts "Player #{@name}, goes with '#{mark}'"
  end

  def self.create_player(mark)
    @@count_players += 1
    puts "Enter name of player#{@@count_players}"
    Player.new(gets.chomp, mark)
  end
  
  def make_a_move
    gets.chomp.to_i
  end
end

# a board is needed so a Board class must be created

class Board
  WINNING_OPTIONS =  [[1, 2, 3], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [4, 5, 6], [7, 8, 9], [3, 5, 7]]
  def initialize
    @free_positions = [[1,2,3], [4,5,6], [7,8,9]]
  end

  def draw_board
    puts '+---+---+---+'
    n = 0
    3.times do
      puts '|   |   |   |'
      k = 0
      3.times do 
        print "| #{@free_positions[n][k]} "
        k += 1
      end
      print '|'
      n += 1
      puts "\n|   |   |   |"
      puts '+---+---+---+'
    end
  end
end

# each game requires a new scenario, so a Game class is needed

class Game
  def initialize
    puts 'A new game was begun, please enter the players'
    @player1 = Player.create_player('X')
    @player2 = Player.create_player('O')
    @board = Board.new
  end

end