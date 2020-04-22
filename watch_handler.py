#!/usr/bin/env python
import sys
import json

# JSON data representing update from consul watch
update = sys.stdin.read()
data = json.loads(update)

message = """

                            _                 _       _       _   _                               _ 
   ___ ___  _ __  ___ _   _| | __      ____ _| |_ ___| |__   | |_(_) __ _  __ _  ___ _ __ ___  __| |
  / __/ _ \| '_ \/ __| | | | | \ \ /\ / / _` | __/ __| '_ \  | __| |/ _` |/ _` |/ _ \ '__/ _ \/ _` |
 | (_| (_) | | | \__ \ |_| | |  \ V  V / (_| | || (__| | | | | |_| | (_| | (_| |  __/ | |  __/ (_| |
  \___\___/|_| |_|___/\__,_|_|   \_/\_/ \__,_|\__\___|_| |_|  \__|_|\__, |\__, |\___|_|  \___|\__,_|
                                                                    |___/ |___/                     

https://www.consul.io/docs/agent/watches.html


Data received from stdin
============================

"""

print(message)
print(json.dumps(data, indent=2))
