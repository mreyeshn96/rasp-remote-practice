#!/bin/bash
echo "TEMPORIZADOR CRON" echo
echo
echo
read -p "Ingrese hora inicial: " hi
echo
read -p "Ingrese minuto inicial: " mi
echo
read -p "Ingrese hora final: " hf
echo
read -p "Ingrese minuto final: " mf

echo $mi $hi "* * * root /home/pi/Desktop/clase/on" > /etc/cron.d/tarea1
echo $mf $hf "* * * root /home/pi/Desktop/clase/off" > /etc/cron.d/tarea2

cd /etc/cron.d/
chmod -R 755 tarea1
chmod -R 755 tarea2

/etc/init.d/cron restart
