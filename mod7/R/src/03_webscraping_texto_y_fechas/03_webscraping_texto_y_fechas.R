
# Install devtools
#install.packages("devtools")

# Load devtools
#library("devtools")

# Install caiomsouzarpackage
# https://github.com/caiomsouza/caiomsouzarpackage
# devtools::install_github("caiomsouza/adminpackage4r")


#Load adminpackage4r
#Info about adminpackage4r package at https://github.com/caiomsouza/adminpackage4r
library("adminpackage4r")

# Specify the list of required packages to be installed and load
Required_Packages=c("stringr", "XML");

# Call the Function
Install_And_Load(Required_Packages);

#library(XML)
#library(stringr)

# IBEX website 
url.ibex <- "http://goo.gl/yD2Bwb"

# Read from IBEX Website 
raw.data <- readLines(url.ibex, warn="F") 
bolsa.doc  <- htmlTreeParse(raw.data, error=function(...){}, useInternalNodes = TRUE,encoding="UTF-8")

#head(raw.data, 20)

#Infos 
class(bolsa.doc)
bolsa.root = xmlRoot(bolsa.doc)
xmlSize(bolsa.root)
xmlSApply(bolsa.root, xmlName)
xmlSApply(bolsa.root, xmlSize)
class(xmlChildren(bolsa.root))
typeof(xmlChildren(bolsa.root))

# Parse IBEX Website
bolsa.body = xmlChildren(bolsa.root)$body
file_header <- xpathSApply(bolsa.body, "//table[@title='Acciones']/*/tr[1]/th", xmlValue)
file_content <- xpathSApply(bolsa.body, "//table[@title='Acciones']/*/tr/td", xmlValue)
file_header <- sapply(file_header, function(x) gsub("^(\n){1,}|(\\*){1,}$", "", x))
bolsa.tabla <- data.frame(matrix(file_content, ncol = 13, byrow = TRUE), stringsAsFactors = FALSE)
bolsa.tabla <- bolsa.tabla[,-5]
file_header<-file_header[-5]
colnames(bolsa.tabla) <- file_header
bolsa.tabla <- bolsa.tabla[order(bolsa.tabla$TKR),]
bolsa.tabla$Último <- as.numeric(gsub(",", ".", bolsa.tabla$Último))
bolsa.tabla$Dif. <- as.numeric(gsub(",", ".", bolsa.tabla$Dif.))
bolsa.tabla$'Dif. %' <- as.numeric(gsub(",", ".", bolsa.tabla$'Dif. %'))
bolsa.tabla$Max. <- as.numeric(gsub(",", ".", bolsa.tabla$Max.))
bolsa.tabla$Min. <- as.numeric(gsub(",", ".", bolsa.tabla$Min.))
bolsa.tabla$Volumen <- as.numeric(gsub("\\.", "", bolsa.tabla$Volumen))
bolsa.tabla$Capital <- as.numeric(gsub("\\.", "", gsub("[:space]*n.d.[:space]*", NA, bolsa.tabla$Capital)))
bolsa.tabla$Último <- as.numeric(gsub(",", ".", bolsa.tabla$Último))
bolsa.tabla$'Rt/Div' <- gsub(",", ".", (gsub("[:space]*n.a.[:space]*", NA, bolsa.tabla$'Rt/Div')))
bolsa.tabla$PER <- as.numeric(gsub(",", ".", gsub("[:space]*n.a.[:space]*", NA, bolsa.tabla$PER)))
bolsa.tabla$BPA <- as.numeric(gsub(",", ".", gsub("[:space]*n.a.[:space]*", NA, bolsa.tabla$BPA)))

#Print 
bolsa.tabla
head(bolsa.tabla, 10)
tail(bolsa.tabla, 10)