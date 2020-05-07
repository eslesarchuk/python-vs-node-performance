#!/usr/bin/env node

const fastify = require('fastify')({ logger: false })

fastify.get('/', (request, reply) => {
  reply.send({ hello: 'world' })
})

// Run the server!
fastify.listen(8003, (err) => {
  if (err) {
    fastify.log.error(err)
    process.exit(1)
  }
  fastify.log.info(`server listening on ${fastify.server.address().port}`)
})
