# TL;DR

Simple 'n' stupid comparison of Node (express) vs Python3 (sanic) performance.

```
docker build -t python_vs_node . \
  && docker run --rm -ti python_vs_node
```

You should be getting something like that:

```
testing -- node v14.2.0, express framework
Concurrency Level:      200
Complete requests:      20000
Requests per second:    5104.02 [#/sec] (mean)

testing -- Python 3.7.3, sanic framework
Concurrency Level:      200
Complete requests:      20000
Requests per second:    9720.49 [#/sec] (mean)
```
