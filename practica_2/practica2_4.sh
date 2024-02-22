#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

echo "Introduzca una tecla: "; read input

char="${input:0:1}"
code=$(printf "%d" "'char'")

if [ "$code" -gt "64" ] && [ "$code" -lt "91" ]
then
    echo "$char es una letra"
elif [ "$code" -gt "96" ] && [ "$code" -lt "123" ]
then
    echo "$char es una letra"
elif [ "$code" -gt "47" ] && [ "$code" -t "59" ]
then
    echo "$char es un numero"
else
    echo "$char es un caracter especial"
fi