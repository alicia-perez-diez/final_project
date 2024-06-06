#importamos las librerías
import pandas as pd

#importamos el archivo de funciones
from functions import configure_pandas_display, get_database_connection, load_all_tables, preprocess_tables, combine_tables, apply_pca_and_update_df, plot_random_state_time_series,\
    model_summary, make_predictions_and_export, plot_feature_importance
""", plot_correlation_heatmap"""

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

# Aplica PCA a varios grupos de columnas predefinidas en el DataFrame y actualiza el DataFrame eliminando las columnas originales y agregando los nuevos componentes PCA
abt_pca = apply_pca_and_update_df(abt)

# Devuelve el gráfico de series temporales de los accidentes fatales para un estado aleatorio
plot_random_state_time_series(abt_pca)

# Llama a la función model_summary para obtener el abt_for_train, el best_model, el sumario y el scaler
abt_for_train, best_model, model_summary_result, scaler, feature_columns, selected_columns, feature_importances_df = model_summary(abt_pca)

# Imprime el resultado
model_summary_result

# Llama a la función make_predictions_and_export con el scaler extraído
make_predictions_and_export(abt_for_train, best_model, scaler, feature_columns, selected_columns)

# Uso de la función para generar y mostrar el gráfico de importancia de características
plot_feature_importance(feature_importances_df, top_n=30)