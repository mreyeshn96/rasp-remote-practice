#!/bin/bash
echo -e "Subject: Test Mail\r\n\r\\nThis is a test mail" | msmtp --debug --from=default -t 1160173@usap.edu
