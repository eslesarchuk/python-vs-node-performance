#!/usr/bin/env bash
setsid node/run_express.js &
setsid node/run_fastify.js &
setsid python/run_tornado.py  &
setsid python/run_sanic.py 2>&1 1>/dev/null &

sleep 3

echo -e "\n$(tput setaf 2)testing -- node $(node -v), express framework $(npm info express version)$(tput sgr0)"
ab -c200 -n20000 127.0.0.1:8002/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 2)testing -- node $(node -v), fastify framework $(npm info fastify version)$(tput sgr0)"
ab -c200 -n20000 127.0.0.1:8003/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 2)testing -- $(python3 -V), tornado framework $(pip3 show tornado | grep Version | awk '{print $2}')$(tput sgr0)"
ab -c200 -n20000 127.0.0.1:8004/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 2)testing -- $(python3 -V), sanic framework $(pip3 show sanic | grep Version | awk '{print $2}')$(tput sgr0)"
ab -c200 -n20000 127.0.0.1:8001/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 3)memory usage breakdown$(tput sgr0)"
tput setaf 7
echo "$(ps aux | grep express | grep -v grep | awk '{print $4}')% express"
echo "$(ps aux | grep fastify | grep -v grep | awk '{print $4}')% fastify"
echo "$(ps aux | grep tornado | grep -v grep | awk '{print $4}')% tornado"
echo "$(ps aux | grep sanic | grep -v grep | awk '{print $4}')% sanic"
tput sgr0

echo
