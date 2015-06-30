# Install devtools
install.packages("devtools")

# Load devtools
library("devtools")

# Install caiomsouzarpackage
# https://github.com/caiomsouza/caiomsouzarpackage
devtools::install_github("caiomsouza/caiomsouzarpackage")

#Load caiomsouzarpackage
library("caiomsouzarpackage")

# cat_function doc
?cat_function

# suma.dos.numeros doc
?suma.dos.numeros

# Try suma.dos.numeros
suma.dos.numeros(2,2) 
suma.dos.numeros(2,8) 
suma.dos.numeros(2.5)
suma.dos.numeros(2.8)


# Remove caiomsouzarpackage
remove.packages("caiomsouzarpackage")

