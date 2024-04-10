#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

if [ "$#" -ne 3 ]
then
	echo "Numero incorrecto de parametros" 1>&2
	exit 1
fi

OLDIFS=$IFS
IFS=,
while read -r ip basura
do
    if ! ping -c 1 "$ip" &> /dev/null; then
        echo "$ip no es accesible" 1>&2
        continue
    fi
    scp -q -i "~/.ssh/id_as_ed25519" "./practica_3.sh" "$2" "as@$ip:~/"
    ssh -i $HOME/.ssh/id_as_ed25519 -n as@${ip} "sudo chmod u+x practica_3.sh"
    ssh -i $HOME/.ssh/id_as_ed25519 -n as@${ip} "sudo ./practica_3.sh $1 $2"
done < "$3"
IFS=$OLDIFS

