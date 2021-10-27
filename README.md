# Quantifying the influence of forest and snow characteristics on avalanche protection of forested slopes

This research proposes a novel method allowing to simulate both the release and flow of the avalanche at the slope scale and the interaction between the snow and the forest at every individual tree.

## Description

The code performs a set of tasks to visualize the first results of the avalanche behaviour

## Getting Started

### Dependencies

* The code is written in the R language. If you are a new user, please refer to: https://rstudio-education.github.io/hopr/starting.html

### Installing

* To run the code with the example data you need to download the
* It is recommended to create a folder containing the R code and the results file (.csv).

### Executing program

* For a better understanding it is recommended to run the code by parts (step-by-step). You need to select the part of the code you want to run and click the "Run" button.
* The outputs of the tasks are shown in the console window. You can access the output dataframes and variables from the "Environment" window. As you will see, the figures will show up in the 4th window.
* The header contains information about the project and the author.
```
# MODELING AVALANCHE PROTECTION IN FORESTS
# Author:       Francesc Molné Correig
# Date:         2020
# Description:  The code loads the results from the model and plots
```
* IMPORTANT: The first thing you will need to do is to save the R script in a directory of your choice, but inside the same folder where the results file (.csv) is located. Then you will go to "Session" > "Set working directory" > "To source file location".
* Now you will load the packages with the library() function. If you need to install them first, you can do it with the function install.packages(). As an example:
```
install.packages("dplyr")
```

```
# Load packages:

library(dplyr)
library(reshape2)
library(chron)
library(ggplot2)
library(GGally)
library(car)
library(corrplot)
library(lattice)
```
* Next, you will need to load the results file. Remember to save the .csv file in the same folder where your code is located. You can use the function

```
# Load results file and check:

file_results  <- file.path("results.csv")   # Call file directory. The results file has to be located at the same directory than the code

results       <- read.table(file_results,   # Read the results data frame, and specify 
                            header = TRUE, 
                            sep = ";", 
                            dec = ",")
head(results)                               # Verify the correct loading by checking the first rows of the results dataframe
```
* The loaded data will have to be arranged into a molten dataframe. This is done for the plotting function requirements. 

```
# Adapt the dataframe (convert into a molten dataframe):

results_melt1 <- melt(results, 
                      id.vars=c("Frame", 
                                "Time", 
                                "Forest_structure", 
                                "Snow_type")
                      )

head(results_melt1)  # Verify the transformation

results_melt1$Forest_structure <- factor(results_melt1$Forest_structure, 
                                         levels = c ("No forest", 
                                                     "Ordered forest", 
                                                     "Random forest", 
                                                     "Clustered forest")
                                         )
```
* Finally, you will be able to setup the plots of the avalanche behaviour (runout distance, front velocity, and percentage of non-released particles), for the three types of snow, and as a function of time.

```
# Plot the avalanche response variables as a function of time (for every snow type):

plot_results1 <- ggplot(results_melt1)     
  + facet_grid(variable ~ Snow_type, 
               scales   = "free_y")          # panels created out of these variables
  + geom_line(aes(Time, 
                  value, 
                  color = Forest_structure)
              )     

print(plot_results1)                         # view the plot
```
## Help

Should you need any help or report a bug, do not hesitate to send an email to the author (contact information hereafter).

## Authors

Francesc Molné Correig (francesc.molne@epfl.ch)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the [NAME HERE] License
