# sakagemc-api

An API that provide the [@sakagemc](https://twitter.com/sakagemc)'s photos.

## Demo

[http://sakagemc.herokuapp.com/](http://sakagemc.herokuapp.com/)

## API

1. Get a photo
2. Get some photos

### 1. Get a photo

#### Method & Path

    GET /

#### Parameters

None

#### Examples

    $ curl http://sakagemc.herokuapp.com/ | jq .
    [
      {
        "url": "http://farm8.staticflickr.com/7395/12191702694_245d3c9735.jpg",
        "title": "【 Awakening of Tiger 】虎臥の目覚め"
      }
    ]

### 2. Get some photos

#### Method & Path

    GET /photos

#### Query Parameters

 name | value
------|-------------------------------------------------------------------------
 n    | the number of photos that you want. (default: the number of all photos)

#### Examples

    $ curl 'http://sakagemc.herokuapp.com/photos?n=2' | jq .
    [
      {
        "url": "http://farm8.staticflickr.com/7395/12191702694_245d3c9735.jpg",
        "title": "【 Awakening of Tiger 】虎臥の目覚め"
      },
      {
        "url": "http://farm8.staticflickr.com/7430/11533404385_69fc4973b2.jpg",
        "title": "【 Tension 】流れに葛藤を与える"
      }
    ]

## Development

### How to run

    $ export SAKAGEMC_API_ID='90569826@N04'
    $ export SAKAGEMC_API_API_KEY='99999999999999999999999999999999'
    $ export SAKAGEMC_API_SECRET='9999999999999999'
    $ npm start

### How to run test

    npm test

## License

MIT

## Badges

[![Build Status][travis-badge]][travis]
[![Dependencies status][david-dm-badge]][david-dm]

[travis]: https://travis-ci.org/bouzuya/sakagemc-api
[travis-badge]: https://travis-ci.org/bouzuya/sakagemc-api.svg?branch=master
[david-dm]: https://david-dm.org/bouzuya/sakagemc-api
[david-dm-badge]: https://david-dm.org/bouzuya/sakagemc-api.png
