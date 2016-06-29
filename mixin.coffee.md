Extend with our own mixin: provide `@ev`, initialize `@locales`, `@formats` and `@messages` (used by riot-intl) when the locale is modified.
(Require riot-intl since we re-use `formatMessage`, `getIntlMessage`.)


    module.exports = (ev,{messages}) ->
      init: ->
        @ev = ev

i18n
====

The riotIntl mixin uses @locales, @formats, and @messages.

        @locales = []
        @formats = {}
        @messages = {}
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
              if not @messages and lang of messages
                @messages = messages[lang]
                @messages_lang = lang

          @messages ?= {}

          @update()

        @i18n = (path,values) =>

          return path unless @messages? and @locales?

Try to find a translation.

          message = try @getIntlMessage path

If no translation is found, use the default message.

          message ?= path
          text = @formatMessage message, values
          text

Provide default locale early

        ev.trigger 'set-locales', (require './get-locales')()
