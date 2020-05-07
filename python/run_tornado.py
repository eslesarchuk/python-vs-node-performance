#!/usr/bin/env python3

import tornado.ioloop
import tornado.web
import logging

logging.getLogger('tornado.access').disabled = True

class MainHandler(tornado.web.RequestHandler):
  def get(self):
    self.write({"hello": "world"})

def make_app():
  return tornado.web.Application([
    (r"/", MainHandler),
  ])

if __name__ == "__main__":
  app = make_app()
  app.listen(8004)
  tornado.ioloop.IOLoop.current().start()
