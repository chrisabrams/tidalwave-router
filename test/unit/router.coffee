Router = require '../../src/router/index'

describe 'Router - Unit', ->

  it 'should be able to initialize', (done) ->

    router = new Router

    expect(router).to.be.an 'object'
    expect(router.findAndExecute).to.be.a 'function'
    expect(router.findMatch).to.be.a 'function'
    expect(router.match).to.be.a 'function'
    expect(router.routes).to.have.length 0
    expect(router.destroy).to.be.a 'function'

    done()

  it 'should be able to find a matching route', (done) ->

    router = new Router

    router.on 'yo', ->

    expect(router.routes).to.have.length 1
    expect(router.findMatch('yo')).to.be.an 'object'

    done()

  it 'should not be able to find a matching route', (done) ->

    router = new Router

    router.on 'yo', ->

    expect(router.routes).to.have.length 1
    expect(router.findMatch('yolanda')).to.equal null

    done()