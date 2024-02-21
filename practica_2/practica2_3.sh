#!/bin/bash

fichero=$1          # Almacenar el primer argumento en la variable 'fichero'

if [ "$#" -ne 1 ]; then 
    echo "Sintaxis: practica2_3.sh $fichero"
elif [ ! -f "$fichero" ]; then
    echo "$fichero no existe"
else 
    chmod u+x,g+x $fichero
fi
