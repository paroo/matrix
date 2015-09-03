require 'minitest/autorun'
require_relative '../lib/matrix'

class MatrixTest < Minitest::Test
  RESET_VALUE = "H"
  COLUMN = 4
  ROW = 3
  VERTICAL_LINE_START = 2
  VERTICAL_LINE_END = 5
  VERTICAL_LINE_COLUMN = 2
  ORIZZANTAL_LINE_START = 4
  ORIZZANTAL_LINE_END = 9
  ORIZZANTAL_LINE_ROW = 8

  def setup
    @matrix = Matrix.new(10, 10)
    @matrix_array = @matrix.matrix
    @default_value = @matrix.default_value  
  end

  def test_matrix   
    assert_equal(100, @matrix_array.count, 
		 "The numeber of element in the matrix is incorrect")
    assert(@matrix_array.all?{|value| value == @default_value},
	   "The newly instatiated matrix does not contain the default value" +
	   "#{@default_value}")
    @matrix.reset(RESET_VALUE)
    assert(@matrix_array.all?{|value| value == RESET_VALUE},
	   "The reset method did not reset all the elements")
    assert_raises do  
      @matrix.reset(1)
    end

    # test set_color_to_pixel() method
    @matrix.set_color_to_pixel(ROW, COLUMN, "X")
    assert_equal("X", @matrix_array[(COLUMN - 1) + ((ROW - 1) * @matrix.columns)], 
		 "The value set in row #{ROW} and column #{COLUMN} is not correct")

    # test draw_vertical_line() method
    @matrix.draw_vertical_line(VERTICAL_LINE_COLUMN, VERTICAL_LINE_START, VERTICAL_LINE_END, "Z")
    vertical_line_indexes = [] 
    @matrix_array.each_with_index do |value, index|
      vertical_line_indexes << index if value == "Z"  
    end
    actual_vertical_line_indexes =  (VERTICAL_LINE_START..VERTICAL_LINE_END).to_a.map{|x| ((x - 1) * @matrix.columns) + (VERTICAL_LINE_COLUMN - 1) }
    assert_equal(vertical_line_indexes, actual_vertical_line_indexes)  

    @matrix.draw_vertical_line(VERTICAL_LINE_COLUMN, VERTICAL_LINE_END, VERTICAL_LINE_START, "S")
    vertical_line_indexes = [] 
    @matrix_array.each_with_index do |value, index|
      vertical_line_indexes << index if value == "S"  
    end
    actual_vertical_line_indexes =  (VERTICAL_LINE_START..VERTICAL_LINE_END).to_a.map{|x| ((x - 1) * @matrix.columns) + (VERTICAL_LINE_COLUMN - 1) }
    assert_equal(vertical_line_indexes, actual_vertical_line_indexes)  

    assert_raises do  
      @matrix.draw_vertical_line(11, 5, 10, "Z")
    end
    assert_raises do  
      @matrix.draw_vertical_line(10, 5, 11, "Z")
    end
    assert_raises do  
      @matrix.draw_vertical_line(10, 11, 10, "Z")
    end
    assert_raises do  
      @matrix.draw_vertical_line(5, 5, 10, 0)
    end

    # test draw_orizzontal_line() method
    @matrix.draw_orizzontal_line(ORIZZANTAL_LINE_START, ORIZZANTAL_LINE_END, ORIZZANTAL_LINE_ROW, "W")
    orizzantal_line_indexes = [] 
    @matrix_array.each_with_index do |value, index|
      orizzantal_line_indexes << index if value == "W"  
    end
    actual_orizzantal_line_indexes =  (ORIZZANTAL_LINE_START..ORIZZANTAL_LINE_END).to_a.map{|x| (x - 1) + ((ORIZZANTAL_LINE_ROW - 1) * @matrix.columns) }
    assert_equal(orizzantal_line_indexes, actual_orizzantal_line_indexes)  

    @matrix.draw_orizzontal_line(ORIZZANTAL_LINE_END, ORIZZANTAL_LINE_START, ORIZZANTAL_LINE_ROW, "K")
    orizzantal_line_indexes = [] 
    @matrix_array.each_with_index do |value, index|
      orizzantal_line_indexes << index if value == "K"  
    end
    actual_orizzantal_line_indexes =  (ORIZZANTAL_LINE_START..ORIZZANTAL_LINE_END).to_a.map{|x| (x - 1) + ((ORIZZANTAL_LINE_ROW - 1) * @matrix.columns) }
    assert_equal(orizzantal_line_indexes, actual_orizzantal_line_indexes)  

    assert_raises do  
      @matrix.draw_orizzontal_line(11, 5, 2, "Z")
    end
    assert_raises do  
      @matrix.draw_orizzontal_line(5, 11, 2, "Z")
    end
    assert_raises do  
      @matrix.draw_orizzontal_line(5, 8, 11, 0)
    end
    assert_raises do  
      @matrix.draw_orizzontal_line(5, 8, 10, 0)
    end

    # test print_area() method
    @matrix.reset
    @matrix.draw_vertical_line(VERTICAL_LINE_COLUMN, VERTICAL_LINE_START, 
			       VERTICAL_LINE_END, "Z")
    vertical_line_indexes = [] 
    @matrix_array.each_with_index do |value, index|
      vertical_line_indexes << index if value == "Z"  
    end

    @matrix.paint_area(3, 2, "P")   

    painted_area_indexes = [] 
    @matrix_array.each_with_index do |value, index|
      painted_area_indexes << index if value == "P"  
    end
    assert_equal(vertical_line_indexes, painted_area_indexes)  

    assert_raises do  
      @matrix.paint_area(11, 5,"Z")
    end
    assert_raises do  
      @matrix.draw_orizzontal_line(5, 11, "Z")
    end
    assert_raises do  
      @matrix.draw_orizzontal_line(5, 8, 0)
    end
  end
end
