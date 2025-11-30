# Predicción de Hechos de Tránsito mediante Árboles de Decisión, Random Forest y Redes Neuronales
<br>


## Descripción general
Este proyecto analiza hechos de tránsito en Guatemala utilizando modelos predictivos de aprendizaje automático enfocados en la estimación de probabilidades.
Se aplican:

- Árboles de decisión
- Random Forest
- Redes neuronales

El estudio se divide en dos partes: la construcción de los árboles de decisión y del Random Forest se realizó en **R**, mientras que el desarrollo de las redes neuronales se efectuó en **Python**. El objetivo es identificar los factores que incrementan la probabilidad de un hecho de tránsito, predecir escenarios de mayor riesgo y generar insumos que permitan orientar intervenciones preventivas más efectivas.

---
## Origen de los datos

Los datos provienen de dos fuentes oficiales del Instituto Nacional de Estadística (INE) de Guatemala:

1. **Datos 2009-2017:**  
   [https://www.ine.gob.gt/bases-de-datos/accidentes-de-transito/](https://www.ine.gob.gt/bases-de-datos/accidentes-de-transito/)

2. **Datos 2018-2024:**  
   [https://datos.ine.gob.gt/dataset/accidentes-de-transito-hechos](https://datos.ine.gob.gt/dataset/accidentes-de-transito-hechos)  

Estos archivos vienen en formatos Excel y SPSS (.sav). Para convertir los archivos SPSS a Excel se utilizó la herramienta:  
[https://secure.ncounter.de/spssconverter](https://secure.ncounter.de/spssconverter)

Los archivos generados se nombraron como:  **hechos-de-transito-ano-<año>.xlsx**

Todos los archivos se encuentran en la carpeta `DATA` del proyecto.

<br>
<br>
<br>
<br>
<br>

---
# Modelos desarrollados en R

## Ruta de la data

Antes de ejecutar los scripts, asegúrate de que la variable `ruta` (definida en la **línea 21**) apunte a la ubicación donde se encuentran los archivos Excel.  
Cambia la ruta según corresponda a tu equipo:

```r
# Ejemplo de ruta (modificar según tu equipo)
ruta <- "C:\\Users\\hedua\\OneDrive\\Escritorio\\MAESTRIA\\4to Trimestre\\INTRO. MINERIA DE DATOS\\Proyecto_Parte2_Introduccion_Mineria_de_Datos\\DATA\\"
```


---
## Librerías necesarias

Para ejecutar los scripts se utilizaron las siguientes librerías de R:

```r
library(readxl)        # Lectura de archivos Excel
library(rpart)         # Árboles de decisión
library(rpart.plot)    # Visualización de árboles de decisión
library(randomForest)  # Modelo Random Forest
library(dplyr)         # Manipulación de datos
```

Para instalar estas librerías, usar el comando:
```r
install.packages("nombre_libreria")
```

---


## Orden Recomendado de Ejecución

1. **Cargar librerías necesarias**  
   - Ver sección de *Librerías necesarias* para todos los paquetes a utilizar.

2. **Preparar los archivos de datos**  
   - Colocar todos los archivos Excel en la carpeta `DATA` del proyecto.  
   - Todos los archivos deben estar en formato `.xlsx`.  
   - Los nombres deben seguir el formato: `hechos-de-transito-ano-<año>.xlsx` (por ejemplo, `hechos-de-transito-ano-2024.xlsx`).

3. **Definir la variable de ruta**  
   - Definir la variable `ruta` apuntando a la carpeta `DATA` en tu equipo.  
   - Ejemplo:  
     ```r
     ruta <- "C:\\Users\\hedua\\OneDrive\\Escritorio\\MAESTRIA\\4to Trimestre\\INTRO. MINERIA DE DATOS\\Proyecto_Parte2_Introduccion_Mineria_de_Datos\\DATA\\"
     ```

4. **Ejecutar los scripts de análisis de forma secuencial**  
   - Ejecutar el bloque **LIMPIEZA DE DATOS** (líneas 37 a 231), que incluye la lectura de todos los archivos (2009-2024), la unificación de las columnas y la creación del dataframe final.
   - Ejecutar el bloque **PREDICCÓN POR MEDIO DE ARBOLES DE DECISIÓN**, donde cada predicción (Predicción 1, Predicción 2, ..., Predicción 4) se ejecuta de forma independiente para generar sus resultados.  
   - Ejecutar el bloque **PREDICCÓN POR MEDIO DE ARBOLES DE DECISIÓN**, donde cada predicción (Predicción 1, Predicción 2, ..., Predicción 4) se ejecuta de forma independiente para generar sus resultados.    



> Cada sección de análisis está identificada y separada en los scripts para facilitar la ejecución y visualización de resultados.


---
## Limpieza y unificación de datos

- **Años 2015-2024:**  
  - Se tomó como referencia los nombres y el orden de las columnas de la data de 2024.  
  - Para los años 2016 y 2015 se ajustó el orden de las columnas para que coincidieran con la referencia.

- **Años 2009-2014:**  
  - Se agregaron columnas que no existían, asignándoles el valor por defecto `IGNORADO` (representado numéricamente según el diccionario de datos `diccionario-hechos-de-transito-2024.xlsx`).  
  - Se reordenaron las columnas para que coincidieran con la estructura de los años 2015-2024.  
  
- **Unificación completa (2009-2024):**  
  - Se unificaron los datos de 2009 a 2014 en un solo `dataframe` utilizando `dplyr::bind_rows()` para garantizar la misma cantidad y orden de columnas.  

- **Reemplazo de valores “IGNORADO”:**  
  - Se aplicó después de unificar todos los años.  
  - Solo se reemplazaron valores en `g_hora`, `g_hora_5` y `g_modelo_veh`, debido a que requieren condiciones basadas en otros datos.


- **Eliminación de columnas innecesarias:**  
  - Se eliminó la columna `num_corre` porque solo era un identificador secuencial.

-  **Funciones nuevas utilizadas:** 
   - `dplyr::bind_rows()`: se utilizó para unificar todos los `dataframes` de cada año y así garantizar que todos tengan la misma cantidad y orden de columnas.  
   - `names(data_2024) <- name_columns`: se utilizó para asignar nombres consistentes a las columnas de todos los `dataframes`.  
   - `rm()`: se utilizó para eliminar temporalmente `dataframes` intermedios y liberar espacio de memoria RAM, mejorando el rendimiento del equipo durante la ejecución
   - `paste0()` para unir ruta y nombre de archivo.



---
## Requisitos técnicos

- R versión 4.3.2
- Carpeta `DATA` con los archivos en formato Excel.
- Librerías instaladas según lo indicado.


<br>
<br>
<br>
<br>
<br>


--- 
# Redes Neuronales en Python

## Ruta de la data

Antes de ejecutar el script, verifica que la variable `ruta` apunte a la carpeta donde están los 16 archivos .xlsx.
Modifícala según la ubicación en tu equipo:

```python
# Ejemplo de ruta (modificar según tu equipo)
ruta = "/content/drive/MyDrive/MAESTRIA/4to Trimestre/INTRO. MINERIA DE DATOS/Proyecto_Parte2_Introduccion_Mineria_de_Datos/DATA/"
```

---

## Librerías necesarias

Para ejecutar los scripts se utilizaron las siguientes librerías de python:

```r
import numpy as np          # Operaciones numéricas y manejo de arreglos
import pandas as pd         # Lectura, limpieza y manipulación de datos
import tensorflow as tf     # Librería para construir y entrenar redes neuronales

from tensorflow.keras.models import Sequential  # Modelo secuencial para redes neuronales
from tensorflow.keras.layers import Dense       # Capas densas totalmente conectadas

from sklearn.model_selection import train_test_split  # División del dataset en entrenamiento y prueba
```


---


## Orden Recomendado de Ejecución

1. **Cargar librerías necesarias**  
   - Ver sección de *Librerías necesarias* para todos los paquetes a utilizar.

2. **Preparar los archivos de datos**  
   - Colocar todos los archivos Excel en la carpeta `DATA` del proyecto.  
   - Todos los archivos deben estar en formato `.xlsx`.  
   - Los nombres deben seguir el formato: `hechos-de-transito-ano-<año>.xlsx` (por ejemplo, `hechos-de-transito-ano-2024.xlsx`).

3. **Definir la variable de ruta**  
   - Definir la variable `ruta` apuntando a la carpeta `DATA` en tu equipo.  
   - Ejemplo:  
     ```python
     ruta = "/content/drive/MyDrive/MAESTRIA/4to Trimestre/INTRO. MINERIA DE DATOS/Proyecto_Parte2_Introduccion_Mineria_de_Datos/DATA/"
     ```

4. **Ejecutar los scripts de análisis de forma secuencial**  
   - Ejecutar todas las celdas contenidas en la sección  **LIMPIEZA DE DATOS** donde se realiza la lectura de los archivos históricos (2009–2024), la homologación de columnas y la construcción del dataframe unificado utilizado en los modelos posteriores.
   - Dentro de la sección **PREDICCIÓN POR REDES NEURONALES**, donde cada predicción (Red Neuronal 1,  ..., Red Neuronal 4) se ejecuta de forma independiente para generar sus resultados.  
  
   
---
## Limpieza y unificación de datos

- **Años 2015-2024:**  
  - Se estandarizaron los nombres y el orden de las columnas usando como referencia 2024.  
  - Para 2016 y 2015 se ajustó el orden de columnas para coincidir con la referencia.  

- **Años 2009-2014:**  
  - Se agregaron columnas faltantes con valor por defecto `IGNORADO`.  
  - Se reordenaron las columnas para coincidir con la estructura de 2015-2024.  

- **Unificación completa (2009-2024):**  
  - Se combinaron todos los años en un solo `DataFrame` con `pandas.concat()`.  

- **Reemplazo de valores “IGNORADO”:**  
  - Se aplicó en `g_hora`, `g_hora_5` y `g_modelo_veh` usando condiciones basadas en otros campos.  

- **Eliminación de columnas innecesarias:**  
  - Se eliminó `num_correlativo` que era solo un identificador secuencial.  
---


---
## Requisitos técnicos

- Python: 3.9 o superior
- Entorno de ejecución: Jupyter Notebook, JupyterLab o Google Colab
- Carpeta `DATA` con los archivos en formato Excel.
- Librerías instaladas según lo indicado.