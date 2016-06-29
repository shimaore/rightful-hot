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
    # Debug.enable 'zappajs-client'
    debug = Debug @name

    @Debug = Debug

i18n

    i18n = require './i18n'
    Mixin = require './mixin'

    @main = (stores,messages,config) ->

For tests only

      config ?= window.config ? {}
      debug 'Using config', config

      Zappa config, ->
        debug 'Zappa started'

        @cfg = config

Remember: `@ev` is our Dispatcher.

        for store in stores
          store.include.call this, this

        @ready ->
          debug 'Zappa ready'
          opts = {}
          ev = @ev
          opts.client = true

Extend with our own mixin: provide `@ev`, initialize `@locales`, `@formats` and `@messages` (used by riot-intl) when the locale is modified.
Also extends with riotIntl

          riot.mixin Mixin ev, messages

          riot.mount 'app', 'app', opts

        debug 'Waiting for Zappa ready'

      debug 'Ready', config
