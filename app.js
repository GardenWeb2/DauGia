var express = require('express');
var app = express();

var pg = require('pg');
var config = {
    user: 'postgres',
    database: 'daugia', 
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


app.get('/setCookie/:matk', (req, res, next)=>{
    var matk = req.params['matk']
    var expireTime = 3600
    res.cookie('user_id', matk, {expire : new Date() + expireTime})
    res.end("DONE")
})

app.get('/abc', (req, res, next)=>{
    if(req.cookies['user_id'] != null)
        res.write("Cookie is " + req.cookies['user_id'])
    else
        res.write("No cookie")
    res.send()
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
                res.send({ status: 'false'});
                res.end()
            }
            else{
                if(result.rows[0].tenloai == "admin"){
                    res.send({ status: 'true', user: result.rows[0].matk, type: "admin" });
                }
                else if(result.rows[0].tenloai == "user"){
                    res.send({ status: 'true', user: result.rows[0].matk, type: "user" });
                }
            }
        });
     });
})

app.get('/index', (req, res) => {
    res.sendfile('index.html')
})

//Load Tất cả sản phẩm để chạy hàm setInterval() trong trang chi tiết
app.get('/load/sp_all', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*,p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp
                        and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'  `
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

//Load Trang Sp HOT là sp có số lần đấu giá nhiều nhất -> sắp GIẢM 10 sp đầu tiên
app.get('/load/sp_hot', (req, res)=>{    
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*,p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp
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
                    WHERE s.masp = p.masp
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
    console.log("Cookie is " + req.cookies['user_id'])
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

//Load Trang Sp Thời trang là sp thuộc loại Thời trang
app.get('/load/sp_thoitrang', (req, res)=>{
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p , tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'thoi trang' and s.masp = p.masp 
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
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'do gia dung' and s.masp = p.masp
                    and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); // huy ket noi
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


// Update Thời gian đấu giá khi nhấn nút trên header_user
app.get('/capNhatThoiGianDau/:id/:time', (req, res) => {
    var id_sp = parseInt(req.params['id'])
    var thoigian = req.params['time']
    //console.log(id_sp+ "    " +thoigian)
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`update phiendaugia
                    set thoigiandau ='`+ thoigian + `'
                    where masp = `+ id_sp
        ,function(err,result) {
           //call `done()` to release the client back to the pool
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            //res.json(result.rows)
            res.send("true")
        })
     });
})



// Update Tình trạng phiên đấu giá khi hết thời gian + 
// Update mã phiếu đấu thắng vào table phiendaugia nếu phiên đgđấu giá đó có người đấu giá
app.get('/capNhatTinhTrangPhien/:maphien', (req, res) => {
    var maphiendg = parseInt(req.params['maphien'])
    console.log(maphiendg)
    var tinhtrangphien = 3       // tên tinhtrangphien = "da dau gia"
    pool.connect(function(err,client,done) {
        if(err){
            console.log("not able to get connection "+ err);
            res.status(400).send(err);
        } 
        client.query(`SELECT p.*
                    FROM phieudaugia p, tinhtrangphieudg t
                    WHERE  p.maphiendg = ` + maphiendg + ` and p.matinhtrang = t.matinhtrangphieudg and t.tentinhtrangphieudg = 'dau gia thanh cong'`
        ,function(err,result) {
            done(); 
            if(err){
                res.end();
                console.log(err);
                res.status(400).send(err)
            }
            // phải tách 2 trường hợp là phiên đấu giá này có người đấu hay không
            // vì gộp chung update k hiểu giá trị tham số null truyền vào biến maphieuthang

            // xét nếu phiên đấu giá này không có ai đấu giá => sẽ k tạo ra phiếu đấu giá
            if(result.rowCount == 0){
                tinhtrangphien = 4     // tên tinhtrangphien = "khong co dau gia"
                client.query(`update phiendaugia
                        set matinhtrang =`+ tinhtrangphien + 
                        `where maphiendg = `+ maphiendg + ``
                ,function(err,result) {
                    done(); 
                    if(err){
                        res.end();
                        console.log("SAI ROI");
                        console.log(err);
                        res.status(400).send(err)
                    }
                    res.send("cap nhat tinh trang phien thành công")
                })   
            }
             // nếu có người đấu giá thì lấy maphieudg của người thắng tại phiên đấu giá này
            else {
                var maphieuthang = parseInt(result.rows[0].maphieudg)
                client.query(`update phiendaugia
                            set matinhtrang =`+ tinhtrangphien + `, maphieudauthang =` + maphieuthang +
                            `where maphiendg = `+ maphiendg + ``
                ,function(err,result) {
                    done(); 
                    if(err){
                        res.end();
                        console.log("SAI ROI");
                        console.log(err);
                        res.status(400).send(err)
                    }
                    res.send("cap nhat tinh trang phien + mã phiếu thắng thành công")
                })   
            }
        })
     })
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
    console.log("Cookie is " + req.cookies['user_id'])
    var matk =  parseInt(req.cookies['user_id'])
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
            console.log("1: update  0: insert" + check)
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
    var tinhtrangphien = 2
    var tensp = req.query.tensp
    var gia =  parseInt(req.query.giatien)
    var loai = parseInt(req.query.phanloai)
    var mota = req.query.chitiet
    var tgbd = req.query.thoigianbd     // nam-thang-ngay
    var tgdau = req.query.thoigiandau
    // cắt thành 2 chuỗi: 1/ ngày   2/ giờ
    var fullTime =[]
    fullTime = tgbd.split(" ");
    // cắt chuỗi ngày thành 3 chuỗi: 1/ nam   2/ tháng     3/ngay
    var date =[]
    date = fullTime[0].split("-");
    // lấy ngày hiện tại kiểm tra
    var d = new Date();
    console.log(d.getDate())
    console.log(d.getMonth())   // vì tháng là từ 0-> 11 nên tháng thực tế phải +1
    var thang = parseInt(d.getMonth()) + 1
    console.log(d.getFullYear())
    if(date[2] == d.getDate() && date[1] == thang && date[0] == d.getFullYear())
        tinhtrangphien = 1
    
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
                    values(` + loai + `,'` +  img + `','` + tensp + `', true, false, '` + mota + `')`)
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
            var ttp = parseInt(tinhtrangphien)
            client.query(`insert into phiendaugia(masp,thoigianbd,thoigiandau,giathapnhat,giahientai,maphieudauthang,matinhtrang)
                            values(`+ masp + `,'`+ tgbd +`','` + tgdau + `',` + gia + `,` + gia + `,null,` + ttp + `)`)
            res.send("Thành công")
        });
     })
})

app.listen(3000, () => console.log("Success"))