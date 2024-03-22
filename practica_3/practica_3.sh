#!/bin/bash

fecha_actual=$(date +"%Y-%m-%d")
fecha_nueva=$(date -d "$fecha_actual + 30 days" +"%Y-%m-%d")

addUser(){
 local login_name="$1"
 local contrasena="$2"
 local nombreCompleto="$3"

 #Comprobar si los campos están vacíos
 if [ -z "$login_name" ] || [ -z "$contrasena" ] || [ -z "$nombreCompleto" ]
 then
    echo "Campo invalido"
    exit 1
 fi

 #Comprobar si el usuario existe revisando el fichero /etc/passwd
 if grep -q "^$login_name:" /etc/passwd; then
    echo "El usuario $login_name ya existe"
 fi

 #Crear el usuario
 useradd -K UID_MIN=1815 -U -m -e $fecha_nueva -k /etc/skel -c "$nombreCompleto" "$login_name"
 #Asignar la contraseña
 echo "$login_name:$contrasena" | chpasswd
 #Desbloquear usuario
 usermod -U "$login_name" &>/dev/null
 echo "$nombreCompleto ha sido creado"
}


borrarUsuraio(){
 for var in $(cut -d ',' -f 1 "$1")
 do
   if [ $(cat /etc/passwd | grep "$var:" | wc -l) -ne 0 -a "$var" != "root" ]; then
     #> /var/spool/mail/"$var"
     #if [ ! -e /extra/backup/"$var".tar ]; then
     if [ tar -cPf /extra/backup/"$var".tar "$(cat /etc/passwd | grep "$var:" | cut -d':' -f6)" ]
     then
     #if [ $? -eq 0 ]; then
       userdel -r "$var"
     #fi
     fi
   fi
 done
}

crearCarpetaBackup(){
   if [ ! -d "/extra" ]; then
      mkdir /extra/
   fi
   if [ ! -d "/extra/backup" ]; then
      mkdir /extra/backup/
   fi
}

if [ $(id -u) -ne "0" ]
then
   echo "Este script necesita privilegios de administracion"




   exit 1
fi

if [ $# != 2 ]
then
    echo "Numero incorrecto de parametros"
    exit 1
fi


if [ "$1" = "-a" ]
then
   OLDIFS=$IFS
   IFS=,
   while read -r usuario pass nombre basura
   do
     addUser "$usuario" "$pass" "$nombre"
   done < "$2"
   IFS=$OLDIFS


elif [ "$1" = "-s" ]; then
   crearCarpetaBackup
   borrarUsuario "$2"
else
 echo "Opcion invalida"
 exit 1
fi
