#!/usr/bin/env python3

import uvloop
import asyncio
import tornado.gen as gen
import tornado.httpserver as httpserver
import tornado.platform.asyncio as tornado_asyncio
import tornado.web as web
import logging

class IndexHandler(web.RequestHandler):
  async def get(self):
    self.finish({"hello": "world"})

class App(web.Application):
  def __init__(self):
    settings = {
      'debug': False
    }
    super(App, self).__init__(
      handlers=[
        (r'/', IndexHandler),
      ],
      **settings)

if __name__ == '__main__':
  logging.getLogger('tornado.access').disabled = True
  asyncio.set_event_loop_policy(uvloop.EventLoopPolicy())
  tornado_asyncio.AsyncIOMainLoop().install()
  app = App()
  server = httpserver.HTTPServer(app, xheaders=True)
  server.listen(8006)
  asyncio.get_event_loop().run_forever()
