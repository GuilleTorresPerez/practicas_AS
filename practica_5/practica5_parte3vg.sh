#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 


if [ $EUID -ne 0 ]; then
    echo "Necesitas permisos de administrador"
    exit(1)
fi

if [ $# -lt 2 ]; then
    echo "Necesitas al menos 2 parametros"
    exit(1)
fi

for part in "$@"; do
    #Comprobar si la particion otorgada por pármetro está disponible
    if [ -z "$(fdisk -l | grep $part)" ]; then
        echo "No se ha encontrado la particion"
    else
        #Comprobar si no está montada, si está montada hay que desmontarla previamente
        if [ -n "$(cat /etc/mtab | grep $part)" ]; then
            umount $part
        fi
        #Llevar a cabo la extensión
        vgextend $1 $part
    fi
done