#Limpiar la tabla
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#Rechazamos paquetes que se reciben
iptables -P INPUT DROP
#Rechazamos paquetes que se reenvian
iptables -P FORWARD DROP
#Rechamazos paquetes que salen
iptables -P OUTPUT ACCEPT

#Intranet

#Aceptar las respuestas de mensajes ping que llegan por la interfaz enp0s8 (redHost)
#y que se queda debian1
iptables -A INPUT -i enp0s8 -p icmp --icmp-type 0 -j ACCEPT 
#Aceptar las respuestas de mensajes pings que llegan por la interfaz enp0s8 (redHost)
#y que se tiene que enviar a otras maquinas
iptables -A FORWARD -i enp0s8 -p icmp --icmp-type 0 -j ACCEPT

#Aceptar el trafico que llegue por la interfaz enp0s9 (redInterna1)
#y que se queda debian1
iptables -A INPUT -i enp0s9 -p all -j ACCEPT 
#Aceptar el trafico que llegue por la interfaz enp0s9 (redInterna1)
#y que se tiene que enviar a otras maquinas
iptables -A FORWARD -i enp0s9 -p all -j ACCEPT

#Aceptar el trafico que llegue por la interfaz enp0s10 (redInterna2)
#y que se queda debian1
iptables -A INPUT -i enp0s10 -p all -j ACCEPT 
#Aceptar el trafico que llegue por la interfaz enp0s10 (redInterna2)
#y que se tiene que enviar a otras maquinas
iptables -A FORWARD -i enp0s10 -p all -j ACCEPT

#Acepta todo el trafico que llegue a traves de loopback, hacer ping a si mismo
#(no se si es necesario)
iptables -A INPUT -i lo -p all -j ACCEPT


#Extranet

#El trafico de la intranet hacia la extranet usa la IP de debian1
iptables -t nat -A POSTROUTING -o enp0s8 -j SNAT --to 192.168.56.2

#Aceptar el trafico que llegue por la interfaz enp0s3
#y que se queda debian1
iptables -A INPUT -i enp0s3 -p all -j ACCEPT 
#Aceptar el trafico que llegue por la interfaz enp0s3
#y que se tiene que enviar a otras maquinas
iptables -A FORWARD -i enp0s3 -p all -j ACCEPT

#Los paquetes con origen redInterna2, redInterna3 y redHost
#se les ocultan las @ ip de dentro de la red interna y son reemplazas por
#las de la interfaz enp0s3
iptables -t nat -A POSTROUTING -s 192.168.56.0/24 -o enp0s3 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o enp0s3 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -o enp0s3 -j MASQUERADE

#Si host quiere conectarse a internet se redirige a debian2 por el puerto 80 (HTTP)
iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 80 -j DNAT --to 192.168.1.1:80
#Lo mismo pero por el puerto 443 (HTTPS)
iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 443 -j DNAT --to 192.168.1.1:443
#Si host quiere conectarse a ssh se redirige a debian5 por el puerto 22 (SSH)
iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 22 -j DNAT --to 192.168.3.1:22


#Acepta todo el trafico con destino debian5 (server SSH) por el puerto 22
iptables -A FORWARD -d 192.168.3.1 -p tcp --dport 22 -j ACCEPT
#Acepta todo el trafico con destino debian2 (Apache) por el puerto 80
iptables -A FORWARD -d 192.168.1.1 -p tcp --dport 80 -j ACCEPT
#Acepta todo el trafico con destino debian2 (Apache) por el puerto 443 a.k.a HTTPS
iptables -A FORWARD -d 192.168.1.1 -p tcp --dport 443 -j ACCEPT

#Mostrar las reglas que se acaban de configurar
iptables -L