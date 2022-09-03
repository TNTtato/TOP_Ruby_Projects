require_relative 'interface'
require_relative 'serialize'

class Game
  include Serialize
  include Interface
  def initialize
    choose_new_saved
  end

  def choose_new_saved
    Interface.new_or_load
    case gets.chomp.to_i
    when 1
      new_game
    when 2
      load_game
    when 3
      delete_game
    end
  end

  def delete_game
    games = print_saved_games('delete')
    if games.empty?
      puts "\n#{Interface.colorize('There are no saved games yet', :red)}"
      sleep(2)
      return Game.new
    end
    fname = load_game_options(games)
    return Game.new if fname.nil?

    File.delete("saved/#{fname}")
    puts "#{fname} has been deleted"
    sleep(1)
    delete_game
  end

  def save_game
    dict = File.read('dict.txt')
    name = dict.split("\n").sample(2).join('_')
    num = (1..100).to_a.sample
    name_file = "#{name}#{num}.yaml"
    File.open("saved/#{name_file}", 'w') do |file|
      file.puts self.to_yaml 
      puts file.to_s
    end
  end

  def load_game_options(games)
    fname = ''
    loop do
      choice = gets.chomp.downcase
      return if choice == 'exit'

      fname = games[choice.to_i - 1]
      break if fname
      
      puts Interface.colorize('no such game saved!', :red)
      sleep(2)
      print_saved_games
    end
    fname
  end

  def load_game
    games = print_saved_games
    if games.empty?
      puts "\n#{Interface.colorize('There are no saved games yet', :red)}"
      sleep(2)
      return Game.new
    end
    fname = load_game_options(games)
    return Game.new if fname.nil?
    
    load_this = File.open("saved/#{fname}")
    self.from_yaml!(load_this)
    draw_result
    play_game
  end

  def set_initial_vars
    @chances = 10
    dict = File.read('dict.txt')
    @word = dict.split("\n").select { |word| word.length.between?(5, 12) }.sample
    @arr_result = Array.new(@word.length, '_')
    @all_guesses = []
  end

  def new_game
    set_initial_vars
    play_game
  end

  def bad_move(c)
    system "clear"
    g = Interface.colorize(c, :red)
    return puts "You should enter another letter, #{g} is incorrect" if check_repetition(g)
    
    @all_guesses << g
    @chances -= 1
    @lose = @chances.zero?
  end

  def good_move(c)
    system "clear"
    g = Interface.colorize(c, :green)
    return puts "#{g} has been guessed!" if check_repetition(g)
    
    @all_guesses << g
    @word.split('').each_with_index do |letter, idx|
        @arr_result[idx] = c if c == letter
      end
    @win = @arr_result.join('') == @word
  end

  def check_repetition(g)
    @all_guesses.include? g
  end

  def play_game
    loop do
      c = enter_char
      return Game.new if c.nil?

      @word.include?(c) ? good_move(c) : bad_move(c)
      draw_result
 
      break if @lose || @win
    end
    final_result
  end

  def enter_char
    a = '0'
    one_entry = lambda do
      print 'Enter a valid letter save, to save the game, exit to quit: '
      gets.chomp.downcase
    end
    until ('a'..'z').include?(a) && !a.empty?
      a = one_entry.call
      save_game if a == 'save'
      return if a == 'exit'
    end
    a
  end
end

