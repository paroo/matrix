require 'minitest/autorun'
require_relative '../lib/matrix'

class MatrixTest < Minitest::Test
  RESET_VALUE = "H"

  def setup
    @matrix = Matrix.new(10, 10)
    @matrix_array = @matrix.matrix
    @default_value = @matrix.default_value  
  end

  def test_matrix   
    assert_equal(100, @matrix_array.count, 
		 "The numeber of element in the matrix is incorrect")
    assert(@matrix_array.all?{|value| value == @default_value},
	   "The newly instatiated matrix does not caoint the default value" +
	   "#{@default_value}")
    @matrix.reset(RESET_VALUE)
    assert(@matrix_array.all?{|value| value == RESET_VALUE})
  end
end
