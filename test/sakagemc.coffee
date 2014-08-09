assert = require 'power-assert'
sinon = require 'sinon'
request = require 'supertest'
{Promise} = require 'q'

describe 'GET /', ->
  beforeEach ->
    @sinon = sinon.sandbox.create()

  afterEach ->
    @sinon.restore()

  describe 'photos: []', ->
    beforeEach (done) ->
      {PhotoLoader} = require '../src/photo-loader'
      @sinon.stub PhotoLoader.prototype, 'load', ->
        Promise.resolve []
      require('../src/sakagemc')().then (app) =>
        @app = app
        done()
      , done

    it 'respond 200 OK and []', (done) ->
      request @app
        .get '/'
        .end (err, res) ->
          assert err is null
          assert res.statusCode is 200
          assert.deepEqual res.body, []
          done()

  describe 'photos: [{ url, title }]', ->
    beforeEach (done) ->
      {PhotoLoader} = require '../src/photo-loader'
      @sinon.stub PhotoLoader.prototype, 'load', ->
        Promise.resolve [
          url: 'http://example.com'
          title: 'title'
        ]
      require('../src/sakagemc')().then (app) =>
        @app = app
        done()
      , done

    it 'respond 200 OK and [{ url, title }]', (done) ->
      request @app
        .get '/'
        .end (err, res) ->
          assert err is null
          assert res.statusCode is 200
          assert.deepEqual res.body, [
            url: 'http://example.com'
            title: 'title'
          ]
          done()

  describe 'photos: [{ url, title }, { url, title }]', ->
    beforeEach (done) ->
      {PhotoLoader} = require '../src/photo-loader'
      @sinon.stub PhotoLoader.prototype, 'load', ->
        Promise.resolve [
          url: 'http://photo1.example.com'
          title: 'title1'
        ,
          url: 'http://photo2.example.com'
          title: 'title2'
        ]
      require('../src/sakagemc')().then (app) =>
        @app = app
        done()
      , done

    it 'respond 200 OK and [{ url, title }]', (done) ->
      request @app
        .get '/'
        .end (err, res) ->
          assert err is null
          assert res.statusCode is 200
          assert res.body.length is 1
          done()

describe 'GET /photos', ->
  beforeEach ->
    @sinon = sinon.sandbox.create()

  afterEach ->
    @sinon.restore()

  describe 'photos: []', ->
    beforeEach (done) ->
      {PhotoLoader} = require '../src/photo-loader'
      @sinon.stub PhotoLoader.prototype, 'load', ->
        Promise.resolve []
      require('../src/sakagemc')().then (app) =>
        @app = app
        done()
      , done

    it 'respond 200 OK and []', (done) ->
      request @app
        .get '/photos'
        .end (err, res) ->
          assert err is null
          assert res.statusCode is 200
          assert.deepEqual res.body, []
          done()

  describe 'photos: [{ url, title }]', ->
    beforeEach (done) ->
      {PhotoLoader} = require '../src/photo-loader'
      @sinon.stub PhotoLoader.prototype, 'load', ->
        Promise.resolve [
          url: 'http://example.com'
          title: 'title'
        ]
      require('../src/sakagemc')().then (app) =>
        @app = app
        done()
      , done

    it 'respond 200 OK and [{ url, title }]', (done) ->
      request @app
        .get '/photos'
        .end (err, res) ->
          assert err is null
          assert res.statusCode is 200
          assert.deepEqual res.body, [
            url: 'http://example.com'
            title: 'title'
          ]
          done()

  describe 'photos: [{ url, title }, { url, title }]', ->
    beforeEach (done) ->
      {PhotoLoader} = require '../src/photo-loader'
      @sinon.stub PhotoLoader.prototype, 'load', ->
        Promise.resolve [
          url: 'http://photo1.example.com'
          title: 'title1'
        ,
          url: 'http://photo2.example.com'
          title: 'title2'
        ]
      require('../src/sakagemc')().then (app) =>
        @app = app
        done()
      , done

    describe 'n = (default) ', ->
      it 'respond 200 OK and [{ url, title }, { url, title }]', (done) ->
        request @app
          .get '/photos'
          .end (err, res) ->
            assert err is null
            assert res.statusCode is 200
            assert res.body.length is 2
            done()

    describe 'n = 1', ->
      it 'respond 200 OK and [{ url, title }]', (done) ->
        request @app
          .get '/photos'
          .query { n: 1 }
          .end (err, res) ->
            assert err is null
            assert res.statusCode is 200
            assert res.body.length is 1
            done()
