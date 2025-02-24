'use strict';

const axios = require('axios');

const pool = require('../db.js');

module.exports = function (app) {

  app.route('/api/stock-prices')
    .get(async function (req, res){
      try {
        const symbol = req.query.stock;
        const like = req.query.like;
        const IPAddress = req.ip;

        const conn = await pool.getConnection();

        let result;
        if(Array.isArray(symbol)) {
          for(let i = 0; i < symbol.length; ++i) {
            result = Number((await conn.query('SELECT COUNT(*) AS count FROM likes WHERE symbol = ? AND ip_address = ?', [symbol[i], IPAddress]))[0].count);
          
            if((!result || result == 0) && like == true) {
              await conn.query('INSERT INTO likes(symbol, ip_address) VALUES(?, ?)', [symbol, IPAddress]);
            }
          }
        } else {
          result = Number((await conn.query('SELECT COUNT(*) AS count FROM likes WHERE symbol = ? AND ip_address = ?', [symbol, IPAddress]))[0].count);
        
          if((!result || result == 0) && like == true) {
            await conn.query('INSERT INTO likes(symbol, ip_address) VALUES(?, ?)', [symbol, IPAddress]);
          }
        }
        
        if(symbol) {
          let stockData;
          
          if(Array.isArray(symbol)) {
            stockData = [];
            let stockLikeCounts = [];

            for(let i = 0; i < symbol.length; ++i) {
              stockLikeCounts.push(Number((await conn.query('SELECT COUNT(*) AS count FROM likes WHERE symbol = ?', [symbol[i]]))[0].count));
              const response = (await axios.get(`https://stock-price-checker-proxy.freecodecamp.rocks/v1/stock/${symbol[i]}/quote`)).data;
              stockData.push({ stock: response.symbol, price: response.latestPrice });
            }

            for(let i = 0; i < stockData.length; ++i) {
              stockData[i]['rel_likes'] = Math.abs(stockLikeCounts[0] - stockLikeCounts[1]);
            }
          } else {
            const count = Number((await conn.query('SELECT COUNT(*) AS count FROM likes WHERE symbol = ?', [symbol]))[0].count);
            const response = (await axios.get(`https://stock-price-checker-proxy.freecodecamp.rocks/v1/stock/${symbol}/quote`)).data;
            stockData = { stock: response.symbol, price: response.latestPrice, likes: count };
          }

          console.log({ stockData });

          res.status(200).json({ stockData });
        }

        conn.release();
      } catch(err) {
        console.log(err);
        res.status(500).json({ error: 'Internal server error, please try again later.' });
      }
    });
    
};
