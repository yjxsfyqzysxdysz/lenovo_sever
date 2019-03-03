// 专门支持详情页的服务端接口

const express = require("express");
const router = express.Router();
const pool = require("../pool");

//测试: http://localhost:3000/details?lid=5
router.get("/", (req, res) => {
  var lid = req.query.lid;
  if (lid !== undefined && lid <= 20) {    // 如果有lid时
    var output = {
      product: {/*详细信息*/ },
      specs: [/*{规格},{规格},{规格}*/],
      pics: [/*{图片},{图片},{图片}*/],
      detail_pics: [],
      layout: {},
      family: [],
      specification: []
    };
    //查询商品对象
    var sql = "SELECT * FROM le_laptop WHERE lid=?";
    // 都是异步操作
    pool.query(sql, [lid], (err, result) => { //异步！
      if (err) throw err;
      output.product = result[0];   // 返回的是唯一结果集的对象
      //查询规格列表
      var fid = output.product.fid;
      var sql = "SELECT lid,spec FROM le_laptop WHERE fid=?";
      pool.query(sql, [fid], (err, result) => { //异步！
        if (err) throw err;
        output.specs = result;
        //查询图片列表
        var sql = "SELECT * FROM le_laptop_pic WHERE lid=?";
        pool.query(sql, [lid], (err, result) => { //异步！
          if (err) throw err;
          output.pics = result;
          //查询详情页的详情彩图列表
          var sql = "SELECT * FROM le_laptop_detail WHERE lid=?";
          pool.query(sql, [lid], (err, result) => {
            if (err) throw err;
            output.detail_pics = result;
            // 查询商品详情页配置信息列表
            var sql = "SELECT * FROM le_laptop_layout WHERE lid=?";
            pool.query(sql, [lid], (err, result) => {
              if (err) throw err;
              output.layout = result[0];
              // 查询系列表内容
              var sql = "SELECT * FROM le_laptop_family WHERE fid=?";
              pool.query(sql, [fid], (err, result) => {
                if (err) throw err;
                output.family = result[0];
                var sql = "SELECT * FROM le_laptop_specification";
                pool.query(sql, [], (err, result) => {
                  if (err) throw err;
                  output.specification = result;

                  res.send(output);
                  res.end();

                });
              });
            });
          });
        });
      });
    });
  }
})


// 筛选
// 未完成
/********************************************************************* */
router.get("/", (req, res) => {
  var lid = req.query.lid,
    fid = req.query.fid,
    condition_a = req.query.condition_a,
    condition_b = req.query.condition_b,
    condition_c = req.query.condition_c,
    output2 = {};
  var sql = "SELECT * FROM le_laptop_specification WHERE ";
  pool.query(sql, [], (err, result) => {
    if (err) throw err;
    output2.specification = result;




    res.send(output);
  })

})

module.exports = router;