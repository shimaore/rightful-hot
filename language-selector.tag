<language-selector>
  <!-- Language selector -->
  <select name="locale" onchange={setLocale}>
    <option each={available_locales} value={locale}>{name}</option>
  </select>
  <span>
    { locales[0] }
  </span>

  debug = (require 'debug') 'rightful-hot:language-selector.tag'

  @available_locales = ({locale,name:v.__name} for own locale,v of @Messages)

  # Set the locales once on startup.
  @on 'mount', =>
    locales = (require './get-locales')()
    debug 'mount', locales
    @ev.trigger 'set-locales', locales

  # Set the locales when the user chooses.
  @setLocale = =>
    locales = [@locale.value]
    debug 'setLocale', locales
    @ev.trigger 'set-locales', locales
    false

</language-selector>
