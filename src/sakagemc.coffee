express = require 'express'
{PhotoLoader} = require './photo-loader'
{PhotoManager} = require './photo-manager'
{Promise} = require 'q'

module.exports = (port) ->
  new Promise (resolve, reject) ->
    app = express()

    app.get '/', (req, res) ->
      res.json app.get('photoManager').random()

    app.get '/photos', (req, res) ->
      manager = app.get('photoManager')
      n = parseInt (req.query.n ? manager.count().toString()), 10
      res.json manager.random(n)

    loaderOptions =
      id: process.env.SAKAGEMC_API_ID
      apiKey: process.env.SAKAGEMC_API_FLICKR_API_KEY
      secret: process.env.SAKAGEMC_API_FLICKR_SECRET
    new PhotoLoader(loaderOptions).load().then (photos) ->
      console.log 'loaded ' + photos.length
      photoManager = new PhotoManager photos
      app.set('photoManager', photoManager)
      app.listen(port) if port?
      resolve app
    , (err) ->
      console.error err
      reject app
