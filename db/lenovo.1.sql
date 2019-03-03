SET NAMES UTF8;
DROP DATABASE IF EXISTS le;
CREATE DATABASE le CHARSET=UTF8;
USE le;

/**笔记本电脑型号家族**/
CREATE TABLE le_laptop_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,
  fname  VARCHAR(32),                   #系列名
  module_a TEXT(500),                #颜色/尺寸
  module_b TEXT(500),                #处理器/操作系统
  module_c TEXT(500)                #内存/硬盘/显卡
);

/**笔记本电脑**/
CREATE TABLE le_laptop(
  lid INT PRIMARY KEY AUTO_INCREMENT,
  fid INT,              #所属型号家族编号
  title VARCHAR(128),         #主标题
  subtitle VARCHAR(128),      #副标题
  price DECIMAL(10,2),        #价格
  promise VARCHAR(64),        #服务承诺
  spec VARCHAR(64),           #规格/颜色
  os VARCHAR(32),             #操作系统
  memory VARCHAR(32),         #内存容量
  resolution VARCHAR(32),     #分辨率
  video_card VARCHAR(32),     #显卡型号
  cpu VARCHAR(32),            #处理器
  video_memory VARCHAR(32),   #显存容量
  disk VARCHAR(32),           #硬盘容量及类型
  photo VARCHAR(128),         #图片
  shelf_time BIGINT,          #上架时间
  inventory INT,              #商品存货
  sold_count INT,             #已售出的数量
  is_onsale BOOLEAN           #是否促销中
);

/**笔记本电脑图片**/
CREATE TABLE le_laptop_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  lid INT,                    #笔记本电脑编号
  md VARCHAR(128),            #中图片路径
  lg VARCHAR(128)             #大图片路径
);

/**商品详情页的详情彩图**/
CREATE TABLE le_laptop_detail(
  ldid INT PRIMARY KEY AUTO_INCREMENT,
  lid INT,                    #笔记本电脑编号
  mg VARCHAR(128)             #图片路径
);

/**商品详情页配置信息**/
CREATE TABLE le_laptop_layout(
  llid INT PRIMARY KEY AUTO_INCREMENT,    #配置序号
  lid INT,                                #笔记本电脑编号
  cpu_name VARCHAR(32),                   #CPU
  cpu_type VARCHAR(32),                   #CPU型号
  cpu_hz VARCHAR(32),                     #CPU主频
  cpu_num   VARCHAR(32),                  #核心数
  os  VARCHAR(32),                        #操作系统
  screen_size VARCHAR(32),                #屏幕尺寸
  screen_type VARCHAR(32),                #屏幕类型
  memory_space  VARCHAR(32),              #内存容量
  memory_type VARCHAR(32),                #内存类型
  disk_space  VARCHAR(32),                #硬盘容量
  disk_type VARCHAR(32),                  #硬盘类型
  video_type  VARCHAR(32),                #显卡类型
  video_name  VARCHAR(32),                #显示芯片
  video_space VARCHAR(32),                #显存容量
  cd_type VARCHAR(32),                    #光驱类型
  usb_port  VARCHAR(32),                  #USB3.1
  video_port  VARCHAR(32),                #视频接口
  audio_port  VARCHAR(32),                #音频接口
  rj45  VARCHAR(32),                      #RJ45(以太网口)
  type_c  VARCHAR(32),                    #Type-C 接口
  wifi  VARCHAR(32),                      #无线网卡
  blue_tooth  VARCHAR(32),                #蓝牙
  loudspeaker VARCHAR(32),                #扬声器
  mic VARCHAR(32),                        #麦克风
  camera  VARCHAR(32),                    #摄像头
  keyboard  VARCHAR(32),                  #键盘描述
  battery VARCHAR(32),                    #电池
  weight  VARCHAR(32),                    #重量
  size  VARCHAR(32),                      #尺寸
  software  VARCHAR(32)                   #预装软件
);

/**商品详情规格表**/
CREATE TABLE le_laptop_specification(
  lsid INT PRIMARY KEY AUTO_INCREMENT,    #规格表序号
  lid INT,                                #商品序号
  fid INT,                                #系列编号
  condition_a VARCHAR(64),                #颜色/尺寸
  condition_b VARCHAR(64),                #处理器/操作系统
  condition_c VARCHAR(64)                 #内存/硬盘/显卡
);

/**用户信息**/
CREATE TABLE le_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(16),           #用户账号
  nickname VARCHAR(32),        #昵称
  upwd VARCHAR(32),            #密码
  gender INT DEFAULT 0,        #性别  0-保密  1-男  2-女
  birthday VARCHAR(64),        #生日
  user_name VARCHAR(32),       #真实姓名
  habitat VARCHAR(32),         #居住地
  address VARCHAR(32),         #详细地址
  phone VARCHAR(16),           #电话
  email VARCHAR(64),           #邮箱
  avatar VARCHAR(128)          #头像地址
);

/**收货地址信息**/
CREATE TABLE le_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  uid INT,                            #用户编号
  receiver VARCHAR(16),               #接收人姓名
  province VARCHAR(16),               #省
  city VARCHAR(16),                   #市
  county VARCHAR(16),                 #县
  address VARCHAR(128),               #详细地址
  cellphone VARCHAR(16),              #手机
  fixedphone VARCHAR(16),             #固定电话
  email VARCHAR(64),                  #邮箱
  is_del BOOLEAN DEFAULT 0,           #是否删除
  is_checked BOOLEAN DEFAULT 0,       #是否选中
  is_default BOOLEAN DEFAULT 0        #是否为当前用户的默认收货地址
);

/**购物车条目**/
CREATE TABLE le_shoppingcart_item(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  uid INT,                        #用户编号
  lid INT,                        #商品编号
  count INT DEFAULT 1,            #购买数量
  is_checked BOOLEAN DEFAULT 0,   #是否已勾选，确定购买
  is_del BOOLEAN DEFAULT 0        #是否已勾选，确定购买
);

/**用户订单**/
CREATE TABLE le_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  iid VARCHAR(16),
  uid INT,
  lid VARCHAR(16),
  aid VARCHAR(16) DEFAULT 0,
  count VARCHAR(16) DEFAULT 0,      #购买数量
  price VARCHAR(128) DEFAULT 0,      #价格
  status INT DEFAULT 0,   #订单状态  0-建立时默认值  1-去结算  2-下单  3-等待付款 4-等待发货  5-运输中  6-已签收  7-已取消
  order_time BIGINT,      #下单时间
  pay_time BIGINT,        #付款时间
  deliver_time BIGINT,    #发货时间
  received_time BIGINT    #签收时间
)AUTO_INCREMENT=10000000;

/****首页轮播广告商品****/
CREATE TABLE le_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  img VARCHAR(128),
  title VARCHAR(64),
  href VARCHAR(128)
);

/**首页闪购广告商品**/
CREATE TABLE le_index_carousel_seckill(
  sid INT PRIMARY KEY AUTO_INCREMENT,
  lid INT,
  md VARCHAR(128),            #中图片路径
  title VARCHAR(64),
  price DECIMAL(10,2),        #价格
  price_old DECIMAL(10,2),    #价格(旧)
  href VARCHAR(128)
);


/****首页商品****/
CREATE TABLE le_index_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,   #id
  lid INT,
  title VARCHAR(64),                    #标题
  details VARCHAR(128),                 #副标题
  md VARCHAR(128),                      #图片
  price DECIMAL(10,2),                  #价格
  href VARCHAR(128),                    #跳转链接
  seq_recommended TINYINT,              #推荐
  seq_new_arrival TINYINT,              #新品
  seq_top_sale TINYINT                  #在售
);


/*******************/
/******数据导入******/
/*******************/
/**电脑系列**/
INSERT INTO le_laptop_family VALUES
(NULL,'拯救者','黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版,i7-8750H/Windows 10 家庭中文版','大硬盘/8G/2T+128G SSD/GTX 1050Ti 4G独显,高色域/8G/1T+128G SSD/1050Ti,大硬盘/8G/2T+128G SSD/1050Ti,高色域/8G/1T+128G SSD/1060,电竞屏/8G/1T+128G SSD/1050Ti,高色域/16G/512G SSD/1060,电竞屏/8G/512G SSD/1060,电竞屏/16G/2T+512G SSD/1060,电竞屏/8G/512G SSD/1050Ti,高色域/8G/512G SSD/1060,高色域/8G/512G SSD/1050Ti'),
(NULL,'小新','灰色/15.6英寸,黑色/15.6英寸,金色/15.6英寸','i7-8550U/Windows 10 家庭中文版,i5-8250U/Windows 10 家庭中文版,i7-8565U/Windows 10 家庭中文版,i5-8265U/Windows 10 家庭中文版','8G/256G PCle SSD/满血版MX150,8G/256 GPCle SSD/满血版MX150,8G/512G PCle SSD/满血版MX150'),
(NULL,'AIO','','',''),
(NULL,'YOGA','','','');


INSERT INTO le_laptop VALUES
(NULL,2,'小新 Air 13 13.3英寸超轻薄笔记本 高定黑 Different 高定款','i7-8565U/Windows 10 家庭中文版/13.3英寸/16G/512G SSD/GeForce MX150 2G独显/高定黑',7299,'【王嘉尔命名款】Different 高定款','13.3英寸/高定黑','Windows 10 家庭中文版','16G','1920x1080','GeForce MX150','intel i7-8565U','2G','512G SSD','./img/product/example/001.jpg',149123456789,35,192,true),
(NULL,2,'小新 Air 15 15.6英寸超轻薄笔记本 灰色','i5-8265U/Windows 10 家庭中文版/15.6英寸/8G/256G SSD/GeForce MX150 2G独显/灰色',5699,'【选件推荐】联想小新智能键盘，触控板变身数字键盘，新品预约价49元，点击查看》','灰色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','满血版MX150','intel i5-8265U','2G','256G PCle SSD','./img/product/example/002.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000P 15.6英寸游戏笔记本 黑色','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/512G SSD/ GeForce GTX 1060 6G独显/黑色',8299,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','1060','intel i5-8300H','6GB','512G SSD','./img/product/example/003.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 大硬盘 15.6英寸游戏笔记本 黑色','i7-8750H/Windows 10 家庭中文版/15.6英寸/8G/2T+128G SSD/ GeForce GTX 1050Ti 4G独显/黑色',7599,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i7-8750H','4GB','2T+128G SSD','./img/product/example/004.jpg',149123456789,35,192,true),
(NULL,2,'小新 潮7000 13.3英寸轻薄笔记本 花火银','i5-8250U/Windows 10 家庭中文版/13.3英寸/8GB/512G SSD/MX150 2GB独显/花火银',5599,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','花火银/13.3英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA GeForce MX150','intel i5-8250U','2G','512G SSD','./img/product/example/005.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 大硬盘 15.6英寸游戏笔记本','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/2T+128G SSD/GTX 1050Ti 4G独显/黑色',6699,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i5-8300H','4GB','2T+128G SSD','./img/product/example/005.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/1T+128G SSD/ GeForce GTX 1050Ti 4G独显/黑色',6799,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i5-8300H','4GB','1T+128G SSD','./img/product/example/006.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 大硬盘 15.6英寸游戏笔记本 黑色','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/2T+128G SSD/ GeForce GTX 1050Ti 4G独显/黑色',6699,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i5-8300H','4GB','2T+128G SSD','./img/product/example/004.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本 黑色','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/1T+128G SSD/ GeForce GTX 1060 6G独显/黑色',7699,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i5-8300H','4GB','2T+128G SSD','./img/product/example/007.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000P 15.6英寸游戏笔记本 黑色','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/512G SSD/ GeForce GTX 1060 6G独显/黑色',8299,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1060','intel i5-8300H','6GB','512G SSD','./img/product/example/003.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000P 15.6英寸游戏笔记本 黑色','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/512G SSD/ GeForce GTX 1050Ti 4G独显/黑色',6899,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i5-8300H','4GB','512G SSD','./img/product/example/003.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本 黑色','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/512G SSD/ GeForce GTX 1060 6G独显/黑色',7499,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1060','intel i5-8300H','6GB','512G SSD','./img/product/example/008.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本 黑色','i5-8300H/Windows 10 家庭中文版/15.6英寸/8G/512G SSD/ GeForce GTX 1050Ti 4G独显/黑色',6499,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i5-8300H','4GB','512G SSD','./img/product/example/009.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本','i7-8750H/Windows 10 家庭中文版/15.6英寸/8G/1T+128G SSD/ GeForce GTX 1050Ti 4G独显/黑色',7299,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i5-8300H','4GB','1T+128G SSD','./img/product/example/006.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 大硬盘 15.6英寸游戏笔记本 黑色','i7-8750H/Windows 10 家庭中文版/15.6英寸/8G/2T+128G SSD/ GeForce GTX 1050Ti 4G独显/黑色',7599,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i5-8300H','4GB','2T+128G SSD','./img/product/example/007.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本 黑色','i7-8750H/Windows 10 家庭中文版/15.6英寸/8G/1T+128G SSD/ GeForce GTX 1060 6G独显/黑色',8299,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1060','intel i7-8750H','6GB','1T+128G SSD','./img/product/example/007.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本 黑色','i7-8750H/Windows 10 家庭中文版/15.6英寸/16G/512G SSD/ GeForce GTX 1060 6G独显/黑色',9499,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','16G','1920x1080','NVIDIA Geforce GTX 1060','intel i7-8750H','6GB','512G SSD','./img/product/example/003.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000P 15.6英寸游戏笔记本 黑色','i7-8750H/Windows 10 家庭中文版/15.6英寸/8G/512G SSD/ GeForce GTX 1060 6G独显/黑色',8899,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1081','NVIDIA Geforce GTX 1060','intel i7-8750H','6GB','512G SSD','./img/product/example/003.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本 黑色','i7-8750H/Windows 10 家庭中文版/15.6英寸/8G/512G SSD/ GeForce GTX 1060 6G独显/黑色',8299,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1060','intel i7-8750H','6GB','512G SSD','./img/product/example/008.jpg',149123456789,35,192,true),
(NULL,1,'拯救者 Y7000 高色域版 15.6英寸游戏笔记本 黑色','i7-8750H/Windows 10 家庭中文版/15.6英寸/8G/512G SSD/GTX 1050Ti 4G独显/黑色',7299,'【爆款推荐】可调、可折叠全铝散热支架，呵护颈椎、呵护本本，低至149元！点击抢购！','黑色/15.6英寸','Windows 10 家庭中文版','8G','1920x1080','NVIDIA Geforce GTX 1050Ti','intel i7-8750H','4GB','512G SSD','./img/product/example/009.jpg',149123456789,35,192,true);



/**笔记本电脑图片**/
INSERT INTO le_laptop_pic VALUES
(NULL,1,'./img/product/sm/001_1.jpg','./img/product/md/001_1.jpg'),
(NULL,1,'./img/product/sm/001_2.jpg','./img/product/md/001_2.jpg'),
(NULL,1,'./img/product/sm/001_3.jpg','./img/product/md/001_3.jpg'),
(NULL,1,'./img/product/sm/001_4.jpg','./img/product/md/001_4.jpg'),
(NULL,1,'./img/product/sm/001_5.jpg','./img/product/md/001_5.jpg'),
(NULL,1,'./img/product/sm/001_6.jpg','./img/product/md/001_6.jpg'),
(NULL,2,'./img/product/sm/002_1.jpg','./img/product/md/002_1.jpg'),
(NULL,2,'./img/product/sm/002_2.jpg','./img/product/md/002_2.jpg'),
(NULL,2,'./img/product/sm/002_3.jpg','./img/product/md/002_3.jpg'),
(NULL,2,'./img/product/sm/002_4.jpg','./img/product/md/002_4.jpg'),
(NULL,2,'./img/product/sm/002_5.jpg','./img/product/md/002_5.jpg'),
(NULL,2,'./img/product/sm/002_6.jpg','./img/product/md/002_6.jpg'),
(NULL,3,'./img/product/sm/003_1.jpg','./img/product/md/003_1.jpg'),
(NULL,3,'./img/product/sm/003_2.jpg','./img/product/md/003_2.jpg'),
(NULL,3,'./img/product/sm/003_3.jpg','./img/product/md/003_3.jpg'),
(NULL,3,'./img/product/sm/003_4.jpg','./img/product/md/003_4.jpg'),
(NULL,3,'./img/product/sm/003_5.jpg','./img/product/md/003_5.jpg'),
(NULL,3,'./img/product/sm/003_6.jpg','./img/product/md/003_6.jpg'),
(NULL,4,'./img/product/sm/004_1.jpg','./img/product/md/004_1.jpg'),
(NULL,4,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,4,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,4,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,4,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,4,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,5,'./img/product/sm/005_1.jpg','./img/product/md/005_1.jpg'),
(NULL,5,'./img/product/sm/005_2.jpg','./img/product/md/005_2.jpg'),
(NULL,5,'./img/product/sm/005_3.jpg','./img/product/md/005_3.jpg'),
(NULL,5,'./img/product/sm/005_4.jpg','./img/product/md/005_4.jpg'),
(NULL,5,'./img/product/sm/005_5.jpg','./img/product/md/005_5.jpg'),
(NULL,5,'./img/product/sm/005_6.jpg','./img/product/md/005_6.jpg'),
(NULL,6,'./img/product/sm/005_1.jpg','./img/product/md/005_1.jpg'),
(NULL,6,'./img/product/sm/005_2.jpg','./img/product/md/005_2.jpg'),
(NULL,6,'./img/product/sm/005_3.jpg','./img/product/md/005_3.jpg'),
(NULL,6,'./img/product/sm/005_4.jpg','./img/product/md/005_4.jpg'),
(NULL,6,'./img/product/sm/005_5.jpg','./img/product/md/005_5.jpg'),
(NULL,6,'./img/product/sm/005_6.jpg','./img/product/md/005_6.jpg'),
(NULL,7,'./img/product/sm/007_1.jpg','./img/product/md/007_1.jpg'),
(NULL,7,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,7,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,7,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,7,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,7,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,8,'./img/product/sm/004_1.jpg','./img/product/md/004_1.jpg'),
(NULL,8,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,8,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,8,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,8,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,8,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,9,'./img/product/sm/009_1.jpg','./img/product/md/009_1.jpg'),
(NULL,9,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,9,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,9,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,9,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,9,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,10,'./img/product/sm/003_1.jpg','./img/product/md/003_1.jpg'),
(NULL,10,'./img/product/sm/003_2.jpg','./img/product/md/003_2.jpg'),
(NULL,10,'./img/product/sm/003_3.jpg','./img/product/md/003_3.jpg'),
(NULL,10,'./img/product/sm/003_4.jpg','./img/product/md/003_4.jpg'),
(NULL,10,'./img/product/sm/003_5.jpg','./img/product/md/003_5.jpg'),
(NULL,10,'./img/product/sm/003_6.jpg','./img/product/md/003_6.jpg'),
(NULL,11,'./img/product/sm/003_1.jpg','./img/product/md/003_1.jpg'),
(NULL,11,'./img/product/sm/003_2.jpg','./img/product/md/003_2.jpg'),
(NULL,11,'./img/product/sm/003_3.jpg','./img/product/md/003_3.jpg'),
(NULL,11,'./img/product/sm/003_4.jpg','./img/product/md/003_4.jpg'),
(NULL,11,'./img/product/sm/003_5.jpg','./img/product/md/003_5.jpg'),
(NULL,11,'./img/product/sm/003_6.jpg','./img/product/md/003_6.jpg'),
(NULL,12,'./img/product/sm/012_1.jpg','./img/product/md/012_1.jpg'),
(NULL,12,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,12,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,12,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,12,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,12,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,13,'./img/product/sm/013_1.jpg','./img/product/md/013_1.jpg'),
(NULL,13,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,13,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,13,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,13,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,13,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,14,'./img/product/sm/007_1.jpg','./img/product/md/007_1.jpg'),
(NULL,14,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,14,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,14,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,14,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,14,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,15,'./img/product/sm/009_1.jpg','./img/product/md/009_1.jpg'),
(NULL,15,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,15,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,15,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,15,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,15,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,16,'./img/product/sm/009_1.jpg','./img/product/md/009_1.jpg'),
(NULL,16,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,16,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,16,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,16,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,16,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,17,'./img/product/sm/003_1.jpg','./img/product/md/003_1.jpg'),
(NULL,17,'./img/product/sm/003_2.jpg','./img/product/md/003_2.jpg'),
(NULL,17,'./img/product/sm/003_3.jpg','./img/product/md/003_3.jpg'),
(NULL,17,'./img/product/sm/003_4.jpg','./img/product/md/003_4.jpg'),
(NULL,17,'./img/product/sm/003_5.jpg','./img/product/md/003_5.jpg'),
(NULL,17,'./img/product/sm/003_6.jpg','./img/product/md/003_6.jpg'),
(NULL,18,'./img/product/sm/003_1.jpg','./img/product/md/003_1.jpg'),
(NULL,18,'./img/product/sm/003_2.jpg','./img/product/md/003_2.jpg'),
(NULL,18,'./img/product/sm/003_3.jpg','./img/product/md/003_3.jpg'),
(NULL,18,'./img/product/sm/003_4.jpg','./img/product/md/003_4.jpg'),
(NULL,18,'./img/product/sm/003_5.jpg','./img/product/md/003_5.jpg'),
(NULL,18,'./img/product/sm/003_6.jpg','./img/product/md/003_6.jpg'),
(NULL,19,'./img/product/sm/012_1.jpg','./img/product/md/012_1.jpg'),
(NULL,19,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,19,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,19,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,19,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,19,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg'),
(NULL,20,'./img/product/sm/013_1.jpg','./img/product/md/013_1.jpg'),
(NULL,20,'./img/product/sm/004_2.jpg','./img/product/md/004_2.jpg'),
(NULL,20,'./img/product/sm/004_3.jpg','./img/product/md/004_3.jpg'),
(NULL,20,'./img/product/sm/004_4.jpg','./img/product/md/004_4.jpg'),
(NULL,20,'./img/product/sm/004_5.jpg','./img/product/md/004_5.jpg'),
(NULL,20,'./img/product/sm/004_6.jpg','./img/product/md/004_6.jpg');


/****首页商品****/
INSERT INTO le_index_product VALUES
(NULL,1,'小新 Air 13 13.3英寸超轻薄笔记本 高定黑 Different 高定款','Different 高定款','./img/product/example/001.jpg',7299,'./product.html?lid=1',1,1,1),
(NULL,2,'小新 Air 15 15.6英寸超轻薄笔记本 灰色','性能增强版全新第八代处理器','./img/product/example/002.jpg',5699,'./product.html?lid=2',1,1,1),
(NULL,3,'拯救者 Y7000P 15.6英寸游戏笔记本 黑色','电竞屏，1060显卡','./img/product/example/003.jpg',8299,'./product.html?lid=3',1,1,1),
(NULL,4,'拯救者 Y7000 大硬盘 15.6英寸游戏笔记本 黑色','2T双硬盘','./img/product/example/004.jpg',7599,'./product.html?lid=4',1,1,1),
(NULL,5,'小新 潮7000 13.3英寸轻薄笔记本 花火银','高色域，512G SSD','./img/product/example/005.jpg',5599,'./product.html?lid=5',1,1,1),
(NULL,6,'AIO 520C-24ICB23.8英寸一体台式机 黑色','高色域窄边框','./img/list_ad/floor_left_item_1_6.jpg',4299,'',1,1,1),
(NULL,7,'拯救者 刃9000 3代 分体台式机 黑色','2080显卡，水冷散热器','./img/list_ad/floor_left_item_1_7.jpg',15999,'',1,1,1),
(NULL,8,'天逸510Pro 分体台式机 银黑色','免工具拆装','./img/list_ad/floor_left_item_1_8.jpg',4099,'',1,1,1);


/**商品详情页的详情彩图**/
INSERT INTO le_laptop_detail VALUES
(NULL,1,'./img/product/particular/001_01.jpg'),
(NULL,1,'./img/product/particular/001_02.jpg'),
(NULL,1,'./img/product/particular/001_03.jpg'),
(NULL,1,'./img/product/particular/001_04.jpg'),
(NULL,1,'./img/product/particular/001_05.jpg'),
(NULL,1,'./img/product/particular/001_06.jpg'),
(NULL,1,'./img/product/particular/001_07.jpg'),
(NULL,1,'./img/product/particular/001_08.jpg'),
(NULL,1,'./img/product/particular/001_09.jpg'),
(NULL,1,'./img/product/particular/001_10.jpg'),
(NULL,1,'./img/product/particular/001_11.jpg'),
(NULL,1,'./img/product/particular/001_12.jpg'),
(NULL,1,'./img/product/particular/001_13.jpg'),
(NULL,1,'./img/product/particular/001_14.jpg'),
(NULL,1,'./img/product/particular/001_15.jpg'),
(NULL,1,'./img/product/particular/001_16.jpg'),
(NULL,1,'./img/product/particular/001_17.jpg'),
(NULL,1,'./img/product/particular/001_18.jpg'),
(NULL,1,'./img/product/particular/001_19.jpg'),
(NULL,2,'./img/product/particular/002_01.jpg'),
(NULL,2,'./img/product/particular/002_02.jpg'),
(NULL,2,'./img/product/particular/002_03.jpg'),
(NULL,2,'./img/product/particular/002_04.jpg'),
(NULL,2,'./img/product/particular/002_05.jpg'),
(NULL,2,'./img/product/particular/002_06.jpg'),
(NULL,2,'./img/product/particular/002_07.jpg'),
(NULL,2,'./img/product/particular/002_08.jpg'),
(NULL,2,'./img/product/particular/002_09.jpg'),
(NULL,2,'./img/product/particular/002_10.jpg'),
(NULL,2,'./img/product/particular/002_11.jpg'),
(NULL,2,'./img/product/particular/002_12.jpg'),
(NULL,2,'./img/product/particular/002_13.jpg'),
(NULL,3,'./img/product/particular/003_01.jpg'),
(NULL,3,'./img/product/particular/003_02.jpg'),
(NULL,3,'./img/product/particular/003_03.jpg'),
(NULL,3,'./img/product/particular/003_04.jpg'),
(NULL,3,'./img/product/particular/003_05.jpg'),
(NULL,3,'./img/product/particular/003_06.jpg'),
(NULL,3,'./img/product/particular/003_07.jpg'),
(NULL,3,'./img/product/particular/003_08.jpg'),
(NULL,3,'./img/product/particular/003_09.jpg'),
(NULL,3,'./img/product/particular/003_10.jpg'),
(NULL,3,'./img/product/particular/003_11.jpg'),
(NULL,3,'./img/product/particular/003_12.jpg'),
(NULL,3,'./img/product/particular/003_13.jpg'),
(NULL,3,'./img/product/particular/003_14.jpg'),
(NULL,3,'./img/product/particular/003_15.jpg'),
(NULL,3,'./img/product/particular/003_16.jpg'),
(NULL,3,'./img/product/particular/003_17.jpg'),
(NULL,3,'./img/product/particular/003_18.jpg'),
(NULL,3,'./img/product/particular/003_19.jpg'),
(NULL,3,'./img/product/particular/001_20.jpg'),
(NULL,3,'./img/product/particular/001_21.jpg'),
(NULL,3,'./img/product/particular/001_22.jpg'),
(NULL,3,'./img/product/particular/001_23.jpg'),
(NULL,3,'./img/product/particular/001_24.jpg'),
(NULL,3,'./img/product/particular/001_25.jpg'),
(NULL,3,'./img/product/particular/001_26.jpg'),
(NULL,3,'./img/product/particular/001_27.jpg'),
(NULL,3,'./img/product/particular/001_28.jpg'),
(NULL,3,'./img/product/particular/001_29.jpg'),
(NULL,4,'./img/product/particular/004_01.jpg'),
(NULL,4,'./img/product/particular/004_02.jpg'),
(NULL,4,'./img/product/particular/004_03.jpg'),
(NULL,4,'./img/product/particular/004_04.jpg'),
(NULL,4,'./img/product/particular/004_05.jpg'),
(NULL,4,'./img/product/particular/004_06.jpg'),
(NULL,4,'./img/product/particular/004_07.jpg'),
(NULL,4,'./img/product/particular/004_08.jpg'),
(NULL,4,'./img/product/particular/004_09.jpg'),
(NULL,4,'./img/product/particular/004_10.jpg'),
(NULL,4,'./img/product/particular/004_11.jpg'),
(NULL,4,'./img/product/particular/004_12.jpg'),
(NULL,4,'./img/product/particular/004_13.jpg'),
(NULL,4,'./img/product/particular/004_14.jpg'),
(NULL,4,'./img/product/particular/004_15.jpg'),
(NULL,4,'./img/product/particular/004_16.jpg'),
(NULL,4,'./img/product/particular/004_17.jpg'),
(NULL,4,'./img/product/particular/004_18.jpg'),
(NULL,4,'./img/product/particular/004_19.jpg'),
(NULL,4,'./img/product/particular/013_18.jpg'),
(NULL,4,'./img/product/particular/004_21.jpg'),
(NULL,4,'./img/product/particular/004_22.jpg'),
(NULL,4,'./img/product/particular/004_23.jpg'),
(NULL,4,'./img/product/particular/004_24.jpg'),
(NULL,4,'./img/product/particular/004_25.jpg'),
(NULL,4,'./img/product/particular/004_26.jpg'),
(NULL,4,'./img/product/particular/004_27.jpg'),
(NULL,4,'./img/product/particular/004_28.jpg'),
(NULL,4,'./img/product/particular/004_29.jpg'),
(NULL,4,'./img/product/particular/004_30.jpg'),
(NULL,5,'./img/product/particular/005_01.jpg'),
(NULL,5,'./img/product/particular/005_02.jpg'),
(NULL,5,'./img/product/particular/005_03.jpg'),
(NULL,5,'./img/product/particular/005_04.jpg'),
(NULL,5,'./img/product/particular/005_05.jpg'),
(NULL,5,'./img/product/particular/005_06.jpg'),
(NULL,5,'./img/product/particular/005_07.jpg'),
(NULL,5,'./img/product/particular/005_08.jpg'),
(NULL,5,'./img/product/particular/005_09.jpg'),
(NULL,5,'./img/product/particular/005_10.jpg'),
(NULL,5,'./img/product/particular/005_11.jpg'),
(NULL,5,'./img/product/particular/005_12.jpg'),
(NULL,5,'./img/product/particular/005_13.jpg'),
(NULL,5,'./img/product/particular/005_14.jpg'),
(NULL,5,'./img/product/particular/005_15.jpg'),
(NULL,6,'./img/product/particular/005_01.jpg'),
(NULL,6,'./img/product/particular/005_02.jpg'),
(NULL,6,'./img/product/particular/005_03.jpg'),
(NULL,6,'./img/product/particular/005_04.jpg'),
(NULL,6,'./img/product/particular/005_05.jpg'),
(NULL,6,'./img/product/particular/005_06.jpg'),
(NULL,6,'./img/product/particular/005_07.jpg'),
(NULL,6,'./img/product/particular/005_08.jpg'),
(NULL,6,'./img/product/particular/005_09.jpg'),
(NULL,6,'./img/product/particular/005_10.jpg'),
(NULL,6,'./img/product/particular/005_11.jpg'),
(NULL,6,'./img/product/particular/005_12.jpg'),
(NULL,6,'./img/product/particular/005_13.jpg'),
(NULL,6,'./img/product/particular/005_14.jpg'),
(NULL,6,'./img/product/particular/005_15.jpg'),
(NULL,7,'./img/product/particular/007_01.jpg'),
(NULL,7,'./img/product/particular/007_02.jpg'),
(NULL,7,'./img/product/particular/007_03.jpg'),
(NULL,7,'./img/product/particular/004_04.jpg'),
(NULL,7,'./img/product/particular/004_05.jpg'),
(NULL,7,'./img/product/particular/004_06.jpg'),
(NULL,7,'./img/product/particular/007_07.jpg'),
(NULL,7,'./img/product/particular/007_08.jpg'),
(NULL,7,'./img/product/particular/004_09.jpg'),
(NULL,7,'./img/product/particular/004_10.jpg'),
(NULL,7,'./img/product/particular/004_11.jpg'),
(NULL,7,'./img/product/particular/004_12.jpg'),
(NULL,7,'./img/product/particular/004_13.jpg'),
(NULL,7,'./img/product/particular/004_14.jpg'),
(NULL,7,'./img/product/particular/007_15.jpg'),
(NULL,7,'./img/product/particular/004_15.jpg'),
(NULL,7,'./img/product/particular/004_16.jpg'),
(NULL,7,'./img/product/particular/004_17.jpg'),
(NULL,7,'./img/product/particular/004_18.jpg'),
(NULL,7,'./img/product/particular/004_19.jpg'),
(NULL,7,'./img/product/particular/013_18.jpg'),
(NULL,7,'./img/product/particular/004_21.jpg'),
(NULL,7,'./img/product/particular/004_22.jpg'),
(NULL,7,'./img/product/particular/004_23.jpg'),
(NULL,7,'./img/product/particular/004_24.jpg'),
(NULL,7,'./img/product/particular/004_25.jpg'),
(NULL,7,'./img/product/particular/004_26.jpg'),
(NULL,7,'./img/product/particular/004_27.jpg'),
(NULL,7,'./img/product/particular/004_28.jpg'),
(NULL,7,'./img/product/particular/004_29.jpg'),
(NULL,7,'./img/product/particular/004_30.jpg'),
(NULL,8,'./img/product/particular/004_01.jpg'),
(NULL,8,'./img/product/particular/004_02.jpg'),
(NULL,8,'./img/product/particular/004_03.jpg'),
(NULL,8,'./img/product/particular/004_04.jpg'),
(NULL,8,'./img/product/particular/004_05.jpg'),
(NULL,8,'./img/product/particular/004_06.jpg'),
(NULL,8,'./img/product/particular/004_07.jpg'),
(NULL,8,'./img/product/particular/004_08.jpg'),
(NULL,8,'./img/product/particular/004_09.jpg'),
(NULL,8,'./img/product/particular/004_10.jpg'),
(NULL,8,'./img/product/particular/004_11.jpg'),
(NULL,8,'./img/product/particular/004_12.jpg'),
(NULL,8,'./img/product/particular/004_13.jpg'),
(NULL,8,'./img/product/particular/004_14.jpg'),
(NULL,8,'./img/product/particular/004_15.jpg'),
(NULL,8,'./img/product/particular/004_16.jpg'),
(NULL,8,'./img/product/particular/004_17.jpg'),
(NULL,8,'./img/product/particular/004_18.jpg'),
(NULL,8,'./img/product/particular/004_19.jpg'),
(NULL,8,'./img/product/particular/013_18.jpg'),
(NULL,8,'./img/product/particular/004_21.jpg'),
(NULL,8,'./img/product/particular/004_22.jpg'),
(NULL,8,'./img/product/particular/004_23.jpg'),
(NULL,8,'./img/product/particular/004_24.jpg'),
(NULL,8,'./img/product/particular/004_25.jpg'),
(NULL,8,'./img/product/particular/004_26.jpg'),
(NULL,8,'./img/product/particular/004_27.jpg'),
(NULL,8,'./img/product/particular/004_28.jpg'),
(NULL,8,'./img/product/particular/004_29.jpg'),
(NULL,8,'./img/product/particular/004_30.jpg'),
(NULL,9,'./img/product/particular/009_01.jpg'),
(NULL,9,'./img/product/particular/009_02.jpg'),
(NULL,9,'./img/product/particular/009_03.jpg'),
(NULL,9,'./img/product/particular/009_04.jpg'),
(NULL,9,'./img/product/particular/009_05.jpg'),
(NULL,9,'./img/product/particular/009_06.jpg'),
(NULL,9,'./img/product/particular/009_07.jpg'),
(NULL,9,'./img/product/particular/009_08.jpg'),
(NULL,9,'./img/product/particular/009_09.jpg'),
(NULL,9,'./img/product/particular/009_10.jpg'),
(NULL,9,'./img/product/particular/009_11.jpg'),
(NULL,9,'./img/product/particular/009_12.jpg'),
(NULL,9,'./img/product/particular/009_13.jpg'),
(NULL,9,'./img/product/particular/009_14.jpg'),
(NULL,9,'./img/product/particular/009_15.jpg'),
(NULL,9,'./img/product/particular/009_16.jpg'),
(NULL,9,'./img/product/particular/009_17.jpg'),
(NULL,9,'./img/product/particular/009_18.jpg'),
(NULL,9,'./img/product/particular/009_19.jpg'),
(NULL,9,'./img/product/particular/004_24.jpg'),
(NULL,9,'./img/product/particular/009_20.jpg'),
(NULL,9,'./img/product/particular/009_21.jpg'),
(NULL,9,'./img/product/particular/009_22.jpg'),
(NULL,9,'./img/product/particular/009_23.jpg'),
(NULL,9,'./img/product/particular/004_28.jpg'),
(NULL,9,'./img/product/particular/004_29.jpg'),
(NULL,9,'./img/product/particular/004_30.jpg'),
(NULL,10,'./img/product/particular/003_01.jpg'),
(NULL,10,'./img/product/particular/010_02.jpg'),
(NULL,10,'./img/product/particular/003_03.jpg'),
(NULL,10,'./img/product/particular/003_04.jpg'),
(NULL,10,'./img/product/particular/003_05.jpg'),
(NULL,10,'./img/product/particular/003_06.jpg'),
(NULL,10,'./img/product/particular/003_07.jpg'),
(NULL,10,'./img/product/particular/003_08.jpg'),
(NULL,10,'./img/product/particular/003_09.jpg'),
(NULL,10,'./img/product/particular/010_10.jpg'),
(NULL,10,'./img/product/particular/010_11.jpg'),
(NULL,10,'./img/product/particular/003_12.jpg'),
(NULL,10,'./img/product/particular/010_13.jpg'),
(NULL,10,'./img/product/particular/010_14.jpg'),
(NULL,10,'./img/product/particular/003_15.jpg'),
(NULL,10,'./img/product/particular/003_16.jpg'),
(NULL,10,'./img/product/particular/003_17.jpg'),
(NULL,10,'./img/product/particular/003_18.jpg'),
(NULL,10,'./img/product/particular/003_19.jpg'),
(NULL,10,'./img/product/particular/001_20.jpg'),
(NULL,10,'./img/product/particular/001_21.jpg'),
(NULL,10,'./img/product/particular/001_22.jpg'),
(NULL,10,'./img/product/particular/010_23.jpg'),
(NULL,10,'./img/product/particular/004_24.jpg'),
(NULL,10,'./img/product/particular/010_25.jpg'),
(NULL,10,'./img/product/particular/001_25.jpg'),
(NULL,10,'./img/product/particular/001_26.jpg'),
(NULL,10,'./img/product/particular/001_27.jpg'),
(NULL,10,'./img/product/particular/001_28.jpg'),
(NULL,10,'./img/product/particular/010_30.jpg'),
(NULL,11,'./img/product/particular/003_01.jpg'),
(NULL,11,'./img/product/particular/010_02.jpg'),
(NULL,11,'./img/product/particular/003_03.jpg'),
(NULL,11,'./img/product/particular/003_04.jpg'),
(NULL,11,'./img/product/particular/003_05.jpg'),
(NULL,11,'./img/product/particular/003_06.jpg'),
(NULL,11,'./img/product/particular/003_07.jpg'),
(NULL,11,'./img/product/particular/003_08.jpg'),
(NULL,11,'./img/product/particular/003_09.jpg'),
(NULL,11,'./img/product/particular/010_10.jpg'),
(NULL,11,'./img/product/particular/010_11.jpg'),
(NULL,11,'./img/product/particular/003_12.jpg'),
(NULL,11,'./img/product/particular/010_13.jpg'),
(NULL,11,'./img/product/particular/010_14.jpg'),
(NULL,11,'./img/product/particular/003_15.jpg'),
(NULL,11,'./img/product/particular/003_16.jpg'),
(NULL,11,'./img/product/particular/003_17.jpg'),
(NULL,11,'./img/product/particular/003_18.jpg'),
(NULL,11,'./img/product/particular/003_19.jpg'),
(NULL,11,'./img/product/particular/001_20.jpg'),
(NULL,11,'./img/product/particular/001_21.jpg'),
(NULL,11,'./img/product/particular/001_22.jpg'),
(NULL,11,'./img/product/particular/010_23.jpg'),
(NULL,11,'./img/product/particular/004_24.jpg'),
(NULL,11,'./img/product/particular/010_25.jpg'),
(NULL,11,'./img/product/particular/001_25.jpg'),
(NULL,11,'./img/product/particular/001_26.jpg'),
(NULL,11,'./img/product/particular/001_27.jpg'),
(NULL,11,'./img/product/particular/001_28.jpg'),
(NULL,11,'./img/product/particular/010_30.jpg'),
(NULL,12,'./img/product/particular/012_01.jpg'),
(NULL,12,'./img/product/particular/012_02.jpg'),
(NULL,12,'./img/product/particular/012_03.jpg'),
(NULL,12,'./img/product/particular/012_04.jpg'),
(NULL,12,'./img/product/particular/009_03.jpg'),
(NULL,12,'./img/product/particular/009_04.jpg'),
(NULL,12,'./img/product/particular/009_05.jpg'),
(NULL,12,'./img/product/particular/009_06.jpg'),
(NULL,12,'./img/product/particular/009_07.jpg'),
(NULL,12,'./img/product/particular/012_10.jpg'),
(NULL,12,'./img/product/particular/012_11.jpg'),
(NULL,12,'./img/product/particular/012_12.jpg'),
(NULL,12,'./img/product/particular/009_10.jpg'),
(NULL,12,'./img/product/particular/009_11.jpg'),
(NULL,12,'./img/product/particular/009_12.jpg'),
(NULL,12,'./img/product/particular/009_13.jpg'),
(NULL,12,'./img/product/particular/009_14.jpg'),
(NULL,12,'./img/product/particular/009_15.jpg'),
(NULL,12,'./img/product/particular/009_16.jpg'),
(NULL,12,'./img/product/particular/009_17.jpg'),
(NULL,12,'./img/product/particular/009_18.jpg'),
(NULL,12,'./img/product/particular/012_22.jpg'),
(NULL,12,'./img/product/particular/004_24.jpg'),
(NULL,12,'./img/product/particular/009_20.jpg'),
(NULL,12,'./img/product/particular/009_21.jpg'),
(NULL,12,'./img/product/particular/009_22.jpg'),
(NULL,12,'./img/product/particular/009_23.jpg'),
(NULL,12,'./img/product/particular/012_28.jpg'),
(NULL,12,'./img/product/particular/012_29.jpg'),
(NULL,12,'./img/product/particular/012_30.jpg'),
(NULL,12,'./img/product/particular/004_30.jpg'),
(NULL,13,'./img/product/particular/013_01.jpg'),
(NULL,13,'./img/product/particular/013_02.jpg'),
(NULL,13,'./img/product/particular/007_07.jpg'),
(NULL,13,'./img/product/particular/007_08.jpg'),
(NULL,13,'./img/product/particular/004_09.jpg'),
(NULL,13,'./img/product/particular/004_10.jpg'),
(NULL,13,'./img/product/particular/004_11.jpg'),
(NULL,13,'./img/product/particular/004_12.jpg'),
(NULL,13,'./img/product/particular/004_13.jpg'),
(NULL,13,'./img/product/particular/013_10.jpg'),
(NULL,13,'./img/product/particular/007_15.jpg'),
(NULL,13,'./img/product/particular/013_12.jpg'),
(NULL,13,'./img/product/particular/004_15.jpg'),
(NULL,13,'./img/product/particular/004_16.jpg'),
(NULL,13,'./img/product/particular/004_17.jpg'),
(NULL,13,'./img/product/particular/004_18.jpg'),
(NULL,13,'./img/product/particular/004_19.jpg'),
(NULL,13,'./img/product/particular/013_18.jpg'),
(NULL,13,'./img/product/particular/004_21.jpg'),
(NULL,13,'./img/product/particular/004_22.jpg'),
(NULL,13,'./img/product/particular/012_22.jpg'),
(NULL,13,'./img/product/particular/004_24.jpg'),
(NULL,13,'./img/product/particular/010_25.jpg'),
(NULL,13,'./img/product/particular/001_25.jpg'),
(NULL,13,'./img/product/particular/001_26.jpg'),
(NULL,13,'./img/product/particular/001_27.jpg'),
(NULL,13,'./img/product/particular/001_28.jpg'),
(NULL,13,'./img/product/particular/010_30.jpg'),
(NULL,14,'./img/product/particular/007_01.jpg'),
(NULL,14,'./img/product/particular/007_02.jpg'),
(NULL,14,'./img/product/particular/007_03.jpg'),
(NULL,14,'./img/product/particular/004_04.jpg'),
(NULL,14,'./img/product/particular/004_05.jpg'),
(NULL,14,'./img/product/particular/004_06.jpg'),
(NULL,14,'./img/product/particular/007_07.jpg'),
(NULL,14,'./img/product/particular/007_08.jpg'),
(NULL,14,'./img/product/particular/004_09.jpg'),
(NULL,14,'./img/product/particular/004_10.jpg'),
(NULL,14,'./img/product/particular/004_11.jpg'),
(NULL,14,'./img/product/particular/004_12.jpg'),
(NULL,14,'./img/product/particular/004_13.jpg'),
(NULL,14,'./img/product/particular/004_14.jpg'),
(NULL,14,'./img/product/particular/007_15.jpg'),
(NULL,14,'./img/product/particular/004_15.jpg'),
(NULL,14,'./img/product/particular/004_16.jpg'),
(NULL,14,'./img/product/particular/004_17.jpg'),
(NULL,14,'./img/product/particular/004_18.jpg'),
(NULL,14,'./img/product/particular/004_19.jpg'),
(NULL,14,'./img/product/particular/013_18.jpg'),
(NULL,14,'./img/product/particular/004_21.jpg'),
(NULL,14,'./img/product/particular/004_22.jpg'),
(NULL,14,'./img/product/particular/004_23.jpg'),
(NULL,14,'./img/product/particular/004_24.jpg'),
(NULL,14,'./img/product/particular/004_25.jpg'),
(NULL,14,'./img/product/particular/004_26.jpg'),
(NULL,14,'./img/product/particular/004_27.jpg'),
(NULL,14,'./img/product/particular/004_28.jpg'),
(NULL,14,'./img/product/particular/004_29.jpg'),
(NULL,14,'./img/product/particular/004_30.jpg'),
(NULL,15,'./img/product/particular/004_01.jpg'),
(NULL,15,'./img/product/particular/004_02.jpg'),
(NULL,15,'./img/product/particular/004_03.jpg'),
(NULL,15,'./img/product/particular/004_04.jpg'),
(NULL,15,'./img/product/particular/004_05.jpg'),
(NULL,15,'./img/product/particular/004_06.jpg'),
(NULL,15,'./img/product/particular/004_07.jpg'),
(NULL,15,'./img/product/particular/004_08.jpg'),
(NULL,15,'./img/product/particular/004_09.jpg'),
(NULL,15,'./img/product/particular/004_10.jpg'),
(NULL,15,'./img/product/particular/004_11.jpg'),
(NULL,15,'./img/product/particular/004_12.jpg'),
(NULL,15,'./img/product/particular/004_13.jpg'),
(NULL,15,'./img/product/particular/004_14.jpg'),
(NULL,15,'./img/product/particular/004_15.jpg'),
(NULL,15,'./img/product/particular/004_16.jpg'),
(NULL,15,'./img/product/particular/004_17.jpg'),
(NULL,15,'./img/product/particular/004_18.jpg'),
(NULL,15,'./img/product/particular/004_19.jpg'),
(NULL,15,'./img/product/particular/013_18.jpg'),
(NULL,15,'./img/product/particular/004_21.jpg'),
(NULL,15,'./img/product/particular/004_22.jpg'),
(NULL,15,'./img/product/particular/004_23.jpg'),
(NULL,15,'./img/product/particular/004_24.jpg'),
(NULL,15,'./img/product/particular/004_25.jpg'),
(NULL,15,'./img/product/particular/004_26.jpg'),
(NULL,15,'./img/product/particular/004_27.jpg'),
(NULL,15,'./img/product/particular/004_28.jpg'),
(NULL,15,'./img/product/particular/004_29.jpg'),
(NULL,15,'./img/product/particular/004_30.jpg'),
(NULL,16,'./img/product/particular/012_01.jpg'),
(NULL,16,'./img/product/particular/012_02.jpg'),
(NULL,16,'./img/product/particular/012_03.jpg'),
(NULL,16,'./img/product/particular/012_04.jpg'),
(NULL,16,'./img/product/particular/009_03.jpg'),
(NULL,16,'./img/product/particular/009_04.jpg'),
(NULL,16,'./img/product/particular/009_05.jpg'),
(NULL,16,'./img/product/particular/009_06.jpg'),
(NULL,16,'./img/product/particular/009_07.jpg'),
(NULL,16,'./img/product/particular/012_10.jpg'),
(NULL,16,'./img/product/particular/012_11.jpg'),
(NULL,16,'./img/product/particular/012_12.jpg'),
(NULL,16,'./img/product/particular/009_10.jpg'),
(NULL,16,'./img/product/particular/009_11.jpg'),
(NULL,16,'./img/product/particular/009_12.jpg'),
(NULL,16,'./img/product/particular/009_13.jpg'),
(NULL,16,'./img/product/particular/009_14.jpg'),
(NULL,16,'./img/product/particular/009_15.jpg'),
(NULL,16,'./img/product/particular/009_16.jpg'),
(NULL,16,'./img/product/particular/009_17.jpg'),
(NULL,16,'./img/product/particular/009_18.jpg'),
(NULL,16,'./img/product/particular/012_22.jpg'),
(NULL,16,'./img/product/particular/004_24.jpg'),
(NULL,16,'./img/product/particular/009_20.jpg'),
(NULL,16,'./img/product/particular/009_21.jpg'),
(NULL,16,'./img/product/particular/009_22.jpg'),
(NULL,16,'./img/product/particular/009_23.jpg'),
(NULL,16,'./img/product/particular/012_28.jpg'),
(NULL,16,'./img/product/particular/012_29.jpg'),
(NULL,16,'./img/product/particular/012_30.jpg'),
(NULL,16,'./img/product/particular/004_30.jpg'),
(NULL,17,'./img/product/particular/012_01.jpg'),
(NULL,17,'./img/product/particular/012_02.jpg'),
(NULL,17,'./img/product/particular/012_03.jpg'),
(NULL,17,'./img/product/particular/012_04.jpg'),
(NULL,17,'./img/product/particular/009_03.jpg'),
(NULL,17,'./img/product/particular/009_04.jpg'),
(NULL,17,'./img/product/particular/009_05.jpg'),
(NULL,17,'./img/product/particular/009_06.jpg'),
(NULL,17,'./img/product/particular/009_07.jpg'),
(NULL,17,'./img/product/particular/012_10.jpg'),
(NULL,17,'./img/product/particular/012_11.jpg'),
(NULL,17,'./img/product/particular/012_12.jpg'),
(NULL,17,'./img/product/particular/009_10.jpg'),
(NULL,17,'./img/product/particular/009_11.jpg'),
(NULL,17,'./img/product/particular/009_12.jpg'),
(NULL,17,'./img/product/particular/009_13.jpg'),
(NULL,17,'./img/product/particular/009_14.jpg'),
(NULL,17,'./img/product/particular/009_15.jpg'),
(NULL,17,'./img/product/particular/009_16.jpg'),
(NULL,17,'./img/product/particular/009_17.jpg'),
(NULL,17,'./img/product/particular/009_18.jpg'),
(NULL,17,'./img/product/particular/012_22.jpg'),
(NULL,17,'./img/product/particular/004_24.jpg'),
(NULL,17,'./img/product/particular/009_20.jpg'),
(NULL,17,'./img/product/particular/009_21.jpg'),
(NULL,17,'./img/product/particular/009_22.jpg'),
(NULL,17,'./img/product/particular/009_23.jpg'),
(NULL,17,'./img/product/particular/012_28.jpg'),
(NULL,17,'./img/product/particular/012_29.jpg'),
(NULL,17,'./img/product/particular/012_30.jpg'),
(NULL,17,'./img/product/particular/004_30.jpg'),
(NULL,18,'./img/product/particular/012_01.jpg'),
(NULL,18,'./img/product/particular/012_02.jpg'),
(NULL,18,'./img/product/particular/012_03.jpg'),
(NULL,18,'./img/product/particular/012_04.jpg'),
(NULL,18,'./img/product/particular/009_03.jpg'),
(NULL,18,'./img/product/particular/009_04.jpg'),
(NULL,18,'./img/product/particular/009_05.jpg'),
(NULL,18,'./img/product/particular/009_06.jpg'),
(NULL,18,'./img/product/particular/009_07.jpg'),
(NULL,18,'./img/product/particular/012_10.jpg'),
(NULL,18,'./img/product/particular/012_11.jpg'),
(NULL,18,'./img/product/particular/012_12.jpg'),
(NULL,18,'./img/product/particular/009_10.jpg'),
(NULL,18,'./img/product/particular/009_11.jpg'),
(NULL,18,'./img/product/particular/009_12.jpg'),
(NULL,18,'./img/product/particular/009_13.jpg'),
(NULL,18,'./img/product/particular/009_14.jpg'),
(NULL,18,'./img/product/particular/009_15.jpg'),
(NULL,18,'./img/product/particular/009_16.jpg'),
(NULL,18,'./img/product/particular/009_17.jpg'),
(NULL,18,'./img/product/particular/009_18.jpg'),
(NULL,18,'./img/product/particular/012_22.jpg'),
(NULL,18,'./img/product/particular/004_24.jpg'),
(NULL,18,'./img/product/particular/009_20.jpg'),
(NULL,18,'./img/product/particular/009_21.jpg'),
(NULL,18,'./img/product/particular/009_22.jpg'),
(NULL,18,'./img/product/particular/009_23.jpg'),
(NULL,18,'./img/product/particular/012_28.jpg'),
(NULL,18,'./img/product/particular/012_29.jpg'),
(NULL,18,'./img/product/particular/012_30.jpg'),
(NULL,18,'./img/product/particular/004_30.jpg'),
(NULL,18,'./img/product/particular/012_01.jpg'),
(NULL,18,'./img/product/particular/012_02.jpg'),
(NULL,18,'./img/product/particular/012_03.jpg'),
(NULL,18,'./img/product/particular/012_04.jpg'),
(NULL,18,'./img/product/particular/009_03.jpg'),
(NULL,18,'./img/product/particular/009_04.jpg'),
(NULL,18,'./img/product/particular/009_05.jpg'),
(NULL,18,'./img/product/particular/009_06.jpg'),
(NULL,18,'./img/product/particular/009_07.jpg'),
(NULL,18,'./img/product/particular/012_10.jpg'),
(NULL,18,'./img/product/particular/012_11.jpg'),
(NULL,18,'./img/product/particular/012_12.jpg'),
(NULL,18,'./img/product/particular/009_10.jpg'),
(NULL,18,'./img/product/particular/009_11.jpg'),
(NULL,18,'./img/product/particular/009_12.jpg'),
(NULL,18,'./img/product/particular/009_13.jpg'),
(NULL,18,'./img/product/particular/009_14.jpg'),
(NULL,18,'./img/product/particular/009_15.jpg'),
(NULL,18,'./img/product/particular/009_16.jpg'),
(NULL,18,'./img/product/particular/009_17.jpg'),
(NULL,18,'./img/product/particular/009_18.jpg'),
(NULL,18,'./img/product/particular/012_22.jpg'),
(NULL,18,'./img/product/particular/004_24.jpg'),
(NULL,18,'./img/product/particular/009_20.jpg'),
(NULL,18,'./img/product/particular/009_21.jpg'),
(NULL,18,'./img/product/particular/009_22.jpg'),
(NULL,18,'./img/product/particular/009_23.jpg'),
(NULL,18,'./img/product/particular/012_28.jpg'),
(NULL,18,'./img/product/particular/012_29.jpg'),
(NULL,18,'./img/product/particular/012_30.jpg'),
(NULL,18,'./img/product/particular/004_30.jpg'),
(NULL,19,'./img/product/particular/012_01.jpg'),
(NULL,19,'./img/product/particular/012_02.jpg'),
(NULL,19,'./img/product/particular/012_03.jpg'),
(NULL,19,'./img/product/particular/012_04.jpg'),
(NULL,19,'./img/product/particular/009_03.jpg'),
(NULL,19,'./img/product/particular/009_04.jpg'),
(NULL,19,'./img/product/particular/009_05.jpg'),
(NULL,19,'./img/product/particular/009_06.jpg'),
(NULL,19,'./img/product/particular/009_07.jpg'),
(NULL,19,'./img/product/particular/012_10.jpg'),
(NULL,19,'./img/product/particular/012_11.jpg'),
(NULL,19,'./img/product/particular/012_12.jpg'),
(NULL,19,'./img/product/particular/009_10.jpg'),
(NULL,19,'./img/product/particular/009_11.jpg'),
(NULL,19,'./img/product/particular/009_12.jpg'),
(NULL,19,'./img/product/particular/009_13.jpg'),
(NULL,19,'./img/product/particular/009_14.jpg'),
(NULL,19,'./img/product/particular/009_15.jpg'),
(NULL,19,'./img/product/particular/009_16.jpg'),
(NULL,19,'./img/product/particular/009_17.jpg'),
(NULL,19,'./img/product/particular/009_18.jpg'),
(NULL,19,'./img/product/particular/012_22.jpg'),
(NULL,19,'./img/product/particular/004_24.jpg'),
(NULL,19,'./img/product/particular/009_20.jpg'),
(NULL,19,'./img/product/particular/009_21.jpg'),
(NULL,19,'./img/product/particular/009_22.jpg'),
(NULL,19,'./img/product/particular/009_23.jpg'),
(NULL,19,'./img/product/particular/012_28.jpg'),
(NULL,19,'./img/product/particular/012_29.jpg'),
(NULL,19,'./img/product/particular/012_30.jpg'),
(NULL,19,'./img/product/particular/004_30.jpg'),
(NULL,19,'./img/product/particular/012_01.jpg'),
(NULL,19,'./img/product/particular/012_02.jpg'),
(NULL,19,'./img/product/particular/012_03.jpg'),
(NULL,19,'./img/product/particular/012_04.jpg'),
(NULL,19,'./img/product/particular/009_03.jpg'),
(NULL,19,'./img/product/particular/009_04.jpg'),
(NULL,19,'./img/product/particular/009_05.jpg'),
(NULL,19,'./img/product/particular/009_06.jpg'),
(NULL,19,'./img/product/particular/009_07.jpg'),
(NULL,19,'./img/product/particular/012_10.jpg'),
(NULL,19,'./img/product/particular/012_11.jpg'),
(NULL,19,'./img/product/particular/012_12.jpg'),
(NULL,19,'./img/product/particular/009_10.jpg'),
(NULL,19,'./img/product/particular/009_11.jpg'),
(NULL,19,'./img/product/particular/009_12.jpg'),
(NULL,19,'./img/product/particular/009_13.jpg'),
(NULL,19,'./img/product/particular/009_14.jpg'),
(NULL,19,'./img/product/particular/009_15.jpg'),
(NULL,19,'./img/product/particular/009_16.jpg'),
(NULL,19,'./img/product/particular/009_17.jpg'),
(NULL,19,'./img/product/particular/009_18.jpg'),
(NULL,19,'./img/product/particular/012_22.jpg'),
(NULL,19,'./img/product/particular/004_24.jpg'),
(NULL,19,'./img/product/particular/009_20.jpg'),
(NULL,19,'./img/product/particular/009_21.jpg'),
(NULL,19,'./img/product/particular/009_22.jpg'),
(NULL,19,'./img/product/particular/009_23.jpg'),
(NULL,19,'./img/product/particular/012_28.jpg'),
(NULL,19,'./img/product/particular/012_29.jpg'),
(NULL,19,'./img/product/particular/012_30.jpg'),
(NULL,19,'./img/product/particular/004_30.jpg'),
(NULL,20,'./img/product/particular/013_01.jpg'),
(NULL,20,'./img/product/particular/013_02.jpg'),
(NULL,20,'./img/product/particular/007_07.jpg'),
(NULL,20,'./img/product/particular/007_08.jpg'),
(NULL,20,'./img/product/particular/004_09.jpg'),
(NULL,20,'./img/product/particular/004_10.jpg'),
(NULL,20,'./img/product/particular/004_11.jpg'),
(NULL,20,'./img/product/particular/004_12.jpg'),
(NULL,20,'./img/product/particular/004_13.jpg'),
(NULL,20,'./img/product/particular/013_10.jpg'),
(NULL,20,'./img/product/particular/007_15.jpg'),
(NULL,20,'./img/product/particular/013_12.jpg'),
(NULL,20,'./img/product/particular/004_15.jpg'),
(NULL,20,'./img/product/particular/004_16.jpg'),
(NULL,20,'./img/product/particular/004_17.jpg'),
(NULL,20,'./img/product/particular/004_18.jpg'),
(NULL,20,'./img/product/particular/004_19.jpg'),
(NULL,20,'./img/product/particular/013_18.jpg'),
(NULL,20,'./img/product/particular/004_21.jpg'),
(NULL,20,'./img/product/particular/004_22.jpg'),
(NULL,20,'./img/product/particular/012_22.jpg');


/**商品详情页配置信息**/
INSERT INTO le_laptop_layout VALUES
(NULL,1,'第八代智能英特尔® 酷睿™ i7 处理器','i7-8565U','1.8 GHz','四核','Windows 10 家庭中文版','13.3英寸','三边窄全高清IPS屏幕','16GB','LPDDR3','512GB','SSD固态硬盘','独立显卡','NVIDIA GeForce MX150','2GB','无光驱','2个','HDMI','耳机、麦克风二合一接口','1个','1个','1*1 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','无背光','45Wh','1.25Kg','厚度14.8mm','正版Office家庭和学生版'),
(NULL,2,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8265U','1.6 GHz','四核','Windows 10 家庭中文版','15.6英寸','三边窄全高清IPS屏幕','8GB','DDR4','256GB','SSD固态硬盘','独立显卡','NVIDIA GeForce MX150','2GB','无光驱','2个','HDMI','耳机、麦克风二合一接口','1个','USB Type-C*1（仅具备USB数据传输功能）','1*1 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','无背光','45Wh','1.69Kg','厚度16.8mm','正版Office家庭和学生版'),
(NULL,3,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1060','6GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.2','内置扬声器','有','720p HD 摄像头','背光键盘','57Wh','2.35Kg','26.9mm（最厚处）','正版Office家庭和学生版'),
(NULL,4,'第八代智能英特尔® 酷睿™ i7 处理器','i7-8750H','2.2 Ghz','六核','Windows 10 家庭中文版','15.6英寸','全高清IPS屏幕','8GB','DDR4','2T+128G SSD','机械硬盘+固态硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','1*1 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,5,'第八代Kabylake智能英特尔® 酷睿™ i5 处理器','i5-8250U','1.6 GHz','四核','Windows 10 家庭中文版','13.3英寸','全高清IPS屏幕','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA GeForce MX150','2GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','USB Type-C*1（仅具备USB数据传输功能）','1*1 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','36Wh','1.2Kg','16.9mm','正版Office家庭和学生版'),
(NULL,6,'第八代Kabylake智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','全高清IPS屏幕','8GB','DDR4','2T+128G SSD','机械硬盘+固态硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','1*1 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,7,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','1TB+128GB SSD','机械硬盘+固态硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','1*1 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,8,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','全高清IPS屏幕','8GB','DDR4','2T+128G SSD','机械硬盘+固态硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','1*1 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,9,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1060','6GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.2','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,10,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1060','6GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.2','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,11,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,12,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1060','6GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.2','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,13,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.3 GHz','四核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,14,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.2 Ghz','六核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','1TB+128GB SSD','机械硬盘+固态硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','有','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,15,'第八代智能英特尔® 酷睿™ i5 处理器','i5-8300H','2.2 Ghz','六核','Windows 10 家庭中文版','15.6英寸','全高清IPS屏幕','8GB','DDR4','2T+128G SSD','机械硬盘+固态硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','1*1 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,16,'第八代智能英特尔® 酷睿™ i7 处理器','i7-8750H','2.2 Ghz','六核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','8GB','机械硬盘','独立显卡','NVIDIA Geforce GTX 1060','6GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','有','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,17,'第八代智能英特尔® 酷睿™ i7 处理器','i7-8750H','2.2 Ghz','六核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1060','6GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.2','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,18,'第八代智能英特尔® 酷睿™ i7 处理器','i7-8750H','2.2 Ghz','六核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1060','6GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.2','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,19,'第八代智能英特尔® 酷睿™ i7 处理器','i7-8750H','2.2 Ghz','六核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','512GB','SSD固态硬盘','独立显卡','NVIDIA Geforce GTX 1060','6GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.2','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版'),
(NULL,20,'第八代智能英特尔® 酷睿™ i7 处理器','i7-8750H','2.2 Ghz','六核','Windows 10 家庭中文版','15.6英寸','72%NTSC IPS FHD显示屏','8GB','DDR4','8GB','机械硬盘','独立显卡','NVIDIA Geforce GTX 1050Ti','4GB','无光驱','3个','HDMI','耳机、麦克风二合一接口','1个','1个','2*2 AC无线局域网卡','BT4.1','内置扬声器','有','720p HD 摄像头','背光键盘','52.5Wh','2.3Kg','23.9mm','正版Office家庭和学生版');




/**商品规格信息**/
INSERT INTO le_laptop_specification VALUES
(NULL,3,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','电竞屏/8G/1T+128G SSD/1050Ti'),
(NULL,4,1,'黑色/15.6英寸','i7-8750H/Windows 10 家庭中文版','大硬盘/8G/2T+128G SSD/1050Ti'),
(NULL,6,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','大硬盘/8G/2T+128G SSD/GTX 1050Ti 4G独显'),
(NULL,7,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','高色域/8G/1T+128G SSD/1050Ti'),
(NULL,8,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','大硬盘/8G/2T+128G SSD/1050Ti'),
(NULL,9,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','高色域/8G/1T+128G SSD/1060'),
(NULL,10,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','电竞屏/8G/512G SSD/1060'),
(NULL,11,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','电竞屏/8G/512G SSD/1050Ti'),
(NULL,12,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','高色域/8G/512G SSD/1060'),
(NULL,13,1,'黑色/15.6英寸','i5-8300H/Windows 10 家庭中文版','高色域/8G/512G SSD/1050Ti'),
(NULL,14,1,'黑色/15.6英寸','i7-8750H/Windows 10 家庭中文版','高色域/8G/1T+128G SSD/1050Ti'),
(NULL,15,1,'黑色/15.6英寸','i7-8750H/Windows 10 家庭中文版','大硬盘/8G/2T+128G SSD/1050Ti'),
(NULL,16,1,'黑色/15.6英寸','i7-8750H/Windows 10 家庭中文版','高色域/16G/512G SSD/1060'),
(NULL,17,1,'黑色/15.6英寸','i7-8750H/Windows 10 家庭中文版','电竞屏/8G/512G SSD/1060'),
(NULL,18,1,'黑色/15.6英寸','i7-8750H/Windows 10 家庭中文版','电竞屏/16G/2T+512G SSD/1060'),
(NULL,19,1,'黑色/15.6英寸','i7-8750H/Windows 10 家庭中文版','高色域/8G/512G SSD/1060'),
(NULL,20,1,'黑色/15.6英寸','i7-8750H/Windows 10 家庭中文版','高色域/8G/512G SSD/1050Ti');


INSERT INTO le_user VALUES
(NULL,'dingding','','123456',1,'','丁伟','','','13501234567','ding@qq.com',''),
(NULL,'dangdang','','123456',1,'','林当','','','13501234568','dang@qq.com',''),
(NULL,'doudou','','123456',0,'','窦志强','','','13501234569','dou@qq.com',''),
(NULL,'yaya','','123456',2,'','秦小雅','','','13501234560','ya@qq.com','');


