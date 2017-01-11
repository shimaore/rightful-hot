    debug = (require 'debug') 'rightful-hot:startup'

    module.exports =
      include: ->

The `welcome` event is emitted by the server when the Socket.io connection
is established.

        @on 'welcome', ->
          debug 'welcome', @data
          @ev.trigger 'welcome', @data

The `failed` event is emitted by the server instead of the `welcome` message
if the ZappaJS-client negotiation failed.

        @on 'failed', ->
          debug 'failed', @data
          @ev.trigger 'socketio-fail'
