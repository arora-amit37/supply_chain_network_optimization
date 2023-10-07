# Supply Chain Network Optimization

This R script is part of a Coursera Guided Project instructed by Moses Gummadi. It focuses on solving a supply chain network optimization problem using the R library "lpSolve API" for optimization. The objective is to determine the most efficient way to distribute goods from factories to distribution centers and customers while minimizing transportation costs.

## Getting Started

1. **Prerequisites**: Make sure you have R and RStudio installed on your system. If not, you can download RStudio for free from [this link](https://rstudio.com/products/rstudio/).

2. **Libraries**: This script uses two R packages: "lpSolveAPI" and "data.table." If you don't have these packages installed, you can install them using the code provided in the script.

3. **Working Directory**: The script assumes that your working directory is set to a specific location. You can modify the working directory using the `setwd()` function at the beginning of the script.

## Overview

The script follows a step-by-step approach to solve the supply chain network optimization problem:

### Task 1 - Introduction
- Introduces the optimization problem and the steps involved.
- Installs and loads necessary libraries.
- Sets the working directory to the desired location.
- Reads the distance matrix and defines factories, distribution centers, and customers.

### Task 2 - Problem Formulation & Objective Function
- Creates an lpSolve object with the objective to minimize transportation costs.
- Sets up the cost function based on the quantity shipped and distance.

Network diagram:

<img width="845" alt="network" src="https://github.com/arora-amit37/supply_chain_network_optimization/assets/50020662/a01ee4d5-7049-485b-b1e3-7bc555248fd3">

### Task 3 - Factory Capacity Constraints
- Adds constraints to ensure that the quantity leaving each factory does not exceed its capacity.

### Task 4 - Distribution Centre Constraints
- Ensures that the quantity out of each distribution center equals the quantity into that center.
- Adds constraints to limit the quantity leaving each distribution center to its throughput limit.

### Task 5 - Customer Demand Constraints
- Enforces that the quantity delivered to each customer matches their demand.
- Sets integer constraints on certain variables.

## Distance Matrix

|           | Birmingham | Cambridge | Carlisle | Darlington | Exeter | Liverpool | London | Newcastle | Oxford | Sheffield | Truro |
|-----------|------------|-----------|----------|------------|--------|-----------|--------|-----------|--------|-----------|-------|
| Birmingham|      0     |     99    |   193    |    172     |  176   |    99     |  221   |    345    |   79   |    91     |  249  |
| Cambridge |     99     |     0     |    60    |     37     |  206   |   221     |   58   |    130    |   99   |   168     |   65  |
| Carlisle  |    193     |    60     |     0    |      0     |  346   |   178     |  307   |    178    |  258   |   130     |  458  |
| Darlington|    172     |    37     |     0    |      0     |  354   |   178     |  249   |    130    |  258   |    91     |  354  |
| Exeter    |    176     |   206     |   346    |    354     |    0   |   251     |  163   |     60    |  163   |   251     |   90  |
| Liverpool |     99     |   221     |   178    |    178     |  251   |    0      |  307   |    236    |  258   |   130     |  458  |
| London    |    221     |    58     |   307    |    249     |  163   |   307     |   0    |    236    |   56   |   168     |  284  |
| Newcastle |    345     |   130     |   178    |    130     |   60   |   236     |  236   |     0     |  258   |    91     |  249  |
| Oxford    |     79     |    99     |   258    |    258     |  163   |   258     |   56   |    258    |    0   |    79     |  168  |
| Sheffield |     91     |   168     |   130    |     91     |  251   |   130     |  168   |     91    |   79   |    0      |  206  |
| Truro     |    249     |    65     |   458    |    354     |   90   |   458     |  284   |    249    |  168   |   206     |    0  |


### Task 6 - Run Optimizer, Obtain & Analyze Solution
- Solves the optimization problem.
- Retrieves and analyzes the solution, including the optimized quantity to be shipped between locations.

## Completion Certificate

<img width="608" alt="completion" src="https://github.com/arora-amit37/supply_chain_network_optimization/assets/50020662/52e15884-36d8-4977-9667-321d033d0edb">

## Usage

You can run this script in RStudio by copying and pasting the code into the R script editor. Follow the comments and execute the code step by step to understand and customize the optimization problem according to your data and requirements.

## Thank You

This marks the end of the Guided Project. Thank you for using this script, and we hope it helps you optimize your supply chain network effectively. If you have any questions or need further assistance, feel free to reach out to the instructor or consult the "lpSolve API" documentation for additional details.

Happy optimizing!
