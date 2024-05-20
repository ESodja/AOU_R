# Introduction
This is a basic introduction to R and RStudio, including basic syntax, using the terminal, writing scripts, 
## About R and RStudio
R is a language, RStudio is an IDE that collects all the pieces in one place to make it easier to use. [Intro to all the parts]

R includes different commands and object types to make working with data easier than, say, C++, FORTRAN, COBOL, or (arguably) Python because it was specifically developed to work with data and do statistics quickly and efficiently. 

R is open source, which has advantages and disadvantages...

R is a bit trickier to work with than Excel, but also has advantages of customizability, better handling of large datasets, and (ahem) doing statistics correctly. 

> Never run statistics in Excel.

R has functions, objects, strings, numbers, booleans, etc. Most of what we will use here are dataframes, which are essentially like an Excel spreadsheet with rows and columns. 

You can save information to objects to the RAM (short-term memory that is erased when you close R) by assigning it to a name. In R, to save a *string* (a character object, like a word or series of letters) to an object, you could use
```R
my_object <- 'This is my object'
```
or 
```R
my_object = 'This is my object'
```
Generally, in R it is preferred to use the arrow assignment (the first example) but in almost all circumstances the '=' will work the same way, so if you're used to using '=' to assign objects from previous Python experience, you can just use that.
If you enter this name into the terminal and hit enter or return, you will get your information back:
```R
> my_object <- 'This is my object'
> my_object
[1] "This is my object"
```
The "greater-than" symbol at the beginning of the line (>) indicates that this line is entered into a terminal as a single line of code -- you don't need to type the '>' part! You can save several things as a single vector object (vector comes from matrix math, where it is a one-dimensional matrix):
```R
> my_objects <- c('This is number one', 'This is number 2')
> my_objects  
[1] "This is number one" "This is number 2"
```
The vector is defined using the function `c()` (the reasons for calling it that are arcane and unimportant at this level). Anything between the brackets of `c()` will be added to the vector. This includes other vectors!
```R
> my_object
[1] "This is my object"
> my_objects
[1] "This is number one" "This is number 2"
> c(my_object, my_objects)
[1] "This is my object" "This is number one" "This is number 2"
```
You can select individual entries of a vector with indexing (Note for those with Python experience: R indexing starts at 1!), which means selecting which entry you want with a number.
```R
> my_objects[1]
[1] "This is number one"
> my_objects[2]
[1] "This is number two"
```

Dataframes work the same way, but have two dimensions:
```R
> vector_a <- c(1,2,3,4,5)
> vector_b <- c('one', 'two', 'three', 'four', 'five')
> my_frame <- data.frame(a=vector_a, b=vector_b)  
> my_frame  
  a     b  
1 1   one  
2 2   two  
3 3 three  
4 4  four  
5 5  five
```
In this code, we define vectors `vector_a` and `vector_b` and then assign them as columns of the dataframe that we name `a` and `b`. The output of `my_frame` is three columns: the first is an index column (i.e. the row number), the second is column `a` as defined in the data.frame() function, and the third is column `b`. To get only one column of the dataframe, we can use indexing again:
```R
> my_frame[1]  
  a  
1 1  
2 2  
3 3  
4 4  
5 5
> my_frame[2]  
      b  
1   one  
2   two  
3 three  
4  four  
5  five
```
Or we can use the column names -- there are two ways to do this:
```R
> my_frame$a  
[1] 1 2 3 4 5
> my_frame$b
[1] "one"   "two"   "three" "four"  "five"
```
This gives you a vector of the column, while the other way gives you a new dataframe with only the selected column(s):
```R
> my_frame['a']
  a
1 1
2 2
3 3
4 4
5 5
> my_frame['b']  
      b  
1   one  
2   two  
3 three  
4  four  
5  five
```
Different situations call for different ways of getting data from a dataframe, but in general people tend to use the `my_frame$a` style.

You can also get specific rows of a dataframe:
```R
> my_frame[2,]
  a   b
2 2 two
> my_frame[2:4,]
  a     b
2 2   two
3 3 three
4 4  four
```
The number before the comma in the bracket denotes the **row**, while the number after is the **column**. If either is blank, it gives you all of the rows or columns available. The ':' indicates a sequence or series of values -- in this case, `2:4` is equivalent to `c(2,3,4)`. If you want data from a specific range of rows and columns, you can define both:
```R
> my_frame[2:4,'b']
[1] "two"   "three" "four"  
> my_frame[2:4,2]  
[1] "two"   "three" "four"
```
The same logic can be used with true/false statements to get a subset of a dataframe. For example, if you want the rows of the dataframe where a is greater than 2, you can use a boolean operator to define the rows:
```R
> my_frame$a > 2
[1] FALSE FALSE  TRUE  TRUE  TRUE
> my_frame[my_frame$a > 2,]
  a     b
3 3 three
4 4  four
5 5  five
```
You can also do this with character vectors, though it is trickier (the words one, two, three, etc. are not recognized as numbers by R).
```R
> my_frame[my_frame$b == 'four',]  
  a    b  
4 4 four
> my_frame[my_frame$b %in% c('one','four','three'),]  
  a     b  
1 1   one  
3 3 three  
4 4  four
```
Note that the order of the elements in the search vector doesn't affect the output row order.

To save the subset as a new dataframe, simply assign it a new name:
```R
> my_frame2 <- my_frame[my_frame$b %in% c('one','four','three'),]
> my_frame2
  a     b  
1 1   one  
3 3 three  
4 4  four
```

To add a new column, you can name a new column and assign a vector to it at the same time:
```R
> my_frame2$c <- c(1.1, 1.2, 1.3)
> my_frame2  
  a     b   c  
1 1   one 1.1  
3 3 three 1.2  
4 4  four 1.3
```
You can also calculate based on existing columns:
```R
> my_frame2$d <- my_frame2$a * my_frame2$c
> my_frame2
  a     b   c   d  
1 1   one 1.1 1.1  
3 3 three 1.2 3.6  
4 4  four 1.3 5.2
```

To join to dataframes together, you use the `merge()` function:
```R
> frame1 <- data.frame(id = 1:5, value = c(1,3,5,7,9))
> frame1  
  id value  
1  1     1  
2  2     3  
3  3     5  
4  4     7  
5  5     9
> frame2 <- data.frame(id = 4:7, value = c('a','a','b','c','c'))  
> frame2  
  id value  
1  1     a  
2  2     a  
3  3     b  
4  4     c  
5  5     c
> merge(frame1, frame2, by='id')
  id value.x value.y  
1  1       1       a  
2  2       3       a  
3  3       5       b  
4  4       7       c  
5  5       9       c
```
If not all the id values match, only the ones that do will be returned by default:
```R
> frame1 <- data.frame(id = 1:5, value = c(1,3,5,7,9))
> frame1  
  id value  
1  1     1  
2  2     3  
3  3     5  
4  4     7  
5  5     9
> frame2 <- data.frame(id = 4:7, value = c('a','a','b','c'))  
> frame2  
  id value  
1  4     a  
2  5     a  
3  6     b  
4  7     c  
> merge(frame1, frame2, by='id')
  id value.x value.y  
1  4       7       a  
2  5       9       a
```

Scripts are pre-written bits of code (often very long bits!) that are run all at once in sequence. This is helpful when creating analyses that will be repeated several times or if you want to keep a record of exactly how the analysis was done.

To make a script, on the workbench in RStudio you can...

RStudio allows you to run individual lines of a script on their own, which can be very helpful for troubleshooting. 

To run an entire script, you can click the button in RStudio or enter `source('my_script.R')` in the terminal. 

Comments can be added to scripts to clarify what is going on or what you are trying to do (I will use these extensively in my code so you can understand what is going on and to 'translate' the R code as we go). Comments are ignored by R -- if a line starts with a `#` symbol, R will ignore that entire line. I will also add commented lines that show expected outputs for my examples. For example:
```R
# Create a new dataframe with three columns, with the third as the total of the first two
# create a dataframe with columns 'a' and 'b'
my_df <- data.frame(a=c(1,4,3,5,2), b=c(6,3,1,1,9))
# check to make sure it looks right
my_df
# Output:
#   a b  
# 1 1 6  
# 2 4 3  
# 3 3 1  
# 4 5 1  
# 5 2 9
# add a column called 'c' that is the sum of 'a' and 'b', by line
my_df$c <- my_df$a + my_df$b
# check to make sure it looks right
my_df
# Output:
#   a b  c  
# 1 1 6  7  
# 2 4 3  7  
# 3 3 1  4  
# 4 5 1  6  
# 5 2 9 11
```
Note that script code doesn't have the '>' at the beginning of each line; that is because it usually isn't entered directly into the terminal, but is run as an entire file. 

When you are writing (or tweaking) your own code, it is a good idea to write detailed comments throughout so that 'future you' can understand what 'past you' was thinking.

Plotting can be one of the hardest parts of data analysis, at least if you want plots that are readable. R has a lot of useful built-in plotting tools, and many more can be found in extension packages. At the most basic level you can generate a scatterplot with x and y values:
```R
# make a dataframe with x values (0 to 10) and y values (11 random values on a uniform distribution, by default between 0 and 1)
plot_df <- data.frame(x=0:10, y=runif(11))
# plot the dataframe with default plotting configuration
plot(plot_df)
```
If you have more than two columns in your dataframe, you will have to define which ones you want:
```R
# make a dataframe with x values (0 to 10), y values (11 random values on a uniform distribution, by default between 0 and 1), and z values (random between 1 and 5)
plot_df <- data.frame(x=0:10, y=runif(11), z=runif(11, 1,5))
# plot the dataframe with default plotting configuration
plot(plot_df)
# This creates plots for x against y, x against z, and y against z. We really only want one of them, say x against z
# We have to define a formula in the form 'z~x', where z is the dependent variable (vertical axis) and x is the independent variable (horizontal axis)
plot(z ~ x, data=plot_df)
# The ~ ('tilde') means 'against' or 'versus', i.e. plot z against x. 'data=plot_df' tells R what dataframe in its memory to pull from to find z and x values.
# What if we want lines between points? For lines only, add the argument type = 'l'
plot(z ~ x, data=plot_df, type='l')
# For points connected by lines, use type='b'
plot(z ~ x, data=plot_df, type='b')
```
Alternatively, you can plot them both on the same plot:
```R
# plot both y and z against x
plot(y ~ x, data=plot_df, type='b')
lines(z ~ x, data=plot_df, type='b')
# Note the use of lines instead of plot -- using plot() creates a new plot, where lines() or points() (if you don't want lines) just adds to what is there
# If the vertical axis of the first relationship is not in the range of the second one, the second one won't be visible. Fix this with ylim:
plot(y ~ x, data=plot_df, type='b', ylim=c(0, 6)) # 6 is roughly the highest value in columns y and z
lines(z ~ x, data=plot_df, type='b')
# To tell the lines apart better, we can change their colors
plot(y ~ x, data=plot_df, type='b', ylim=c(0, 6), col='blue') 
lines(z ~ x, data=plot_df, type='b', col='red')
```

Boxplots are a little different because of the way the data are structured:
```R
# Generate a boxplot
# Make an appropriate dataset for a boxplot
# rep(x, n) is to repeat its first argument x (a vector) n times
box_df <- data.frame(category=rep(c('a', 'b', 'c'), 4), value=runif(12, 0, 5))
box_df
# Output:
#    category     value  
# 1         a 3.9103827  
# 2         b 0.3264468  
# 3         c 1.2635002  
# 4         a 1.9668815  
# 5         b 0.7635340  
# 6         c 3.7872080  
# 7         a 2.8381111  
# 8         b 2.0232439  
# 9         c 1.2126411  
# 10        a 3.8239520  
# 11        b 2.8152267  
# 12        c 4.3681383
# make a boxplot with values of box_df$value and categories of box_df$category
boxplot(value ~ category, data=box_df)
# add some color with a vector of color names:
boxplot(value ~ category, data=box_df, col=c('red', 'blue', 'orange'))
```


## Things to keep in mind
- If you need help with using a function, type `?help` in the terminal (or in RStudio, you can search for help in the tab)
- There are so many places online to get help, so if you're stuck don't be afraid to google your issue. Someone has likely already asked the question and found an answer.
- The computer will always execute your commands **exactly**, even if there is a mistake in your code. 
- 

## Reading Errors in R

# RStudio
## The interface

## Installing and using packages

