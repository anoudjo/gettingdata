# gettingdata
Getting and Cleaning Data Project
R Tidy Data project: create a script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.
The project is to turn a raw data or messy data into a Tidy data that satisfies 3 conditions:
1) Each variable forms a column
2) Each observation forms a row 
3) Each type of observational unit forms a table
In this project we use the following tools to clean the data and to achieve a tidy data that is restructured for analysis and meeting the objective of the tidy data cited above. The description of the package tools used are as follow:
reshape allows to handle the cleaning and tidying the data that restructure the dataset to facilitate analysis
plyr provides the tools for splitting, applying and combining data. it allows to break the data into manageable pieces 
dplyr is the next iteration of plyr and it focuses on in depth manipulation of data frame like objects

References
http://vita.had.co.nz/papers/tidy-data.pdf
https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html
https://github.com/hadley/data-baby-names
https://github.com/hadley/data-fuel-economy
https://cran.r-project.org/web/packages/plyr/index.html
https://cran.r-project.org/web/packages/dplyr/README.html
