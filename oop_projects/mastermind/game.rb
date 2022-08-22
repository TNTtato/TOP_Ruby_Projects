require_relative 'forms_and_colors'
require_relative 'interface'

class Game
  attr_reader :code
  def initialize
    @remaining_attempts = 12
    @code_broke = false
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
    code = []
    4.times do 
      code << (1..6).to_a.sample(1)
    end
    code.join('')
  end

  def breaker_mode(board)
    @code = '1432'
    loop do
      one_round_breaker_m(board)
      condition1 = @code_broke
      condition2 = board.length.zero?
      if condition1
        puts 'You have broke the code!'
        break
      end
      if condition2
        puts 'You have no more chances, the code was:'
        puts @code
        break
      end
    end
  end

  def one_round_breaker_m(board)
    @user_code = enter_code
    result = validate_code(@user_code).sort
    @code_broke = result.all? {|c| c == 'c'}
    board.change_cells_color(@user_code, result)
    Interface.draw_board(board)
  end

  def guesser_mode(board)
  end

  def validate_code(code, tcode = @code)
    input_code = code.split('')
    target_code = tcode.split('')
    result = []
    numbers = num_matches(input_code, target_code)
    numbers[0].times {result << 'c'}
    numbers[1].times {result << 'm'}
    result << 'n' until result.length == 4
    result
  end
  
  def num_matches(code, tcode)
    n = 0
    target = tcode
    code_i = code
    code.each_with_index do |el, idx|
      if el == tcode[idx]
        n += 1
        code_i[idx] = '*'
        target[idx] = '-'
      end
    end
    m = num_non_exact_matches(code_i, target)
    [n,m]
  end
  
  def num_non_exact_matches(code, tcode)
    n = 0
    target = tcode
    code_i = code
    code_i.each_with_index do |_c, idx|
      target.each_with_index do |_tar, jdx|
        if target[jdx] == code_i[idx]
          n += 1
          code_i[idx] = '*'
          target[jdx] = '-'
        end
      end
    end
    n
  end

  def gen_pos
    base = (1111..6666).to_a
    base_s = base.map { |num| num.to_s }
    base_s_n = base_s.select do |num|
      num.split('').any? { |n| n.to_i > 6 || n.to_i.zero? }
    end
    base_s -= base_s_n
  end
  
end
