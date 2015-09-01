class TestMetrix

  def initialize(rows, columns) 
    @rows = rows	  
    @columns = columns
    @matrix = []
    @dimension = rows * columns
    @default_value = "O"
    reset    
  end

  def reset(default_value = nil) 
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
