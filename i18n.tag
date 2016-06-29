<i18n>
  <virtual if={ show }>
    <yield/>
  </virtual>

  ###
  A very basic translation tag.
  Use {parent.foo} inside the yield-ed code in order to access your tag's values.
  ###

  @show = false

  @ev.on 'set-locales', (locales) =>
    @locales = locales
    @langs = @locales.map (n) -> n.split('-')[0]
    @show = opts.lang in @locales or opts.lang in @langs
    @update()

</i18n>
