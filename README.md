# Análisis de los accidentes de tráfico fatales en EE.UU. en 2022

Análisis y modelo predictivo de los accidentes de tráfico fatales ocurridos en los 51 estados de EE.UU. a lo largo de 2022.

## 👋 Introducción

¡Hola, analista o curioso de los datos! 📈 Soy Alicia, estudiante de análisis de datos de Ironhack. En este notebook, que representa mi proyecto final, encontrarás un análisis detallado de los accidentes con al menos una muerte que tuvieron lugar en 2022 en Estados Unidos y un modelo predictivo que predice con un alto nivel de precisión el número de muertes que habrá en las 8 semanas siguientes en cada uno de los estados.

## Tabla de contenidos

- Metadatos
- Estructura del análisis
- Insights visuales

## Metadatos

- Autora: Alicia Pérez.
- Fecha de creación: 07/06/2024.
- Última modificación: 07/06/2024.
- Fuente de datos:

    <a href= "https://www.nhtsa.gov/file-downloads?p=nhtsa/downloads/FARS/2022/National/">United States Department of Transportation (NHTSA).</a>

## Estructura del análisis

- Planificación del proyecto: selección de tipo de proyecto, base de datos, definición de objetivos y desarrollo del ERD.
- Importación de datos con Python a MySQL Workbench.
- Limpieza y formateo con MySQL.
- Agrupación final, análisis estadístico y visualización gráfica con PowerBI.
- Desarrollo del ABT, PCA y modelo de predicción con Python.

## 📊 Insights visuales data analysis

![PowerBI dashboard](https://github.com/alicia-perez-diez/final_project/blob/main/images/dashboard.gif)

Puedes descargar el dashboard a través del siguiente <a href="(https://drive.google.com/uc?export=view&id=1jc92TVn6kgTVwsLcuqmUH_Tdkd_5rXG4)">enlace.</a>

## 📊 Insights visuales modelo de predicción

![Time series for 1 random state](https://drive.google.com/uc?export=view&id=1_3nYQxFsc6YUbA4D_e4ykrMIoVvEMPhW)

El análisis de la serie de tiempo para un estado seleccionado al azar mostró una variabilidad diaria sin patrón definido. Por ello, se agruparon los datos por semana para suavizar la tendencia y revelar patrones más claros. Esta estrategia facilitó una comprensión más estructurada de la evolución de los accidentes de tráfico en cada estado.

![Features importance](https://drive.google.com/uc?export=view&id=1DIG-oZtVGaTHg0E8w5Q-qp8SMmObcASZ)

El término 'ma8' representa el promedio móvil de las últimas 8 semanas en el contexto del análisis de muertes por accidentes de tráfico. Este indicador refleja la tendencia histórica de las muertes en un período específico. Al calcular este promedio, se obtiene una visión más suavizada de la evolución de la incidencia de accidentes a lo largo del tiempo, lo que permite detectar patrones o tendencias significativas. Esta técnica facilita la identificación de cambios en la frecuencia de los accidentes y proporciona una comprensión más clara de la dinámica subyacente de los datos.

![Fatalities forecast](https://drive.google.com/uc?export=view&id=1vZsqLiPsbykqSfg6T_Qj5F2Rz0xN53Z4)

El gráfico de predicción muestra una evolución clara de las muertes por accidentes de tráfico en 2022, destacando picos significativos de hasta 939 y 934 muertes por semana en las últimas semanas del año. Estos picos indican periodos críticos de alto riesgo. Para las próximas 8 semanas, el modelo predice cifras de 871, 844, 849, 850, 845, 849, 817 y 848 muertes por semana, revelando que serán unas semanas críticas que requerirán atención especial.

Encuentra información detallada sobre el proyecto en el siguiente <a href="https://docs.google.com/presentation/d/1AKr2wNU-6pMedlli2poKJx5BKxoEVtAbk5RP1vD4Xw8/edit?usp=sharing">enlace.</a>

Y el enlace al ERD <a href="https://docs.google.com/presentation/d/1WEghHFbpD1ldkTyGZPo3oXcFeZM19uF5/edit?usp=sharing">enlace.</a>

¡Gracias por leerme 😊!