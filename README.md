# TL;DR

Simple 'n' stupid comparison of Node vs Python3 performance with different frameworks doing the same job - responding with `{"hello":"world"}`.

```
make
```

or, if gnu make is missing:

```
docker build -t python-vs-node . && docker run --rm -ti python-vs-node
```

You should be getting something like that:

```
testing -- node v14.2.0, express framework 4.17.1
Concurrency Level:      200
Complete requests:      20000
Requests per second:    4971.21 [#/sec] (mean)

testing -- node v14.2.0, fastify framework 2.14.0
Concurrency Level:      200
Complete requests:      20000
Requests per second:    6976.47 [#/sec] (mean)

testing -- Python 3.7.3, tornado framework 6.0.4
Concurrency Level:      200
Complete requests:      20000
Requests per second:    1909.32 [#/sec] (mean)

testing -- Python 3.7.3, sanic framework 19.12.2
Concurrency Level:      200
Complete requests:      20000
Requests per second:    10892.08 [#/sec] (mean)

memory usage breakdown
2.8% express
2.8% fastify
1.2% tornado
2.3% sanic
```
