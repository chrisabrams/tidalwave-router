Router = require '../../src/router/index'
Server = require 'tidalwave'

describe 'Router - Functional', ->

  it 'should set a route', (done) ->

    server = new Server
      port: 8000

    router = new Router

    router.on 'yo', ->

    expect(router.routes).to.have.length 1

    server.shutdown ->

      done()  
