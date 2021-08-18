#!/bin/bash
ginfo=$(gpio readall | grep 'GPIO.29')
echo -e "Subject: GPIO Actualizado\r\n\r\\nSe ha encendido el gpio #29\n\n-- INFORMACIÓN: \n$ginfo" | msmtp --from=default -t you_email@domain.extension