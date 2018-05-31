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

var cookieParser = require('cookie-parser')
app.use(cookieParser())


app.use(express.static('public'))

app.get('/', (req, res) => {
    res.sendfile('welcome.html')
})

app.get('/login', (req, res) => {
    var name = req.query.username
    var pass = req.query.password
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT t.*, l.*
                    FROM taikhoan t, loaitk l
                    WHERE t.loaitk = l.maloai and t.tentk ='`+ name + `' and t.matkhau ='`+ pass + `'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            if(result.rowCount == 0){
                res.send("false")
                res.end()
            }
            else{
                if(result.rows[0].tenloai == "admin"){
                    res.send("admin")
                }
                else if(result.rows[0].tenloai == "user"){
                    var expireTime = 3600
                    res.cookie('user_id', result.rows[0].matk, {expire : new Date() + expireTime})
                    console.log(req.cookies['user_id'])
                    res.send("user")
                }
            }
        });
     });
})

app.get('/index', (req, res) => {
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

//Load Trang Sp ĐỒ GIA DỤNG là sp thuộc loại do gia dung
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

// Chi tiết sản phẩm
app.get('/load/chitiet/:id', (req, res) => {
    var id_sp = parseInt(req.params['id'])
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
})
///--------------//////
app.get('/daugia/:a/:b/:c/:d', (req, res) => {
    var gia = parseInt(req.params['a'])
    var pheptinh = req.params['b']
    var giathau = parseInt(req.params['c'])
    var delta = parseInt(req.params['d'])
    if( pheptinh == 'tru' &&  gia > giathau)
        gia = gia - delta
    else if( pheptinh == 'cong')
        gia = gia + delta
    if( gia < 1)
        gia = 1
    // Gui tra ve cho client du lieu ma Server da xu li
    // vi khi tra ve cho client luon phai la dang chuoi,
    // khong duoc la kieu so nen se tien hanh ep kieu
    res.send(gia.toString())
})

// Thực hiện đấu giá
app.get('/create_update_PhieuDG', (req, res)=>{
    var maphien =  parseInt(req.query.maphien)
    // var masp =  parseInt(req.query.masp)
    var matk =  parseInt(req.query.matk)
    var giadau =  parseInt(req.query.giadau)
    var tinhtrangphieu =  parseInt(req.query.matinhtrang)
    var maphieu = 0
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        }
              
        client.query(`SELECT p.*
                    FROM phieudaugia p
                    WHERE p.maphiendg = ` + maphien + ` and p.matk = ` + matk + ``
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            var check = result.rowCount
            console.log(check)
            if(check != '0'){
                // khi tk này đã đấu giá sp này rồi thì trong phieudg sp của tk này là update giá và tình trạng
                maphieu = parseInt(result.rows[0].maphieudg)
               
                client.query(`update phieudaugia
                              set giadau =`+ giadau + `, matinhtrang =` + tinhtrangphieu +
                             `where maphieudg = `+ maphieu)
            }
            else{
                // khi tk này chưa đấu giá sp này thì ta tạo 1 phiếudg sp này cho tk hiện tại
                client.query(`insert into phieudaugia(maphiendg,matk,giadau,matinhtrang)
                            values(`+ maphien + `,'`+ matk +`','` + giadau + `',` + tinhtrangphieu + `)`)
                // lấy được maphieudg vừa đc random ở postgre => SAI chưa làm đc
                // client.query(`SELECT p.*
                //             FROM phieudaugia p
                //             WHERE p.maphiendg = ` + maphien + ` and p.matk = ` + matk + ``   
                // ,function(err,result) {
                //     done(); 
                //     maphieu = parseInt(result.rows[0].maphieudg)
                // });         
            }    
            console.log("maphieu:" + maphieu)
            console.log("MAPHIEN:" + maphien)
            //update lại tình trạng của các tài khoản khác cũng đấu giá sản phẩm này thành dg không thành công
            client.query(`update phieudaugia
                              set matinhtrang = 2
                             where maphiendg = `+ maphien + ` and matk != `+ matk )

            // update lại giá hiện tại khi 1 tk nâng giá lên của sp trong phiendaugia + maphieudauthang la maphieu hiện tại
            client.query(`update phiendaugia
                        set giahientai =`+ giadau +  
                        `where maphiendg = `+ maphien) 
            client.query(`SELECT p.*
                    FROM phiendaugia p
                    WHERE p.maphiendg =` + maphien
            ,function(err,result) {
                res.json(result.rows[0])
            });
        });
     });
})


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






app.listen(3000, () => console.log("Success"))