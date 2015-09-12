# Technical Test Ruby developer

Ruby 2.0 program that simulates a basic interactive bitmap editor solving the [exercise](https://gist.github.com/soulnafein/8ee4e60def4e5468df2f) 

## Approach

*  I decided to use one Array to represent the bitmap instead of having multiple Arrays as it will create only one array object in memory rather than one array per row.
* I M N function : this function initialize the Matrix class with the rows and columns that form the bitmap as well as identifying the elements in the perimeter of the bitmap to use when painting the area with the function F.
*   C function  : this function is easy to implement as I need to loop one across one array. 
*   L X Y C : First I made sure that the row and column are within the bitmap and the colour C is a string, otherwise I raise an exception. The function change the value of an element in the Array with index ((row - 1) * @columns) + (column - 1), where row is the X, column is Y and @column is the number of column the bitmap has. Note I decreased the value or row and column as the first element of the Array is 0 while the first row and column is 1. 
*   V X Y1 Y2 C function : First I made sure the rows and columns are within the bitmap and the colour is a string. The function start by identifying where to start changing the value and where to stop. The loop simply change the first element in the vertical line and set the next element by adding the column the bitmap has. One the loop reach the second element the function set the value of that element with the value C.  
*  H X1 X2 Y C function : First I made sure the rows and columns are within the bitmap and the colour is a string. The function start by identifying the start point and end point. The loop simply change the value of all the element between the starting point and end point with the value C.  
*   F X Y C function : First I made sure that the row and column are within the bitmap and the colour C is a string, otherwise I raise an exception. I have taken a depth-first approach, recursively searching each possible path and change the value if it the same as the parent node. I made sure that if the element is in the border of the bitmap the function can search only in the directions available. e.g. if the element is in row 1 and column1, the function should only search the element on the right, bottom, and bottom-right-corner. Once the element is visited I make sure that the element cannot be visited again. The search continuouse till all the element are visited.
*  S function : I use a loop to collect all the element in a row, once the loop reach the last element in the loop I print all the elements collected and restart the process till there is no more element in the Array.    
*   X function : Simply exit the IO read function.

## Improvements

* I will make the console more user friendly by proactively asking the user to enter a input rather than enter a function with all its parameters. e.g. 
 
Please enter one of the following options :

* I  - Create a new image with all pixels coloured white (O).
* C - Clears the table, setting all pixels to white (O).
* L - Colours the pixel with colour C.
* V - Draw a vertical segment of colour C.
* H - Draw a horizontal segment of colour C.
* F - Fill the region R with the colour C.
* S - Show the contents of the current image
* X - Terminate the session

> I

Please enter the number of rows:

> 100

Please enter the number of columns:

> 100

If there is any error display the error and ask the used to enter the value again.

Please select the number of rows:

> A

The row must be a number, Please enter the number of rows:

> 100

I will modify the I option::

> I  

Please enter bitmap name :

> test_bitmap_1

...

I will also add one more options::

* O   - Display options
* D   - Save a specific bitmap in a given location.
* SA - Show all bitmaps details (size, location and last modified)
* L    - Load bitmaps in a give location
* M   - Make a copy of a bitmap


