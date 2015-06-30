# Caio Moreno
# twitte.com/caiomsouza
# github.com/caiomsouza
# caiomsouza@gmail.com

# Infos del paquete MicroDatoEs
# http://cran.r-project.org/web/packages/MicroDatosEs/index.html
# http://www.datanalytics.com/2012/08/06/un-paseo-por-el-paquete-microdatoses-y-la-epa-de-nuevo/
# http://cran.r-project.org/web/packages/MicroDatosEs/MicroDatosEs.pdf
# http://cran.r-project.org/src/contrib/Archive/MicroDatosEs/

# Install MicroDatosEs if it is not already installed
#install.packages("MicroDatosEs")
#library(MicroDatosEs)
if (!(require("MicroDatosEs", character.only=T, quietly=T))) {
  install.packages("MicroDatosEs")
  library("MicroDatosEs", character.only=T)
}

#library(plyr)
if (!(require("plyr", character.only=T, quietly=T))) {
  install.packages("plyr")
  library("plyr", character.only=T)
}

remove.packages("plyr")

library("plyr")

#install.packages("data.table")
#library(data.table)
if (!(require("data.table", character.only=T, quietly=T))) {
  install.packages("data.table")
  library("data.table", character.only=T)
}

#install.packages("dplyr")
#library(dplyr)
if (!(require("dplyr", character.only=T, quietly=T))) {
  install.packages("dplyr")
  library("dplyr", character.only=T)
}


# Descarga los microdatos del censo del 2011 de http://goo.gl/guhG1M. Puedes bajar el nacional o, si tienes problemas de memoria, alguno de los regionalizados. En esa página hay también información sobre las variables contenidas en el fichero y su formato. Puedes leerlo en R usando el paquete MicroDatosEs. Consulta la ayuda de la función censo2010.

# Set the path
setwd("~/git/Bitbucket/u-tad/Mod7/carlos.bellosta/ejercicios-entregues")

# MicroDatosEs Package Bug
# There is a bug in the package. To fix it you have to replace the MicroDatosEs file censo_2010_mdat1.txt by the new one at INE.
# Copy the correct censo_2010_mdat1.txt at INE or dat/censo_2010_mdat1.txt to the MicroDatosEs folder
# Linux terminal command line:
# cp /Users/caiomsouza/git/Bitbucket/u-tad/Mod7/carlos.bellosta/ejercicios/dat/censo_2010_mdat1.txt /Library/Frameworks/R.framework/Versions/3.1/Resources/library/MicroDatosEs/metadata


#censo2010

# Link to download Microdatos_personas_nacional (MicrodatosCP_NV_per_nacional_CSE.txt)
# ftp://www.ine.es/temas/censopv/cen11/Microdatos_personas_nacional.zip
#censo <- censo2010("dat/MicrodatosCP_NV_per_nacional_CSE.txt", summary=FALSE);

# Hemos utilizado MicrodatosCP_NV_per_BLOQUE4_CSE.txt por que el MicrodatosCP_NV_per_nacional_CSE.txt es muy grande.
censo <- censo2010("dat/MicrodatosCP_NV_per_BLOQUE4_CSE.txt", summary=FALSE);

head(censo)

factores <- c("edad", "cpro", "rela");
censo.df <- as.data.frame(censo[, factores]);
censo.df$rela[is.na(censo.df$rela)]<- 'Otra situación'


#head(censo.df)
#summary(censo.df)
#colnames(censo.df);

memory.size(max = FALSE)

#rownames(censo.df)

# Porcentaje de poblacion activa por edad y provincia con ddply 
occupied.percent <- ddply(censo.df, .(edad, cpro), function(x) {
  totalNumber = nrow(x)
  numberOccupied = nrow(x[x$rela == 'Ocupado',])
  occupied.percent = (numberOccupied/totalNumber)*100
  data.frame(occupied.percent = occupied.percent)
})


censo.dt <- as.data.table(censo.df)
tables()

censo.dt$swOcupado <- ifelse( censo.dt$rela == "Ocupado",1,0)
censo.dt$sumaAux <- ifelse( censo.dt$rela == "Ocupado",1,1)
censo.summarize <- censo.dt[, list(sumOcupaCount = sum(swOcupado) , sumTotalCont =  sum(sumaAux)), by = c("edad", "cpro")]
censo.summarize[, percentOcupa := {(sumOcupaCount / sumTotalCont) * 100},]

#colnames(censo.summarize)
setkeyv(censo.summarize, c("edad", "cpro"))
censo.dplyr <- copy(censo.df)
censo.dplyr <- censo.dplyr %>% mutate(sumaAux = 1)
censo.dplyr <- censo.dplyr %>% mutate(swOcupado = ifelse( censo.dplyr$rela == "Ocupado",1,0))
censo.dplyr.summarize <- censo.dplyr %>% group_by(edad, cpro) %>% summarise((sum(swOcupado)/sum(sumaAux))*100)

# prints
head(censo.dplyr.summarize)
tail(occupied.percent, 100)


# Falta hacer la medición de tiempos