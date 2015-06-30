#
# Caio Moreno
# twitte.com/caiomsouza
# github.com/caiomsouza
# caiomsouza@gmail.com
#
# Recursos utilizados:
# http://cran.r-project.org/doc/contrib/intro-spatial-rl.pdf

#install.packages("rgeos")
#install.packages("maptools")

# Cargamos las librerías necesarias para el manejo de datos espaciales y para el tratamiento de datos.
library(rgdal)
library(ggplot2)
library(rgeos)
library(maptools)
library(plyr)
library(reshape2)

# Establecer el directorio de trabajo antes de ejecutarlo
setwd("~/git/Bitbucket/u-tad/Mod7/carlos.bellosta/ejercicios-entregues")

# Cargamos los shapefiles y lo formateamos para que pueda ser representado por ggplot2
#provincias.Espana <- readOGR(dsn = "dat/Provincias_ETRS89_30N","Provincias_ETRS89_30N", encoding="UTF-8")
provincias.Espana <- readOGR(dsn = "dat/Provincias_ETRS89_30N","Provincias_ETRS89_30N")
typeof(provincias.Espana)

provincias.Espana.df <- fortify(provincias.Espana, region = "Codigo")
head(provincias.Espana.df)
provincias.Espana.df <- merge(provincias.Espana.df, provincias.Espana@data, by.x = "id", by.y = "Codigo")

# Cargamos y limpiamos el df con los viajeros entrados por provincia en los últimos años (2011, 2012 y 2013 - Encuesta de ocupación hotelera)

# Arreglar eso cambiar el lapply(11:13) eso es para cargar los ficheiros de 11 a 13

tmp <- lapply(c(11:13), function(x) 
                        read.table(paste(paste("dat/viajeros_provincias_20", x, sep = ""), ".csv", sep = ""), sep = ";", header = T, encoding = "UTF-8"))
# No se indican las columnas de unión, lo coge automáticamente por provincia.
viajeros.Espana <- join(join(tmp[[1]], tmp[[2]]), tmp[[3]])
viajeros.Espana <- viajeros.Espana[,-3]
colnames(viajeros.Espana)[2:4] <- c("2011", "2012", "2013")

provincias.Espana$Texto %in% viajeros.Espana$Provincia
provincias.Espana$Texto[which(!(provincias.Espana$Texto %in% viajeros.Espana$Provincia))]
levels(viajeros.Espana$Provincia)
# Se indexa con un factor, si fuera character no se podría
levels(viajeros.Espana$Provincia)[viajeros.Espana$Provincia[which(!(viajeros.Espana$Provincia %in% provincias.Espana$Texto))]] <- c("Vizcaya", "Guipúzcoa", "Gerona", "Orense")
provincias.Espana$Texto %in% viajeros.Espana$Provincia

# Convertimos en formato largo para trabajar con los datos
viajeros.Espana.melt <- melt(viajeros.Espana, id = "Provincia")

plot.data <- merge(provincias.Espana.df, viajeros.Espana.melt, by.x = "Texto", by.y = "Provincia")
plot.data <- plot.data[order(plot.data$order), ]
#colnames(viajeros.España.melt)[2:3] <- c("año", "visitas")

head(plot.data)

ggplot(data = plot.data, aes(x = long, y = lat, fill = value, group = group)) + 
  geom_polygon() + geom_path(colour = "grey", lwd = 0.1) + coord_equal() + facet_wrap(~variable)

