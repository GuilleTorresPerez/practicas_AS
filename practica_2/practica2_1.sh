#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 


# Inicializar una cadena vacía para almacenar los permisos del archivo
permisos=""                                     

# Solicitar al usuario que introduzca el nombre del archivo y almacenar la entrada en la variable 'fich'
echo -n "Introduzca el nombre del fichero: "   
read fich                           

# Verificar si el archivo existe 
if test -f "$fich"                  
then 
    permisos+="Los permisos del archivo $fich son: "   # Agregar un encabezado a la cadena 'permisos'

    if test -r "$fich"              # Verificar si el archivo es legible
    then
        permisos+="r"               # Agregar 'r' a 'permisos' si el archivo es legible
    else
        permisos+="-"               # Agregar '-' a 'permisos' si el archivo no es legible
    fi

    if test -w "$fich"              # Verificar si el archivo es escribible
    then
        permisos+="w"               # Agregar 'w' a 'permisos' si el archivo es escribible
    else
        permisos+="-"               # Agregar '-' a 'permisos' si el archivo no es escribible
    fi

    if test -x "$fich"              # Verificar si el archivo es ejecutable
    then
        permisos+="x"               # Agregar 'x' a 'permisos' si el archivo es ejecutable
    else
        permisos+="-"               # Agregar '-' a 'permisos' si el archivo no es ejecutable
    fi

else
    permisos="$fich no existe"      # Si el archivo no existe, asignar un mensaje de error a 'permisos'
fi 

echo $permisos                      # Imprimir los permisos del archivo o el mensaje de error
