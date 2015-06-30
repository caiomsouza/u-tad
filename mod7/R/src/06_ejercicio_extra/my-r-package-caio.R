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

# https://github.com/caiomsouza/caiomsouzarpackage
devtools::install_github("caiomsouza/caiomsouzarpackage")

?cat_function

remove.packages("caiomsouzarpackage")







