.DEFAULT_GOAL :=
.PHONY: test
test: build run

.PHONY: build
build:
	docker build -t python-vs-node .

.PHONY: run
run:
	docker run --rm -ti python-vs-node
