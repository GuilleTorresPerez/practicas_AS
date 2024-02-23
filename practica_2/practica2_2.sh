#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

for param in "$@"
do
    if [ -f "$param" ]
    then
       more "$param"
    else
       echo -n "$param no es un fichero"
    fi
done