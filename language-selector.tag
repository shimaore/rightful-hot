<language-selector>
  <!-- Language selector -->
  <span>
    <i18n lang="en">Language:</i18n>
    <i18n lang="fr">Langue:</i18n>
    { locales[0] }
  </span>
  <select name="locale" onchange={setLocale}>
    <option value="en-US">English</option>
    <option value="fr-FR">Français</option>
  </select>

  debug = (require 'debug') 'flowery-seat:language-selector.tag'

  # Set the locales once on startup.
  @on 'mount', =>
    locales = (require 'rightful-hot/get-locales')()
    debug 'mount', locales
    @ev.trigger 'set-locales', locales

  # Set the locales when the user chooses.
  @setLocale = =>
    @ev.trigger 'set-locales', [@locale.value]
    false

</language-selector>
