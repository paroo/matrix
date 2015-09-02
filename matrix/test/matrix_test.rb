require 'minitest/autorun'
require_relative '../lib/matrix'

class MatrixTest < Minitest::Test
  RESET_VALUE = "H"
  COLUMN = 4
  ROW = 3
  VERTICAL_LINE_START = 2
  VERTICAL_LINE_END = 5
  VERTICAL_LINE_COLUMN = 2

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
    @matrix.set_color_to_pixel(ROW, COLUMN, "X")
    assert_equal("X", @matrix_array[(COLUMN - 1) + ((ROW - 1) * @matrix.columns)], 
		 "The value set in row #{ROW} and column #{COLUMN} is not correct")

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

  end
end