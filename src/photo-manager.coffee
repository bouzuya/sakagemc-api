_ = require 'lodash'

class PhotoManager
  constructor: (@photos) ->

  random: (n=1) ->
    n = 1 if n < 1
    n = @photos.length if n > @photos.length
    if n is 1
      [@photos[Math.floor(Math.random() * @photos.length)]]
    else
      _.shuffle(@photos).slice(0, n)

  count: ->
    @photos.length

module.exports.PhotoManager = PhotoManager
