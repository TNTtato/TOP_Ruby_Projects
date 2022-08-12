module WiningConditions
  WINNING_OPTIONS = [[1, 2, 3], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [4, 5, 6], [7, 8, 9], [3, 5, 7]].freeze  
end

# game for two human players, Player class needed
class Player
  @@count_players = 0
  attr_reader :mark, :name
  attr_accessor :winner, :player_moves

  def initialize(name, mark)
    @name = name
    @winner = false
    @mark = mark
    @player_moves = []
    puts "Player #{@name}, goes with '#{mark}'"
  end

  def self.create_player(mark)
    @@count_players += 1
    puts "Enter name of player#{@@count_players}"
    Player.new(gets.chomp, mark)
  end

  def make_a_move
    puts "\n#{@name}, make a valid move"
    gets.chomp.to_i
  end
end

# a board is needed so a Board class must be created
class Board
  attr_accessor :free_positions

  def initialize
    @free_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
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

  def valid_move?(move)
    @free_positions.flatten.include? move
  end
end

# each game requires a new scenario, so a Game class is needed
class Game
  attr_reader :player1, :player2
  def initialize
    puts 'A new game was begun, please enter the players'
    @player1 = Player.create_player('X')
    @player2 = Player.create_player('O')
    @players = [@player1, @player2]
    @board = Board.new
    @board.draw_board
  end

  def full_game
    n = 0
    loop do
      break if run_game(n).nil?

      n = n.zero? ? 1 : 0
    end
  end

  def run_game(n)
    return puts "#{@players[n].name} is the winner" if one_player_actions(@players[n])
    return puts 'There is a draw' unless @board.free_positions.flatten.any? { |pos| pos.to_i.positive?}

    0
  end

  def one_player_actions(player)
    move_of_player(player)
    @board.draw_board
    win?(player)
  end

  def move_of_player(player)
    move = 0
    move = player.make_a_move until @board.valid_move?(move)
    player.player_moves << move
    i = 0
    j = 0
    @board.free_positions.each_with_index do |free_row, idx|
      if free_row.include? move
        i = idx
        j = free_row.index move
      end
    end
    @board.free_positions[i][j] = player.mark
  end

  def win?(player)
    player_won = false
    WiningConditions::WINNING_OPTIONS
      .each { |win_opt| player_won = true if (win_opt - player.player_moves).empty? }
    player.winner = player_won
  end
end

game1 = Game.new
game1.full_game
