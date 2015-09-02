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

  # re-set all the pixels in the matrix with a given value
  # if value is not passed to the method use @default_value
  def reset(value = nil) 
    value ||= @default_value
    raise_wrong_pixel_value(value)
    @matrix.clear
    index = 0

    while index <= @dimension - 1
      @matrix << value
      index += 1
    end 
  end 

  # set value in a specific pixel
  def set_color_to_pixel(row, column, colour)
    raise_wrong_row(row)
    raise_wrong_column(column)    
    raise_wrong_pixel_value(colour)
    pixel = ((row - 1) * @columns) + (column - 1)
    @matrix[pixel] = colour
  end 
  
  # drow a vertical line from a pixel to another pixel
  # with a give colour 
  def draw_vertical_line(column, start_row, end_row, colour)
    first_row = start_row > end_row ? end_row   : start_row
    last_row  = start_row > end_row ? start_row : end_row
    raise_wrong_row(first_row, last_row)
    raise_wrong_column(column)    
    raise_wrong_pixel_value(colour)
       
    if start_row == end_row
      set_color_to_pixel(start_row, column, colour)
    else 
      index = 0
      start_pixel = pixel(first_row, column)
      end_pixel = pixel(last_row, column)

      for i in 0 .. @matrix.length - 1 
        index += 1
	if start_pixel == index && i < end_pixel
          @matrix[index - 1] = colour
	  start_pixel += @columns
	end	
      end
    end 	  
  end 

  # drow a orizzantal line from a pixel to another pixel
  # with a give colour 
  def draw_orizzontal_line(start_column, end_column, row, colour)
    first_column = start_column > end_column ? end_column : start_column
    last_column  = start_column > end_column ? start_column : end_column
    raise_wrong_row(row)
    raise_wrong_column(start_column, end_column)    
    raise_wrong_pixel_value(colour)

    if start_column == end_column 
      set_color_to_pixel(start_column, row, colour)
    else 
      start_pixel = pixel(row, first_column)
      end_pixel = pixel(row, last_column)

      for i in 0 .. @matrix.length - 1 
	if i >= start_pixel && i <= end_pixel
          @matrix[i - 1] = colour  
	end
      end
    end
  end

  def paint_area
  end 	  

  def init
  end

  private def pixel(row, column)
    ((row - 1) * @columns) + column
  end

  private def raise_wrong_row(*rows) 
    if rows.any?{|value| value > @rows}
      raise "The row selected is greater than #{@rows}"
    end  
  end

  private def raise_wrong_column(*columns) 
    if columns.any?{|value| value > @columns}
      raise "The column selected is greater than #{@columns}"
    end  
  end
  
  private def raise_wrong_pixel_value(value)
    if value.nil? || !value.is_a?(String)
      raise "The value is nil or is not a string"
    end
  end

  def to_s(*matrix)
  end
end
