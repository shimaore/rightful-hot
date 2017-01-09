RiotJS mixin that wraps an event sequence in a Promise.

    Throttle = require './throttle.coffee.md'

    module.exports = ->
      init: ->

The wrapper turns an event name into a function that returns a Promise,
wrapping the event .trigger/.one sequence.

        @throttle = Throttle
