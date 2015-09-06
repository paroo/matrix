#!/usr/bin/env ruby

class Matrix
  attr_accessor :matrix, :default_value, :rows, :columns

  def initialize(rows, columns) 
    @rows = rows	  
    @columns = columns
    @matrix = []
    @dimension = rows * columns
    @default_value = "O"
    @row_start = *(0..((@rows - 1) * @columns)).step(@columns).to_a
    @row_end =  *((@columns - 1)..((@rows) * @columns)).step(@columns).to_a
    @first_row = *(0..(@columns - 1)).to_a
    @last_row = (((@rows - 1) * @columns)...@dimension).to_a
    @cell_value = nil
    reset
  end

  # re-set all the pixels in the matrix with a given value
  # if value is not passed to the method use @default_value
  def reset(value = nil) 
    value ||= @default_value
    raise_is_not_a_string(value)
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
    raise_is_not_a_string(colour)
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
    raise_is_not_a_string(colour)
       
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
  def draw_horizontal_line(start_column, end_column, row, colour)
    first_column = start_column > end_column ? end_column : start_column
    last_column  = start_column > end_column ? start_column : end_column
    raise_wrong_row(row)
    raise_wrong_column(start_column, end_column)    
    raise_is_not_a_string(colour)

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

  def paint_area(row, column, colour)
    raise_wrong_row(row)
    raise_wrong_column(column)    
    raise_is_not_a_string(colour)

    @visited = []
    pixel = pixel(row, column - 1)
    setSimilarValue(pixel, colour)
  end

  # recursively set the colour of the next pixel
  # if the colour is the same, if not continue searching
  def setSimilarValue(cell, colour)
    @cell_value = @matrix[cell] if @cell_value.nil?
    value = @matrix[cell]

    if !cell.nil? && !@visited.include?(cell) && 
       value == @cell_value && cell >= 0 and cell < @dimension
      @visited << cell
      @matrix[cell] = colour 
      # TODO: refactor the following if statements
      if @row_start.include?(cell)
        if cell == 0
          setSimilarValue(cell + 1, colour)               
	  setSimilarValue(cell + @columns, colour)
          setSimilarValue(cell + @columns + 1, colour)  
	elsif cell == 15	
          setSimilarValue(cell + 1, colour)               
	  setSimilarValue(cell - @columns, colour)
          setSimilarValue(cell - @columns + 1, colour)  
	else
	  setSimilarValue(cell + 1, colour)               
	  setSimilarValue(cell - @columns, colour)      
          setSimilarValue(cell + @columns, colour)       
          setSimilarValue(cell + @columns + 1, colour) 
          setSimilarValue(cell - @columns + 1, colour)  
        end			     
      elsif @row_end.include?(cell)
        if cell == 4
          setSimilarValue(cell - 1, colour)               
	  setSimilarValue(cell + @columns, colour)
          setSimilarValue(cell + @columns + 1, colour)  
	elsif cell == 15	
          setSimilarValue(cell - 1, colour)               
	  setSimilarValue(cell - @columns, colour)
          selectSimilarValue(cell - @columns + 1, colour) 
	else
	  setSimilarValue(cell + 1, colour)               
	  setSimilarValue(cell - @columns, colour)      
          setSimilarValue(cell + @columns, colour)       
          setSimilarValue(cell + @columns + 1, colour)
	  setSimilarValue(cell - @columns + 1, colour)  
        end
      elsif @first_row.include?(cell) 
        setSimilarValue(cell + 1, colour)               
	setSimilarValue(cell + @columns, colour)
        setSimilarValue(cell + @columns + 1, colour) 
        setSimilarValue(cell - 1, colour)               
	setSimilarValue(cell + @columns + 1, colour)     
      elsif @last_row.include?(cell) 
        setSimilarValue(cell + 1, colour)               
	setSimilarValue(cell - @columns, colour)
        setSimilarValue(cell - @columns + 1, colour)  
        setSimilarValue(cell - 1, colour)               
	setSimilarValue(cell - @columns - 1, colour)
      else
        setSimilarValue(cell + 1, colour)               
	setSimilarValue(cell - 1, colour)               
	setSimilarValue(cell + @columns, colour)        
	setSimilarValue(cell - @columns, colour)        
	setSimilarValue(cell + @columns + 1, colour)        
	setSimilarValue(cell + @columns - 1, colour)        
        setSimilarValue(cell - @columns + 1, colour)        
	setSimilarValue(cell - @columns - 1, colour)
      end   
    end
  end

  private def pixel(row, column)
    ((row - 1) * @columns) + column
  end

  private def raise_wrong_row(*rows) 
    if rows.any?{|value| value > @rows}
      capture_exception("The row selected is greater than #{@rows}")
    end  
  end

  private def raise_wrong_column(*columns) 
    if columns.any?{|value| value > @columns}
      capture_exception("The column selected is greater than #{@columns}")
    end  
  end
  
  private def raise_is_not_a_string(value)
    if value.nil? || !value.is_a?(String)
      capture_exception("The value is nil or is not a string") 
    end
  end

  # utility method to capture exceptions
  private def capture_exception(exception)
    begin
      raise exception
    rescue => detail
      puts detail
    end	      
  end

  def self.exctract_arguments(values)
    values.delete_at(0)
    values.map do |value|
      if self.is_number? value
        value.to_i
      else
	value
      end
    end
  end

  def self.is_number?(string_value)
    true if Integer(string_value) rescue false
  end

  # create a regex expression from a series fo commands
  def self.create_regex(command, number_of_digits = 0)
    if !command.is_a?(String)
      capture_exception("The command argument must be a string") 
    end
    if !number_of_digits.is_a?(Integer)
      capture_exception("The number_of_digits argument must be a string") 
    end

    if number_of_digits != 0
      arguments = [command, 
		   *(0...number_of_digits).map{|x| "d+"}, "w"
                  ].join("\\s+\\")
    else
      arguments = command
    end

    return Regexp.new(arguments)
  end

  def self.init
    is_matrix_created = false
    create_bitmap_usage = <<-eos
      Usage: I [number] [number] -- program that simulates a basic interactive 
                                    bitmap editor

        where:
            number(first)   rapresent the number of rows in the bitmap
            number(second)  rapresent the number of column in the bitmap
    
    eos

    interective_bitmap_usage = <<-eos
       Usage : 
           C           - Clears the table, setting all pixels to white (O).
           L X Y C     - Colours the pixel (X,Y) with colour C.
           V X Y1 Y2 C - Draw a vertical segment of colour C in column X betwee
                         rows Y1 and Y2 (inclusive).
           H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between
                         columns X1 and X2 (inclusive).
           F X Y C     - Fill the region R with the colour C. R is defined as: 
                         Pixel (X,Y) belongs to R. Any other pixel which is the
                         same colour as (X,Y) and shares a common side with any
                         pixel in R also belongs to this region.
           S           - Show the contents of the current image
           X           - Terminate the session
    eos
        
    puts create_bitmap_usage

    $stdin.each_line do |line|	
       input = String(line.chomp)
       values = String(line.chomp).split(/\s+/)
       command = values[0]
       if command == "X"
         return
       end	       
        
       if !is_matrix_created
         rows = values[1].to_i
         columns = values[2].to_i
         if values.count == 3 && command == "I" && 
            self.is_number?(rows) && 
	    self.is_number?(columns) 
           
           if rows != 0 && columns != 0 
             @new_matrix = Matrix.new(rows, columns)
	     is_matrix_created = true
	     puts "Bitmap #{rows} X #{columns} has been created\n"
             puts interective_bitmap_usage
	   else 	 
	     puts create_bitmap_usage	   
	   end	   
         else 	 
	   puts create_bitmap_usage	   
         end	   
       else
	 arguments = exctract_arguments(values)
         case input
           when create_regex("C")
             @new_matrix.reset
           when create_regex("L", 2)
             @new_matrix.set_color_to_pixel(*arguments)
           when create_regex("V", 3)
             @new_matrix.draw_vertical_line(*arguments)
           when create_regex("H", 3)
             @new_matrix.draw_horizontal_line(*arguments)
           when create_regex("F", 2)
             @new_matrix.paint_area(*arguments)
           when create_regex("S")
             @new_matrix.to_s    
          else  
             puts "The command #{values.join(" ")} is not valid please " + 
                  "select the following options"
	     puts interective_bitmap_usage   
         end
      end 
    end
  end

  def to_s(*matrix)
    matrix ||= @matrix	  
    columns_index = 0
    elements = ""
    @matrix.each do |i|
      elements += i
      columns_index += 1	 
      if columns_index == @columns       
         puts elements
         elements = ""
         columns_index = 0
      end
    end 
  end
  self
end.init

