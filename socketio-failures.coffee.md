Handle Socket.IO disconnect / reconnect
=======================================

    exports.include = ({ev}) ->

      io_failures = [
        'connect_error'
        'connect_timeout'
        'reconnect_error'
        'reconnect_failed'
      ]
      for io_failure in io_failures
        @on io_failure, ->
          debug io_failure
          ev.trigger 'socketio-fail'

      io_attempts = [
        'reconnecting'
      ]
      for io_attempt in io_attempts
        @on io_attempt, ->
          debug io_attempt
          ev.trigger 'socketio-attempt'

      io_successes = [
        'reconnect'
        # 'pong'
      ]
      for io_success in io_successes
        @on io_success, ->
          debug io_success
          ev.trigger 'socketio-success'
