const express = require("express");
const router = express.Router();
const pool = require("../pool");

// 页面载入时，需要默认加载的数据
router.get("/sel", (req, res) => {
  var uid = req.query.uid;
  if (!uid) {
    res.send({ code: 401, msg: "用户序号错误" });
    return;
  }
  var output = {
    shopping_trolley: [],
    product: [],
  }
  var a = 0;
  var sql = "select * from le_shoppingcart_item where is_del=0 and is_checked=0 and uid=? order by is_del";
  pool.query(sql, [uid], (err, result) => {
    if (err) throw err;
    output.shopping_trolley = result; // 将返回的数据导入output的shopping_trolley中
    // 查询购物车中的商品信息
    var sql = "select * from le_laptop where lid=?";
    for (var i = 0; i < output.shopping_trolley.length; i++) {
      var lid = output.shopping_trolley[i].lid;
      pool.query(sql, [lid], (err, result) => {
        if (err) throw err;
        output.product.push(result[0]);
        a++; // 避免异步，输出多次send的问题
        if (a == output.shopping_trolley.length) {
          res.send(output);
          res.end();
        }
      })
    }
  })
})

// 搜索购物车商品的数量
router.get("/sel_shoppingcart_item", (req, res) => {
  var uid = req.query.uid;
  if (!uid) {
    res.send({ code: 401, msg: "用户序号错误" });
    return;
  }
  var sql = "select * from le_shoppingcart_item where uid=? and is_checked=0 and is_del!=1";
  pool.query(sql, [uid], (err, result) => {
    if (err) throw err;
    res.send(result);
    res.end();
  })
})

// 删除任意一个或多个商品
router.get("/del", (req, res) => {
  var iid = req.query.iid;
  var sql = "UPDATE le_shoppingcart_item SET is_del=1 WHERE iid=?";
  var a = 0;
  for (var i = 0; i < iid.length; i++) {
    pool.query(sql, [iid[i]], (err, result) => {
      if (err) throw err;
      a++; // 避免异步，输出多次send的问题
      if (a == iid.length) {
        if (result.affectedRows > 0) {
          res.send({ code: 1, msg: "删除成功" });
          res.end();
        } else {
          res.send({ code: 0, msg: "删除失败" });
          res.end();
        }
      }
    })
  }
})

// 修改商品数量
router.post("/amount", (req, res) => {
  var count = req.body.count;
  var iid = req.body.iid;
  var lid = req.body.lid;
  var sql = "select inventory from le_laptop where lid=?";
  pool.query(sql, [lid], (err, result) => {
    if (err) throw err;
    if (result[0].inventory >= count) {   // 判断，如果购买数量小于等于存量，则可修改
      var sql = "UPDATE `le_shoppingcart_item` SET count=? WHERE iid=?";
      pool.query(sql, [count, iid], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {
          res.send({ ok: 1, msg: "修改成功" });
          res.end();
        } else {
          res.send({ ok: 0, msg: "修改失败" });
          res.end();
        }
      })
    } else {    //  若购买量大于时，则返回信息
      res.send({ ok: 1, msg: "商品存货不足，请重新选择购买数量" })
      res.end();
    }
  })
})

// 加入购物车
router.get("/add", (req, res) => {
  var lid = req.query.lid;
  var count = req.query.count;
  var uid = req.query.uid;
  if (uid !== undefined && lid != undefined && count != 0) {
    var sql = "select * from le_shoppingcart_item where uid=? and lid=? and is_del!=1 and is_checked!=1";
    pool.query(sql, [uid, lid], (err, result) => {
      if (err) throw err;
      if (result[0] == undefined) {     // 如果没有符合该条件的数据“列”就新建一个
        var sql = "insert into le_shoppingcart_item values (null,?,?,?,'','');";
        pool.query(sql, [uid, lid, count], (err, result) => {
          if (err) throw err;
          if (result.affectedRows > 0) {
            res.send({ ok: 1, msg: "商品加入成功" });
            res.end();
          } else {
            res.send({ ok: 0, msg: "商品加入失败" });
            res.end();
          }
        })
      } else {  // 如果已经存在符合该uid用户，lid商品的item，就修改
        var sql = "update le_shoppingcart_item set count=count+? where uid=? and lid=?";
        pool.query(sql, [count, uid, lid], (err, result) => {
          if (err) throw err;
          res.send({ ok: 1, msg: "商品加入成功" });
          res.end();
        })
      }
    })
  } else {
    res.send({ ok: 0, msg: "请先登陆！" });
  }
})

// 在购物车点击立即购买后，跳转至结算中心
router.get("/indent", (req, res) => {
  var lid = req.query.lid;
  var uid = req.query.uid;
  var iid = '';
  var count = '';
  if (uid !== undefined && lid !== undefined) {      // 点击立即购买，将自动生成一个新的订单，若进入订单页面后，将该商品标记status为1若不继续下去，则标记status为6（取消），若继续则标记status为2（等待付款）
    // 先通过查表查询购物车表单中的对应商品数量count

    var a = 0;
    var sql = "select iid,count from le_shoppingcart_item where is_del=0 and uid=? and lid=? and is_checked=0";
    for (var i = 0; i < lid.length; i++) {
      pool.query(sql, [uid, lid[i]], (err, result) => {
        if (err) throw err;
        iid += result[0].iid + ',';
        count += result[0].count + ',';
        a++; // 避免异步，输出多次send的问题
        if (a == lid.length) {
          var _lid = lid.toString() + ',';
          var sql = "INSERT INTO le_order (`oid`, `iid`, `uid`, `lid`, `count`, `status`,`aid`,`order_time`,`pay_time`,`deliver_time`,`received_time`,`price`) VALUES (NULL,?,?,?,?,1,'','','','','','')";
          pool.query(sql, [iid, uid, _lid, count], (err, result) => {
            if (err) throw err;
            // console.log(result)
            if (result.affectedRows > 0) {
              res.send({ ok: 1, msg: "订单建立成功" });
              res.end();
            } else {
              res.send({ ok: 0, msg: "订单建立失败" });
              res.end();
            }
          })
        }
      })
    }
    /*
    var a = 0;
    for (var i = 0; i < lid.length; i++) {
      pool.query(sql, [uid, lid[i], uid, lid[i], uid, lid[i]], (err, result) => {     // 异步
        if (err) throw err;
        a++; // 避免异步，输出多次send的问题
        if (a == lid.length) {
          if (result.affectedRows > 0) {
            res.send({ ok: 1, msg: "订单建立成功" });
            res.end();
          } else {
            res.send({ ok: 0, msg: "订单建立失败" });
            res.end();
          }
        }
      })
    }
    */
  } else {
    res.send({ ok: 0, msg: "请先登陆！" });
  }
})

// 在详情页点击立即购买
router.get("/lijg", (req, res) => {
  var lid = req.query.lid + ',';
  var uid = req.query.uid;
  var count = req.query.count + ',';
  if (!uid) {
    res.send({ code: 401, msg: "用户序号错误" });
    return;
  }
  // 封装用户订单表
  function insert_order() {
    var sql = "select iid from le_shoppingcart_item where is_del=0 and uid=? and lid=? AND is_checked=0";
    pool.query(sql, [uid, lid], (err, result) => {
      if (err) throw err;
      if (result.length > 0) {
        var sql = "INSERT INTO le_order (`oid`, `iid`, `uid`, `lid`, `aid`, `count`, `price`, `status`, `order_time`, `pay_time`, `deliver_time`, `received_time`) VALUES (NULL,?,?,?,'',?,'',1,'','','','')";
        pool.query(sql, [result[0].iid, uid, lid, count], (err, result) => {
          if (err) throw err;
          if (result.affectedRows > 0) {  // 建立-用户订单表-成功
            res.send({ code: 1, msg: "用户订单表建立成功" });
            res.end();
          } else {
            res.send({ code: 0, msg: "在商品详情页面将购物车中失败" });
            res.end();
          }
        })
      } else {
        res.send({ code: 0, msg: "在购物车表查询iid失败" });
        res.end();
      }
    })
  }

  // 点击立即购买后，将建立购物车表（le_shoppingcart_item）和用户订单表（le_order）
  // 先搜索购物车表（le_shoppingcart_item），如果没有就建立，如果有，就改数量（count）
  var sql = "select * from le_shoppingcart_item where uid=? and lid=? and is_del!=1 and is_checked=0;"
  pool.query(sql, [uid, lid], (err, result) => {
    if (err) throw err;
    if (result.length == 0) {   // 如果-购物车表-中没有就建立
      var sql = "INSERT INTO le_shoppingcart_item VALUE (NULL,?,?,?,'','')";
      pool.query(sql, [uid, lid, count], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {  // 建立-用户订单表-成功
          // 用户订单表
          insert_order();
        } else {
          res.send({ code: 0, msg: "在商品详情页面将购物车中失败" });
          res.end();
        }
      })
    } else {    //  如果-购物车表-有，就修改数量，在提交至订单表（le_order）中
      var sql = "update le_shoppingcart_item set count=? where uid=? and lid=? and is_del!=1 and is_checked=0";
      pool.query(sql, [count, uid, lid], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {
          // 用户订单表
          insert_order();
        } else {
          res.send({ code: 0, msg: "在商品详情页面将购物车中已有的商品以详情页的数量修改失败" });
          res.end();
        }
      })
    }
  })
})

// 在结算中心，获取商品信息
router.get("/sel_order", (req, res) => {
  var uid = req.query.uid;
  if (uid != undefined) {
    var output = {
      order: {},
      laptop: [],
    };
    var sql = "select * from le_order where status=1 and uid=?";
    pool.query(sql, [uid], (err, result) => {
      if (err) throw err;
      output.order = result[0];
      var lid = output.order.lid.split(',');
      // if(output.order.lid.indexOf(',',0)!=-1){
      lid.pop();
      // }
      var a = 0;
      var sql = "select * from le_laptop where lid=? ";
      for (var i = 0; i < lid.length; i++) {
        pool.query(sql, [lid[i]], (err, result) => {
          if (err) throw err;
          output.laptop.push(result[0]);
          a++;
          if (a == lid.length) {
            res.send(output);
            res.end();
          }
        })
      }
    })

  } else {
    res.send({ ok: 0, msg: "请先登陆！" });
  }
})

// 当支付超时时，页面返回上一页，结算中心
// le_order的status将边为0
router.get("/update_shoppingcart_ischecked", (req, res) => {
  var oid = req.query.oid;
  var aid = req.query.aid;
  var iid = req.query.iid;

  var a = 0;
  var sql = "update le_receiver_address set is_del=1 where aid=?";
  pool.query(sql, [aid], (err, result) => {
    if (err) throw err;
    var sql = "update le_shoppingcart_item set is_checked=0 where iid=?";
    for (var i = 0; i < iid.length; i++) {
      pool.query(sql, [iid[i]], (err, result) => {
        if (err) throw err;
        var sql = "update le_order set aid=NULL , status=1 , order_time=0 where oid=?";
        pool.query(sql, [oid[i]], (err, result) => {
          if (err) throw err;
          a++;
          if (a == iid.length) {
            if (result.affectedRows > 0) {
              res.send({ code: 1, msg: "修改成功" });
              res.end();
            } else {
              res.send({ code: 0, msg: "修改失败" });
              res.end();
            }
          }
        })
      })
    }
  })
})

// 修改 用户订单 数据表 商品状态status
router.get("/update_order", (req, res) => {
  var oid = req.query.oid;
  var status = req.query.status;
  var sql = `update le_order set status=${status} where oid=?`;
  var a = 0;
  pool.query(sql, [oid], (err, result) => {
    if (err) throw err;
    if (result.affectedRows > 0) {
      res.send({ code: 1, msg: `订单提交成功,status状态修改为:${status}` });
      res.end();
    } else {
      res.send({ code: 0, msg: "订单提交失败" });
      res.end();
    }
  })
})

// 结算中心，点击提交————>支付页面
router.get("/submit_order", (req, res) => {
  var oid = req.query.oid;
  var aid = req.query.aid;
  var price = req.query.price;
  var order_time = new Date().getTime();
  var a = 0;
  // 复制了当前标粉色的地址表
  var sql = `insert into le_receiver_address(uid, receiver, province, city, county, address, cellphone, fixedphone, email, is_del, is_default, is_checked) select uid, receiver, province, city, county, address, cellphone, fixedphone, email, is_del, is_default, is_checked FROM le_receiver_address where aid=?; `;
  pool.query(sql, [aid, aid], (err, result) => {
    if (err) throw err;
    var sql = `UPDATE le_receiver_address set is_checked=1 WHERE aid=?;`;
    pool.query(sql, [aid], (err, result) => {
      if (err) throw err;
      var _price = price.toString() + ',';
      var sql = 'update le_order set aid=? ,price=? ,order_time=? ,status=3 where oid=?;'
      pool.query(sql, [aid, _price, order_time, oid], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {
          // 修改购物车条目中的is_checked 项
          // 查找购物车的iid
          var sql = "select iid from le_order where oid=?"
          pool.query(sql, [oid], (err, result) => {
            if (err) throw err;
            if(result[0].iid.indexOf(",")!=-1){   // 如果只有一个商品
              var iid = result[0].iid.split(",");
              iid.pop();
            }else{
              var iid=[];
              iid.push(result[0].iid);
            }
            var sql = "update le_shoppingcart_item set is_checked=1 where iid=?";
            for (var i = 0; i < iid.length; i++) {
              pool.query(sql, [iid[i]], (err, result) => {
                if (err) throw err;
                a++;
                if (a == iid.length) {
                  if (result.affectedRows > 0) {
                    res.send({ code: 1, msg: "修改成功" });
                    res.end();
                  } else {
                    res.send({ code: 0, msg: "修改失败" });
                    res.end();
                  }
                }
              })
            }
          })
        } else {
          res.send({ code: 0, msg: "修改失败" });
          res.end();
        }
      })
    })
  })
})

// 支付页——页面信息获取
router.get("/selorder_detail", (req, res) => {
  var uid = req.query.uid;
  if (!uid) {
    res.send({ code: 401, msg: "用户序号错误" });
    return;
  }
  var output = {
    order: [],
    product: [],
    receiver_address: {},
  };
  var a = 0;
  // 筛选改用户 订单 得到 aid lid
  var sql = "select * from le_order where uid = ? and status=3;";
  pool.query(sql, [uid], (err, result) => {
    if (err) throw err;
    output.order = result[0];
    // 筛选该 订单 的收件人地址   aid
    var sql = "select * from le_receiver_address where aid=?;";
    pool.query(sql, [output.order.aid], (err, result) => {
      if (err) throw err;
      output.receiver_address = result[0];
      // 筛选 商品 lid
      var lid = output.order.lid.split(",");
      lid.pop();
      for (var i = 0; i < lid.length; i++) {
        var sql = "select * from le_laptop where lid=?";
        pool.query(sql, [lid[i]], (err, result) => {
          output.product.push(result[0]);
          a++;
          if (a == lid.length) {
            res.send(output);
            res.end();
          }
        })
      }
    })
  })
})

// 在支付页面——点击确认支付
router.get("/payment", (req, res) => {
  var oid = req.query.oid;
  var pay_time = new Date().getTime();
  var sql = "update le_order set status=4 ,pay_time=? where oid=?;";
  pool.query(sql, [pay_time, oid], (err, result) => {
    if (err) throw err;
    if (result.affectedRows > 0) {
      res.send({ code: 1, msg: "下单成功" });
      res.end();
    } else {
      res.send({ code: 0, msg: "下单失败" });
      res.end();
    }
  })
})

// 在用户主页从服务器获取用户订单信息，并写在页面上
router.get("/userorder", (req, res) => {
  var uid = req.query.uid;
  if (!uid) {
    res.send({ code: 401, msg: "用户序号错误" });
    return;
  }
  var output = {
    order: [],
    laptop: [],
  };
  Array.prototype.distinct = function () {    // 去除重复
    var arr = this, i, j, len = arr.length;
    for (i = 0; i < len; i++) {
      for (j = i + 1; j < len; j++) {
        if (arr[i] == arr[j]) {
          arr.splice(j, 1);
          len--;
          j--;
        }
      }
    }
    return arr;
  };
  var arr=[];
  var sql = "select * from le_order where uid=? and status!=1 and status!=0";
  pool.query(sql, [uid], (err, result) => {
    if (err) throw err;
    output.order = result;
    if (output.order.length == 0) {    // 没有订单
      res.send({ code: 0, msg: "没有status>1的订单" });
      res.end();
    } else {    // 有订单
      var lids = [];
      for (var i = 0; i < output.order.length; i++) { // 遍历每一个表单
        var _lid = output.order[i].lid.split(',');
        _lid.pop();    // 获得每个表单的商品的lid
        for (var j = 0; j < _lid.length; j++) {   // 遍历每个表单的每个商品
          lids.push(_lid[j]);
        }
      }
      var lidss=lids.distinct();
      var sql = "select * from le_laptop where lid=?";
      var a = 0;
      for (var lid of lidss) {
        pool.query(sql, [lid], (err, result) => {
          if (err) throw err;
          a++;
          output.laptop.push(result[0]);
          if (a == lidss.length) {
            res.send({ code: 1, output });
            res.end();
          }
        })
      }
    }
  })
})

module.exports = router;