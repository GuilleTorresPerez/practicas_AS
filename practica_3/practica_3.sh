#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

if [ $(id -u) -ne "0" ]
then
   echo "Este script necesita permisos de administración"
   exit -1
fi

if [ $# != 2 ]
then
  echo "Número incorrecto de parámetros"
  exit
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
fi


addUser() {
   local login_name="$1"
   local contrasena="$2"
   local nombre_completo_del_usuario="$3"
   
   # Comprobar si los campos están vacíos
   if [ -z "$login_name" ] || [ -z "$contrasena" ] || [ -z "$nombre_completo_del_usuario" ]; then
      echo "Campo invalido"
      return 1
   fi
   
   # Comprobar si el usuario existe revisando el fichero /etc/passwd 
   if grep -q "^$login_name:" /etc/passwd; then
      echo "El usuario $login_name ya existe"
      return 1
   fi
   
   # Crear el usuario
   useradd -m -e 30 -K UID_MIN=1815 -c "$nombre_completo_del_usuario" -k /etc/skel "$login_name"
   
   # Asignar la contraseña
   echo "$login_name:$contrasena" | chpasswd
   
   # Desbloquear usuario
   usermod -U "$login_name" &>/dev/null
}






































































# El script debe cumplir los siguientes requisitos:
# a) Comprobación de usuario con privilegios de administración. Si el script no está
# siendo ejecutado por un usuario privilegiado, terminará escribiendo por
# pantalla: “Este script necesita privilegios de administracion” y el estado de
# salida será 1.
# b) La creación o borrado de usuarios se especifica mediante el parámetro [-a|-
# s]. Cualquier otra opción generará el mensaje de error: “Opcion invalida” por
# la salida de error, stderr.
# c) La sintaxis del script es practica_3.sh [-a|-s] <nombre_fichero>. Cuando el
# número de argumentos sea distinto de 2. El script mostrará el siguiente
# mensaje de error: “Numero incorrecto de parametros”.
# d) Para borrar usuarios, sólo es necesario el primer campo del fichero. Es decir,
# se permiten ficheros que sólo tengan un campo.
# e) Al añadir usuarios, la caducidad de la nueva contraseña establecida será de
# 30 días y se escribirá por pantalla el siguiente mensaje: “<nombre completo
# del usuario> ha sido creado”.
# f) Al añadir usuarios, si el usuario existe, ni se añadirá ni se cambiará su
# contraseña y se mostrará el siguiente mensaje por pantalla: “El usuario
# <identificador> ya existe”. Después de mostrar el mensaje, el script continuará
# procesando el fichero de entrada.
# g) Al añadir usuarios, se comprobará que los 3 campos son distintos de la
# cadena vacía, si alguno de ellos es igual se abortará la ejecución y se
# mostrará el siguiente mensaje: “Campo invalido”.
# h) Al borrar usuarios, si el usuario no existe, se continuará procesando el fichero
# sin escribir nada por pantalla.
# i) Es necesario utilizar los comandos: useradd, userdel, usermod y chpasswd.
# j) Los usuarios deberán tener un UID mayor o igual que 1815.
# k) Cada usuario tendrá como grupo por defecto uno con su mismo nombre.
# l) El directorio home de cada usuario se inicializará con los ficheros de /etc/skel.
# m) El proceso ha de ser completamente automático, sin interacción del
# administrador.
# n) El borrado de usuarios será completo, incluyendo su directorio home.
# o) Antes de borrar un usuario, el script realizará un backup de su directorio home
# (mediante tar y con nombre <usuario>.tar) que será guardado en el directorio
# /extra/backup.
# p) Si el argumento es “-s”, borrado de usuarios, se debe crear el directorio
# /extra/backup aunque no se borre ningún usuario.
# q) En caso de que el backup no pueda ser completado satisfactoriamente, no se
# realizará el borrado.
