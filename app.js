var express = require('express');
var app = express();

var pg = require('pg');
var config = {
    user: 'postgres',
    database: 'daugia', 
    password: '1234', 
    port: 5432, 
    max: 10, // max number of connection can be open to database
    idleTimeoutMillis: 30000, // how long a client is allowed to remain idle before being closed
};
var pool = new pg.Pool(config);


app.use(express.static('public'))

app.get('/', (req, res) => {
    res.sendfile('welcome.html')
})

app.get('/login', (req, res) => {
    res.sendfile('login.html')
})

app.get('/home', (req, res) => {
    res.sendfile('index.html')
})
//Load Trang Sp HOT là sp có số lần đấu giá nhiều nhất -> sắp GIẢM 10 sp đầu tiên
app.get('/load/sp_hot', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*,p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp and p.matinhtrang = 1
                        and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'
                    ORDER BY p.giahientai DESC
                    limit 5 `
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            res.json(result.rows)
        });
     });
})
//Load Trang Sp HẾT THỜI GIAN ĐẤU GIÁ là sp có thời gian đấu giá sắp hết ASC hoặc DESC
app.get('/load/sp_hettg', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*,p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp and p.matinhtrang = 1 
                        and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'
                    ORDER BY p.thoigiandau ASC
                    limit 5 `
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            res.json(result.rows)
        });
     });
})

app.get('/congNghe', (req, res) => {
    res.sendfile('congNghe.html')
})
//Load Trang Sp CÔNG NGHỆ là sp thuộc loại Công nghệ
app.get('/load/sp_congnghe', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p, tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'cong nghe' and s.masp = p.masp
                         and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            res.json(result.rows)
        });
     });
})

app.get('/thoiTrang', (req, res) => {
    res.sendfile('thoiTrang.html')
})
//Load Trang Sp CÔNG NGHỆ là sp thuộc loại Công nghệ
app.get('/load/sp_thoitrang', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p , tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'thoi trang' and s.masp = p.masp and p.matinhtrang = 1
                    and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            res.json(result.rows)
        });
     });
})

app.get('/doGiaDung', (req, res) => {
    res.sendfile('doGiaDung.html')
})
app.get('/load/sp_dogiadung', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p, tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'do gia dung' and s.masp = p.masp and p.matinhtrang = 1
                    and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            res.json(result.rows)
        });
     });
})
app.get('/shopping', (req, res) => {

    res.sendfile('shopping-cart.html')
})

app.get('/daugiacuatoi', (req, res) => {

    res.sendfile('daugiacuatoi.html')
})


// app.get('/chitiet', (req, res) => {
//     res.sendfile('chitietsp.html')
// })


//          ADMIN       //

app.get('/home_admin', (req, res) => {
    res.sendfile('spDangDauGia_admin.html')
})

app.get('/themsp', (req, res) => {
    res.sendfile('insert_admin.html')
})

app.get('/spDangDauGia', (req, res) => {
    res.sendfile('spDangDauGia_admin.html')
})

app.get('/spDaDauGia', (req, res) => {
    res.sendfile('spDaDauGia_admin.html')
})
app.get('/load/sp_dadaugia', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'da dau gia'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            res.json(result.rows)
        });
     });
})

app.get('/spKhongDauGia', (req, res) => {
    res.sendfile('spKhongDauGia_admin.html')
})
app.get('/load/sp_khongdaugia', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*, p.*
                FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                WHERE s.masp = p.masp and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'khong co dau gia'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            res.json(result.rows)
        });
     });
})


app.get('/createProduct', (req, res)=>{
    //console.log(req.query)
    var tensp = req.query.tensp
    var gia =  parseInt(req.query.giatien)
    var loai =  parseInt(req.query.phanloai)
    var mota = req.query.chitiet
    var tgbd = req.query.thoigianbd
    var tgdau = req.query.thoigiandau
    var hinhanh = req.query.hinhanh
    console.log(hinhanh)
    var arr =[]
    arr = hinhanh.split("\\");
    console.log(arr[2])
    var img = arr[2]
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        }
              
        client.query(`INSERT INTO sanpham(loaisp, hinhanh, info, isnew, isdelete, mota)
                    values(` + loai + `,'` +  img + `','` + tensp + `', true, false, '` + mota + `')`),
        client.query(`SELECT s.*
                    FROM sanpham s
                    WHERE s.info = '` + tensp + `'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            var masp = parseInt(result.rows[0].masp)
            client.query(`insert into phiendaugia(masp,thoigianbd,thoigiandau,giathapnhat,giahientai,maphieudauthang,matinhtrang)
                            values(`+ masp + `,'`+ tgbd +`','` + tgdau + `',` + gia + `,` + gia + `,null,2)`)
            res.send("Thành công")
        });
     });
})


///--------------//////
app.get('/daugia/:a/:b/:c/:d', (req, res) => {
    var gia = parseInt(req.params['a'])
    var pheptinh = req.params['b']
    var giathau = parseInt(req.params['c'])
    var delta = parseInt(req.params['d'])
    if( pheptinh == '-' &&  gia > giathau)
        gia = gia - delta
    else if( pheptinh == '+')
        gia = gia + delta
    if( gia < 1)
        gia = 1
    // Gui tra ve cho client du lieu ma Server da xu li
    // vi khi tra ve cho client luon phai la dang chuoi,
    // khong duoc la kieu so nen se tien hanh ep kieu
    res.send(gia.toString())
})

//  TRANG CHI TIẾT PHẢI ĐỂ SAU CÙNG VÌ KHI CHẠY TỪ TRÊN XUỐNG DƯỚI mã_sp CHƯA ĐƯỢC GÁN GIÁ TRỊ
// NẾU ĐỂ BÊN TRÊN SẼ LÀM CÁC TRANG NẰM DƯỚI phần này LỖI
var id_sp;
app.get('/:id', (req, res) => {
    id_sp = parseInt(req.params['id'])
    res.sendfile('chitietsp.html')
})
app.get('/load/chitiet', (req, res) => {
    console.log("ID la: " + id_sp);
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*, p.*, t.giatri
                    FROM sanpham s, phiendaugia p, thamso t
                    WHERE s.masp = ` + id_sp + ` and s.masp = p.masp and t.tenthamso = 'delta so tien'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            res.json(result.rows)
        });
     });
    //res.json(id_sp)
})

app.listen(3000, () => console.log("Success"))