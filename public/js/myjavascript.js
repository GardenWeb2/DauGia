function anRandom() {
    $('#hot').hide()
    $('#hetthoigian').hide()
}

function anALL() {
    // an ben user
    $('#UserHeader').hide()
    $('#ChinhSuaUserHeader').hide()
    $('#signup').hide()
    $('#congnghe').hide()
    $('#thoitrang').hide()
    $('#dogiadung').hide()
    $('#chitietsp').hide()
    $('#CacSPDangDauGia').hide()
    $('#idGioHang').hide()
    $('.luachon').hide()

    //an ben admin
    $('.sp_DaDG').html("")
    $('.sp_KhongDG').html("")
    $('.sp_KhongTT').html("")
    $('.menu').hide();
    $('#header_admin').hide()
    $('#insertSP').hide()
    $('#spDaDG').hide()
    $('#spKhongDG').hide()
    $('#spKhongTT').hide()
}


// setInterval cho thời gian thay đổi ở các trang bên ngoài
function thoiGianGiam(data, loaiid, solan) {
    setInterval(function () {
        var tagId = "#" + loaiid + data.masp + "_" + solan
        var arr = []
        arr = $(tagId).text().split(":"); // 00:03:40
       
        if (arr[0] != "" && $(tagId).text() != '00:00:00') {
            var gio = parseInt(arr[0])
            var phut = parseInt(arr[1])
            var giay = parseInt(arr[2])

            var thoigiantd = ""
            if (gio > 0 && phut == 0 && giay == 0) {
                gio = gio - 1
                phut = 59
                giay = 60
            }
            else if (phut > 0 && giay == 0) {
                phut = phut - 1
                giay = 60
            }

            giay = giay - 1

            if (gio < 10)
                gio = '0' + gio
            if (phut < 10)
                phut = '0' + phut
            if (giay < 10)
                giay = '0' + giay

            thoigiantd = gio + ':' + phut + ':' + giay
            $(tagId).text(thoigiantd)

            // nếu sp còn thời gian thì cập nhật thời gian thay đổi xuống database
            // ngược lại nếu hết thời gian thì sẽ update tình trạng phiên đấu giá 
            // hoặc có thể update thêm người đấu giá thắng sp + thời gian = '00:00:00'
            if (thoigiantd != "00:00:00") { //  && thoigiantd != "00:00:00"
                capNhatThoigianDG(data.masp, thoigiantd)
            }
            else {    // khi hết thời gian thì cập nhật tình trạng, thời gian
                capNhatTinhTrangPhienDG(data.maphiendg)
            }
        }
    }, 1000)
}

// setInterval cho thời gian thay đổi ở các trang chi tiết, 
//giống code bên trên nhưng không cần chạy hàm cập nhật lại thời gian sau 1s vì ở trên đã cập nhật rồi
function thoiGianGiamChiTiet(masp, loaiid, solan) {
    setInterval(function () {
        var tagId = "#" + loaiid + masp + solan
        var arr = []
        arr = $(tagId).text().split(":"); // 00:03:40
        var gio = parseInt(arr[0])
        var phut = parseInt(arr[1])
        var giay = parseInt(arr[2])

        if (arr[0] != "" && $(tagId).text() != '00:00:00') {
            var thoigiantd = ""
            if (gio > 0 && phut == 0 && giay == 0) {
                gio = gio - 1
                phut = 59
                giay = 60
            }
            else if (phut > 0 && giay == 0) {
                phut = phut - 1
                giay = 60
            }
            else if (gio == 0 && phut == 0 && giay == 0) {
                giay = giay + 1
            }

            giay = giay - 1

            if (gio < 10)
                gio = '0' + gio
            if (phut < 10)
                phut = '0' + phut
            if (giay < 10)
                giay = '0' + giay

            thoigiantd = gio + ':' + phut + ':' + giay
            $(tagId).text(thoigiantd)
        }
    }, 1000)
}

// update xuống postgre sau mỗi 1s
function capNhatThoigianDG(masp, thoigian) {
    $.ajax({
        url: '/capNhatThoiGianDau/' + masp + '/' + thoigian,
        method: 'get',
        success(data) {
            //console.log(data)
        }
    })
}

function capNhatTinhTrangPhienDG(maphien) {
    $.ajax({
        url: '/user/capNhatTinhTrangPhien/' + maphien,
        method: 'get',
        success(data) {
            console.log(data)
        },
        error(err) {
            console.log(err)
        },
    })
}

function loadSPHotUser(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/user/load/sp_hot',
        method: 'get',
        success(data) {
            // Không được gộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_hot').html("")

            for (var i = 0; i < data.length; i++) {
                var tagId = "#idhot" + data[i].masp
                $(tagId).text("")
                $('.sp_hot').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` +
                    `Thời gian:      <strong id="idhot` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                            <button class="btn-default" onclick="xemChitietUser(this, solanchitiet)" value="` +
                    data[i].masp + `" > Đấu Giá Ngay</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idhot", solan)
            }
        },
        error(err) {
            $('.sp_hot').status(404)
        },
    })
}

function loadSPHotAdmin(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/admin/load/sp_hot',
        method: 'get',
        success(data) {
            anALL()
            $('#hetthoigian').hide()
            $('#header_admin').show()
            // Không được gộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_hot').html("")

            for (var i = 0; i < data.length; i++) {
                var tagId = "#idhot" + data[i].masp
                $(tagId).text("")
                $('.sp_hot').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` + 
                    `Thời gian:      <strong id="idhot` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                            <button class="btn-default" onclick="xemChitietAdmin(this, solanchitiet)" value="` +
                    data[i].masp + `" > Xem chi tiết</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idhot", solan)
            }

        },
        error(err) {
            $('.sp_hot').status(404)
        },
    })
}

function loadSPHetThoiGianDauUser(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/user/load/sp_hettg',
        method: 'get',
        success(data) {
            // Không được gộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_hettg').html("")
            for (var i = 0; i < data.length; i++) {
                $('.sp_hettg').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` +
                    `Thời gian:      <strong id="idhettg` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                            <button class="btn-default" onclick="xemChitietUser(this, solanchitiet)" value="` +
                    data[i].masp + `" > Đấu Giá Ngay</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idhettg", solan)
            }
        },
        error(err) {
            $('.sp_hettg').status(404)
        },
    })
}

function loadSPHetThoiGianDauAdmin(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/admin/load/sp_hettg',
        method: 'get',
        success(data) {
            anALL()
            $('#hot').hide()
            $('#header_admin').show()
            // Không được gộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_hettg').html("")
            for (var i = 0; i < data.length; i++) {
                $('.sp_hettg').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` +
                    `Thời gian:      <strong id="idhettg` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                            <button class="btn-default" onclick="xemChitietAdmin(this, solanchitiet)" value="` +
                    data[i].masp + `" > Xem chi tiết</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idhettg", solan)
            }
        },
        error(err) {
            $('.sp_hettg').status(404)
        },
    })
}

function loadSPCongNgheUser(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/user/load/sp_congnghe',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            $('#congnghe').show()
            // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_congnghe').html("")
            for (var i = 0; i < data.length; i++) {
                $('.sp_congnghe').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` +
                    `Thời gian:      <strong id="idspcn` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                        <button class="btn-default" onclick="xemChitietUser(this, solanchitiet)" value="` +
                    data[i].masp + `" > Đấu Giá Ngay</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idspcn", solan)
            }
        },
        error(err) {
            $('.sp_congnghe').status(404)
        },
    })
}

function loadSPCongNgheAdmin(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/admin/load/sp_congnghe',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            $('#header_admin').show()
            $('#congnghe').show()
            // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_congnghe').html("")
            for (var i = 0; i < data.length; i++) {
                $('.sp_congnghe').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` +
                    `Thời gian:      <strong id="idspcn` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                        <button class="btn-default" onclick="xemChitietAdmin(this, solanchitiet)" value="` +
                    data[i].masp + `" > Xem chi tiết</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idspcn", solan)
            }
        },
        error(err) {
            $('.sp_congnghe').status(404)
        },
    })
}

function loadSPDoGiaDungUser(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/user/load/sp_dogiadung',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            $('#dogiadung').show()
            // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_dogiadung').html("")
            for (var i = 0; i < data.length; i++) {
                $('.sp_dogiadung').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` +
                    `Thời gian:      <strong id="idspdgd` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                        <button class="btn-default" onclick="xemChitietUser(this, solanchitiet)" value="` +
                    data[i].masp + `" > Đấu Giá Ngay</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idspdgd", solan)
            }
        },
        error(err) {
            $('.sp_dogiadung').status(404)
        },
    })
}

function loadSPDoGiaDungAdmin(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/admin/load/sp_dogiadung',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            $('#header_admin').show()
            $('#dogiadung').show()
            // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_dogiadung').html("")
            for (var i = 0; i < data.length; i++) {
                $('.sp_dogiadung').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` + 
                    `Thời gian:      <strong id="idspdgd` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                        <button class="btn-default" onclick="xemChitietAdmin(this, solanchitiet)" value="` +
                    data[i].masp + `" >Xem chi tiết</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idspdgd", solan)
            }
        },
        error(err) {
            $('.sp_dogiadung').status(404)
        },
    })
}

function loadSPThoiTrangUser(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/user/load/sp_thoitrang',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            $('#thoitrang').show()
            // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_thoitrang').html("")
            for (var i = 0; i < data.length; i++) {
                $('.sp_thoitrang').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` +
                    `Thời gian:      <strong id="idsptt` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                        <button class="btn-default" onclick="xemChitietUser(this, solanchitiet)" value="` +
                    data[i].masp + `" > Đấu Giá Ngay</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idsptt", solan)
            }
        },
        error(err) {
            $('.sp_thoitrang').status(404)
        },
    })
}

function loadSPThoiTrangAdmin(i, k) {
    solan = i
    solanchitiet = k
    $.ajax({
        url: '/admin/load/sp_thoitrang',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            $('#header_admin').show()
            $('#thoitrang').show()
            // Không được gộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_thoitrang').html("")
            for (var i = 0; i < data.length; i++) {
                $('.sp_thoitrang').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    data[i].hinhanh + `" width="300" hight="300">` +
                    `Thời gian:      <strong id="idsptt` + data[i].masp + `_` + solan + `" >` +
                    data[i].thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    data[i].giahientai + "K" +
                    `</span></br>
                        <button class="btn-default" onclick="xemChitietAdmin(this, solanchitiet)" value="` +
                    data[i].masp + `" >Xem chi tiết</button></div></div></div>`
                )
                thoiGianGiam(data[i], "idsptt", solan)
            }
        },
        error(err) {
            $('.sp_thoitrang').status(404)
        },
    })
}

function showHome_User(i, k) {
    anALL()
    $('#login').hide()
    $('#header_user').show()
    $('#hot').show()
    $('#hetthoigian').show()

    loadSPHotUser(i, k)
    loadSPHetThoiGianDauUser(i, k)
}

$(document).ready(() => {
    anRandom()
    anALL()
    $('#header_user').hide()

    $('#btndangki').click(function () {
        $('#login').hide()
        $('#signup').show()
    })

    $('#btnDangNhap').click(function () {
        $('#login').show()
        $('#signup').hide()
    })

    $('#btnUserHeader').click(function () {
        anALL()
        anRandom()
        $('#UserHeader').show()
        loadInfoUser()
    })

    $('#ChinhSuaInfoUser').click(function () {
        anALL()
        anRandom()
        $('#ChinhSuaUserHeader').show()
    })

    $('#UpdateInfoUser').click(function () {
        anALL()
        anRandom()
        UpdateInfoUser()
    })

    var demHome = 1
    var demChitiet = 1
    $('#btnhome').click(function () {
        showHome_User(demHome, demChitiet);
        demHome++
        demChitiet++
    })

    var demCongnghe = 0
    $('#btncongnghe').click(function () {
        loadSPCongNgheUser(demCongnghe, demChitiet)
        demCongnghe++
        demChitiet++
    })

    var demThoitrang = 0
    $('#btnthoitrang').click(function () {
        loadSPThoiTrangUser(demThoitrang, demChitiet)
        demThoitrang++
        demChitiet++
    })

    var demDogiadung = 0
    $('#btndogiadung').click(function () {
        loadSPDoGiaDungUser(demDogiadung, demChitiet)
        demDogiadung++
        demChitiet++
    })

    $('#btnDauGiaCuaToi').click(function () {
        anALL()
        anRandom()
        $('#CacSPDangDauGia').show();
        loadDauGiaCuaToi()
    })

    $('#btnGioHang').click(function () {
        anALL()
        anRandom()
        $('#idGioHang').show();
        loadGioHang()
    })

    $('#btnTiepTucMua').click(function () {
        showHome_User(demHome, demChitiet);
        demHome++
        demChitiet++
    })

    $('#btnThanhToan').click(function () {
        thanhToan()
    })

    $('#btndangxuat').click(function () {
        resetCookies('user')
        location.reload();
    })

    nutAdmin()      // các nút trên header_admin bên trang admin
})

function loadDauGiaCuaToi() {
    $.ajax({
        url: '/user/load/daugiacuatoi',
        method: 'get',
        success(data) {
            var i = 1
            $('.tbody4').html("")
            if (data.status == "true") {
                data.detail.forEach(x => {
                    $('.table').append(
                        `<tr>` +
                        `<td>` + `<p>` + i + `</p>` + `</td>` +
                        `<td>` + `<p>` + x.info + `</p>` + `<td>` +
                        `<img src="./img/` + x.hinhanh + `"width="100" hight="100">` +
                        `<td>` + x.giadau + ` K </td>` +
                        `<td>` + x.giahientai + ` K </td>` +
                        `<td>` + x.tentinhtrangphieudg + `</td>` +
                        `</tr>`
                    )
                    i++
                })
            }
            else {
                $('.table').html("")
            }
        },
        error(err) {
            $('.lichSuDG').status(404)
        },
    })
}

// Thogn tin cua tai khoan dang dang nhap
function loadInfoUser() {
    $.ajax({
        url: '/user/load/InfoUser',
        method: 'get',
        success(data) {
            if (data.status == "true") {
                //console.log(data.detail[0].tentk);
                $('#Ten').val(data.detail[0].tentk);
                $('#SDT').val(data.detail[0].sdt);
                $('#DiaChi').val(data.detail[0].diachi);
            }
            else {
                console.log(err)
            }
        },
        error(err) {
            console.log(err)
        },
    })
}

// update lai thong tin cua user khi chinh sua
function UpdateInfoUser() {
    //var tendn =  $('#TenUser').val();
    $('#TenUser').text($('#idUserHeader').text)
    var mk1 = $('#pass1').val();
    var mk2 = $('#pass2').val();
    var sdt = $('#updateSDT').val();
    var diachi = $('#updateDiaChi').val();

    $.ajax({
        url: '/user/update/InfoUser',
        method: 'get',
        data: {
            //tendn:tendn,
            mk1: mk1,
            mk2: mk2,
            sdt: sdt,
            diachi: diachi
        },
        success(data) {
            loadlaiformChinhSua()
            alert(data)
        }
    })

}

function loadlaiformChinhSua() {
    $('#TenUser').val("");
    $('#pass1').val("");
    $('#pass2').val("");
    $('#updateSDT').val("");
    $('#updateDiaChi').val("");
}

// Giỏ hàng của người dùng
function loadGioHang() {
    $.ajax({
        url: '/user/load/gioHang',
        method: 'get',
        success(data) {
            var tongtien = 0
            $('.tbody3').html("")
            $('.tongTien').html("")
            if (data.status == "true") {
                data.detail.forEach(x => {
                    tongtien += parseInt(x.giadau)
                    $('.tableShopping').append(
                        `<tr>` +
                        `<td class="col-sm-2">` + x.info + `</td>
                            <td class="col-sm-2">   1 </td>
                            <td class="col-sm-2">`+ x.giadau + `000 </td>
                            <td class="col-sm-2">  <button class="btn-default" onclick="khongMua(this)" value="` + x.maphiendg + `"> Xóa </button>  </td>
                         </tr>`
                    )
                })
                $('.tongTien').append(
                    `<tr>
                        <td>
                            <h4>Thành tiền:         ` + tongtien.toString() + `000 VNĐ </h4>
                        </td>
                    </tr> `
                )
                $('.luachon').show()
            }
            else {
                $('.tableShopping').html("")
            }
        },
        error(err) {
            console.log(err)
        },
    })
}

// khi người dùng nhấn nút thanh toán trong giỏ hàng,
// sẽ đổi cột thanhtian trong phiendaugia thành 'true'
function thanhToan() {
    $.ajax({
        url: '/user/thanhToan',
        method: 'get',
        success(data) {
            $('#idGioHang').html("")
            alert(data)
        },
        error(err) {
            console.log(err)
        },
    })
}

function xemChitietUser(e, i) {
    var id = $(e).val()
    var solan = i
    $.ajax({
        url: '/user/load/chitiet/' + id,
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            $('#chitietsp').show()
            $('.chitiet_sp').html("")
            data.forEach(x => {
                $('#ten_ctsp').text(x.info)
                var giadau_toithieu = parseInt(x.giahientai) + 1
                $('.chitiet_sp').append(
                    `<div class="col-sm-3 col-md-3 hinh">
                                <div class="thumbnail" style="height:350px">
                                <img src='./img/` + x.hinhanh + `' width="300px" hight="350px">           
                        </div>
                            </div>
                            <div class="col-sm-5 col-md-5">
                                <div class="thumbnail" style="height:350px">
                                    <div class="caption" aligint="center">
                                        <h4> Kết thúc trong: </h4>
                                        <h2>
                                            <span style="color: red">
                                                <strong id="idchitietsp`+ x.masp + solan + `">` + x.thoigiandau + `</strong>
                                            </span>
                                        </h2>
                                        <h4> Giá thầu hiện tại: </h4>
                                        <h2>
                                            <span style="color: black">
                                                <strong > <span id="giathau">` + x.giahientai + ` </span> K </strong>
                                            </span>
                                        </h2>
                                        <p>
                                            <h4> Đấu giá ngay: </h4>
                                            <div class="input-group">
                                                <span class="input-group-btn">
                                                <button onclick="giaTienThayDoi(this)" value="tru" class="btn btn-danger btn-number" data-type="minus" data-field="quant">
                                                <span class="glyphicon glyphicon-minus"></span>
                                                </button>
                                                </span>
                                                <input value="`+ giadau_toithieu + `" id="giadau" class="form-control input-number" type="text" style="width: 70px">
                                                <button onclick="giaTienThayDoi(this)" value="cong" class="btn btn-success btn-number" data-type="plus" data-field="quant">
                                                    <span class="glyphicon glyphicon-plus"></span>
                                                </button> K
                                            </div>
                                            <br>
                                            
                                            <button onclick="dauGia(this)" value class="btn btn-default" role="button"> Đấu Giá </button>
                                        </p>
                                        <input id="deltasoluong" value="`+ x.giatri + `"type="hidden">
                                        <input id="idmaPhienDG" value="`+ x.maphiendg + `"type="hidden">
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="thumbnail" style="height:350px">
                                    <div class="navigat">
                                        <h2>Top 10 đấu giá:</h2>
                                    </div>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>User</th>
                                                <th>Giá đấu</th>
                                            </tr>
                                        </thead>
                                        <tbody class="tbodytop10">
                                            <div class="top10">
                                            </div>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                                <!--    Phần dưới chi tiết thông tin       !-->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3> Thông tin sản phẩm </h3>
                                    </div>
                                    <div class="panel-body">
                                        <span> <p> Chi tiết sản phẩm</p>`+ x.mota + `</span>
                                    </div>
                                    </div> `
                )
            thoiGianGiamChiTiet(id, "idchitietsp", solan)    // load thời gian chạy setInterval các sản phẩm trong trang chi tiết                            
            });
        },
        error(err) {
            console.log(err)
        },
    })
    loadTop10(id)
}

function loadTop10(e) {
    var id = $(e).val()
    $.ajax({
        url: '/loadtop10/' + e,
        method: 'get',
        success(data) {
            $('.tbodytop10').html("")
            var i = 1
            data.forEach(x => {
                if (i == 1) {
                    $('.table').append(
                        `<tr>` +
                        `<td>` + `<p> <span class="glyphicon glyphicon-king"></span>` + i + `</p>` + `</td>` +
                        `<td>` + `<p>` + x.tentk + `</p>` + `</td>` +
                        `<td>` + `<p>` + x.giadau + `</p>` + `</td>` +
                        `</tr>`
                    )
                }
                else {
                    $('.table').append(
                        `<tr>` +
                        `<td>` + `<p>` + i + `</p>` + `</td>` +
                        `<td>` + `<p>` + x.tentk + `</p>` + `</td>` +
                        `<td>` + `<p>` + x.giadau + `</p>` + `</td>` +
                        `</tr>`
                    )
                }
                i++
            })
        },
        error(err) {
            console.log(err)
            $('.top10').status(404)
        }
    })
}

function giaTienThayDoi(e) {
    var giadau = $('#giadau').val()
    var loai = $(e).val()
    var giathau = $('#giathau').text()
    var delta = $('#deltasoluong').val()
    $.ajax({
        url: '/user/daugia/' + giadau + '/' + loai + '/' + giathau + '/' + delta,
        method: 'get',
        success(data) {
            var gia = parseInt(data)
            $('#giadau').val(gia)
        },
        error(err) {
            $('#giadau').val(err)
        },
    })
}

function dauGia(e) {
    var id = $(e).val()
    var maphiendg = $('#idmaPhienDG').val()
    var giadau = $('#giadau').val()
    var tinhtrangphieu = 1
    $.ajax({
        url: '/user/create_update_PhieuDG',
        method: 'get',
        data: {
            maphien: maphiendg,
            giadau: giadau,
            matinhtrang: tinhtrangphieu
        },
        success(data) {
            var gia = parseInt(data.giahientai)
            $('#giathau').text(gia)
        },
        error(err) {
            console.log(err)
        },
    })
    // xemChitiet(id, "user")
}

function khongMua(e) {
    var maphiendg = $(e).val()
    $.ajax({
        url: '/user/updateKhongThanhToan/' + maphiendg,
        method: 'delete',
        success(data) {  //: function(response){
            // alert(data)
            loadGioHang()
        },
        error(err) {
            alert(err)
            console.log(err)
        },
    })
}

function resetCookies(loaitk) {
    var type = loaitk
    $.ajax({
        url: '/resetCookies/'+ type,
        method: 'get',
        success(data) { 
        },
        error(err) {
            console.log(err)
        },
    })
}

//      ---------------- ADMIN ----------------
function showHome_Admin() {
    $('#login').hide()
    $('#header_admin').show()
    $('#insertSP').show();

}

function taoSPMoi() {
    var ten = $('#ProName').val();
    var gia = $('#Price').val();
    var checkbox = document.getElementsByName("loaisp");
    var loai = 1;
    for (var i = 0; i < checkbox.length; i++) {
        if (checkbox[i].checked === true) {
            var loai = checkbox[i].value;
        }
    }
    var tgbd = $('#thoigianbd').val();
    var tgdau = $('#thoigiandaugia').val();
    var mota = $('#FullDes').val();
    var img = $('#idImage').val();
    loadLaiBangTaoSP()
    $.ajax({
        url: '/admin/createProduct',
        method: 'get',
        data: {
            tensp: ten,
            giatien: gia,
            phanloai: loai,
            thoigianbd: tgbd,
            thoigiandau: tgdau,
            chitiet: mota,
            hinhanh: img
        },
        success(data) {
            //thoiGianGiamChiTiet(data, "idchitietsp")
            alert(data)
        },
        error(err) {
            $('.thongbao').status(404)
        },
    })
}

function loadLaiBangTaoSP() {
    $('#ProName').val("");
    $('#Price').val("");
    $('#thoigianbd').val("");
    $('#thoigiandaugia').val("");
    $('#FullDes').val("");
    $('#idImage').val("");
}


function xemChitietAdmin(e, i) {
    var id = $(e).val()
    var solan = i
    $.ajax({
        url: '/admin/load/chitiet/' + id,
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            $('#header_admin').show()
            $('#chitietsp').show()
            $('.chitiet_sp').html("")
            data.forEach(x => {
                $('#ten_ctsp').text(x.info)
                $('.chitiet_sp').append(
                    `<div class="col-sm-3 col-md-3 hinh">
                                <div class="thumbnail" style="height:350px">
                                <img src='./img/` + x.hinhanh + `' width="300px" hight="350px">           
                        </div>
                            </div>
                            <div class="col-sm-5 col-md-5">
                                <div class="thumbnail" style="height:350px">
                                    <div class="caption" aligint="center">
                                        <h4> Kết thúc trong: </h4>
                                        <h2>
                                            <span style="color: red">
                                                <strong id="idchitietsp`+ x.masp + solan + `">` + x.thoigiandau + `</strong>
                                            </span>
                                        </h2>
                                        <h4> Giá thầu hiện tại: </h4>
                                        <h2>
                                            <span style="color: black">
                                                <strong > <span id="giathau">` + x.giahientai + ` </span> K </strong>
                                            </span>
                                        </h2>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="thumbnail" style="height:350px">
                                    <div class="navigat">
                                        <h2>Top 10 đấu giá:</h2>
                                    </div>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>User</th>
                                                <th>Giá đấu</th>
                                            </tr>
                                        </thead>
                                        <tbody class="tbodytop10">
                                            <div class="top10">
                                            </div>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                                <!--    Phần dưới chi tiết thông tin       !-->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3> Thông tin sản phẩm </h3>
                                    </div>
                                    <div class="panel-body">
                                        <span> <p> Chi tiết sản phẩm</p>`+ x.mota + `</span>
                                    </div>
                                    </div> `
                )
                thoiGianGiamChiTiet(id, "idchitietsp", solan)    // load thời gian chạy setInterval các sản phẩm trong trang chi tiết                            
            });
        },
        error(err) {
            console.log(err)
        },
    })
    loadTop10(id)
}

function loadSPDaDG() {
    $.ajax({
        url: '/admin/load/sp_dadaugia',
        method: 'get',
        success(data) {
            var i = 1
            $('.tbody1').html("")
            data.forEach(x => {
                $('.table').append(
                    `<tr>` +
                    `<td>` + `<p>` + i + `</p>` + `</td>` +
                    `<td>` + `<p>` + x.info + `</p>` + `<td>` +
                    `<img src="./img/` + x.hinhanh + `"width="100" hight="100">` +
                    `<td>` + x.giahientai + `</td>`
                    + `</tr>`
                )
                i++
            })
        },
        error(err) {
            $('.sp_DaDG').status(404)
        }
    })
}

function loadSPKhongDG() {
    f = 1
    $.ajax({
        url: '/admin/load/sp_khongdaugia',
        method: 'get',
        success(data) {
            var i = 1
            $('.tbody2').html("")
            data.forEach(x => {
                $('.table').append(
                    `<tr>` +
                    `<td>` + `<p>` + i + `</p>` + `</td>` +
                    `<td>` + x.masp + `</td>` +
                    `<td>` + `<p>` + x.info + `</p>` + `<td>` +
                    `<img src="./img/` + x.hinhanh + `"width="100" hight="100">` +
                    `<td><button class="btn-default" onclick="isDelete(this, f)" value="` + x.masp + `"> Delete </button></td>`
                    + `</tr>`
                )
                i++
            })
        },
        error(err) {
            $('.sp_KhongDG').status(404)
        }
    })
}

function loadSPKhongTT() {
    f = 2
    $.ajax({
        url: '/admin/donotpay',
        method: 'get',
        success(data) {
            $('.tbody6').html("")
            var i = 1
            data.forEach(x => {
                $('.table1').append(
                    `<tr>` +
                    `<td>` + i + `</td>` +
                    `<td>` + x.masp + `</td>` +
                    `<td>` + x.info + `</td>` +
                    `<td><img src="./img/` + x.hinhanh + `"width="100" hight="100"> </td>` +
                    `<td>` + x.solandg + `</td>` +
                    `<td><button class="btn-default" onclick="isInsertForPay()" value="` + x.masp + `"> Insert </button></td>` +
                    `<td><button class="btn-default" onclick="isDelete(this, f)" value="` + x.masp + `"> Delete </button></td>` +
                    `</tr>`
                )
                i++
            })
        },
        error(err) {
            $('.sp_KhongTT').status(404)
        }
    })
}

function isInsertForPay() {
    anRandom()
    anALL()
    $('#header_admin').show()
    $('#insertSP').show()
}

function isDelete(e, f) {
    var id = $(e).val()
    if (f == 1) {
        $.ajax({
            url: '/admin/delete/' + id,
            method: 'delete',
            success: function (response) {
                loadSPKhongDG()
            },
            error(err) {
                console.log(err)
                alert("Xóa không thành công!")
            }
        })
    }
    else if (f == 2) {
        $.ajax({
            url: '/admin/delete/' + id,
            method: 'delete',
            success: function (response) {
                loadSPKhongTT()
            },
            error(err) {
                console.log(err)
                alert("Xóa không thành công!")
            }
        })
    }

}

function nutAdmin() {
    $('#btnthemsanpham').click(function () {
        anRandom()
        anALL()
        $('#header_admin').show()
        $('#insertSP').show();
    })

    $('#submitThemSp').click(function () {
        anRandom()
        anALL()
        $('#header_admin').show()
        $('#insertSP').show()
        taoSPMoi()
    })
    var demsphot_ad = 0
    var demsphtg_ad = 0
    var demspcnt_ad = 0
    var demsptt_ad = 0
    var demspdgd_ad = 0
    var demchitiet_ad = 0

    $('#btnsphot2').click(function () {
        $('#insertSP').hide()
        $('#hot').show()
        loadSPHotAdmin(demsphot_ad, demchitiet_ad)
        demsphot_ad++
        demchitiet_ad++
    })

    $('#btnspshtg').click(function () {
        $('#insertSP').hide()
        $('#hetthoigian').show()
        loadSPHetThoiGianDauAdmin(demsphtg_ad, demchitiet_ad)
        demsphtg_ad++
        demchitiet_ad++
    })

    $('#btncongnghe2').click(function () {
        loadSPCongNgheAdmin(demspcnt_ad, demchitiet_ad)
        demspcnt_ad++
        demchitiet_ad++
    })

    $('#btndogiadung2').click(function () {
        $('#insertSP').hide()
        loadSPDoGiaDungAdmin(demspdgd_ad, demchitiet_ad)
        demspdgd_ad++
        demchitiet_ad++
    })

    $('#btnthoitrang2').click(function () {
        $('#insertSP').hide()
        loadSPThoiTrangAdmin(demsptt_ad, demchitiet_ad)
        demsptt_ad++
        demchitiet_ad++
    })

    $('#btndadaugia').click(function () {
        anALL()
        anRandom()
        $('#header_admin').show()
        $('#spDaDG').show()
        $('.sp_DaDG').show()
        $('.sp_KhongDG').hide()
        loadSPDaDG()
    })

    $('#btnkhongdaugia').click(function () {
        anALL()
        anRandom()
        $('#header_admin').show()
        $('#spKhongDG').show()
        $('.sp_KhongDG').show()
        $('.sp_DaDG').hide()
        loadSPKhongDG()
    })

    $('#btnkhongthanhtoan').click(function () {
        anALL()
        anRandom()
        $('#header_admin').show()
        $('#spKhongTT').show()
        $('.sp_KhongTT').show()
        loadSPKhongTT()
    })

    $('#btndangxuatadmin').click(function () {
        resetCookies('admin')
        anALL()
        anRandom()
        $('#login').show()
        location.reload()
    })
}

function login() {
    var name = $('#nametxt').val()
    var pass = $('#namepass').val()
    $.ajax({
        url: '/login',
        method: 'get',
        data: {
            username: name,
            password: pass
        },
        success(data) {
            if (data.status != "false") {
                //loadAllSPDangDauGia()
                $.ajax({
                    url: '/setCookie/' + data.matk + '/' + data.type,
                    method: 'get',
                    success(data) {
                        console.log("Du lieu nhan duoc: " + data)
                    },
                    error(err) {
                        console.log(err)
                    },
                })
                $('#idUserHeader').text(data.username)
                if (data.type == "user")
                    showHome_User(0, 0)
                else if (data.type == "admin")
                    showHome_Admin()
            }
            else
                alert("Username hoặc Password không đúng ")
        },
        error(err) {
            console.log(err)
        },
    })
}

function signup() {
    var name = $('#user').val()
    var pass = $('#pass').val()
    var passa = $('#passa').val()
    var add = $('#add').val()
    var phone = $('#phone').val()
    if (pass != passa)
        alert("Nhập lại pass không đúng! Vui lòng nhập lại.")
    else {
        $.ajax({
            url: '/signup',
            method: 'get',
            data: {
                username: name,
                password: pass,
                address: add,
                phone: phone
            },
            success(data) {
                if (data.status == "false") {
                    alert("Tài khoản này đã tồn tại! Vui lòng tạo tài khoản mới. ")
                }
                else {
                    $.ajax({
                        url: '/setCookie/' + data.matk + '/' + data.type,
                        method: 'get',
                        success(data) {
                            console.log("Du lieu nhan duoc: " + data.matk)
                        },
                        error(err) {
                            console.log(err)
                        },
                    })
                    $('#idUserHeader').text(data.username)
                    showHome_User(0, 0)
                }
            },
            error(err) {
                console.log(err)
            }
        })
    }
}