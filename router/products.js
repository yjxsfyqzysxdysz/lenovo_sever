const express = require("express");
const router = express.Router();
const pool = require("../pool");

//http://localhost:3000/seach_page?kwords=i5&pno=0
// 主页页面搜索栏
router.get("/", (req, res) => {
  var kwords = decodeURIComponent(req.query.kwords);
  var output = {
    pno: 0,
    pageSize: 8,
    count: 0,
    pageCount: 0,
    products: []
  }
  if (req.query.pno !== undefined) {
    output.pno = parseInt(req.query.pno);
  }
  kwords = kwords.split(" ");
  kwords.forEach((val, i, arr) => {
    arr[i] = `%${val}%`;
  });
  var arr = [];
  for (var kw of kwords) {
    arr.push(` title LIKE ? `);
  }
  var where = " WHERE " + arr.join(" AND ");
  var sql = "SELECT * ,(SELECT md FROM le_laptop_pic WHERE le_laptop_pic.lid=le_laptop.lid LIMIT 1) AS img FROM le_laptop " + where;

  pool.query(sql, kwords, (err, result) => {
    if (err) throw err;
    var count = result.length;
    var pageCount = Math.ceil(count / output.pageSize);
    output.count = count;
    output.pageCount = pageCount;
    var starti = output.pno * output.pageSize;
    output.products = result.slice(starti, starti + output.pageSize);
    res.send(output);
    res.end();
  });
})

// 筛选
router.get("/filtrate", (req, res) => {
  var uid = req.query.uid;
  var kwords = decodeURIComponent(req.query.kwords);
  var output = {
    pno: 0,
    pageSize: 8,
    count: 0,
    pageCount: 0,
    products: []
  }
  if (req.query.pno !== undefined) {
    output.pno = parseInt(req.query.pno);
  }
  kwords = kwords.split(",");
  kwords.pop();
  kwords.forEach((val, i, arr) => {
    arr[i] = `%${val}%`;
  });
  var arr = [];
  for (var kw of kwords) {
    arr.push(` ( title like ? or subtitle like ? or resolution like ? or cpu like ? ) `);
  }
  var where = "WHERE " + arr.join(" AND ");
  var sql = "select * from le_laptop " + where;
  var kw = [];
  for (var kws of kwords) {
    for (var i = 0; i < 4; i++) {
      kw.push(kws);
    }
  }
  pool.query(sql, kw, (err, result) => {
    if (err) throw err;
    var count = result.length;
    var pageCount = Math.ceil(count / output.pageSize);
    output.count = count;
    output.pageCount = pageCount;
    var starti = output.pno * output.pageSize;
    output.products = result.slice(starti, starti + output.pageSize);
    res.send(output);
    res.end();
  })
})

// 未开通
router.get("/multipleChoice", (req, res) => {
  var uid = req.query.uid;
  var kwords = decodeURIComponent(req.query.kwords);
  var output = {
    pno: 0,
    pageSize: 8,
    count: 0,
    pageCount: 0,
    products: []
  }
  if (req.query.pno !== undefined) {
    output.pno = parseInt(req.query.pno);
  }
  kwords.forEach((val, i, arr) => {
    arr[i] = `%${val}%`;
  });
  var arr = [];
  for (var kw of kwords) {
    arr.push(` ( title like ? or subtitle like ? or resolution like ? or cpu like ? ) `);
  }
  var where = "WHERE " + arr.join(" OR ");
  var sql = "select * from le_laptop " + where;
  var kw = [];
  for (var kws of kwords) {
    for (var i = 0; i < 4; i++) {
      kw.push(kws);
    }
  }
  res.send("暂未开通")
})

module.exports = router;
