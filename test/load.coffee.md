    describe 'Modules', ->
      modules = [
        # 'client'
        'ev-mixin'
        'get-locales'
        # 'i18n-mixin'
        'socketio-status'
        'startup'
        'throttle'
        'throttle-mixin'
        'update'
        'wrapper'
        'wrapper-mixin'
      ]
      for m in modules
        do (m) ->
          it "should load #{m}", ->
            require "../#{m}"
