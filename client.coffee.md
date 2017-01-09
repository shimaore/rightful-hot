    pkg = name: 'rightful-hot'
    @name = "#{pkg.name}:client"

    Zappa = require 'zappajs-client'
    {riot} = Zappa

    @Zappa = Zappa
    @riot = riot

See http://bluebirdjs.com/docs/install.html#browserify-and-webpack
and https://github.com/petkaantonov/bluebird/issues/897

    Promise.config? longStackTraces: false, warnings: false

    Debug = require 'debug'
    Debug.enable "#{pkg.name}:*"
    Debug.enable 'zappajs-client'
    debug = Debug @name

    @Debug = Debug

    Mixin = require './mixin'
    WrapperMixin = require './wrapper-mixin'
    ThrottleMixin = require './throttle-mixin'
    SocketStore = require './socketio-failures'

    @main = (stores,config,f) ->

For tests only

      config ?= window.config ? {}
      debug 'Using config', config

      Zappa config, ->
        debug 'Zappa started'

        @cfg = config

Remember: `@ev` is our Dispatcher.

        for store in stores
          store.include.call this, this

        SocketStore.include.call this, this

        @ready ->
          debug 'Zappa ready'
          ev = @ev

          if config.mixins?
            for mixin in config.mixins
              riot.mixin mixin @ev, config

          riot.mixin Mixin @ev, config
          riot.mixin WrapperMixin()
          riot.mixin ThrottleMixin()

          f.call this

        debug 'Waiting for Zappa ready'

      debug 'Ready', config
