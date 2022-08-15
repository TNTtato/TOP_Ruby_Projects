require_relative 'forms_and_colors'
require_relative 'board'

class Game
  attr_reader :code
  def initialize
    @remaining_attempts = 12
    # instructions needed, must be created in interface
    choose_role
  end

  def choose_role
    loop do
      puts 'Choose your role:'
      puts 'BREAKER ----> 1'
      puts 'GUESSER ----> 2'
      @role = gets.chomp.to_i
      break if (1..2).include? @role
    end
  end

  def play(board)
    case @role
    when 1
      breaker_mode(board)
    when 2
      guesser_mode(board)
    end
  end

  def enter_code
    code = ''
    in_range = false
    until code.size == 4 && in_range
      print FAC.colorize('Enter a valid code:  ', :red)
      code = gets.chomp
      in_range = code.split('').all? { |c| (1..6).include? c.to_i }
    end
    code
  end

  def rand_code
    (1..6).to_a.sample(4).join('')
  end

  def breaker_mode(board)
    @code = rand_code
    @user_code = enter_code
    result = validate_code(@user_code).sort
  end

  def guesser_mode
  end

  def validate_code(code)
    target_code = @code.split('')
    input_code = code.split('')
    result = []
    target_code.each_with_index do |cod, idx|
      if input_code.include?(cod)
        n = 'm'
        input_code.each_with_index do |tar, jdx|
          n = 'c' if jdx == idx && tar == cod
        end
        result << n
      else
        n = 'n'
        result << n
      end
    end
    result
  end
end
