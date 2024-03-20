#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

# a) 
# b) 
# c) 
# d)
# e)
# f)
# g)
# h)
# i)
# j)
# k)
# l)
# m)
# n)
# o)
# p)
# q)

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
