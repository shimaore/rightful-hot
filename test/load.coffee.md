    describe 'Modules', ->
      modules = [
        # 'client'
        # 'mixin'
        'throttle'
        'update'
        'wrapper-mixin'
        'get-locales'
        'socketio-failures'
        'throttle-mixin'
        'wrapper'
      ]
      for m in modules
        do (m) ->
          it "should load #{m}", ->
            require "../#{m}"
