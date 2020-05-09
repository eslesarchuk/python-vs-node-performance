#!/usr/bin/env bash

CONN=50
REQS=10000

setsid node/run_express.js &
setsid node/run_fastify.js &
setsid python/run_tornado.py &
setsid python/run_tornado_uvloop.py &
setsid python/run_sanic.py 2>&1 1>/dev/null &
setsid python/run_sanic_mw.py 2>&1 1>/dev/null &
nginx

sleep 3

echo -e "\n$(tput setaf 1)testing -- $(nginx -v 2>&1 | awk '{print $3}'), workers = cores$(tput sgr0)"
ab -c$CONN -n$REQS 127.0.0.1:8000/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second|timeout)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 2)testing -- node $(node -v), express framework $(npm info express version)$(tput sgr0)"
ab -c$CONN -n$REQS 127.0.0.1:8002/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second|timeout)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 2)testing -- node $(node -v), fastify framework $(npm info fastify version)$(tput sgr0)"
ab -c$CONN -n$REQS 127.0.0.1:8003/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second|timeout)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 3)testing -- $(python3 -V), tornado framework $(pip3 show tornado | grep Version | awk '{print $2}')$(tput sgr0)"
ab -c$CONN -n$(($REQS/2)) 127.0.0.1:8004/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second|timeout)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 3)testing -- $(python3 -V), tornado framework $(pip3 show tornado | grep Version | awk '{print $2}'), uvloop$(tput sgr0)"
ab -c$CONN -n$(($REQS/2)) 127.0.0.1:8006/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second|timeout)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 3)testing -- $(python3 -V), sanic framework $(pip3 show sanic | grep Version | awk '{print $2}')$(tput sgr0)"
ab -c$CONN -n$REQS 127.0.0.1:8001/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second|timeout)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 3)testing -- $(python3 -V), sanic framework $(pip3 show sanic | grep Version | awk '{print $2}'), 2 workers$(tput sgr0)"
ab -c$CONN -n$REQS 127.0.0.1:8005/ 2>&1 | egrep "(Concurrency Level|Complete requests|Requests per second|timeout)" | while read line; do
  echo "$(tput setaf 7)$line$(tput sgr0)"
done

echo -e "\n$(tput setaf 3)memory usage breakdown$(tput sgr0)"
tput setaf 7
echo "$(ps aux | grep express | grep -v grep | awk '{print $4}')% express"
echo "$(ps aux | grep fastify | grep -v grep | awk '{print $4}')% fastify"
echo "$(ps aux | grep tornado.py | grep -v grep | awk '{print $4}')% tornado"
echo "$(ps aux | grep tornado_uvloop | grep -v grep | awk '{print $4}')% tornado (uvloop)"
echo "$(ps aux | grep sanic.py | grep -v grep | awk '{print $4}')% sanic"
echo "$(echo 0 $(ps aux | grep sanic_mw | grep -v grep | awk '{print $4}' | xargs -n1 echo +) | bc)% sanic (2 workers)"
echo "$(echo 0 $(ps aux | grep nginx | grep -v grep | awk '{print $4}' | xargs -n1 echo +) | bc)% nginx"
tput sgr0

echo
