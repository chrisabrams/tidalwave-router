Route = require '../../src/router/route'

describe 'Route - Functional', ->

  it 'should be able to generate a route', (done) ->

    route = new Route 'yo', 'foo', 'bar'

    expect(route, 'route').to.be.an 'object'
    expect(route.pattern, 'route.patter').to.equal 'yo'
    expect(route.allParams, 'route.allParams').to.have.length 0
    expect(route.optionalParams, 'route.optionalParams').to.have.length 0
    expect(route.requiredParams, 'route.requiredParams').to.have.length 0
    expect(typeof route.regExp, 'route.regExp').to.equal typeof /^yo(?=\/?(\?|$))/

    done()

  it 'should be able to generate a route with params', (done) ->

    route = new Route 'yo/:id/ma', 'foo', 'bar'

    expect(route.allParams, 'route.allParams').to.have.length 1
    expect(route.optionalParams, 'route.optionalParams').to.have.length 0
    expect(route.requiredParams, 'route.requiredParams').to.have.length 1

    done()
