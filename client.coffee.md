    pkg = name: 'rightful-hot'
    @name = "#{pkg.name}:client"

    Zappa = require 'zappajs-client'

    @Zappa = Zappa
    @riot = Zappa.riot

See http://bluebirdjs.com/docs/install.html#browserify-and-webpack
and https://github.com/petkaantonov/bluebird/issues/897

    Promise.config? longStackTraces: false, warnings: false

    Debug = require 'debug'
    Debug.enable "#{pkg.name}:*"
    Debug.enable 'zappajs-client'
    debug = Debug @name

    @Debug = Debug

    EvMixin = require './ev-mixin'
    I18nMixin = require './i18n-mixin'
    WrapperMixin = require './wrapper-mixin'
    ThrottleMixin = require './throttle-mixin'
    SocketStatus = require './socketio-status'
    Startup = require './startup'

    @main = (config,f) ->

      if typeof config is 'function'
        [config,f] = [null,config]

Use `window.config` for test purposes only.

      config ?= window.config ? {}
      debug 'Using config', config

      Zappa config, ->
        debug 'Zappa started'

        @cfg = config

        @include SocketStatus
        @include Startup

        @ready ->
          debug 'Zappa ready'

          @riot.mixin WrapperMixin()
          @riot.mixin ThrottleMixin()

Remember: `@ev` is our Dispatcher, created by ZappaJS-client.

          @riot.mixin EvMixin @ev
          if config.messages?
            @riot.mixin I18nMixin @ev, config.messages
          else
            debug 'config.messages is not initialized'

          f.call this

        debug 'Waiting for Zappa ready'

      debug 'Ready', config
