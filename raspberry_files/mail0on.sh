#!/bin/bash
ginfo=$(gpio readall | grep 'GPIO. 0')
echo -e "Subject: GPIO Actualizado\r\n\r\\nSe ha encendido el gpio #0\n\n-- INFORMACIÓN: \n$ginfo" | msmtp --from=default -t you_email@domain.extension
echo -e "\e[30m$ginfo\e[0m"