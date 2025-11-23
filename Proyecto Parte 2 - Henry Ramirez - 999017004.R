#instalacion de librerias
#install.packages("readxl")
#install.packages('rpart')
#install.packages('rpart.plot')
#install.packages("randomForest")
#install.packages("ggalt")



#Carga de librerias
library(readxl)
library(rpart)
library(rpart.plot)
library(randomForest)
library(dplyr)


# NOTA IMPORTANTE:
# Antes de ejecutar el script, CAMBIA la siguiente ruta según la ubicación
# de la carpeta "DATA" en tu computadora.
ruta<-"C:\\Users\\hedua\\OneDrive\\Escritorio\\MAESTRIA\\4to Trimestre\\INTRO. MINERIA DE DATOS\\Proyecto_Parte2_Introduccion_Mineria_de_Datos\\DATA\\"


#---------------------------------------------------------------------------
#----------------------LIMPIEZA DE LOS DATOS-------------------------------
#---------------------------------------------------------------------------

# Nota: Este bloque (líneas 38 a 230) puede ejecutarse de manera continua sin necesidad de hacerlo línea por línea.
# Al ejecutar el bloque completo, se aplican todas las transformaciones, 
# normalizaciones y unificación de columnas para los datos de los años 2015-2024. 

# Para los años 2015-2024:
# - Se toma como referencia la estructura de columnas del archivo de 2024.
# - Se asignan nombres consistentes a todas las columnas de los dataframes de cada año.
# - Se reordenan las columnas para que todos los dataframes tengan la misma estructura.

name_columns <- c("num_correlativo","anio_ocu","dia_ocu","hora_ocu","g_hora","g_hora_5",
                  "mes_ocu","dia_sem_ocu","mupio_ocu","depto_ocu","zona_ocu","tipo_veh",
                  "marca_veh","color_veh","modelo_veh","g_modelo_veh","tipo_eve")



data_2024 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2024.xlsx"))
names(data_2024) <- name_columns

data_2023 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2023.xlsx"))
names(data_2023) <- name_columns

data_2022 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2022.xlsx"))  
names(data_2022) <- name_columns

data_2021 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2021.xlsx"))
data_2021<-data_2021[,-12]
names(data_2021) <- name_columns


data_2020 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2020.xlsx"))
names(data_2020) <- name_columns

data_2019 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2019.xlsx"))
names(data_2019) <- name_columns

data_2018 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2018.xlsx"))
names(data_2018) <- name_columns

data_2017 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2017.xlsx"))
names(data_2017) <- name_columns


data_2016 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2016.xlsx"))
data_2016 <- data_2016[, c("núm_corre","año_ocu","día_ocu","hora_ocu","g_hora",
                           "g_hora_5","mes_ocu","día_sem_ocu","mupio_ocu","depto_ocu",
                           "zona_ocu","tipo_veh","marca_veh","color_veh","modelo_veh","g_modelo_veh","tipo_eve")]
names(data_2016) <- name_columns


data_2015 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2015.xlsx"))
data_2015<-data_2015[, c("núm_corre","año_ocu","día_ocu","hora_ocu","g_hora","g_hora_5","mes_ocu",
                         "día_sem_ocu","mupio_ocu","depto_ocu","zona_ocu","tipo_veh","marca_veh",
                         "color_veh","modelo_veh","g_modelo_veh","tipo_eve")]
names(data_2015) <- name_columns




# Para los años 2009-2014:
# - Se realiza limpieza y se agregan columnas que no existen en estos archivos.
# - Las columnas agregadas se llenan con el valor por defecto "IGNORADO"
#   (representado numéricamente según el diccionario de datos).
# - Se reordenan las columnas para que coincidan con la estructura de los años 2015-2024.

data_2014 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2014.xlsx"))
data_2014$año_ocu <-2014
data_2014$g_hora_5 <- 4
data_2014$g_modelo_veh <- 99
data_2014<-data_2014[, c("num_correlativo","año_ocu","día_ocu","hora_ocu","g_hora","g_hora_5","mes_ocu",
                        "día_sem_ocu","mupio_ocu","depto_ocu","zona_ocu","tipo_veh","marca_veh",
                        "color_veh","modelo_veh","g_modelo_veh","tipo_eve")]
names(data_2014) <- name_columns




data_2013 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2013.xlsx"))
data_2013$año_ocu <-2013
data_2013$g_hora_5 <- 4
data_2013$g_modelo_veh <- 99
data_2013<-data_2013[, c("num_hecho","año_ocu","dia_ocu","hora_ocu","g_hora","g_hora_5","mes_ocu",
                         "dia_sem_ocu","mupio_ocu","depto_ocu","zona_ocu","tipo_veh","marca_veh",
                         "color_veh","modelo_veh","g_modelo_veh","causa_acc")]
names(data_2013) <- name_columns



data_2012 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2012.xlsx"))
data_2012$año_ocu <-2012
data_2012$g_hora <-5
data_2012$g_hora_5<-4
data_2012$marca_vehi <- 999
data_2012$modelo_vehi <- 9999
data_2012$g_modelo_vehi <- 99
data_2012<-data_2012[, c("num_hecho","año_ocu","dia_ocu","hora_ocu","g_hora","g_hora_5","mes_ocu",
                         "dia_sem_ocu","mupio_ocu","depto_ocu","zona_ocu","tipo_vehi","marca_vehi",
                         "color_vehi","modelo_vehi","g_modelo_vehi","causa_acc")]
names(data_2012) <- name_columns




data_2011 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2011.xlsx"))
data_2011$año_ocu <-2011
data_2011$g_hora <-5
data_2011$g_hora_5<-4
data_2011$g_modelo_vehi <- 99
data_2011<-data_2011[, c("num_hecho","año_ocu","dia_ocu","hora_ocu","g_hora","g_hora_5","mes_ocu",
                         "dia_sem_ocu","muni_ocu","depto_ocu","zona_ocu","tipo_vehiculo","marca_vehi",
                         "color_vehi","modelo_vehi","g_modelo_vehi","causa_acc")]
names(data_2011) <- name_columns




data_2010 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2010.xlsx"))
data_2010$num_hecho <- 1
data_2010$año_ocu <-2010
data_2010$g_hora <-5
data_2010$g_hora_5<-4
data_2010$muni_ocu<-9999
data_2010$marca_v<-999
data_2010$g_modelo_vehi <- 99
data_2010<-data_2010[, c("num_hecho","año_ocu","dia_ocu","hora_ocu","g_hora","g_hora_5","mes_ocu",
                         "dia_sem_ocu","muni_ocu","depto_ocu","zona_ocu","tipo_v","marca_v",
                         "color_v","modelo_v","g_modelo_vehi","causa_ac")]
names(data_2010) <- name_columns




data_2009 <- read_excel(paste0(ruta,"hechos-de-transito-ano-2009.xlsx"))
data_2009$año_ocu <-2009
data_2009$g_hora <-5
data_2009$g_hora_5<-4
data_2009$muni_ocu<-9999
data_2009$zona_ocu<-99
data_2009$marca_vehi<-999
data_2009$g_modelo_vehi <- 99
data_2009<-data_2009[, c("num_hecho","año_ocu","dia_ocu","hora_ocu","g_hora","g_hora_5","mes_ocu",
                         "dia_sem_ocu","muni_ocu","depto_ocu","zona_ocu","tipo_vehi","marca_vehi",
                         "color_vehi","modelo_vehi","g_modelo_vehi","causa_acc")]
names(data_2009) <- name_columns





#Unificamos la data del 2009-2024
data_completa <- bind_rows(data_2024, data_2023, data_2022, data_2021, data_2020,
                           data_2019, data_2018, data_2017, data_2016, data_2015,
                           data_2014, data_2013, data_2012, data_2011, data_2010,
                           data_2009)



# Reemplazo de valores por defecto "IGNORADO" según el diccionario de datos:
#   Solo se aplican condiciones a las columnas g_hora, g_hora_5 y g_modelo_veh,
#   ya que sus valores dependen de la información de otros campos.
data_completa$g_hora <- ifelse(
                              data_completa$hora_ocu >= 0 & data_completa$hora_ocu <= 5, 1,
                              ifelse(data_completa$hora_ocu >= 6 & data_completa$hora_ocu <= 11, 2,
                                     ifelse(data_completa$hora_ocu >= 12 & data_completa$hora_ocu <= 17, 3,
                                            ifelse(data_completa$hora_ocu >= 18 & data_completa$hora_ocu <= 24, 4, 5))))



data_completa$g_hora_5 <- ifelse(
                                  data_completa$g_hora %in% c(1, 2), 1,
                                  ifelse(data_completa$g_hora == 3, 2,
                                         ifelse(data_completa$g_hora == 4, 3, 4)))


data_completa$g_modelo_veh <- ifelse(
                              data_completa$modelo_veh >= 1970 & data_completa$modelo_veh <= 1979, 1,
                              ifelse(data_completa$modelo_veh >= 1980 & data_completa$modelo_veh <= 1989, 2,
                                     ifelse(data_completa$modelo_veh >= 1990 & data_completa$modelo_veh <= 1999, 3,
                                            ifelse(data_completa$modelo_veh >= 2000 & data_completa$modelo_veh <= 2009, 4,
                                                   ifelse(data_completa$modelo_veh >= 2010 & data_completa$modelo_veh <= 2019, 5,
                                                          ifelse(data_completa$modelo_veh >= 2020 & data_completa$modelo_veh <= 2029, 6, 99))))))



# Eliminación de columna innecesaria:
# La columna 'num_corre' se elimina porque solo sirve como identificador secuencial
data_completa<-data_completa[,-1]


#Se agrupa los colores de los vehiculos
data_completa$grupo_color <- ifelse(data_completa$color_veh %in% c(3,4,5,9,10,15), 1,  #1--> Colores Oscuros
                            ifelse(data_completa$color_veh %in% c(2,8,11,12,13,16), 2,  #2--> Colores Claros
                                   ifelse(data_completa$color_veh %in% c(1,6,7,14), 3,   #3--> Colores Vivos
                                          ifelse(data_completa$color_veh == 17, 4, 5))))  #4--> Otros colores   y 5 ---> 'Desconocidos'






# Liberar memoria RAM:
# Se eliminan los dataframes individuales de cada año (2009-2024) 
# para mejorar el rendimiento durante la ejecución del proyecto
rm(data_2024, data_2023, data_2022, data_2021, data_2020,data_2019, data_2018, data_2017, data_2016, data_2015,
   data_2014, data_2013, data_2012, data_2011, data_2010, data_2009)











