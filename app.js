var express = require('express');
var app = express();

var pg = require('pg');
var config = {
    user: 'postgres',
    database: 'daugia', 
    password: '1234', 
    port: 5432, 
    max: 10, // max number of connection can be open to database
    idleTimeoutMillis: 30000000, // how long a client is allowed to remain idle before being closed
};
var pool = new pg.Pool(config)


var cookieParser = require('cookie-parser')
app.use(cookieParser())

app.use(express.static('public'))


app.get('/index', (req, res) => {
    res.sendfile('index.html')
})

var temp1 = 0
var temp2 = 0

app.get('/setCookie/:matk/:type', (req, res, next) => {
    var matk = req.params['matk']
    var loaitk = req.params['type']
    if(req.params['type'] == 'user')
        temp1 = loaitk
    else
        temp2 = loaitk
        
    var expireTime = 3600
    res.cookie('user_id', matk, { expire: new Date() + expireTime })
    res.cookie('type_id', loaitk, { expire: new Date() + expireTime })
    res.end("DONE")
})

// reset cookies về null khi đăng xuất
app.get('/resetCookies/:type', (req, res) => {
    if(req.params['type'] == 'user'){
        temp1 = 'null'
        console.log(req.params['type'])
    }
    else{
        temp2 = 'null'
        console.log(req.params['type'])
    }
    var expireTime = 3600
    res.cookie('user_id', null, { expire: new Date() + expireTime })
    res.cookie('type_id', null, { expire: new Date() + expireTime })
    res.end("DONE")
})

app.all('/user/*', (req, res, next) => {
    if(req.cookies['type_id'] == 'user' || temp1 == 'user')
        next()
})

app.all('/admin/*', (req, res, next) => {
    if(req.cookies['type_id'] == 'admin' || temp2 == 'admin')
        next()
})

app.get('/login', (req, res) => {
    var name = req.query.username
    var pass = req.query.password
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT t.*, l.*
                    FROM taikhoan t, loaitk l
                    WHERE t.loaitk = l.maloai and t.tentk ='`+ name + `' and t.matkhau ='` + pass + `'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    //res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                if (result.rowCount == 0) {
                    res.send({ status: 'false' });
                    res.end()
                }
                else {
                    if (result.rows[0].tenloai == "admin") {
                        res.send({ status: 'true', matk: result.rows[0].matk, type: "admin", username: result.rows[0].tentk });
                    }
                    else if (result.rows[0].tenloai == "user") {
                        res.send({ status: 'true', matk: result.rows[0].matk, type: "user", username: result.rows[0].tentk });
                    }
                }
            });
    });
})

app.get('/signup', (req, res) => {
    var u = req.query.username
    var pass = req.query.password
    var add = req.query.address
    var phone = req.query.phone
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT t.*, l.*
                    FROM taikhoan t, loaitk l
                    WHERE t.loaitk = l.maloai and t.tentk ='` + u + `' and t.matkhau ='` + pass + `'`
            , function (err, result) {
                done()
                if (err) {
                    console.log(err)
                    res.status(400).send(err)
                    res.end()
                }
                if (result.rowCount == 1) {
                    res.send({ status: 'false', username: u })
                    res.end()
                }
                else {
                    client.query(`INSERT into taikhoan(tentk, matkhau, loaitk, sdt, diachi) values('` + u + `', '` + pass + `', 2, '` + phone + `', '` + add + `')`)
                    client.query(`SELECT t.*, l.*
                            FROM taikhoan t, loaitk l
                            WHERE t.loaitk = l.maloai and t.tentk ='` + u + `' and t.matkhau ='` + pass + `'`
                        , function (err, result1) {
                            done()
                            if (err) {
                                console.log(err)
                                res.status(400).send(err)
                                res.end()
                            }
                            else {
                                res.send({ status: 'true', matk: result1.rows[0].matk, username: result1.rows[0].tentk,  type: "user" })
                                res.end()
                            }
                        })
                }
            })

    })
})

//Load Trang Sp HOT là sp có số lần đấu giá nhiều nhất -> sắp GIẢM 10 sp đầu tiên
app.get('/user/load/sp_hot', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*,p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp
                        and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'
                    ORDER BY p.giahientai DESC
                    limit 8 `
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

app.get('/admin/load/sp_hot', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*,p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp
                        and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'
                    ORDER BY p.giahientai DESC
                    limit 8 `
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})
//Load Trang Sp HẾT THỜI GIAN ĐẤU GIÁ là sp có thời gian đấu giá sắp hết ASC hoặc DESC
app.get('/user/load/sp_hettg', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*,p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp
                        and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'
                    ORDER BY p.thoigiandau ASC
                    limit 8 `
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

app.get('/admin/load/sp_hettg', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*,p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp
                        and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'
                    ORDER BY p.thoigiandau ASC
                    limit 8 `
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

//Load Trang Sp CÔNG NGHỆ là sp thuộc loại Công nghệ
app.get('/user/load/sp_congnghe', (req, res) => {
    console.log("Cookie is " + req.cookies['user_id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p, tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'cong nghe' and s.masp = p.masp
                         and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

app.get('/admin/load/sp_congnghe', (req, res) => {
    console.log("Cookie is " + req.cookies['user_id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p, tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'cong nghe' and s.masp = p.masp
                         and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

//Load Trang Sp Thời trang là sp thuộc loại Thời trang
app.get('/user/load/sp_thoitrang', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p , tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'thoi trang' and s.masp = p.masp 
                    and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

app.get('/admin/load/sp_thoitrang', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p , tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'thoi trang' and s.masp = p.masp 
                    and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

//Load Trang Sp ĐỒ GIA DỤNG là sp thuộc loại do gia dung
app.get('/user/load/sp_dogiadung', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p, tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'do gia dung' and s.masp = p.masp
                    and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done(); // huy ket noi
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

app.get('/admin/load/sp_dogiadung', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, loaisp l, phiendaugia p, tinhtrangphiendg t
                    WHERE s.loaisp = l.maloaisp and l.tenloai = 'do gia dung' and s.masp = p.masp
                    and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done(); // huy ket noi
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

// Update Thời gian đấu giá mỗi 1s
app.get('/capNhatThoiGianDau/:id/:time', (req, res) => {
    var id_sp = parseInt(req.params['id'])
    var thoigian = req.params['time']
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`update phiendaugia
                    set thoigiandau ='`+ thoigian + `'
                    where masp = `+ id_sp
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log("Loi:   " + err);
                    res.status(404).send(err)
                }
                //res.json(result.rows)
                res.send("true")
            })
    });
})

// Update Tình trạng phiên đấu giá khi hết thời gian + 
// Update mã phiếu đấu thắng vào table phiendaugia nếu phiên đgđấu giá đó có người đấu giá
app.get('/user/capNhatTinhTrangPhien/:maphien', (req, res) => {
    var maphiendg = parseInt(req.params['maphien'])
    var tinhtrangphien = 3       // tên tinhtrangphien = "da dau gia"
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT p.*
                    FROM phieudaugia p
                    WHERE  p.maphiendg = ` + maphiendg // + ` and p.matinhtrang = t.matinhtrangphieudg and t.tentinhtrangphieudg = 'dau gia thanh cong'`
            , function (err, result) {
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                // phải tách 2 trường hợp là phiên đấu giá này có người đấu hay không
                // vì gộp chung update k hiểu giá trị tham số null truyền vào biến maphieuthang

                // xét nếu phiên đấu giá này không có ai đấu giá => sẽ k tạo ra phiếu đấu giá
                if (result.rowCount == 0) {
                    tinhtrangphien = 4     // tên tinhtrangphien = "khong co dau gia"
                    client.query(`update phiendaugia
                        set matinhtrang =`+ tinhtrangphien + `, thoigiandau = '00:00:00'
                        where maphiendg = `+ maphiendg + ``
                        , function (err, result) {
                            done();
                            if (err) {
                                res.end();
                                console.log("SAI ROI 1");
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
                            set matinhtrang =`+ tinhtrangphien + `, maphieudauthang =` + maphieuthang + `, thoigiandau = '00:00:00'
                            where maphiendg = `+ maphiendg + ``
                        , function (err, result) {
                            done();
                            if (err) {
                                res.end();
                                console.log("SAI ROI 2");
                                console.log(err);
                                res.status(400).send(err)
                            }
                            res.send("cap nhat tinh trang phien + mã phiếu thắng thành công")
                        })
                }
            })
    })
})

// Load các sản phẩm mà user đang đấu giá khi nhấn nút Đấu Giá Của Tôi trên header_user
app.get('/user/load/daugiacuatoi', (req, res) => {
    console.log("Cookie is " + req.cookies['user_id'])
    var matk = parseInt(req.cookies['user_id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*, ph.*, tt.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t, phieudaugia ph, tinhtrangphieudg tt
                    WHERE s.masp = p.masp and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'dang dau gia'
                          and p.maphiendg = ph.maphiendg and ph.matinhtrang = tt.matinhtrangphieudg 
                          and ph.matk = ` + matk + ``
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }

                if (result.rowCount == 0) {
                    res.send({ status: 'false' });
                    res.end()
                }
                else {
                    // QUÁ HAY: có thể gửi dạng json kèm theo, đưa nó vào 1 biến, để bên client có thể lấy qua
                    res.send({ status: 'true', detail: result.rows });
                }
            });
    });
})

// Load thong tin cua user đang đăng nhập 
app.get('/user/load/InfoUser', (req,res) =>{
    console.log("Cookie is " + req.cookies['user_id'])
    var matk = parseInt(req.cookies['user_id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT t.*
                    FROM taikhoan t
                    WHERE t.matk = ` + matk + ``
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }

                if (result.rowCount == 0) {
                    res.send({ status: 'false' });
                    res.end()
                }
                else {
                    //gửi dạng json kèm theo, đưa nó vào 1 biến, để bên client có thể lấy qua
                    //console.log("thanhcong")
                    //console.log(result.rows)
                    res.send({ status: 'true', detail: result.rows });
                }
            });
    })
})



// update lại thông tin user muốn chỉnh sữa

app.get('/user/update/InfoUser', (req, res) => {
    console.log("Cookie is " + req.cookies['user_id'])
    var matk = parseInt(req.cookies['user_id'])
    //var tendn = req.query.tendn
    var pass1 = req.query.mk1
    var pass2 = req.query.mk2
    var sdt = req.query.sdt
    var diachi = req.query.diachi

    //console.log(tendn);

    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`update taikhoan
                      set matkhau = '` + pass1 + `', sdt ='` + sdt + `', diachi = '` + diachi + `'
                      WHERE matk = `+matk+``
                , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }

                else {
                    res.send("update thông tin thành công");
                    
                }
            });
    })
})


// Load các sản phẩm mà user đấu giá thành công khi nhấn nút Giỏ Hàng trên header_user
app.get('/user/load/gioHang', (req, res) => {
    console.log("Cookie is " + req.cookies['user_id'])
    var matk = parseInt(req.cookies['user_id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*, ph.*, tt.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t, phieudaugia ph, tinhtrangphieudg tt
                    WHERE s.masp = p.masp and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'da dau gia'
                          and p.maphiendg = ph.maphiendg and ph.matinhtrang = tt.matinhtrangphieudg and  p.thanhtoan ='false'
                          and tt.tentinhtrangphieudg = 'dau gia thanh cong' and ph.matk = ` + matk + ``
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }

                if (result.rowCount == 0) {
                    res.send({ status: 'false' });
                    res.end()
                }
                else {
                    // QUÁ HAY: có thể gửi dạng json kèm theo, đưa nó vào 1 biến, để bên client có thể lấy qua
                    res.send({ status: 'true', detail: result.rows });
                }
            });
    });
})

// khi người dùng muốn xóa 1 sp khi đã đấu giá thành công và hiện trên giỏ hàng
app.delete('/user/updateKhongThanhToan/:a', (req, res) => {
    var maphiendaugia = parseInt(req.params['a'])
    console.log(maphiendaugia)
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connect" + err)
            res.status(404).send(err)
        }
        client.query(`update phiendaugia
                    set matinhtrang = 5
                    where maphiendg = ` + maphiendaugia
            , function (err, result) {
                done()
                if (err) {
                    res.end()
                    console.log("Loi: " + err)
                    res.status(404).send(err)
                }
                res.send("Xóa sản phẩm trong giỏ hàng thành công")
            })
    })
})

// Khi ng dùng nhấn nút thanh toán trong giỏ hàng
app.get('/user/thanhToan', (req, res) => {
    var matk = parseInt(req.cookies['user_id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }

        client.query(`SELECT ph.*
                    FROM phieudaugia ph, tinhtrangphieudg t, phiendaugia p, tinhtrangphiendg tp
                    WHERE ph.matinhtrang = t.matinhtrangphieudg and t.tentinhtrangphieudg = 'dau gia thanh cong' 
                    and p.matinhtrang = tp.matinhtrangphiendg and tp.tentinhtrangphiendg = 'da dau gia'
                    and p.maphieudauthang = ph.maphieudg and ph.matk = ` + matk
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log("Loi:   " + err);
                    res.status(400).send(err)
                }
                for (var i = 0; i < result.rowCount; i++) {
                    console.log("MA PHIEU Da Dau thang: " + result.rows[i].maphieudg)
                    //xét xem ma phieu nào đã đấu thắng trong tất cả các mã phiếu
                    client.query(`update phiendaugia
                    set thanhtoan ='true'
                    where maphieudauthang = `+ result.rows[i].maphieudg
                        , function (err, result1) {
                            //call `done()` to release the client back to the pool
                            done();
                            if (err) {
                                res.end();
                                console.log("Loi:   " + err);
                                res.status(400).send(err)
                            }
                        })
                }
                res.send("Thanh toán thành công")
            })
    })
})

// Chi tiết sản phẩm
app.get('/user/load/chitiet/:id', (req, res) => {
    var id_sp = parseInt(req.params['id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*, t.giatri
                    FROM sanpham s, phiendaugia p, thamso t
                    WHERE s.masp = ` + id_sp + ` and s.masp = p.masp and t.tenthamso = 'delta so tien'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

app.get('/admin/load/chitiet/:id', (req, res) => {
    var id_sp = parseInt(req.params['id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*, t.giatri
                    FROM sanpham s, phiendaugia p, thamso t
                    WHERE s.masp = ` + id_sp + ` and s.masp = p.masp and t.tenthamso = 'delta so tien'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            })
    });
})

app.get('/loadtop10/:id', (req, res) => {
    var id_sp = parseInt(req.params['id'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT t.tentk, ph.giadau
                    FROM taikhoan t, phiendaugia p, phieudaugia ph
                    WHERE p.masp = ` + id_sp + `and ph.maphiendg = p.maphiendg and t.matk = ph.matk
                    ORDER BY ph.giadau DESC`
            ,function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                }
                res.json(result.rows)
            });
    });
})
///--------------//////
app.get('/user/daugia/:a/:b/:c/:d', (req, res) => {
    var gia = parseInt(req.params['a'])
    var pheptinh = req.params['b']
    var giathau = parseInt(req.params['c'])
    var delta = parseInt(req.params['d'])
    if(gia < 10 )
        delta = 2
    if (pheptinh == 'tru' && gia > giathau)
        gia = gia - delta
    else if (pheptinh == 'cong')
        gia = gia + delta
    if (gia < 1)
        gia = 1
    // Gui tra ve cho client du lieu ma Server da xu li
    // vi khi tra ve cho client luon phai la dang chuoi,
    // khong duoc la kieu so nen se tien hanh ep kieu
    res.send(gia.toString())
})

// Thực hiện đấu giá (QUAN TRỌNG)
// cập nhật hoặc tạo 1 phiếu đấu giá khi user chọn 1 sp đấu giá
app.get('/user/create_update_PhieuDG', (req, res) => {
    var maphien = parseInt(req.query.maphien)
    // var masp =  parseInt(req.query.masp)
    console.log("Cookie is " + req.cookies['user_id'])
    var matk = parseInt(req.cookies['user_id'])
    var giadau = parseInt(req.query.giadau)
    var tinhtrangphieu = parseInt(req.query.matinhtrang)
    var maphieu = 0
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }

        client.query(`SELECT p.*
                    FROM phieudaugia p
                    WHERE p.maphiendg = ` + maphien + ` and p.matk = ` + matk + ``
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                var check = result.rowCount
                console.log("1: update  0: insert" + check)
                if (check != '0') {
                    // khi tk này đã đấu giá sp này rồi thì trong phieudg sp của tk này là update giá và tình trạng
                    maphieu = parseInt(result.rows[0].maphieudg)

                    client.query(`update phieudaugia
                              set giadau =`+ giadau + `, matinhtrang =` + tinhtrangphieu +
                        `where maphieudg = ` + maphieu)
                }
                else {
                    // khi tk này chưa đấu giá sp này thì ta tạo 1 phiếudg sp này cho tk hiện tại
                    client.query(`insert into phieudaugia(maphiendg,matk,giadau,matinhtrang)
                            values(`+ maphien + `,'` + matk + `','` + giadau + `',` + tinhtrangphieu + `)`)

                }

                console.log("maphieu:" + maphieu)
                console.log("MAPHIEN:" + maphien)
                //update lại tình trạng của các tài khoản khác cũng đấu giá sản phẩm này thành dg không thành công
                client.query(`update phieudaugia
                              set matinhtrang = 2
                             where maphiendg = `+ maphien + ` and matk != ` + matk)

                // update lại giá hiện tại khi 1 tk nâng giá lên của sp trong phiendaugia + maphieudauthang la maphieu hiện tại
                client.query(`update phiendaugia
                        set giahientai =`+ giadau +
                    `where maphiendg = ` + maphien)
                client.query(`SELECT p.*
                    FROM phiendaugia p
                    WHERE p.maphiendg =` + maphien
                    , function (err, result1) {
                        res.json(result1.rows[0])
                    });
            });
    });
})


//          ADMIN       //
app.get('/admin/load/sp_dadaugia', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*
                    FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                    WHERE s.masp = p.masp and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'da dau gia'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

app.get('/admin/load/sp_khongdaugia', (req, res) => {
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }
        client.query(`SELECT s.*, p.*
                FROM sanpham s, phiendaugia p, tinhtrangphiendg t
                WHERE s.masp = p.masp and p.matinhtrang = t.matinhtrangphiendg and t.tentinhtrangphiendg = 'khong co dau gia' and s.Isdelete = 'false'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                res.json(result.rows)
            });
    });
})

app.get('/admin/donotpay', (req, res) =>{
    pool.connect(function(err, client, done){
        if (err) {
            console.log("not able to get connect" + err)
            res.status(404).send(err)
        }
        client.query(`SELECT p.*, s.* ,(select count(*)
                    from phiendaugia p2
                    where p2.masp = p.masp) as solandg
                    FROM phiendaugia p, sanpham s
                    WHERE matinhtrang = 5 and p.masp = s.masp and s.isdelete = false`
        , function(err, result){
            done()
            if(err){
                console.log(err)
                res.end()
            }
            res.json(result.rows)
        })
    })
})

app.delete('/admin/delete/:a', (req, res) => {
    var id = parseInt(req.params['a'])
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connect" + err)
            res.status(404).send(err)
        }
        client.query(`update sanpham
                    set Isdelete = 'True'
                    where masp = ` + id
            , function (err, result) {
                done()
                if (err) {
                    res.end()
                    console.log("Loi: " + err)
                    res.status(404).send(err)
                }

                res.send("Xóa thành công")
            })
    })
})

app.get('/admin/createProduct', (req, res) => {
    //console.log(req.query)
    var tinhtrangphien = 2
    var tensp = req.query.tensp
    var gia = parseInt(req.query.giatien)
    var loai = parseInt(req.query.phanloai)
    var mota = req.query.chitiet
    var tgbd = req.query.thoigianbd     // nam-thang-ngay
    var tgdau = req.query.thoigiandau
    // cắt thành 2 chuỗi: 1/ ngày   2/ giờ
    var fullTime = []
    fullTime = tgbd.split(" ");
    // cắt chuỗi ngày thành 3 chuỗi: 1/ nam   2/ tháng     3/ngay
    var date = []
    date = fullTime[0].split("-");
    // lấy ngày hiện tại kiểm tra
    var d = new Date();
    console.log(d.getDate())
    console.log(d.getMonth())   // vì tháng là từ 0-> 11 nên tháng thực tế phải +1
    var thang = parseInt(d.getMonth()) + 1
    console.log(d.getFullYear())
    if (date[2] == d.getDate() && date[1] == thang && date[0] == d.getFullYear())
        tinhtrangphien = 1

    var hinhanh = req.query.hinhanh
    console.log(hinhanh)
    var arr = []
    arr = hinhanh.split("\\");
    console.log(arr[2])
    var img = arr[2]
    pool.connect(function (err, client, done) {
        if (err) {
            console.log("not able to get connection " + err);
            res.status(400).send(err);
        }

        client.query(`INSERT INTO sanpham(loaisp, hinhanh, info, isnew, isdelete, mota)
                    values(` + loai + `,'` + img + `','` + tensp + `', true, false, '` + mota + `')`)
        client.query(`SELECT s.*
                    FROM sanpham s
                    WHERE s.info = '` + tensp + `'`
            , function (err, result) {
                //call `done()` to release the client back to the pool
                done();
                if (err) {
                    res.end();
                    console.log(err);
                    res.status(400).send(err)
                }
                var masp = parseInt(result.rows[0].masp)
                var ttp = parseInt(tinhtrangphien)
                client.query(`insert into phiendaugia(masp,thoigianbd,thoigiandau,giathapnhat,giahientai,maphieudauthang,matinhtrang,thanhtoan)
                            values(`+ masp + `,'` + tgbd + `','` + tgdau + `',` + gia + `,` + gia + `,null,` + ttp + `, false)`)
                //res.json(masp)
                res.send("Thêm sản phẩm thành công")
            });
    })
})

app.listen(3000, () => console.log("Success"))