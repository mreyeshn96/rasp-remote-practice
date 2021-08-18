#!/bin/bash
ginfo=$(gpio readall | grep 'GPIO. 2')
echo -e "Subject: GPIO Actualizado\r\n\r\\nSe ha encendido el gpio #2\n\n-- INFORMACIÓN: \n$ginfo" | msmtp --from=default -t you_email@domain.extension