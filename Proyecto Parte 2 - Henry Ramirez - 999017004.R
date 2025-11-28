#instalacion de librerias
#install.packages("readxl")
#install.packages('rpart')
#install.packages('rpart.plot')
#install.packages("randomForest")
#install.packages(dplyr)



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




#---------------------------------------------------------------------------
#-------------PREDICCÓN POR MEDIO DE ARBOLES DE DECISIÓN--------------------
#---------------------------------------------------------------------------

# Nota general:
# 1. Cada predicción (Predicción 1, ..., Predicción 5) está separado y puede ejecutarse de forma individual.
#    Esto permite visualizar y analizar los resultados de cada patrón por separado.



#Predicción 1: Modelos de vehículos más afectado en las horas pico en el departamento de Guatemala
data_arbol_1 <- subset(data_completa, depto_ocu==1 & ((hora_ocu >= 5 & hora_ocu <= 9) | (hora_ocu >= 16 & hora_ocu <= 20)) & g_modelo_veh!=99)


arbol_1 <- rpart(g_modelo_veh~ 
                   color_veh +
                   tipo_veh +
                   hora_ocu +
                   tipo_eve,
                   data = data_arbol_1, method = 'class'
)

rpart.plot(arbol_1, type = 2 , extra=0 , under = TRUE , fallen.leaves = TRUE, box.palette = 'BuGn',
           main='Modelos de vehículo más afectados en hora pico – Guatemala', cex=0.5)


persona_arb_1 <- data.frame(
  color_veh = c(2),    # 2--> blanco
  tipo_veh = c(1) ,    # 1 --> Automóvil
  hora_ocu = c(6) ,    # 6 de la tarde
  tipo_eve = c(2)      # 2--> Choque
)

result_arb_1 <- predict(arbol_1, persona_arb_1, type='prob')
result_arb_1





#Predicción 2: Clasificación de hecho de tránsito (colisión y no colisión) para motocicletas
data_arbol_2 <- subset(data_completa, tipo_veh==4  & depto_ocu<=22)


data_arbol_2$colision = ifelse(data_arbol_2$tipo_eve == 1, 1, 0) #Se crea una columna si el evento es colision es 1 si no es entonces es 0

arbol_2 <- rpart(colision~ 
                   color_veh +
                   hora_ocu +
                   g_modelo_veh,
                 data = data_arbol_2, method = 'class'
)


rpart.plot(arbol_2, type = 2 , extra=0 , under = TRUE , fallen.leaves = TRUE, box.palette = 'BuGn',
           main='Clasificación de Incidentes: Colisión y No Colisión (Motocicletas)', cex=0.5)

persona_arb_2 <- data.frame(
  color_veh = c(2),     # 2--> Azul
  hora_ocu = c(20) ,    
  g_modelo_veh = c(5)   # 5--> Modelo 2010-2019
)

result_arb_2 <- predict(arbol_2, persona_arb_2, type='prob')
result_arb_2





#Predicción 3: Clasificación de incidentes de tipo atropello según su ocurrencia: dentro o fuera del departamento de Guatemala
data_arbol_3 <- subset(data_completa, (zona_ocu %in% c(4,10,15,1) & dia_sem_ocu %in% c(6,7)) & depto_ocu==1 & tipo_veh!=99)

arbol_3 <- rpart(tipo_veh ~ 
                   color_veh +
                   hora_ocu +
                   g_modelo_veh + 
                   tipo_eve+
                   marca_veh,
                 data = data_arbol_3, method = 'class'
)

rpart.plot(arbol_3, type = 2 , extra=0 , under = TRUE , fallen.leaves = TRUE, box.palette = 'BuGn',
           main='Tipo de vehículo más involucrado en zonas activas (1,4,10,15) – Guatemala', cex=0.5)


persona_arb_3 <- data.frame(
  color_veh = c(5),     # 5--> Negro
  hora_ocu = c(22) ,    # 20 ---> 10 de la noche
  g_modelo_veh = c(6),  # 6--> Modelo 2020-2029
  tipo_eve = c(3),      # 3--> vuelco
  marca_veh = c(27)     # 27--> Honda
)

result_arb_3 <- predict(arbol_3, persona_arb_3, type='prob')
result_arb_3






#Predicción 4: Clasificación de incidentes de tipo atropello según su ocurrencia: dentro o fuera del departamento de Guatemala
data_arbol_4 <- subset(data_completa, tipo_eve == 5  & depto_ocu <=22 & (modelo_veh >= 1970 & modelo_veh <= 2030))


data_arbol_4$depto_region = ifelse(data_arbol_4$depto_ocu == 1, 1, 0) #Se crea una columna si el evento fue en el depto. Guatemala 1 y si fue departamental 0       
                      
arbol_4 <- rpart(depto_region ~ 
                   color_veh +
                   modelo_veh +
                   marca_veh,
                 data = data_arbol_4, method = 'class'
)

rpart.plot(arbol_4, type = 2 , extra=0 , under = TRUE , fallen.leaves = TRUE, box.palette = 'BuGn',
           main='Predicción de atropellos dentro y fuera del departamento de Guatemala', cex=0.5)

persona_arb_4 <- data.frame(
  color_veh = c(5),     # 5--> Negro
  modelo_veh = c(2010) ,    
  marca_veh = c(8)      # 8--> Marca BMW
)

result_arb_4 <- predict(arbol_4, persona_arb_4, type='prob')
result_arb_4




#---------------------------------------------------------------------------
#----------------PREDICCÓN POR MEDIO DE RANDOM FFOREST----------------------
#---------------------------------------------------------------------------

# Nota general:
# 1. Cada predicción (Predicción 1, ..., Predicción 5) está separado y puede ejecutarse de forma individual.
#    Esto permite visualizar y analizar los resultados de cada patrón por separado.



#Predicción 1: Predicción de accidentes por región en temporada de lluvia
data_rf_1 <- subset(data_completa, (mes_ocu %in% c(6,7,8,9,10)) & depto_ocu<=22 & hora_ocu<=24 & marca_veh<999 & tipo_eve<=8 & color_veh<=17)

#  segmentacion po region
data_rf_1$depto_region <- ifelse(data_rf_1$depto_ocu %in% c(1), 1,   # Metropolitana
                          ifelse(data_rf_1$depto_ocu %in% c(16,17), 2,  # Norte
                          ifelse(data_rf_1$depto_ocu %in% c(18,19,20,21,22), 3,  # Oriente
                          ifelse(data_rf_1$depto_ocu %in% c(7,8,9,12,13,14), 4,  # Occidente
                          ifelse(data_rf_1$depto_ocu %in% c(5,6,10,11), 5,  # Costa Sur
                          ifelse(data_rf_1$depto_ocu %in% c(2,3,4,15), 6,  # Centro
                          0 )))))) #Otro


data_rf_1<-data_rf_1[,c("depto_region","hora_ocu","marca_veh","color_veh","tipo_eve")]

data_rf_1$depto_region<-as.factor(data_rf_1$depto_region)
data_rf_1<-na.omit(data_rf_1)
set.seed(100)


data_rf_1<-data_rf_1[sample(1:nrow(data_rf_1)),]
index_1 <- sample(1:nrow(data_rf_1), 0.90*nrow(data_rf_1))
train_1<- data_rf_1[index_1,]
test_1<-data_rf_1[-index_1,]


bosque_1 <- randomForest(depto_region ~ 
                          hora_ocu +
                         marca_veh+
                          color_veh +
                         tipo_eve,
                         data = train_1, 
                         ntree = 500,
                         mtry = 4
)

prueba_1 <- predict(bosque_1,test_1) 
matriz_1 <- table(test_1$depto_region,prueba_1)

#  Verificamos que tan preciso es el arbol
pre_1 <- sum(diag(matriz_1))/sum(matriz_1)
pre_1

#  Creamos un datafram epara predecir su valor
persona_rf_1 <- data.frame( 
  hora_ocu = c(12),     
  marca_veh = c(69) ,   # 69--> Marca Toyota 
  color_veh = c(1),     # 4-->  Color Gris
  tipo_eve = c(2)       # 2--> Choque
)

#  Predecimos los valores
result_rf_1<- predict(bosque_1,persona_rf_1,type="prob")
result_rf_1


#  Grafica
plot(bosque_1 ,main='Predicción de hechos de transito por región en temporada de lluvia') 













#Predicción 2:  Hechos de tránsito con vehículos de modelo reciente (2020 - 2029) 
data_rf_2 <- subset(data_completa, g_modelo_veh == 6)


data_rf_2<-data_rf_2[,c("tipo_eve","hora_ocu","tipo_veh","marca_veh","depto_ocu")]

data_rf_2$tipo_eve<-as.factor(data_rf_2$tipo_eve)
data_rf_2<-na.omit(data_rf_2)
set.seed(100)


data_rf_2<-data_rf_2[sample(1:nrow(data_rf_2)),]
index_2 <- sample(1:nrow(data_rf_2), 0.90*nrow(data_rf_2))
train_2<- data_rf_2[index_2,]
test_2<-data_rf_2[-index_2,]


bosque_2 <- randomForest(tipo_eve ~ 
                           hora_ocu +
                           marca_veh+
                           tipo_veh +
                           depto_ocu,
                         data = train_2, 
                         ntree = 500,
                         mtry = 4
)

prueba_2 <- predict(bosque_2,test_2) 
matriz_2 <- table(test_2$tipo_eve,prueba_2)

#  Verificamos que tan preciso es el arbol
pre_2 <- sum(diag(matriz_2))/sum(matriz_2)
pre_2

#  Creamos un datafram epara predecir su valor
persona_rf_2 <- data.frame( 
  hora_ocu = c(20),     
  marca_veh = c(28) ,   # 69--> Marca Hyundai 
  tipo_veh = c(1),     # 1-->  Automovil
  depto_ocu = c(9)       # 9--> Quetzaltenango
)

#  Predecimos los valores
result_rf_2<- predict(bosque_2,persona_rf_2,type="prob")
result_rf_2


#  Grafica
plot(bosque_2 ,main='Predicción de incidentes con vehículos 2020-2029') 














#Predicción 3:  Prediccion tipo de vehículo en incidentes nocturnos
data_rf_3 <- subset(data_completa, g_hora_5 ==3 & tipo_veh!=99)


data_rf_3<-data_rf_3[,c("tipo_veh","tipo_eve","hora_ocu","color_veh","depto_ocu")]

data_rf_3$tipo_veh<-as.factor(data_rf_3$tipo_veh)
data_rf_3<-na.omit(data_rf_3)
set.seed(100)


data_rf_3<-data_rf_3[sample(1:nrow(data_rf_3)),]
index_3 <- sample(1:nrow(data_rf_3), 0.90*nrow(data_rf_3))
train_3<- data_rf_3[index_3,]
test_3<-data_rf_3[-index_3,]


bosque_3 <- randomForest(tipo_veh ~ 
                           tipo_eve +
                           hora_ocu+
                           color_veh +
                           depto_ocu,
                         data = train_3, 
                         ntree = 500,
                         mtry = 4
)

prueba_3 <- predict(bosque_3,test_3) 
matriz_3 <- table(test_3$tipo_veh,prueba_3)

#  Verificamos que tan preciso es el arbol
pre_3 <- sum(diag(matriz_3))/sum(matriz_3)
pre_3

#  Creamos un datafram epara predecir su valor
persona_rf_3 <- data.frame( 
  tipo_eve = c(8),     # 8--> Encunetado
  hora_ocu = c(22) ,   
  color_veh = c(5),    # 5-->  Color Negro
  depto_ocu = c(1)     # 1--> Guatemala
)

#  Predecimos los valores
result_rf_3<- predict(bosque_3,persona_rf_3,type="prob")
result_rf_3


#  Grafica
plot(bosque_3 ,main='Prediccion tipo de vehículo en incidentes nocturnos') 


















#Predicción 4:  Hechos de tránsito relacionados según el color del vehículo (Claro, oscuro, vivo, otros).
data_rf_4 <- subset(data_completa, color_veh <=17 & (hora_ocu >= 0 & hora_ocu <= 24))


data_rf_4<-data_rf_4[,c("grupo_color","tipo_eve","hora_ocu","marca_veh","depto_ocu","dia_sem_ocu","modelo_veh")]

data_rf_4$grupo_color<-as.factor(data_rf_4$grupo_color)
data_rf_4<-na.omit(data_rf_4)
set.seed(100)


data_rf_4<-data_rf_4[sample(1:nrow(data_rf_4)),]
index_4 <- sample(1:nrow(data_rf_4), 0.90*nrow(data_rf_4))
train_4<- data_rf_4[index_4,]
test_4<-data_rf_4[-index_4,]


bosque_4 <- randomForest(grupo_color ~ 
                           tipo_eve +
                           hora_ocu+
                           marca_veh+
                           depto_ocu +
                           dia_sem_ocu +
                           modelo_veh,
                         data = train_4, 
                         ntree = 500,
                         mtry = 4
)

prueba_4 <- predict(bosque_4,test_4) 
matriz_4 <- table(test_4$grupo_color,prueba_4)

#  Verificamos que tan preciso es el arbol
pre_4 <- sum(diag(matriz_4))/sum(matriz_4)
pre_4

#  Creamos un datafram epara predecir su valor
persona_rf_4 <- data.frame( 
  tipo_eve = c(1),      # 1--> Colision
  hora_ocu = c(17) ,   
  marca_veh = c(56),    # 56-->  Marca Nissan
  depto_ocu = c(1),     # 1--> Guatemala
  dia_sem_ocu = c(1),   # 5--> Viernes
  modelo_veh = c(2020)     
)

#  Predecimos los valores
result_rf_4<- predict(bosque_4,persona_rf_4,type="prob")
result_rf_4


#  Grafica
plot(bosque_4 ,main='Predicción de hechos de tránsito según grupo de color del vehículo') 