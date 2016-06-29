    seem = require 'seem'
    pkg = name: 'rightful-hot'
    debug = (require 'debug') "#{pkg.name}:update"

    module.exports = update = seem (db,doc) ->
      debug 'update', doc
      {_rev} = yield db
        .get doc._id
        .catch (error) ->
          debug "update get #{error.stack ? error}", doc._id
          {}
      delete doc._rev
      doc._rev = _rev if _rev?
      debug 'update put', doc
      {rev} = yield db
        .put doc
        .catch (error) ->
          debug "update put #{error.stack ? error}", doc
          {}
      delete doc._rev
      doc._rev = rev if rev?
      debug 'update return', doc
      doc
