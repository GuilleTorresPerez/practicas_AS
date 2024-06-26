#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

#Escribir un script que reciba un único nombre de archivo en la línea de
#comandos, verifique que existe y que es un archivo común (o regular), lo
#convierta en ejecutable para el dueño y el grupo y muestre el modo final mediante
#el comando stat (deberás buscar el formato correcto). Si el fichero no existe,
#debes mostrar el mensaje de error: “<nombre_archivo> no existe”. En caso de
#recibir un número distinto de argumentos por la línea de comandos, el script
#imprimirá el siguiente mensaje de error: “Sintaxis: practica2_3.sh
#<nombre_archivo>”.

#Ejemplos:
#as@as0:~$./practica2_3.sh practica2_3.sh
#-rwxr-xr-x
#as@as0:~$./practica2_3.sh primer_arg “segundo argumento”
#Sintaxis: practica2_3.sh <nombre_archivo>


fichero=$1                                           # Almacenar el primer argumento en la variable 'fichero'

if [ "$#" -ne 1 ]; then                              # Verificar si el número de argumentos es distinto de 1
    echo "Sintaxis: practica2_3.sh <nombre_archivo>" # Imprimir un mensaje de error
elif [ ! -f "$fichero" ]; then                       # Verificar si el archivo no existe
    echo "$fichero no existe"                        # Imprimir un mensaje de error
else                                                 # Si el archivo existe
    chmod u+x,g+x "$fichero"                         # Conceder permisos de ejecución al dueño y al grupo
    stat -c '%A' "$fichero"                          # Mostrar el modo final del archivo
fi
