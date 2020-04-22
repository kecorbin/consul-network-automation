#!/bin/bash
echo "Setting initial SNMP value"
consul kv put NetworkAutomation/snmp_ro snmp_$RANDOM
consul kv put NetworkAutomation/snmp_rw "Maybe use vault instead?"
consul watch -type key -key NetworkAutomation/snmp_ro ./watch_handler.py &
sleep 30
echo "Rotating SNMP string"
consul kv put NetworkAutomation/snmp_ro snmp_$RANDOM
sleep 30
