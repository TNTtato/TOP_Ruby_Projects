require_relative 'forms_and_colors'
require_relative 'settings'

module Interface
  CORNER_UP_L = "\u250c".freeze
  CORNER_UP_R = "\u2510".freeze
  CORNER_DOWN_L = "\u2514".freeze
  CORNER_DOWN_R = "\u2518".freeze
  HORIZONTAL = "\u2500".freeze
  VERTICAL = "\u2502".freeze
  HORIZONTAL_MIDDLE_DIV_P_D = "\u252c".freeze
  HORIZONTAL_MIDDLE_DIV_P_U = "\u2534".freeze
  VERTICAL_MIDDLE_DIV_P_R = "\u251c".freeze
  VERTICAL_MIDDLE_DIV_P_L = "\u2524".freeze
  MIDDLE_DIV_X = "\u253c".freeze
  COLOR_HASH = Settings.color_hash

  def self.draw_row(row_cells, result_cells)
    print VERTICAL + ' ' * 12 + VERTICAL
    result_cells[0].each { |cell| print ' ' + cell.circle + ' ' }
    print "#{VERTICAL}\n#{VERTICAL}"
    row_cells.each { |cell| print ' ' + cell.circle + ' ' }
    print VERTICAL + ' ' * 6
    print "#{VERTICAL}\n"
    print VERTICAL + ' ' * 12 + VERTICAL
    result_cells[1].each { |cell| print ' ' + cell.circle + ' ' }
    print "#{VERTICAL}\n"
  end

  def self.draw_board(board)
    intern_line = HORIZONTAL * 12 + MIDDLE_DIV_X + HORIZONTAL * 6 
    intern_line_up = HORIZONTAL * 12 + HORIZONTAL_MIDDLE_DIV_P_D + HORIZONTAL * 6 
    intern_line_d = HORIZONTAL * 12 + HORIZONTAL_MIDDLE_DIV_P_U + HORIZONTAL * 6
    all_rows = board.rows
    puts CORNER_UP_L + intern_line_up + CORNER_UP_R
    all_rows.each do |row|
      row_cells = row.full_row[0]
      result_cells = row.full_row[1]
      draw_row(row_cells, result_cells.status)
      puts VERTICAL_MIDDLE_DIV_P_R + intern_line + VERTICAL_MIDDLE_DIV_P_L 
    end
    puts VERTICAL + "\e[0;34m\e[47m\  BREAK THE CODE!  \e[m" + VERTICAL
    puts CORNER_DOWN_L + intern_line_d + CORNER_DOWN_R
  end

  def self.instructions
    puts CORNER_UP_L + HORIZONTAL * 20 + CORNER_UP_R
    puts VERTICAL + "\e[0;34m\e[47m\       WELCOME!     \e[m" + VERTICAL
    puts VERTICAL + "\e[0;34m\e[47m\   MASTERMIND GAME  \e[m" + VERTICAL
    puts CORNER_DOWN_L + HORIZONTAL * 20 + CORNER_DOWN_R
  
    puts 'This game consist in guessing a color code'
    puts 'The code is made of 4 colors out of six'
    puts 'There is going to be a feedback using 4 dots that represent the four colors'
    puts "\nThe feedback is going to be as follows:"
    puts 'The color is not in the code:'
    puts "----->     #{FAC.default_row_circle}"
    puts 'The color is in the code, in the wrong spot:'
    puts "----->     #{FAC.colorize(FAC.filled_circle, :white)}"
    puts 'The color is in the code, in the rigth spot:'
    puts "----->     #{FAC.colorize(FAC.filled_circle, :red)}"
    puts 'For example, two colors are rigth, one is the wrong place, and the other is not in the code:'
    puts CORNER_UP_L + HORIZONTAL * 6 + CORNER_UP_R
    puts VERTICAL + " #{FAC.colorize(FAC.filled_circle, :red)} " * 2 + VERTICAL
    puts VERTICAL + ' ' * 6 + VERTICAL
    puts VERTICAL + " #{FAC.colorize(FAC.filled_circle, :white)} " + " #{FAC.default_row_circle} " + VERTICAL
    puts CORNER_DOWN_L + HORIZONTAL * 6 + CORNER_DOWN_R
    puts "\nTo enter the colors, its going to be the next way:"
    COLOR_HASH.each { |k, v| puts "#{k} ----> #{v}" }
    puts FAC.colorize("To enter the code, you must write the whole number", :red)
    puts "\nIn this game you are going to play with the computer. You will be guessing the code or you are going to set one for the computer to guess"
    puts "\nNOW, LET THE GAME BEGIN!"
  end
end
