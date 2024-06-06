# Análisis de los accidentes de tráfico fatales en EE.UU. en 2022

Análisis y modelo predictivo de los accidentes de tráfico fatales ocurridos en los 51 estados de EE.UU. a lo largo de 2022.

## 👋 Introducción

¡Hola, analista o curioso de los datos! 📈 Soy Alicia, estudiante de análisis de datos de Ironhack. En este notebook, que representa mi proyecto final, encontrarás un análisis detallado de los accidentes con al menos una muerte que tuvieron lugar en 2022 en Estados Unidos y un modelo predictivo que predice con un alto nivel de precisión el número de muertes que habrá en las 8 semanas siguientes en cada uno de los estados.

Puedes ver la presentación de mi  proyecto en el siguiente <a href="https://docs.google.com/presentation/d/1AKr2wNU-6pMedlli2poKJx5BKxoEVtAbk5RP1vD4Xw8/edit?usp=sharing">enlace.</a>

Y el enlace al ERD <a href="https://www.figma.com/file/gOvrnYqe9p5d0xPGVYHeHR/ny_project_ERD?type=design&mode=design">aquí.</a>

## Tabla de contenidos

- Metadatos
- Estructura del análisis
- Insights visuales

## Metadatos

- Autora: Alicia Pérez.
- Fecha de creación: 07/06/2024.
- Última modificación: 07/06/2024.
- Fuente de datos:

    <a href= "https://www.kaggle.com/datasets/dgomonov/new-york-city-airbnb-open-data">NY City Airbnb Open Data.</a>

    <a href= "https://www.kaggle.com/datasets/mrmorj/new-york-city-police-crime-data-historic">NY City Police Crime Data Historic.</a>

## Estructura del análisis

- Planificación del proyecto: selección de tipo de proyecto, base de datos, definición de objetivos y desarrollo del ERD.
- Importación de datos con Python a MySQL Workbench.
- Limpieza y formateo con MySQL.
- Agrupación final, análisis estadístico y visualización gráfica con PowerBI.
- Desarrollo del ABT, PCA y modelo de predicción con Python.

## 📊 Insights visuales data analysis

Los gráficos de este análisis se han generado en PowerBI. Puedes ver el dashboard a través del siguiente <a href="https://www.figma.com/file/gOvrnYqe9p5d0xPGVYHeHR/ny_project_ERD?type=design&mode=design">enlace.</a>

## 📊 Insights visuales modelo de predicción

![Time series for 1 random state](https://drive.google.com/uc?export=view&id=1dAf6f0uyVGJLgKJBIuusFNsUtUXbvc40)

Serie de tiempo para 1 estado seleccionado al azar.

![Features importance](https://drive.google.com/uc?export=view&id=1DIG-oZtVGaTHg0E8w5Q-qp8SMmObcASZ)

Importancia de las variables. Ma8 es el promedio de las últimas 8 semanas.


¡Gracias por leerme 😊!