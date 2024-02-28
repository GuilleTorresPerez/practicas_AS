#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

#Bucle para iterar sobre la lista de argumentos otorgado
for param in "$@"
do
    if [ -f "$param" ]                    #Si el archivo existe y es un archivo común
    then
       more -e "$param"                   #Mostrar el archivo con more -e para que pase los tests
    else
       echo -n "$param no es un fichero"  #Imprimir el mensaje de error
    fi
done