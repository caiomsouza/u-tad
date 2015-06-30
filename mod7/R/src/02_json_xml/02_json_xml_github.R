#github apis
#https://developer.github.com/v3/
# https://api.github.com/search/repositories?q=it4biz&sort=stars&order=desc
#https://api.github.com/users/caiomsouza/orgs
#https://api.github.com/users/caiomsouza/followers
#https://api.github.com/users/caiomsouza
#https://api.github.com/users/aws/repos


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
Required_Packages=c("jsonlite", "ggplot2");

# Call the Function
Install_And_Load(Required_Packages);


setwd("~/git/Bitbucket/u-tad/Mod7/carlos.bellosta/ejercicios-entregues")

#url <- "https://api.github.com/users/caiomsouza/repos"
url <- "https://api.github.com/users/it4biz/repos"
#url <- "https://api.github.com/users/aws/repos"
#url <- "https://api.github.com/search/repositories?q=pentaho&sort=stars&order=desc"

json <- fromJSON(url)

json
head(json)
class(json)

#plot <- ggplot(json, aes(ssh_url, score)) + geom_point()
#print(plot)

plot <- ggplot(json, aes(name, size)) + geom_point()
print(plot)

plot <- ggplot(json, aes(name, open_issues)) + geom_point()
print(plot)

plot <- ggplot(json, aes(name, watchers)) + geom_point()
print(plot)

ggplot(json, aes(name, fill=watchers)) + geom_bar() + coord_flip()

ggplot(json, aes(name, fill=open_issues)) + geom_bar() + coord_flip()

ggplot(json, aes(name, fill=size)) + geom_bar() + coord_flip()


#str(json)
#json

#colunas
#id
#full_name
#name
#created_at
#updated_at
#size
#watchers 
#open_issues
#forks


#json[[1]]
#json[[2]]
#json[[3]]
#json[[4]]
#json[[5]]
#json[[6]]
#json[[7]]
#json[[8]]
#json[[9]]
#json[[10]]
#json[[11]]
#json[[12]]
#json[[13]]
#json[[14]]
#json[[15]]
#json[[16]]
#json[[17]]
#json[[18]]
#json[[19]]
#json[[20]]
#json[[21]]
#json[[22]]
#json[[23]]
#json[[24]]
#json[[25]]
#json[[26]]
#json[[27]]
#json[[28]]



names(json)
#names(json$owner)
#json$owner$login
#json$owner$watchers_count
#json$owner$size
#head(json)
#colnames(json)