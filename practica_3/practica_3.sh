#!/bin/bash

if [ $(id -u) -ne "0" ]
then
   echo "Este script necesita permisos de administración"
   exit
fi

if [ $# != 2 ]
then
  echo "Número incorrecto de parámetros"
  exit
fi

if [ -f "$2" ]
then
   while read linea
   do
     if [ -z "$linea" ]
     then
        echo "Campo vacio"
        exit
     fi
     echo "$linea"
   done < "$2"
fi
