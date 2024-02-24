#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

#Imprimir el mensaje que pide una tecla al usuario
echo "Introduzca una tecla: "; read input           #Almacenar las teclas pulsadas en input

char="${input:0:1}"                                 #Almacenar el primer carácter en char
code=$(printf "%d" "'char'")                        #Almacenar el código ASCII de char en code

if [ "$code" -gt "64" ] && [ "$code" -lt "91" ]     #Si 64 < code < 91 es una letra en mayúscula
then
    echo "$char es una letra"                       #Imprimir el mensaje
elif [ "$code" -gt "96" ] && [ "$code" -lt "123" ]  #Si 96 < code < 123 es una letra en minúscula
then
    echo "$char es una letra"                       #Imprimir el mensaje
elif [ "$code" -gt "47" ] && [ "$code" -t "59" ]    #Si 47 < code < 59 es un número
then
    echo "$char es un numero"                       #Imprimir el mensaje
else                                                #En caso contrario, es un carácter mensaje
    echo "$char es un caracter especial"            #Imprimir el mensaje
fi