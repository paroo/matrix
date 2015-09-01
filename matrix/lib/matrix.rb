class Matrix
  attr_accessor :matrix, :default_value

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
  def reset(default_value = nil) 
    default_value ||= @default_value
    @matrix.clear
    index = 0

    while index <= @dimension - 1
      @matrix << default_value
      index += 1
    end 
  end 

  def set_color_to_pixel(row, column, colour)
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
