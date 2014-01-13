Route = require '../../src/router/route'

describe 'Routes - Unit', ->

  it 'should generate a route', (done) ->

    route = new Route 'yo', ->

    expect(route).to.be.an 'object'
    expect(route.listener).to.be.a 'function'
    expect(route.pattern, 'route.patter').to.equal 'yo'
    expect(route.allParams, 'route.allParams').to.have.length 0
    expect(route.optionalParams, 'route.optionalParams').to.have.length 0
    expect(route.requiredParams, 'route.requiredParams').to.have.length 0
    expect(typeof route.regExp, 'route.regExp').to.equal typeof /^yo(?=\/?(\?|$))/

    done()

  it 'should generate a route with params', (done) ->

    route = new Route 'yo/:id/ma', ->

    expect(route.allParams, 'route.allParams').to.have.length 1
    expect(route.optionalParams, 'route.optionalParams').to.have.length 0
    expect(route.requiredParams, 'route.requiredParams').to.have.length 1

    done()

  it 'should match a route', (done) ->

    route = new Route 'yo'

    expect(route.test('yo')).to.equal true

    done()

  it 'should match a route with params', (done) ->

    route = new Route 'yo/:id/ma', {}

    expect(route.test('yo/1/ma')).to.equal true

    done()
