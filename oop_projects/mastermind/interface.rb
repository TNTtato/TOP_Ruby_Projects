module Interface
  CORNER_UP_L = "\u250c"
  CORNER_UP_R = "\u2510"
  CORNER_DOWN_L = "\u2514"
  CORNER_DOWN_R = "\u2518"
  HORIZONTAL = "\u2500"
  VERTICAL = "\u2502"
  HORIZONTAL_MIDDLE_DIV_P_D = "\u252c"
  HORIZONTAL_MIDDLE_DIV_P_U = "\u2534"
  VERTICAL_MIDDLE_DIV_P_R = "\u251c"
  VERTICAL_MIDDLE_DIV_P_L = "\u2524"
  MIDDLE_DIV_X = "\u253c"

  intern_line = HORIZONTAL * 12 + MIDDLE_DIV_X + HORIZONTAL * 6 
  intern_line_up = HORIZONTAL * 12 + HORIZONTAL_MIDDLE_DIV_P_D + HORIZONTAL * 6 
  intern_line_d = HORIZONTAL * 12 + HORIZONTAL_MIDDLE_DIV_P_U + HORIZONTAL * 6
  one_cell = ' ' + "\u25cb" + ' '

  puts top_line_box = CORNER_UP_L + intern_line_up + CORNER_UP_R
  puts one_result = VERTICAL + ' ' * 12 + VERTICAL + one_cell * 2 + VERTICAL
  puts test_line = VERTICAL + one_cell * 4 + VERTICAL + ' ' * 6 + VERTICAL
  puts one_result
  puts middle_line_box = VERTICAL_MIDDLE_DIV_P_R + intern_line + VERTICAL_MIDDLE_DIV_P_L 
  puts botom_line_box = CORNER_DOWN_L + intern_line_d + CORNER_DOWN_R
end
