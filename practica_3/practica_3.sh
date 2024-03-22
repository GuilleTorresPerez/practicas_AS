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


borrarUsuario(){
   #Comprobar si el usuario existe
   grep -q "$1" /etc/passwd
   if [ $? -eq 1 ]; then 
      return 
   fi

   #Obtenemos el directorio home del user
   home=$(grep "$1" /etc/passwd | cut -d ':' -f 6) 
   tar czfp /extra/backup/"$1".tar "$home" &> /dev/null
   if [ $? -eq 0 ]; then								# Por último, eliminamos el usuario
		userdel -r "$1" &> /dev/null	
	fi
}

crearCarpetaBackup(){
   if [ ! -d /extra/backup ]; then					# Creamos el directorio de backup
		mkdir -p /extra/backup
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

OLDIFS=$IFS
IFS=,
if [ "$1" = "-a" ]
then
   while read -r usuario pass nombre basura
   do
     addUser "$usuario" "$pass" "$nombre"
   done < "$2"
elif [ "$1" = "-s" ]; then
   crearCarpetaBackup
   while read usuario passwd nombre basura
   do 
      borrarUsuario "$usuario"
   done < "$2"
else
   echo "Opcion invalida"
   exit 1
fi
IFS=$OLDIFS
