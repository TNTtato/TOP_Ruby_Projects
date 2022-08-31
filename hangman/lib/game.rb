require_relative 'interface'

class Game
  def initialize
    @chances = 10
    @dict = File.read('dict.txt')
  end

  def new_game
    @word = @dict.split("\n").select { |word| word.length.between?(5, 12) }.sample
    @arr_result = Array.new(@word.length, '_')
    @all_guesses = []
    play_game
  end

  def play_game
    loop do
      c = enter_char
      g = Interface.colorize(c, :red)
      @word.split('').each_with_index do |letter, idx|
        if c == letter
          @arr_result[idx] = c
          g = Interface.colorize(c, :green)
        end
      end
      if @all_guesses.include? g
        puts 'Enter a letter that has not been enter'
        next
      end

      @all_guesses << g
      print "Current guesses are: "
      @all_guesses.each { |l| print " #{l}"}
      puts
      @chances -= 1 unless @word.include? c
      @arr_result.each { |k| print " #{k}"}
      print "\tRemaining chances: #{@chances}"
      puts
      break if @arr_result.join('') == @word || @chances.zero?
    end
    puts "Too bad, you lose. The word was: #{@word}" if @chances.zero?
  end

  def enter_char
    a = '0'
    one_entry = ->(c) do
      print 'Enter a valid letter: '
      gets.chomp.downcase
    end
    a = one_entry.(a) until ('a'..'z').include?(a) && !a.empty?
    a
  end
end

Game.new.new_game