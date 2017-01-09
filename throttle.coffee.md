    default_timeout = 700
    module.exports = throttle = (f) ->
      self = this
      (args...) ->
        if f.__timer?
          clearTimeout f.__timer
          delete f.__timer
        cb = ->
          delete f.__timer
          f.apply self,args
        f.__timer = setTimeout cb, default_timeout
