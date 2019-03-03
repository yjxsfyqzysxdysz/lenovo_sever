const express = require("express");
const router = express.Router();
const pool = require("../pool");

//测试: http://localhost:3000/index
router.get("/", (req, res) => {
  var sql = `SELECT * FROM le_index_product
    where seq_recommended!=0
    order by seq_recommended`;
  pool.query(sql, [], (err, result) => {
    if (err) throw err;
    res.send(result);
  });
})
module.exports = router;