_     = require 'underscore'
Route = require './route'
util  = require 'util'

module.exports = class TidalWaveRouter

  constructor: (connection, request) ->

    @routes = new Array

    if connection
      @connection = connection

      connection.on 'message', (message) =>

        @findAndExecute message, connection, request

    @

  dispatch: (route, pkg) ->

    if @connection
      @connection.sendUTF JSON.stringify({route: route, pkg: pkg})

  findAndExecute: (msg, conn, req) ->

    if msg.type is 'utf8'

      obj   = JSON.parse msg.utf8Data
      route = obj.route
      match = @findMatch(route)

      if route and match

        util.debug "Route matched: #{match.pattern}"

        if @emitter
          @emitter.emit 'route:matched', match

        match.listener obj.pkg, conn, req

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

  onUse: () ->
