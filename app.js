// 1:加载模块 express  pool
const express = require('express')
const bodyParser = require('body-parser')
const pool = require('./pool')
const session = require('express-session')
const cookieParser = require('cookie-parser')
// 引入路由模块
const index = require('./router/index')
const details = require('./router/details')
const users = require('./router/users')
const products = require('./router/products')
const cart = require('./router/cart')

// 2:创建express对象
var app = express()
// 2.1:加载跨域访问组件
const cors = require('cors')
// 2.2:配置允许脚手架访问程序
app.use(
  cors({
    origin: [
      'http://127.0.0.1:3000',
      'http://localhost:3000',
      'http://127.0.0.1:5500',
      'http://localhost:5500'
    ],
    credentials: true
  })
)
// 3:指定监听端口3000
app.listen(3000, function() {
  console.log('启动服务器')
})
//使用body-parser中间件
app.use(bodyParser.urlencoded({ extended: false }))
// 4:指定静态目录  publice
app.use(express.static(__dirname + '../lenovo_app'))
// 5:GET  /imagelist
app.use(cookieParser())
app.use(
  session({
    //  express-session配置文件
    secret: '128位随机字符',
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 80000 }
  })
)

// 使用路由器来管理路由
app.use('/index', index)
app.use('/details', details)
app.use('/users', users)
app.use('/cart', cart)
app.use('/products', products)
