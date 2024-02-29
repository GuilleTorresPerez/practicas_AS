#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

count="0"

# ~ indica la ruta /home/<nombre_usuario>
# ? para sustituir 1 carácter
# 2> para indicar la redirección de std_err a /dev/null
# Lo restante selecciona el directorio más reciente
OUT=$(stat -c %n,%Y ~/bin??? 2> /dev/null | sort -t ',' -k 2n | cut -d ',' -f1 | cut -d $'\n' -f1)


if test "$OUT" = ""                         #Si no se existe ninguno, se crea uno temporal con mktemp
then
    OUT=$(mktemp -d $HOME/binXXX)
    echo "Se ha creado el directorio $OUT"
fi

echo "Directorio destino de copia: $OUT"

for file in *                               #Se recorre el directorio actual en busca de ejecutables
do
    if [ -x "$file" -a ! -d "$file" ]       #Se comprueba si el fichero es un ejecutable y que no es un directorio
    then
        cp "$file" "$OUT"
        echo "./$file ha sido copiado a $OUT"
        count=$((count+1))                  #Se aumenta la variable de ejecutables copiados (count)
    fi
done

if [ "$count" -eq 0 ]                       #Se comprueba el número de ejecutables copiados (count)
then
    echo "No se ha copiado ningún archivo"
else
    echo "Se han copiado $count archivos"
fi