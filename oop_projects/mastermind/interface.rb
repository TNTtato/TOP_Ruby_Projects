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

  # intern_line = HORIZONTAL * 12 + MIDDLE_DIV_X + HORIZONTAL * 6 
  # intern_line_up = HORIZONTAL * 12 + HORIZONTAL_MIDDLE_DIV_P_D + HORIZONTAL * 6 
  # intern_line_d = HORIZONTAL * 12 + HORIZONTAL_MIDDLE_DIV_P_U + HORIZONTAL * 6
  # one_cell = ' ' + "\u25cb" + ' '

  # puts top_line_box = CORNER_UP_L + intern_line_up + CORNER_UP_R
  # puts one_result = VERTICAL + ' ' * 12 + VERTICAL + one_cell * 2 + VERTICAL
  # puts test_line = VERTICAL + one_cell * 4 + VERTICAL + ' ' * 6 + VERTICAL
  # puts one_result
  # puts middle_line_box = VERTICAL_MIDDLE_DIV_P_R + intern_line + VERTICAL_MIDDLE_DIV_P_L 
  # puts botom_line_box = CORNER_DOWN_L + intern_line_d + CORNER_DOWN_R

  def Interface.draw_row(row_cells, result_cells)
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

  def Interface.draw_board(board)
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
end

#draw_board(["\u25cb","\u25cb","\u25cb","\u25cb"], [["\u25cb","\u25cb"],["\u25cb","\u25cb"]])