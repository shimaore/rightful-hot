RiotJS mixin that wraps an event sequence in a Promise.

    debug = (require 'debug') 'wrapper'

    seconds = 1000
    default_timeout = 5*seconds

    class WrapperError extends Error


The wrapper turns an event name into a function that returns a Promise,
wrapping the event .trigger/.one sequence.

The sequence is started by the wrapper triggering the event, and a module
triggering either `event:done` or `event:error` in response. The wrapper
adds `event:timeout` if the module does not respond.

    module.exports = wrapper = (ev, event, timeout = default_timeout) ->
      (args...) ->
        new Promise (resolve,reject) ->

Success is when we receive the `:done` message back from the store.

          ev.one "#{event}:done", (values...) ->
            debug "#{event}:done", values...
            clearTimeout timer if timer?
            resolve values...

Reject with reported errors.

          ev.one "#{event}:error", (error) ->
            debug "#{event}:error", error
            clearTimeout timer if timer?
            reject error ? new StoreError """
              #{event} trigerred an error
            """

Also reject if we timeout.

          timer = setTimeout ->
            debug "#{event}:timeout"
            timer = null
            reject new StoreError """
              #{event} timed out after #{timeout}ms
            """
          , timeout

Trigger the event.

          debug "#{event}:trigger", args
          ev.trigger event, args...
