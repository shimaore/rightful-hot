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

  require './i18n'

  # Set the locales once on startup.
  @on 'mount', =>
    @ev.trigger 'set-locales', (require './get-locales')()
    @ev.trigger 'load_manager'

  # Set the locales when the user chooses.
  @setLocale = =>
    @ev.trigger 'set-locales', [@locale.value]
    false

</language-selector>
