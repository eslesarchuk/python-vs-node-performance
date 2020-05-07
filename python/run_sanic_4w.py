#!/usr/bin/env python3

from sanic import Sanic
from sanic.response import json

app = Sanic(name="perftest app")

@app.route("/")
async def index(request):
  return json({"hello": "world"})

if __name__ == "__main__":
  app.run(host="127.0.0.1", port=8005, debug=False, access_log=False, workers=4)
