RiotJS mixin that wraps an event sequence in a Promise.

    Wrapper = require './wrapper'

    module.exports = ->
      init: ->

The wrapper turns an event name into a function that returns a Promise,
wrapping the event .trigger/.one sequence.

        @wrapper = (event, timeout) =>
          Wrapper @ev, event, timeout
