const mariadb = require('mariadb');

const pool = mariadb.createPool({
  host: '127.0.0.1',
  user: 'freecodecamp',
  password: 'freecodecamp',
  database: 'stock_price_checker',
  connectionLimit: 5
});

module.exports = pool;