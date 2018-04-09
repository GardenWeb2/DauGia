var express = require('express');
var app = express();

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

app.get('/congNghe', (req, res) => {

    res.sendfile('congNghe.html')
})

app.get('/thoiTrang', (req, res) => {

    res.sendfile('thoiTrang.html')
})

app.get('/doGiaDung', (req, res) => {

    res.sendfile('doGiaDung.html')
})

app.get('/shopping', (req, res) => {

    res.sendfile('shopping-cart.html')
})

app.get('/daugiacuatoi', (req, res) => {

    res.sendfile('daugiacuatoi.html')
})

app.get('/chitiet', (req, res) => {
    res.sendfile('chitietsp.html')
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

app.get('/spKhongDauGia', (req, res) => {
    res.sendfile('spKhongDauGia_admin.html')
})

///--------------//////

app.get('/daugia/:a/:b', (req, res) => {
    var gia = parseInt(req.params['a'])
    var pheptinh = req.params['b']
    if( pheptinh == '-' &&  gia > 15)
        gia = gia - 15
    else if( pheptinh == '+')
        gia = gia + 15
    if( gia == 1)
        gia = 1
    // Gui tra ve cho client du lieu ma Server da xu li
    // vi khi tra ve cho client luon phai la dang chuoi,
    // khong duoc la kieu so nen se tien hanh ep kieu
    res.send(gia.toString())
})

app.listen(3000, () => console.log("Success"))