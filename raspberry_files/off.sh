#! /bin/bash
echo 25 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio25/direction
echo 0 > /sys/class/gpio/gpio17/value
#echo 0 > /home/pi/foco1.txt
user=`cut -d " " -f1 /home/pi/.conexion.txt`
pass=`cut -d " " -f2 /home/pi/.conexion.txt`
db=`cut -d " " -f3 /home/pi/.conexion.txt`
fecha=`date +"%Y-%m-%d-%T"`
usuario="april"
query="insert into caja1(num_gpio, desc_gpio, value,fecha_ini, usuario) values('25','caja1','0','$fecha','$usuario')"

mysql -u $user -p$pass $db -e "$query"
