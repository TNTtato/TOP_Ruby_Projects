require_relative 'forms_and_colors'
require_relative 'interface'
require_relative 'settings'

class Game
  attr_reader :code

  def initialize
    @remaining_attempts = 12
    @code_broke = false
    choose_role
  end

  def play(board)
    case @role
    when 1
      breaker_mode(board)
    when 2
      setter_mode(board)
    end
  end

  private

  def choose_role
    loop do
      puts 'Choose your role:'
      puts 'BREAKER ----> 1'
      puts 'SETTER -----> 2'
      @role = gets.chomp.to_i
      break if (1..2).include? @role
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
      code << (1..6).to_a.sample
    end
    code.join('')
  end

  def breaker_mode(board)
    @code = rand_code
    breaker_loop(board)
  end

  def breaker_loop(board)
    loop do
      one_round_breaker_m(board)
      if @code_broke
        puts 'You have broke the code!'
        break
      end
      if board.length.zero?
        puts "You have no more chances, the code was: #{@code}"
        break
      end
    end
  end

  def one_round_breaker_m(board)
    @user_code = enter_code
    code = @user_code
    result = result_each_round(code)
    draw_board(code, board, result)
  end

  def result_each_round(code)
    result = validate_code(code).sort
    @code_broke = result.all? { |c| c == 'c' }
    result
  end

  def draw_board(code, board, result)
    board.change_cells_color(code, result)
    Interface.draw_board(board)
  end

  def one_round_setter_m(board)
    result = result_each_round(@computer_code)
    draw_board(@computer_code, board, result)
    sleep(1)
  end

  def computer_loop(s, board)
    loop do
      one_round_setter_m(board)
      break if @remaining_attempts.zero? || @code_broke

      response = validate_code(@computer_code)
      delete_candidates = eliminate_candidates(s, @computer_code, response)
      s -= delete_candidates
      @computer_code = pick_a_guess(s)
      @remaining_attempts -= 1
    end
  end

  def setter_mode(board)
    puts 'Set a code for the computer:'
    @code = enter_code
    s = Settings.gen_pos
    @computer_code = '1122'
    computer_loop(s, board)
    puts 'Computer broke the code' if @code_broke
    puts 'Computer has no more chances' if @remaining_attempts.zero?
  end

  def validate_code(code, tcode = @code)
    input_code = code.split('')
    target_code = tcode.split('')
    result = []
    numbers = num_matches(input_code, target_code)
    numbers[0].times { result << 'c' }
    numbers[1].times { result << 'm' }
    result << 'n' until result.length == 4
    result
  end

  def eliminate_candidates(s, guess, last_response)
    s.reject do |candidate|
      current_ans = validate_code(candidate, guess).sort
      current_ans == last_response
    end
  end

  def pick_a_guess(possibilities)
    possibilities.sample
  end

  def num_matches(code, tcode)
    n = 0
    target = tcode
    code_i = code
    code.each_with_index do |el, idx|
      next unless el == tcode[idx]

      n += 1
      code_i[idx] = '*'
      target[idx] = '-'
    end
    m = num_non_exact_matches(code_i, target)
    [n, m]
  end

  def num_non_exact_matches(code, tcode)
    n = 0
    target = tcode
    code_i = code
    code_i.each_with_index do |_c, idx|
      target.each_with_index do |_tar, jdx|
        next unless target[jdx] == code_i[idx]

        n += 1
        code_i[idx] = '*'
        target[jdx] = '-'
      end
    end
    n
  end
end
