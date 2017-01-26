Initialize `@locales`, `@formats` and `@messages` (used by riot-intl) when the locale is modified.
(Require riot-intl since we re-use `formatMessage`, `getIntlMessage`.)

    {IntlMixin} = require 'riot-intl/lib/riot-intl'

    current_messages = {}
    current_locales = []

    module.exports = (ev,messages) ->
      init: ->

i18n
====

The riotIntl mixin uses @locales, @formats, and @messages.

        @locales = current_locales
        @formats = {}
        @messages = current_messages

This is our way to allow our users to access the original messages stash.

        @Messages = messages

        ev.on 'set-locales', (locales) =>
          langs = locales.map (n) -> n.split('-')[0]
          @locales = locales
          @langs = langs

          @messages = null
          @messages_locale = null
          @messages_lang = null

`@Messages` contains the entire list of messages (for all locales)

`@messages` (used by riot-intl) contains the list of messages for the current locale.

          if messages?

First try to find the exact locale.

            for locale in locales
              if not @messages? and locale of messages
                @messages = messages[locale]
                @messages_locale = locale

If that fails, try to find using only the language.

            for lang in langs
              if not @messages? and lang of messages
                @messages = messages[lang]
                @messages_lang = lang

          @messages ?= {}

Save the values so that tags initialized after the `set-locales` event may benefit from them.

          current_messages = @messages
          current_locales = locales

          try @update()
          null

        @i18n = (path,values) =>

          return path unless @messages? and @locales?

Try to find a translation.

          message = try @getIntlMessage path

If no translation is found, use the default message.

          message ?= path
          text = @formatMessage message, values
          text

Load the riot-intl mixin

        @mixin IntlMixin
