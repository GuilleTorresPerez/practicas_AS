#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

# Escribir un script que pida introducir la ruta de un directorio por teclado y muestre
# cuantos archivos y cuantos directorios hay dentro de ese directorio (sin aplicar
# recursividad en ambos casos). En caso de que la ruta leída no se corresponda
# con un directorio, el script escribirá por pantalla el siguiente mensaje:
# “<ruta_leida> no es un directorio”. Una vez determinados el número de ficheros
# y directorios, el script mostrará el siguiente mensaje: “El numero de ficheros y
# directorios en <dir> es de <num_files> y <num_dirs>, respectivamente”.
# Ejemplos:
# as@as0:~$./practica2_5.sh
# Introduzca el nombre de un directorio: <dir_no_existe>
# <dir_no_existe> no es un directorio
# as@as0:~$./practica2_5.sh
# Introduzca el nombre de un directorio: <dir_valido>
# El numero de ficheros y directorios en <dir_valido> es de 0 y 13, respectivamente




echo -n "Introduzca el nombre de un directorio: "
read directorio

numDirectorios=0
numFicheros=0

if [ ! -d "$directorio" ]; then
    echo "$directorio no es un directorio"
else 
    numDirectorios=$(ls -l "$directorio" | grep ^d | wc -l )
    numFicheros=$(ls -l "$directorio" | grep ^- | wc -l )
    echo "El numero de ficheros y directorios en $directorio es de $numFicheros y $numDirectorios, respectivamente"
fi



