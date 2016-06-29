    module.exports = getLocales = ->
      if navigator.languages?
        navigator.languages
      else
        [ navigator.userLanguage ? navigator.language ]
