require_relative 'forms_and_colors'

module Board
  class Stack_of_Rows
    attr_reader :rows

    def initialize
      @length = 12
      @rows = []
      append_rows
    end

    def append_rows
      @length.times { @rows << Row.new }
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
    attr_reader :status

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
    attr_reader :circle

    def initialize
      @circle = FormsAndColors.default_row_circle
    end
  end
end
