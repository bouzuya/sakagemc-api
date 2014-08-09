{format} = require('util')
Flickr = require('flickrapi')
Promise = require('q').Promise

class PhotoLoader
  constructor: (options) ->
    @_sakagemcId = options.id
    @_authOptions =
      api_key: options.apiKey
      secret:  options.secret

  _authenticate: ->
    new Promise (resolve, reject) =>
      Flickr.tokenOnly @_authOptions, (err, flickr) =>
        if err?
          reject err
        else
          @flickr = flickr
          resolve()

  _getPublicPhotos: (page) ->
    new Promise (resolve, reject) =>
      @flickr.people.getPublicPhotos {
        user_id: @_sakagemcId,
        page: page,
        per_page: 500,
      }, (err, result) ->
        if err
          reject err
        else
          resolve result

  _getPublicPhotosAll: ->
    new Promise (resolve, reject) =>
      f = (page, photos) =>
        @_getPublicPhotos page
          .then (result) ->
            newPhotos = photos.concat result.photos.photo
            if result.photos.page < result.photos.pages
              f page + 1, newPhotos
            else
              resolve newPhotos
          .then null, reject
      f 1, []

  _formatPhotos: (photos) ->
    Promise.resolve photos.map (p) ->
      fmt = 'http://farm%s.staticflickr.com/%s/%s_%s.jpg'
      url = format(fmt, p.farm, p.server, p.id, p.secret)
      { title: p.title, url: url }

  load: ->
    @_authenticate()
      .then @_getPublicPhotosAll.bind(@)
      .then @_formatPhotos.bind(@)

module.exports.PhotoLoader = PhotoLoader
