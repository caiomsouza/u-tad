# Writing an R package from scratch
# http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/

install.packages("devtools")
library("devtools")
devtools::install_github("klutometis/roxygen")
library(roxygen2)

# Show your Directory
getwd()

# Set your Directory
setwd("/Users/caiomsouza/git/Bitbucket/u-tad/Mod7/carlos.bellosta/ejercicios")

# Create a package
create("caiomsouzarpackage")

setwd("./caiomsouzarpackage")
document()

setwd("..")
install("caiomsouzarpackage")

?cat_function
?suma.dos.numeros

remove.packages("caiomsouzarpackage")
