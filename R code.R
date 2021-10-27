# MODELING AVALANCHE PROTECTION IN FORESTS
# Author:       Francesc Molné Correig
# Date:         2020
# Description:  The code loads the results from the model and plots


# Load packages:

library(dplyr)
library(reshape2)
library(chron)
library(ggplot2)
library(GGally)
library(car)
library(corrplot)
library(lattice)


# Load results file and check:

file_results  <- file.path("results.csv")   # Call file directory. The results file has to be located at the same directory than the code

results       <- read.table(file_results,   # Read the results data frame, and specify 
                            header = TRUE, 
                            sep = ";", 
                            dec = ",")
head(results)                               # Verify the correct loading by checking the first rows of the results dataframe


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


# Plot the avalanche response variables as a function of time (for every snow type):

plot_results1 <- ggplot(results_melt1)     
  + facet_grid(variable ~ Snow_type, 
               scales   = "free_y")          # panels created out of these variables
  + geom_line(aes(Time, 
                  value, 
                  color = Forest_structure)
              )     

print(plot_results1)                         # view the plot



