#importamos las librerías
import pandas as pd

#importamos el archivo de funciones
from functions import configure_pandas_display, get_database_connection, load_all_tables, preprocess_tables, combine_tables
"""plot_correlation_heatmap"""

# Configura la visualización de pandas para mostrar todas las columnas de las tablas
configure_pandas_display()

# Obtiene la conexión a la base de datos
engine = get_database_connection()

# Importa todas las tablas necesarias
data = load_all_tables(engine)

# Acceso a los DataFrames individuales
accident = data['accident']
distract = data['distract']
drugs = data['drugs']
maneuver = data['maneuver']
person = data['person']
vehicle = data['vehicle']
weather = data['weather']

# Edición previa a la unión de las tablas
accident, distract, drugs, maneuver, person, vehicle, weather = preprocess_tables(accident, distract, drugs, maneuver, person, vehicle, weather)

# Combina todas las tablas en 'accident' y hace la edición final de abt previo al modelo de predicción
abt = combine_tables(accident, distract, drugs, maneuver, person, vehicle, weather)

# Muestra el mapa de calor con todas las variables numéricas para detectar qué variables están correlacionadas
# Línea de código comentada, ya que procesa muchos datos. Descomentar para visualizar el mapa de correlación 
"""plot_correlation_heatmap(abt)"""

