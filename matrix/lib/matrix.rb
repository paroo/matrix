class Matrix
  attr_accessor :matrix, :default_value, :rows, :columns

  def initialize(rows, columns) 
    @rows = rows	  
    @columns = columns
    @matrix = []
    @dimension = rows * columns
    @default_value = "O"
    reset    
  end

  # re-set all the cell in a matrix with a given value
  # if value is not passed to the method use @default_value
  def reset(value = nil) 
    value ||= @default_value
    if value.nil? || !value.is_a?(String)
      raise "The value is nil or is not a string"
    end  
    @matrix.clear
    index = 0

    while index <= @dimension - 1
      @matrix << value
      index += 1
    end 
  end 

  # set the a value in a specific cell
  def set_color_to_pixel(row, column, colour)
    pixel = ((row - 1) * @columns) + (column - 1)
    @matrix[pixel] = colour
  end 
  
  def draw_vertical_line(column, start_row, end_row, colour)
  end 
 
  def draw_orizzontal_line(start_column, end_column, row, colour)
  end

  def paint_area
  end 	  

  def init
  end
	  
  def to_s(*matrix)
  end
end
