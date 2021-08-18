#!/bin/bash
ginfo=$(gpio readall | grep 'GPIO. 0')
echo -e "Subject: GPIO Actualizado\r\n\r\\nSe ha apagado el gpio #0\n\n-- INFORMACIÓN: \n$ginfo" | msmtp --from=default -t you_email@domain.extension