import logging
from datetime import datetime
import pandas as pd
import json
import re


def read_CSV_View():
   try:
       logging.info("Se hace la lectura del fichero Views")
       df = pd.read_csv('VIEWS_CC_Catalana_Estadisticas_Video_20231128_20231128 (1).csv')
       if len(df.columns) != 19:
           raise ValueError("El fichero Views no tiene el número esperado de columnas.")
       if set(df.columns) != {'Video Link', 'Video Duration', 'Video File Name','Storyboard ID','Statistic ID', 'Year', 'Month', 'Day', 'Hour', 'Minute', 'Second', 'OS', 'Browser', 'Platform', 'Location Country', 'Location City', 'Location State', 'Engagement %', 'Tags'}:
           raise ValueError("El fichero Views no tiene los nombres de columnas esperados.")
       df['Year'] = df['Year'].astype(str)
       df['Month'] = df['Month'].astype(str).str.zfill(2)
       df['Day'] = df['Day'].astype(str).str.zfill(2)
       df['Hour'] = df['Hour'].astype(str).str.zfill(2)
       df['Minute'] = df['Minute'].astype(str).str.zfill(2)
       df['Second'] = df['Second'].astype(str).str.zfill(2)
       df['Fecha'] = df['Year'] + '-' + df['Month'] + '-' + df['Day'] + ' ' + df['Hour'] + ':' + df['Minute'] + ':' + df['Second']
       df['Fecha'] = pd.to_datetime(df['Fecha'])
       return df
   except FileNotFoundError:
       logging.error("El fichero Views no se encontró.")
       return None
   except ValueError as e:
       logging.error(f"Error al leer el fichero Views: {str(e)}")
       return None


def read_CSV_Engagement():
   try:
       logging.info("Se hace la lectura del fichero Engagement")
       df_Engagement = pd.read_csv('ENGAGEMENT_CC_Catalana_Estadisticas_Video_20231128_20231128 1 (1).csv')
       if len(df_Engagement.columns) != 8:
           raise ValueError("El fichero Engagement no tiene el número esperado de columnas.")
       if set(df_Engagement.columns) != {'Video Link', 'Video File Name','Storyboard ID','Statistic ID','Total Views', 'Max Engagement %', 'Buttons Clicks', 'Tags'}:
           raise ValueError("El fichero Engagement no tiene los nombres de columnas esperados.")
       df_Engagement['Buttons Clicks'] = df_Engagement['Buttons Clicks'].fillna('')
       df_Engagement['Buttons Clicks'] = df_Engagement['Buttons Clicks'].str.replace(",", ";")
       df_Engagement['Buttons Clicks'] = df_Engagement['Buttons Clicks'].str.split(";")
       df_Engagement['DatosJSON'] = df_Engagement['Buttons Clicks'].apply(transform_to_json)
       logging.info("Se convierte a JSON la columna ButtonClicks y se guardan los resultados de trasponerla")
       df_expandido = pd.json_normalize(df_Engagement['DatosJSON'].apply(json.loads))
       df_Engagement = pd.concat([df_Engagement, df_expandido], axis=1)
       if '{Pregunta_ESTRELLA 5' in df_Engagement.columns:
           df_Engagement['{Pregunta_ESTRELLA 5'].fillna(df_Engagement['Pregunta_ESTRELLA 5'])
           df_Engagement.rename(columns={'{Pregunta_ESTRELLA 5': 'Pregunta_ESTRELLA5'}, inplace=True)
           df_Engagement.drop(columns=['Pregunta_ESTRELLA 5'], inplace=True)
           df_Engagement['Pregunta_ESTRELLA5'] = df_Engagement['Pregunta_ESTRELLA5'].str.rstrip('}')


       if '{Pregunta_ESTRELLA1' in df_Engagement.columns:
           df_Engagement.rename(columns={'{Pregunta_ESTRELLA 1': 'Pregunta_ESTRELLA1'}, inplace=True)
           df_Engagement['Pregunta_ESTRELLA1'] = df_Engagement['Pregunta_ESTRELLA1'].str.rstrip('}')
       if '{AppApple' in df_Engagement.columns:


           df_Engagement['AppApple'] = df_Engagement['{AppApple'].astype(str).str.rstrip('}')
           df_Engagement.drop(columns='{AppApple', inplace=True)


       if '{AppAndroid' in df_Engagement.columns:
           df_Engagement['AppAndroid'] = df_Engagement['{AppAndroid'].astype(str).str.rstrip('}')
           df_Engagement.drop(columns='{AppAndroid', inplace=True)


       logging.info("Se calcula el campo NPS")
       df_Engagement['NPS'] = df_Engagement.apply(calcular_nps, axis=1)
       df_Engagement.to_csv('df_Engagement2.csv', index=False)


       columnas_player = df_Engagement.filter(regex=re.compile(r'[Pp]layer')).columns
       df_Engagement.drop(columns=columnas_player, inplace=True)
       df_Engagement.to_csv('df_Engagement_no_player.csv', index=False)
       return df_Engagement
   except FileNotFoundError:
       logging.error("El fichero Engagement no se encontró.")
       return None
   except ValueError as e:
       logging.error(f"Error al leer el fichero Engagement: {str(e)}")
       return None


def transform_to_json(entries):
   result = {}
   for entry in entries:
       parts = entry.split("=")
       if len(parts) == 2:
           result[parts[0].strip()] = parts[1].strip()
   return json.dumps(result)


def calcular_nps(row):
   if 'Pregunta_ESTRELLA5' in row and not pd.isna(row['Pregunta_ESTRELLA5']):
       return 5
   elif 'Pregunta_ESTRELLA 4' in row and not pd.isna(row['Pregunta_ESTRELLA 4']):
       return 4
   elif 'Pregunta_ESTRELLA 3' in row and not pd.isna(row['Pregunta_ESTRELLA 3']):
       return 3
   elif 'Pregunta_ESTRELLA 2' in row and not pd.isna(row['Pregunta_ESTRELLA 2']):
       return 2
   elif 'Pregunta_ESTRELLA1' in row and not pd.isna(row['Pregunta_ESTRELLA1']):
       return 1
   else:
       return None


def join_dataframes(df, df_Engagement):
   try:
       logging.info("Se unen ambos ficheros")
       columns_to_drop_df = ['Year', 'Month', 'Day', 'Hour', 'Minute', 'Second', 'Storyboard ID', 'Statistic ID']
       columns_to_drop_df_Engagement = ['Storyboard ID', 'Statistic ID', 'Video Link', 'Total Views',
                                        'Max Engagement %',
                                        'Buttons Clicks', 'Tags', 'Pregunta_ESTRELLA1', 'Pregunta_ESTRELLA 2',
                                        'Pregunta_ESTRELLA 3', 'Pregunta_ESTRELLA 4', 'Pregunta_ESTRELLA5',
                                        'DatosJSON']


       for col in columns_to_drop_df:
           if col in df.columns:
               df = df.drop(columns=[col])


       for col in columns_to_drop_df_Engagement:
           if col in df_Engagement.columns:
               df_Engagement = df_Engagement.drop(columns=[col])


  
       df_merged = pd.merge(df, df_Engagement, on='Video File Name', how='inner')




       df_merged.rename(columns={'AppAndroid': 'Android'}, inplace=True)
       df_merged.rename(columns={'AppApple': 'iOS'}, inplace=True)
       df_merged.rename(columns={'Fecha': 'Timestamp_View'}, inplace=True)
       df_merged['TotalViews'] = df_merged.groupby('Video File Name')['Video File Name'].transform('count')




       return df_merged
   except Exception as e:
       logging.error(f"Error al unir los DataFrames: {str(e)}")
       return None


if __name__ == '__main__':
   now = datetime.now()
   logging.basicConfig(filename=f"./Log/log-{now.strftime('%d%m%Y')}.log",
                      filemode='a',
                      format='%(asctime)s,%(msecs)d %(name)s %(levelname)s %(message)s',
                      datefmt='%H:%M:%S',
                      encoding='utf-8',
                      level=logging.DEBUG)
   logging.info("Se leen ambos ficheros")
   df = read_CSV_View()
   df_Engagement = read_CSV_Engagement()
   if df is not None and df_Engagement is not None:
       logging.info("Se hace el Join de ambos ficheros")
       df_merged = join_dataframes(df, df_Engagement)
       if df_merged is not None:
           logging.info("Se hace un group by en el Dataframe resultante de la union de ambos ficheros")
           df_merged = df_merged.sort_values(by=['Video File Name', 'Timestamp_View'])
           df_merged['Max'] = df_merged['Engagement %']
           required_columns = ['Video Duration', 'Video File Name', 'OS', 'Browser', 'Platform',
                               'Location Country', 'Location City', 'Location State', 'Engagement %',
                               'Tags', 'NPS', 'iOS', 'Android', 'Max', 'Timestamp_View']
           missing_columns = [col for col in required_columns if col not in df_merged.columns]


           if missing_columns:
               group_by_columns = [col for col in required_columns if col not in missing_columns]
               logging.info(
                   f"Se omitirán las siguientes columnas en el group by debido a que no están presentes en el DataFrame: {missing_columns}")
           else:
               group_by_columns = required_columns
           f_group = df_merged.groupby(by=['Video Link'], as_index=False).agg({
               'Video Duration': 'first', 'Video File Name': 'first', 'OS': 'first', 'Browser': 'first',
               'Platform': 'first', 'Location Country': 'first', 'Location City': 'first',
               'Location State': 'first', 'Engagement %': 'first', 'Tags': 'first', 'NPS': 'first',
               'iOS': 'first', 'Android': 'first', 'Max': 'max', 'Timestamp_View': 'first'
           })


           logging.info("Se guarda el resultado en un fichero CSV")
           Date = datetime.now().strftime("%Y%d%d")
           f_group.to_csv(f'Prueba{Date}.csv', index=False)
       else:
           logging.error("No se pudo realizar el group by debido a un error en la unión de los DataFrames.")
   else:
       logging.error("No se pudieron leer los ficheros necesarios para el proceso.")
