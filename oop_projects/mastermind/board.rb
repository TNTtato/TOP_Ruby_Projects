require_relative 'forms_and_colors'
require_relative 'settings'

module Board
  class StackOfRows
    COLORS = Settings.color_hash
    attr_reader :rows, :length

    def initialize
      @length = 12
      @rows = []
      append_rows
    end

    def append_rows
      @length.times { @rows << Row.new }
    end

    def change_cells_color(code, result)
      pos = @length - 1
      change_row_input(code, pos)
      change_cells_result(result, pos)
      @length -= 1
    end

    def change_row_input(code, pos)
      broke_code = code.split('')
      working_row = @rows[pos].full_row[0]
      n = 0
      working_row.each do |cell|
        cell.circle = COLORS[broke_code[n]]
        n += 1
      end
    end

    def change_cells_result(result, pos)
      working_row = @rows[pos].full_row[1]
      n = 0
      working_row.status.flatten.each do |cell|
        case result[n]
        when 'c'
          cell.circle = COLORS['1']
        when 'm'
          cell.circle = COLORS['7']
        when 'n'
          cell.circle = FAC.default_row_circle
        end
        n += 1
      end
    end
  end

  class Row
    attr_reader :cells, :full_row

    def initialize
      @length = 4
      @cells = []
      append_cells
      @row_result = Result.new
      @full_row = [@cells, @row_result]
    end

    def append_cells
      @length.times { @cells << Cell.new }
    end
  end

  class Result
    attr_accessor :status

    def initialize
      @status = []
      create_grid_result
    end

    def create_grid_result
      2.times do
        temp = []
        2.times { temp << Cell.new }
        @status << temp
      end
    end
  end

  class Cell
    attr_accessor :circle

    def initialize
      @circle = FAC.default_row_circle
    end
  end
end
