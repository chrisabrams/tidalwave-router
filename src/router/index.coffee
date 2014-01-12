_     = require 'underscore'
Route = require './route'
util  = require 'util'

module.exports = class TidalWaveRouter

  constructor: ->

    @routes = new Array

    @

  findAndExecute: (req, msg, conn) ->

    if msg.type is 'utf8'

      obj   = JSON.parse msg.utf8Data
      route = obj.route
      match = @findMatch(route)

      if route and match
        util.debug "Route matched: #{match.path}"

        @emitter.emit 'dispatcher:dispatch', match

        match.listener.call @server, req, msg, conn

  findMatch: (path) ->

    match = null

    for route in @routes

      if route.test path

        match = route

        break

    return match

  match: (path, listener) =>

    route = new Route path, listener

    @routes.push route

    return route

  on: (path, cb) ->

    route = new Route path,cb
    @routes.push route

  onUse: (server) ->

    server.on 'request', (request) =>
      
      connection = request.accept 'echo-protocol', request.origin

      connection.on 'message', (message) =>

        @findAndExecute.call @, request, message, connection
