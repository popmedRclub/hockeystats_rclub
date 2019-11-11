#### Types of data ####

### numeric (num) ###
#this is the default class for any number that is input into R. Can be either a decimal or an integer.

is.numeric(4.56)
is.integer(4.56)

class(4)
#why is 4 not an integer?
#what could you do to classify 4 as an integer?
#why would you want to classify a number as an integer?

### integers (int) ###

#integers are WHOLE numbers 

is.integer(3.14)

as.integer(3.14)

#what happens here?
as.integer(3.99)

#SPOILERS: the as.integer function will ALWAYS round down. If you are trying to round the conventional way, try round()
#alternatively, if you want to round one way or another you can use floor(), or ceiling()


### logical (lgl) ###
# TRUE (note caps) <==> T
# FALSE <==> F

a <- 5
#is a less than 4?
a < 4

b <- c(1:10)
b < 5

which(b < 5)


### characters (chr) ###
#due to the statistical nature of R, letters are always read as potential variables.Must close in 
#either " " or ' ' quotes (either is fine). Characters are the default class for text strings.

names <- c("Sarah", 'Reilly')
class(names)

#NOTE: look how the text in the brackets turns green - if all of your code is green then you 
#may have forgot a closing quote


### factors ###
#a factor is a category - can be both numeric and a string

sample.data <- c(T,F,T,T,T,F,T,F,T,T,F,T,F,F,F,F,F,T,F)
sample.data <- as.integer(sample.data)

#try looking at the summary statistics of the sample data (NOTE the class of 'sample.data')
summary()
#Does this seem right?

#now let's try to reassign this vector as a facor and look at the summary stats, what's different?
sample.data <- as.factor(sample.data)
summary()

### double floats (dbl) ###

#not a lot here - a dbl is simply a numeric with double-precision
?double

#an aside...
double(5) #will create a vector of length 5 containing all zeros.
#useful for creating a 'blank' vector that can be filled in as necessary (can also use integer(5),numeric(5))

### Commands recap ###
#is.___()
#class(___)

#changing class of data
#data <- as.____(data)

#### Types of data storage ####

#### Vectors ####

#c function will create a vector of the same class

#not always needed.
sample.vector <- 1:10
is.vector(sample.vector)
#true or false?

#but what if we have numbers that aren't in order
sample.vector <- c(2,4,6,8)

#vector addition &subtraction
5 + sample.vector
sample.vector-1

#vector multiplication & division
2*sample.vector
sample.vector/2

#what if we want to have a vector of characters?
char.vector <- c("red","blue","green")
class(char.vector)

#Can we combine two vectors? Try it with 'sample.vector' and 'char.vector'. 
#Do we need quotes or not?

combined.vector <- c()

#take a look at the class, what do you see?  
class(combined.vector)


## Indexing with vectors  
#we can index a particular item in a vector using []

sample.vector[3]

#take all EXCEPT with a '-'
sample.vector[-3]

#choose only items with a certain value
sample.vector[sample.vector > 2 & sample.vector < 8]


#### Matrices #### 
#Matrices have ONLY the same data class - i.e. a way of storing a group of vectors

A <- matrix( c(1, 1, 2, 3, 5, 8), nrow=2, ncol=3, byrow = TRUE)   
dimnames(A) <- list(c("Monday","Tuesday"),c('a','b','c'))

#include a character - what happens to all the numbers?
B <- matrix( c(1, 1, 2, 3, 5, "orange"), nrow=2, ncol=3, byrow = TRUE)   
dimnames(B) <- list(c("Monday","Tuesday"),c('a','b','c'))

#### Indexing a matrix ####

#matrix[row,column]

#index with numbers
A[1,3] #feel free to double check this from your matrix

#index by name
A["Tuesday","c"]


#combination of matrices - careful of variable names!!

#bind the columns of the matrices together
comb.mat <- cbind(A,B)

#bind the rows of the matrices together
comb.mat <- rbind(A,B)

## can perform a variety of matrix algebra that won't be discussed here - just FYI for you linear algebra weirdos!


#### Lists ####

#Lists are a convenient way to store various types and sizes of data in one place

names <- c("Sarah", "Reilly")
pets <- c(2,0)
pet.names <- c("George","Cat", NA)

# ***what is important here? ***

Rclub.pet.info <- list(names,pets,pet.names)

#### Indexing lists ####
# use [] to index the a list slice 

Rclub.pet.info[1]

# use [[]] to index a member of a list directly  

Rclub.pet.info[[2]]

#use [[]][] to index specific items in a membership vector 

Rclub.pet.info[[2]][1]

#### Dataframes ####

#dataframes are very similar to matrices BUT...

artists <- c("Guthrie","Seeger","Dylan")
DOB <- as.Date(c("14jul1912","03may1919","24may1941"),format="%d%b%Y")
nobel.prize <- c(F,F,T)
number.np.awards <- c(0,0,1)
string.average <- c(18/3,23/3,6)
deceased.age <- c(55,94,NA)

df <- data.frame(artists, 
                 DOB, 
                 nobel.prize,
                 number.np.awards,
                 string.average,
                 deceased.age)

#### Indexing dataframes ####

# using [,] - same as a matrix!
# dataframe[row,column]

df[1,1]

# use the $ operator to index by column name

df$string.average

#use our knowledge of vectors to index a df and then index the vector
df$string.average[2] #OR 

df$string.average[df$artists=="Seeger"]
#The latter is a little bit more complex but much easier to work with if you are unfamiliar with the dataset



#NEXT WEEK: INTRO TO TIDYVERSE (so that you dont have to type things like line 220)
