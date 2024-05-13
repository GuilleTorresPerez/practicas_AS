#!/bin/bash
#842545, Valero Casajus, Curro, [M], [3], [B]
#843078, Torres Perez, Guillermo, [M], [3], [B] 

if [ $# -ne 1 ]; then
    echo "Introduzca la IP como parametro"
    exit 1
fi
ssh as@"$1" "sudo sfdisk -s && sudo sfdisk -l && sudo df -hT | grep -ve 'udev|tmpfs'"