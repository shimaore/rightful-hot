    pkg = name: 'rightful-hot'
    debug = (require 'debug') "#{pkg.name}:update"

    module.exports = update = (db,doc) ->
      debug 'update', doc
      db
        .get doc._id
        .catch (error) ->
          debug "update get #{error.stack ? error}", doc._id
          {}
      .then ({_rev}) ->
        delete doc._rev
        doc._rev = _rev if _rev?
        debug 'update put', doc
        db
        .put doc
        .catch (error) ->
          debug "update put #{error.stack ? error}", doc
          {}
      .then ({rev}) ->
        delete doc._rev
        doc._rev = rev if rev?
        debug 'update return', doc
        doc
