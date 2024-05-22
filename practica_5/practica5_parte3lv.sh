#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 


if [ $EUID -ne 0 ]; then
    echo "Necesitas permisos de administrador"
    exit(1)
fi

echo "Introduce los datos: "
oldIFS=$IFS
IFS=,
read nombreG nombreV size fichero direccion

#Comprobamos si el volumen lógico está en activo
if [ -z "$(lvscan | grep ${nombreG}/${nombreV})" ]; then
    echo "No exite, se va a crear"
    #Se crea
    lvcreate -n $nombreV -L $size $nombreG
    #Se monta
    mount -t $fichero /dev/${nombreG}/${nombreV} $direccion
    dir=$(lvdipslay ${nombreG}/${nombreV} | grep ${nombreG}/${nombreV} | tr -d '[[:space:]]')
    #Se incluye en /etc/fstab para que se monte cada vez que se arranque el sistema
    echo "${dir}\t${direccion}\t${fichero}\tdefaults 0 0" >> /etc/fstab
else
    echo "Ya existe, se expande"
    #Llevar a cablo la extensión del volumen logico
    lvextend -L $size $dir 
    #Extender elsistema de ficheros
    resize2fs $dir
fi
