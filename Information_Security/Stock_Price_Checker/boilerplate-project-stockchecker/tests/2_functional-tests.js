const chaiHttp = require('chai-http');
const chai = require('chai');
const assert = chai.assert;
const server = require('../server');
const axios = require('axios');

chai.use(chaiHttp);

suite('Functional Tests', function() {
    test('GET /api/stock-prices?stock=GOOG', function (done) {
      chai.request(server)
        .get('/api/stock-prices?stock=GOOG')
        .end(function (err, res) {
          assert.equal(res.status, 200);
          assert.isObject(res.body);
          assert.property(res.body, 'stockData');
          done();
        });
    });

    test('GET /api/stock-prices?stock=GOOG&like=true', function (done) {
      chai.request(server)
        .get('/api/stock-prices?stock=GOOG&like=true')
        .end(function (err, res) {
          assert.equal(res.status, 200);
          assert.isObject(res.body);
          assert.property(res.body, 'stockData');
          done();
        });
    });

    test('GET /api/stock-prices?stock=GOOG&like=true', function (done) {
      chai.request(server)
        .get('/api/stock-prices?stock=GOOG&like=true')
        .end(function (err, res) {
          assert.equal(res.status, 200);
          assert.isObject(res.body);
          assert.property(res.body, 'stockData');
          done();
        });
    });

    test('GET /api/stock-prices?stock=GOOG&stock=NVDA', function (done) {
      chai.request(server)
        .get('/api/stock-prices?stock=GOOG&stock=NVDA')
        .end(function (err, res) {
          assert.equal(res.status, 200);
          assert.isObject(res.body);
          assert.property(res.body, 'stockData');
          done();
        });
    });

    test('GET /api/stock-prices?stock=GOOG&like=true', function (done) {
      chai.request(server)
        .get('/api/stock-prices?stock=GOOG&stock=NVDA&like=true')
        .end(function (err, res) {
          assert.equal(res.status, 200);
          assert.isObject(res.body);
          assert.property(res.body, 'stockData');
          done();
        });
    });
});
