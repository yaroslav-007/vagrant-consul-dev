
#!/usr/bin/env bash
set -x

# Check if consul member is alive
gitconsul members  | awk '{print $3}' | grep  alive

if [ $? == 0 ];then
  echo "GOOD: consul is up"
else
  echo "BAD: there is problem with service"
  exit 1
fi

# Check if web page is accesible
curl -I -s http://localhost:8500/ui/ | grep "HTTP/1.1 200 OK"

if [ $? == 0 ];then
  echo "GOOD: web page is accessible"
else
  echo "BAD: web page is not accessible"
  exit 1
fi
