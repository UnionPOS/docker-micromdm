#!/bin/bash

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "unionpos/micromdm container docker-entrypoint.sh"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

DIR=/docker-entrypoint.d
# is scripts exist in DIR run them
if [[ -d "$DIR" ]]
then
  /bin/run-parts --verbose "$DIR"
fi

/opt/bin/micromdm serve \
  -http-debug=true \
  -server-url=https://localhost \
  -tls=false
