#!/usr/bin/env bash

echo -e "\n$(tput setaf 2)testing -- node $(node -v), express framework$(tput sgr0)"
setsid node/run_express.js &
sleep 2
ab -c200 -n20000 127.0.0.1:8002/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 2)testing -- node $(node -v), fastify framework$(tput sgr0)"
setsid node/run_fastify.js &
sleep 2
ab -c200 -n20000 127.0.0.1:8003/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 2)testing -- $(python3 -V), sanic framework$(tput sgr0)"
setsid python/run_server.py 2>&1 1>/dev/null &
sleep 2
ab -c200 -n20000 127.0.0.1:8001/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo
