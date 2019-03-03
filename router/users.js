const express = require("express");
const router = express.Router();
const pool = require("../pool");

// 登录
router.post("/signin", (req, res) => {
  var uname = req.body.uname;
  var upwd = req.body.upwd;
  var sql = "SELECT * FROM le_user WHERE uname=? and upwd=?";
  pool.query(sql, [uname, upwd], (err, result) => {
    if (err) throw err;
    if (result.length == 1) {
      // express-session
      req.session.uname = uname;
      req.session.uid = result[0].uid;
      // console.log(`登录项——成功，uid：${req.session.uid}`);
      res.send({ ok: 1, msg: '登陆成功', session: req.session });
    } else {
      res.send({ ok: 0, msg: "用户名或密码错误！" })
    }
    res.end();
  })
})

// 登出
router.get("/signout", (req, res) => {
  req.session.uid = undefined;
  // console.log(`登出项——成功，uid：${req.session.uid}`)
  res.send({ ok: 1, msg: "登出成功" })
  res.end();
})

//用户注册路由
router.post('/reg', function (req, res) {
  //接受post的请求数据
  var obj = req.body;
  var $upwd = obj.upwd;
  //判断密码是否为空
  if ($upwd == '') {
    res.send({ code: 401, msg: 'upwd required' });
    return;//阻止程序继续往后执行
  }
  var $phone = obj.phone;
  if (!$phone) {
    res.send({ code: 402, msg: 'phone required' });
    return;
  }
  // 检查是否已有该用户名

  //把用户信息插入到数据库
  pool.query('INSERT INTO le_user VALUES(NULL,NULL,?,NULL,?,NULL,NULL,0)', [$upwd, $phone], function (err, result) {
    if (err) throw err;
    //判断affectedRows是否大于0
    // console.log(`新用户注册项， ${result.affectedRows} 大于0时，成功`)
    if (result.affectedRows > 0) {
      res.send({ code: 200, msg: 'reg success' });
    } else {
      res.send({ code: 400, msg: 'reg err' });
    }
  });
});

// 查询用户信息
router.get('/sel', function (req, res) {
  var uid = req.query.uid;
  if (!uid) {
    res.send({ code: 401, msg: "用户序号错误" });
    return;
  }
  // console.log(uid)
  var sql = "select * from le_user where uid=?";
  pool.query(sql, [uid], (err, result) => {
    if (err) throw err;
    // console.log(result[0])
    // console.log(`查询用户信息项，${result[0]}1`);
    res.send(result[0]);
    res.end();
  })
})

// 修改用户个人信息
router.post('/update', function (req, res) {
  var obj = req.body;
  var $uid = obj.uid;
  var $nickname = obj.nickname;
  var $gender = Number(obj.gender);
  var $birthday = obj.birthday;
  var $user_name = obj.user_name;
  var $habitat = obj.habitat;
  var $address = obj.address;
  var $phone = obj.phone;
  var $avatar = obj.avatar;
  var $upwd = req.body.upwd;
  // console.log("$upwd:" + $upwd)
  // console.log("$uid:" + $uid)
  if ($upwd) {    // 如果只有upwd修改
    var sql = "update le_user set upwd=? where uid=?";
    pool.query(sql, [$upwd, $uid], (err, result) => {
      if (err) throw err;
      // console.log(`修改用户个人信息项——只修改用户密码， ${result.affectedRow} 大于0时，修改成功`)
      if (result.affectedRows > 0) {
        res.send({ code: 200, msg: '修改成功' });
      } else {
        res.send({ code: 301, msg: '修改失败' });
      }
    })
  }
  var sql = "UPDATE le_user set nickname =?,gender =? ,birthday =?, habitat =?,phone = ? , address = ? , user_name = ? where uid =?";
  pool.query(sql, [$nickname, $gender, $birthday, $habitat, $phone, $address, $user_name, $uid], (err, result) => {
    if (err) throw err;
    // console.log(`修改用户个人信息项——除 密码 及 头像 ， ${result.affectedRows} 大于0时成功`)
    if (result.affectedRows > 0) {
      res.send({ code: 200, msg: '修改成功' });
    } else {
      res.send({ code: 301, msg: '修改失败' });
    }
  })
});

// 查询用户收件人地址
router.get("/seladdress", (req, res) => {
  var uid = req.query.uid;
  if (!uid) {
    res.send({ code: 401, msg: "用户序号错误" });
    return;
  }
  // 查询是否有未删除的收件人信息
  var sql = "select * from le_receiver_address where is_del!=1 and is_checked!=1 and uid=?";
  pool.query(sql, [uid], (err, result) => {
    if (err) throw err;
    // console.log(`查询是否有未删除的收件人信息项——判断是否有未被删除的收件人信息，其信息数量为：${result.length}`)
    if (result.length > 0) {    // 如果有未删除的收件人数据
      // 查询未删除的收件人中是否有默认地址的收件人
      var a = [];
      for (var i = 0; i < result.length; i++) {
        a.push(result[i].is_default);
      }
      // console.log(a)
      // console.log(a.indexOf(1, 0))
      if (a.indexOf(1, 0) == -1) {   // ，没有默认的地址数据
        // 设置查询结果中的第一条数据为 is_default=1 但已有的不改变
        var sql = "UPDATE le_receiver_address SET is_default=1 WHERE is_del!=1 and is_checked!=1 and uid=? limit 1";
        pool.query(sql, [uid], (err, result) => {
          if (err) throw err;
          // console.log(`查询是否有未删除的收件人信息项——若没有默认地址，则修改第一条地址信息为默认地址 ，若result.changedRows：${result.changedRows} 大于0时，修改成功`)
          if (result.changedRows > 0) {    // 修改成功
            var sql = "select * from le_receiver_address where is_del!=1 and is_checked!=1 and uid=?";
            pool.query(sql, [uid], (err, result) => {
              if (err) throw err;
              // console.log(`查询是否有未删除的收件人信息——搜索出修改第一条为默认地址后的所有收件人地址，数量为： ${result.length}`)
              res.send({ result, code: 1, msg: "该用户有收货地址" });
              res.end();
            })
          } else {
            res.send({ code: 2, msg: "该用户有收货地址，但设置第一条已有地址为默认地址失败" });
            res.end();
          }
        })
      } else {    // 有默认的地址信息
        res.send({ result, code: 1, msg: "该用户有收货地址" });
        res.end();
      }

    } else {    // 该用户没有未删除的收件人数据
      res.send({ code: 0, msg: "该用户没有保存收货地址" });
      res.end();
    }
  })
})

// 建立新的收件人地址
// 修改已有的收件人地址
router.post("/address", function (req, res) {
  var uid = req.body.uid;
  var receiver = req.body.receiver;
  var province = req.body.province;
  var city = req.body.city;
  var county = req.body.county;
  var address = req.body.address;
  var cellphone = req.body.cellphone;
  var fixedphone = req.body.fixedphone;
  var email = req.body.email;
  var is_default = req.body.is_default;
  var aid = req.body.aid;
  
  if (aid == undefined) {   // 没有aid表示没有对应的收件人信息
    var sql = "select * from le_receiver_address where is_del!=1 and is_checked!=1 and uid=?"
    pool.query(sql, [uid], (err, result) => {
      if (err) throw err;
      console.log(`修改/建立收件人地址——如果没有收件人信息————查询该用户现有收件人地址，数量为：${result.length}`)
      if (result.length > 0) {    // 如果已经有地址
        if (is_default == "on") {   // 如果新增地址设为默认地址
          var sql = "update le_receiver_address set is_default=0 where is_del!=1 and is_checked!=1 and uid=?"
          pool.query(sql, [uid], (err, result) => {   // 将别的is_delfault设为0
            if (err) throw err;
            // console.log(`修改/建立收件人地址——如果没有收件人信息——若设置为默认地址，则将其余未删除的收件人地址修改为非默认地址`)
            // console.log(`修改/建立收件人地址——如果没有收件人信息——若设置为默认地址，新建为默认地址的收件人地址`)
            is_default = 1;
            insert_address();   // 建立新的地址
          })
        } else {
          // console.log(`修改/建立收件人地址——如果没有收件人信息——若设置为非默认地址，则新建非默认收件人地址`)
          insert_address();   // 建立新的地址
        }
      } else {    // 如果之前没有地址
        // console.log(`修改/建立收件人地址——如果没有收件人信息——若之前没有地址，则新建设置为默认地址的收件人地址`)
        insert_address(1);   // 建立新的地址
      }
    })
  } else {    // 有aid表示有对应的收件人信息
    //筛选是否有默认地址
    var sql = "select is_default from le_receiver_address where is_del!=1 and is_checked!=1 and uid=?"
    pool.query(sql, [uid], (err, result) => {
      if (err) throw err;
      var a = [];
      for (var i = 0; i < result.length; i++) {
        a.push(result[i].is_default);
      }
      // console.log(`修改/建立收件人地址——如果有收件人信息——筛选是否有默认地址，如果${a.indexOf(1, 0)}不等于-1，表示有默认地址`)
      if (a.indexOf(1, 0) != -1) {
        if (is_default == 'on') {   // 设为默认地址
          // 将其余有可能是默认地址的改为非默认地址
          var sql = "update le_receiver_address set is_default=0 where is_del=0 and uid=?";
          pool.query(sql, [uid], (err, result) => {
            if (err) throw result;
            // console.log(`修改/建立收件人地址——如果有收件人信息——如果有默认地址——且本次设置为默认地址时，则将其余地址修改为非默认地址`)
            update_address(1);
          })
        } else {    // 设置为非默认地址
          update_address(0);
        }
      } else {    // 如果没有默认地址
        // console.log(`修改/建立收件人地址——如果有收件人信息——筛选是否有默认地址，如果${a.indexOf(1, 0)}等于-1，表示没有默认地址，则自动修改为默认地址`)
        update_address(1);
      }
    })
  }



  // 构造函数——修改地址
  function update_address(is_default) {
    var sql = `update le_receiver_address set is_default=${is_default}, receiver=?, province=?, city=?, county=?, address=?, cellphone=?, fixedphone=?, email=? where aid=?`;
    pool.query(sql, [receiver, province, city, county, address, cellphone, fixedphone, email, aid], (err, result) => {
      if (err) throw err;
      // console.log(`修改收件人地址构造函数——is_default设置为：${is_default}——若为1则为默认，若为0则非默认`)
      if (result.changedRows > 0) {
        res.send({ code: 3, msg: "新地址保存成功" });
        res.end();
      } else {
        res.send({ code: 0, msg: "新地址保存失败" });
      }
    })
  }
  // 构造函数——建立新的地址
  function insert_address() {
    var sql = "INSERT INTO le_receiver_address VALUES (NULL,?,?,?,?,?,?,?,?,?,'',?,'')";
    pool.query(sql, [uid, receiver, province, city, county, address, cellphone, fixedphone, email, is_default], (err, result) => {
      if (err) throw err;
      res.send({ code: 1, msg: "新的收件地址建立成功" });
      res.end();
    })
  }
})

// 删除收件人信息
router.get("/order_del", function (req, res) {
  var aid = req.query.aid;
  var sql = "UPDATE `le_receiver_address` SET `is_del`=1 WHERE aid=?";
  pool.query(sql, [aid], (err, result) => {
    if (err) throw err;
    // console.log(`删除收件人信息项——若result.changedRows：${result.changedRows}大于0，则修改成功`)
    if (result.changedRows > 0) {
      res.send({ code: 1, msg: "收件人删除成功" })
      res.end();
    } else {
      res.send({ code: 0, msg: "收件人删除失败" })
      res.end();
    }
  })
})




module.exports = router;