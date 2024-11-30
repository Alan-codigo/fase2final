import tkinter as tk
import pandas as pd
import re

# Función para convertir binario a decimal, si el valor es un binario válido
def binario_a_decimal(valor_binario):
    valor_binario = str(valor_binario).strip()
    # Validar si el valor es un número binario
    if re.fullmatch(r'[01]+', valor_binario):
        return int(valor_binario, 2)
    return None  # Si no es binario, retorna None

# Función para convertir decimal a binario, asegurando que tenga un número fijo de bits
def decimal_a_binario(valor_decimal, bits):
    if pd.isna(valor_decimal):
        return None  # Si es NaN, retorna None
    return format(int(valor_decimal), f'0{bits}b')  # Convierte a binario con ceros a la izquierda

# Función para convertir los datos del archivo Excel
def convertir_datos():
    try:
        df = pd.read_excel('Book1.xlsx')  # Cambia la ruta si es necesario
        # Eliminar espacios en blanco en los nombres de columnas y reemplazar NaN
        df.columns = df.columns.str.strip()
        print("Columnas del DataFrame:", df.columns)  # Verificar los nombres de las columnas
        df.columns = ['op 6', 'rs 5', 'rt 5', 'rd 5', 'shawt 5', 'funct 6']  # Ajustar nombres si es necesario

        # Convertir las columnas de decimal a binario
        df['op 6'] = df['op 6'].apply(lambda x: decimal_a_binario(x, 6))
        df['rs 5'] = df['rs 5'].apply(lambda x: decimal_a_binario(x, 5))
        df['rt 5'] = df['rt 5'].apply(lambda x: decimal_a_binario(x, 5))
        df['rd 5'] = df['rd 5'].apply(lambda x: decimal_a_binario(x, 5))
        df['shawt 5'] = df['shawt 5'].apply(lambda x: decimal_a_binario(x, 5))
        df['funct 6'] = df['funct 6'].apply(lambda x: decimal_a_binario(x, 6))

        # Filtrar solo filas con datos válidos
        df_filtrado = df.dropna(subset=['op 6', 'rs 5', 'rt 5', 'rd 5', 'shawt 5', 'funct 6'])

        # Guardar los datos convertidos en un archivo .txt
        archivo_salida = 'dataintructionM.txt'
        with open(archivo_salida, 'w') as f:
            for index, row in df_filtrado.iterrows():
                # Cambiamos el orden y formato según lo solicitado
                f.write(f"{row['op 6']}{row['rs 5']}{row['rt 5']}{row['rd 5']}{row['shawt 5']}{row['funct 6']}\n")

        etiqueta.config(text=f"Datos convertidos y guardados en: {archivo_salida}")
        # Llamar al formateo automático después de guardar
        formatear_binario(archivo_salida, 'dataintructionM_formateado.txt')
        etiqueta.config(text=f"Archivo formateado guardado en: dataintructionM_formateado.txt")

    except Exception as e:
        etiqueta.config(text=f"Error: {e}")

# Función para leer y mostrar datos de Excel
def leer_excel():
    try:
        df = pd.read_excel('Book1.xlsx')  # Cambia la ruta si es necesario
        print(df)  # Muestra los datos en la consola
        etiqueta.config(text="Datos leídos correctamente")
    except Exception as e:
        etiqueta.config(text=f"Error: {e}")

# Función para formatear el archivo en bloques de 8 bits
def formatear_binario(archivo_entrada, archivo_salida):
    try:
        with open(archivo_entrada, 'r') as entrada, open(archivo_salida, 'w') as salida:
            for linea in entrada:
                # Eliminar espacios y saltos de línea
                binario = linea.strip()
                # Dividir la línea en bloques de 8 bits
                bloques = [binario[i:i+8] for i in range(0, len(binario), 8)]
                # Escribir cada bloque en una nueva línea
                salida.write('\n'.join(bloques) + '\n')
        print(f"Archivo formateado guardado en: {archivo_salida}")
    except Exception as e:
        print(f"Error: {e}")

# Crear la ventana principal
ventana = tk.Tk()
ventana.title("Lectura y Conversión de Excel")
ventana.geometry("700x400")

# Crear una etiqueta
etiqueta = tk.Label(ventana, text="Presiona el botón para leer datos")
etiqueta.pack(pady=10)

# Crear un botón para leer Excel
boton_leer = tk.Button(ventana, text="Leer Excel", command=leer_excel)
boton_leer.pack(pady=10)

# Crear un botón para convertir los datos
boton_convertir = tk.Button(ventana, text="Convertir y Formatear", command=convertir_datos)
boton_convertir.pack(pady=10)

# Ejecutar el bucle principal
ventana.mainloop()
