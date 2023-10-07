#
# SUPPLY CHAIN NETWORK OPTIMIZATION

# Coursera Guided Project
# Instructor - Moses Gummadi

# We use R Library "lpSolve API" for Optimization
# Reference - https://cran.r-project.org/web/packages/lpSolveAPI/index.html

# This is an R Script file
# You can open this in R Studio
# Use # symbol for comments in R Script file
# The script file contains code and comments
# You can run the code by typing it next to ">" symbol
#   in the Console window (bottom left)
# You can also run the code by selecting the code in
#   the script file and hit "Run" in the top-left pane

# R Studio is already downloaded in your Rhyme Desktop
# To download on your own desktop
# Use this link https://rstudio.com/products/rstudio/
# Choose the RStudio Desktop Free Option

# ---------------------------------------------------------
# Task 1 - Introduction
# ---------------------------------------------------------

# R lpSolve API Optmization Steps:
#    Determine Number of Variables, Assign Names
#    Define & Add Objective Function 
#    Determine & Add The Constraints
#    Solve The Optimization Problem
#    Obtain & Export The Solution

# Add Libraries
check = c("lpSolveAPI","data.table") %in% installed.packages()
if(!check[1]) install.packages("lpSolveAPI")
if(!check[2]) install.packages("data.table")
library(lpSolveAPI); library(data.table)

#setwd("~/Documents/Coursera Instructor/Optimisation")
setwd("C:/Users/r0869080/Downloads")

# Distance Matrix
Dist = fread("Distance Matrix.csv")
Dist$Index = 1:nrow(Dist)

# Factories & Capacities
FT = data.table(Factory = unique(Dist$Source)[1:2],
                Capacity = c(150000, 200000))

# Distribution Centres & Throughputs
DC = data.table(
  DistCentre = unique(Dist$Source)[3:6],
  Throughput = c(70000, 50000,100000,40000))

# Customers & Demands
CT = data.table(Customer = unique(Dist$Destination)[5:10],
                Demand = c(50000,10000,40000,35000,60000,20000))

print(Dist)
print(FT)
print(DC)
print(CT)

# Exercise - run the above code


# ---------------------------------------------------------
# Task 2 - Problem Formulation & Objective Function
# ---------------------------------------------------------

# lpSolve Object (0 constraints, nrow(Dist) variables)
m <- make.lp(0,nrow(Dist))

# Cost Function - Minimize Cost = Qty Shipped x Distance
# set.objfn(model, vector of coefficients of all Xs)
set.objfn(m,Dist$Distance)

# Exercise 1: Run the Above Code

# Exercise 2: 
# Display the Customer Demand (figures only)  
# Use the $ to get the column from dataframe

CT$Demand


# ---------------------------------------------------------
# Task 3 - Factory Capacity Constraints
#         Qty leaving Factory <= Capacity
# ---------------------------------------------------------

# add.constraint(model, coeff, sign, rhs, indexes)

xcoef = rep(1, nrow(Dist[Source == "Liverpool"]))
xpos   = Dist[Source == "Liverpool"]$Index
xrhs  = FT[Factory == "Liverpool"]$Capacity
add.constraint(m,xcoef,"<=", xrhs, xpos)

xcoef = rep(1, nrow(Dist[Source == "Brighton"]))
xpos   = Dist[Source == "Brighton"]$Index
xrhs  = FT[Factory == "Brighton"]$Capacity
add.constraint(m,xcoef,"<=", xrhs, xpos)


# Exercise 1: Run the Above Code

# Exercise 2: 
# Subset "Dist" by Source = "Newcastle"
# Extract index values for the above

Dist[Source == "Newcastle"]
Dist[Source == "Newcastle"]$Index

# ---------------------------------------------------------
# Task 4 - Distribution Centre Constraints 
#          Qty out of DC - Qty into DC = 0
#          Qty out of DC <= DC Throughput Limit
# ---------------------------------------------------------

# Qty out of DC - Qty into DC = 0
for(i in DC$DistCentre) {
  xcoef = c(rep(1, nrow(Dist[Source == i])),
            rep(-1, nrow(Dist[Destination == i])))
  xpos  = c(Dist[Source == i]$Index,
            Dist[Destination == i]$Index)
  add.constraint(m,xcoef,"=", 0, xpos)
}

# Qty out of DC <= DC Throughput Limit
# Do it in the exercise

# Exercise 1: Run the Above Code

# Exercise 2: Add the 2nd constraint:
# Qty out of DC <= DC Throughput Limit

for(i in DC$DistCentre) {
  xcoef = rep(1, nrow(Dist[Source == i]))
  xpos   = Dist[Source == i]$Index
  xrhs  = DC[DistCentre == i]$Throughput
  add.constraint(m,xcoef,"<=", xrhs, xpos)
}




# ---------------------------------------------------------
# Task 5 - Customer Demand Constraints
#          Qty into Customer = Demand
#          Integer Constraint
# ---------------------------------------------------------

# Qty into Customer = Demand
for(i in CT$Customer) {
  xcoef = rep(1, nrow(Dist[Destination == i]))
  xpos   = Dist[Destination == i]$Index
  xrhs  = CT[Customer == i]$Demand
  add.constraint(m,xcoef,"=", xrhs, xpos)
}

# Exercise 1: Run the Above Code

# Exercise 2: Apply "integer" constraints 
# Use set.type(model, variable indexes, "integer")

set.type(m, Dist$Index,"integer")

# ---------------------------------------------------------
# Task 6 - Run Optimiser, Obtain & Analyse Solution
# ---------------------------------------------------------

# Solve & Get Solution
x = proc.time()
lp.control(m, timeout = 10)

solve(m)
proc.time() - x

get.objective(m) 

out = get.variables(m)
Dist$Qty = out

Dist[Qty != 0]

# Exercise 1: Run the Above Code

# Exercise 2: 
# Change Factory Capacities To
# Liverpool = 250,000
# Brighton = 100,000
# And run the solver again



# ---------------------------------------------------------
# End of Guided Project - Thank You
# ---------------------------------------------------------
