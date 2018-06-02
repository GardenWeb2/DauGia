function anRandom() {
    $('#hot').hide()
    $('#hetthoigian').hide()
}

function anALL() {
     // an ben user
     $('#congnghe').hide()
     $('#thoitrang').hide()
     $('#dogiadung').hide()
     $('#chitietsp').hide()

    //an ben admin
    $('.sp_DaDG').html("")
    $('.sp_KhongDG').html("")
    $('.menu').hide();
    $('#header_admin').hide()
    $('#insertSP').hide()
    $('#spDaDG').hide()
    $('#spKhongDG').hide()
}


// update xuống postgre sau mỗi 1s
function capNhatThoigianDG(masp, thoigian) {
    $.ajax({
        url: '/capNhatThoiGianDau/' + masp + '/' + thoigian,
        method: 'get',
        success(data) {
            console.log(data)
        }
    })
}

// setInterval cho thời gian thay đổi ở các trang bên ngoài
function thoiGianGiam(data, loaiid){
    setInterval(function() {
        for(var i=0; i< data.length; i++){
            var tagId = "#" + loaiid + data[i].masp
            var arr = []
            arr = $(tagId).text().split(":"); // 00:03:40
            var gio = parseInt(arr[0])
            var phut = parseInt(arr[1])
            var giay = parseInt(arr[2])
            
            var thoigiantd =""
            if (gio > 0 && phut == 0 && giay == 0){
                gio = gio - 1
                phut = 59
                giay = 60
            }
            else if (phut > 0 && giay == 0){
                phut = phut - 1
                giay = 60
            }
            else if (gio == 0 && phut == 0 && giay == 0){
                giay = giay + 1
            }
                
            giay = giay - 1

            if(gio < 10 )
                gio = '0' + gio
            if(phut < 10 )
                phut = '0' + phut
            if(giay < 10 )
                giay = '0' + giay

            thoigiantd = gio + ':' + phut + ':' + giay
            $(tagId).text(thoigiantd)
            //console.log($(tagId).text());
            capNhatThoigianDG(data[i].masp, $(tagId).text())
           
            if($(tagId).text() == "00:00:00")
                capNhatTinhTrangPhienDG(data[i].maphiendg)
        }
    }, 1000)
    
}

// setInterval cho thời gian thay đổi ở các trang chi tiết, 
//giống code bên trên nhưng không cần chạy hàm cập nhật lại thời gian sau 1s vì ở trên đã cập nhật rồi
function thoiGianGiamChiTiet(data, loaiid){
    setInterval(function() {
        for(var i=0; i< data.length; i++){
            var tagId = "#" + loaiid + data[i].masp
            var arr = []
            arr = $(tagId).text().split(":"); // 00:03:40
            var gio = parseInt(arr[0])
            var phut = parseInt(arr[1])
            var giay = parseInt(arr[2])
            
            var thoigiantd =""
            if (gio > 0 && phut == 0 && giay == 0){
                gio = gio - 1
                phut = 59
                giay = 60
            }
            else if (phut > 0 && giay == 0){
                phut = phut - 1
                giay = 60
            }
            else if (gio == 0 && phut == 0 && giay == 0){
                giay = giay + 1
            }
                
            giay = giay - 1

            if(gio < 10 )
                gio = '0' + gio
            if(phut < 10 )
                phut = '0' + phut
            if(giay < 10 )
                giay = '0' + giay

            thoigiantd = gio + ':' + phut + ':' + giay
            $(tagId).text(thoigiantd)
           
        }
    }, 1000)
}

function capNhatTinhTrangPhienDG(maphien) {
    
    $.ajax({
        url: '/capNhatTinhTrangPhien/' + maphien,
        method: 'get',
        success(data) {
            console.log(data)
        },
        error(err) {
            console.log(err)
        },
    })
}


function loadSPHot(e,i) {
    f = 'user'
    $.ajax({
        url: '/load/sp_hot',
        method: 'get',
        success(data) {
            if (e == 'admin') {
                anALL()
                $('#hetthoigian').hide()
                $('#header_admin').show()
                f = 'admin'
            }
             // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_hot').html("") 
            data.forEach(x => {
                $('.sp_hot').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    x.hinhanh +
                    `" width="300" hight="300"><div class="caption"><h3>` + x.info +
                    `</h3>Thời gian:      <strong id="idhot` + x.masp + `" >` +
                    x.thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    x.giahientai + "K" +
                    `</span></br>
                        <button class="btn-default" onclick="xemChitiet(this, f)" value="` +
                    x.masp + `" > Đấu Giá Ngay</button></div></div></div>`
                )
            });
            if(i == 0){
                thoiGianGiam(data,"idhot")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
            }
        },
        error(err) {
            $('.sp_hot').status(404)
        },
    })
}

function loadSPHetThoiGianDau(e,i) {
    f = 'user'
    $.ajax({
        url: '/load/sp_hettg',
        method: 'get',
        success(data) {
            if (e == 'admin') {
                anALL()
                $('#hot').hide()
                $('#header_admin').show()
                f = 'admin'
            }
             // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
             $('.sp_hettg').html("") 
            data.forEach(x => {
                $('.sp_hettg').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    x.hinhanh +
                    `" width="300" hight="300"><div class="caption"><h3>` + x.info +
                    `</h3>Thời gian:      <strong id="idhettg` + x.masp + `">` +
                    x.thoigiandau + `</strong><br> Giá:<span style="color: red">` +
                    x.giahientai + "K" +
                    `</span></br>   
                    <button class="btn-default" onclick="xemChitiet(this, f)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                )
            });
            if(i == 0){
                thoiGianGiam(data,"idhettg")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
            }
        },
        error(err) {
            $('.sp_hettg').status(404)
        },
    })
}

function loadSPCongNghe(e,i) {
    f = 'user'
    $.ajax({
        url: '/load/sp_congnghe',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            if (e == 'admin'){
                $('#header_admin').show()
                f = 'admin'
            }
            $('#congnghe').show()
            // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
           $('.sp_congnghe').html("")
            data.forEach(x => {
                $('.sp_congnghe').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    x.hinhanh +
                    `" width="300" hight="300"><div class="caption"><h3>` +
                    x.info + `</h3>Thời gian:      <strong id="idspcn` + x.masp + `">` +
                    x.thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    x.giahientai + "K" + `</span></br>
                                <button class="btn-default" onclick="xemChitiet(this, f)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                )
            });
            if(i == 0){
                thoiGianGiam(data,"idspcn")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
            }
        },
        error(err) {
            $('.sp_congnghe').status(404)
        },
    })
}

function loadSPDoGiaDung(e,i) {
    f = 'user'
    $.ajax({
        url: '/load/sp_dogiadung',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            if (e == 'admin'){
                $('#header_admin').show()
                f = 'admin'
            }
            $('#dogiadung').show()
            // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_dogiadung').html("")
            data.forEach(x => {
                $('.sp_dogiadung').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    x.hinhanh +
                    `" width="300" hight="300"><div class="caption"><h3>` +
                    x.info + `</h3>Thời gian:      <strong id="idspdgd` + x.masp + `">` +
                    x.thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    x.giahientai + "K" +
                    `</span></br>  
                            <button class="btn-default" onclick="xemChitiet(this, f)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                )
            });
            if(i == 0){
                thoiGianGiam(data,"idspdgd")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
            }
        },
        error(err) {
            $('.sp_dogiadung').status(404)
        },
    })
}

function loadSPThoiTrang(e,i) {
    f = 'user'
    $.ajax({
        url: '/load/sp_thoitrang',
        method: 'get',
        success(data) {
            anALL()
            anRandom()
            if (e == 'admin'){
                $('#header_admin').show()
                f = 'admin'
            }
                
            $('#thoitrang').show()
            // Không đượcgộp chung trên hàm anALL() nếu không nó sẽ không giảm khi ta chuyển sang button khác
            $('.sp_thoitrang').html("")
            data.forEach(x => {
                $('.sp_thoitrang').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    x.hinhanh +
                    `" width="300" hight="300"><div class="caption"><h3>` +
                    x.info + `</h3>Thời gian:      <strong id="idsptt` + x.masp + `">` +
                    x.thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    x.giahientai + "K" +
                    `</span></br>   
                            <button class="btn-default" onclick="xemChitiet(this, f)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                )
            });
            if(i == 0){// chỉ chạy 1 lần đầu
                thoiGianGiam(data,"idsptt")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
            }
        },
        error(err) {
            $('.sp_thoitrang').status(404)
        },
    })
}

function loadAllSPDangDauGia() {
    $.ajax({
        url: '/load/sp_all',
        method: 'get',
        success(data) {
            //$('#chitietsp').show()
            data.forEach(x => {
                $('.chitiet_sp').append(
                    `<span style="color: red">
                        <strong id="idchitietsp`+ x.masp + `">` + x.thoigiandau + `</strong>
                    </span>`
                )
            })
            thoiGianGiamChiTiet(data,"idchitietsp")    // load thời gian chạy setInterval các sản phẩm trong trang chi tiết
        },
        error(err) {
           console.log(err)
        },
    })
}



function showHome_User(i) {
    anALL()
    $('#login').hide()
    $('#header_user').show()
    $('#hot').show()
    $('#hetthoigian').show()

    loadSPHot('user',i)
    loadSPHetThoiGianDau('user',i)
}


$(document).ready(() => {
    anRandom()
    anALL()
    $('#header_user').hide()

    var demCongnghe = 0
    $('#btncongnghe').click(function () {
        loadSPCongNghe('user',demCongnghe)
        demCongnghe++
    })

    var demThoitrang = 0
    $('#btnthoitrang').click(function () {
        loadSPThoiTrang('user', demThoitrang)
        demThoitrang++
    })

    var demDogiadung = 0
    $('#btndogiadung').click(function () {
        loadSPDoGiaDung('user',demDogiadung)
        demDogiadung++
    })

    $('#btnhome').click(function () {
        showHome_User(1);
    })

    nutAdmin()
})



function xemChitiet(e, f) {
    //alert($(e).val())
    var id = $(e).val()
    if (f == 'user'){
        $.ajax({
            url: '/load/chitiet/' + id,
            method: 'get',
            success(data) {
                anALL()
                anRandom()
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
                            <div class="col-sm-9 col-md-9">
                                <div class="thumbnail" style="height:350px">
                                    <div class="caption" aligint="center">
                                        <h4> Kết thúc trong: </h4>
                                        <h2>
                                            <span style="color: red">
                                                <strong id="idchitietsp`+ x.masp+`">` + x.thoigiandau + `</strong>
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
                                                <input value="`+ x.giahientai + `" id="giadau" class="form-control input-number" type="text" style="width: 50px">
                                                <button onclick="giaTienThayDoi(this)" value="cong" class="btn btn-success btn-number" data-type="plus" data-field="quant">
                                                    <span class="glyphicon glyphicon-plus"></span>
                                                </button>
                                            </div>
                                            <br>
                                            
                                            <button onclick="dauGia(this)" value class="btn btn-default" role="button"> Đấu Giá </button>
                                        </p>
                                        <input id="deltasoluong" value="`+ x.giatri + `"type="hidden">
                                        <input id="idmaPhienDG" value="`+ x.maphiendg + `"type="hidden">
                                        
                                    </div>
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
                });
                
            },
            error(err) {
                console.log(err)
            },
        })
    }
    else{
        $.ajax({
            url: '/load/chitiet/' + id,
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
                            <div class="col-sm-9 col-md-9">
                                <div class="thumbnail" style="height:350px">
                                    <div class="caption" aligint="center">
                                        <h4> Kết thúc trong: </h4>
                                        <h2>
                                            <span style="color: red">
                                                <strong id="idchitietsp`+ x.masp+`">` + x.thoigiandau + `</strong>
                                            </span>
                                        </h2>
                                        <h4> Giá thầu hiện tại: </h4>
                                        <h2>
                                            <span style="color: black">
                                                <strong > <span id="giathau">` + x.giahientai + ` </span> K </strong>
                                            </span>
                                        </h2>
                                        
                                        <input id="deltasoluong" value="`+ x.giatri + `"type="hidden">
                                        <input id="idmaPhienDG" value="`+ x.maphiendg + `"type="hidden">
                                        
                                    </div>
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
    
                });
            },
            error(err) {
                console.log(err)
            },
        })
    }
    
}

function giaTienThayDoi(e) {
    var giadau = $('#giadau').val()
    var loai = $(e).val()
    var giathau = $('#giathau').text()
    var delta = $('#deltasoluong').val()
    $.ajax({
        url: '/daugia/' + giadau + '/' + loai + '/' + giathau + '/' + delta,
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
    var maphiendg = $('#idmaPhienDG').val()
    var giadau = $('#giadau').val()
    var tinhtrangphieu = 1
    $.ajax({
        url: '/create_update_PhieuDG',
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
}



//      ---------------- ADMIN ----------------
function showHome_Admin() {
    $('#login').hide()
    $('#header_admin').show()
    $('#insertSP').show();
    
}

function loadSPDaDG() {
    $.ajax({
        url: '/load/sp_dadaugia',
        method: 'get',
        success(data) {
            var i = 1
            data.forEach(x => {
                $('table').append(
                    `<tr>` +
                        `<td>`+ `<p>` + i + `</p>` + `</td>` +
                        `<td>`+ `<p>` + x.info + `</p>` + `<td>` +
                        `<img src="./img/`+ x.hinhanh + `"width="100" hight="100">` +
                        `<td>`+ x.giahientai + `</td>`
                    + `</tr>`
                )
                i++
            })
        },
        error(err){
            $('.sp_DaDG').status(404)
        },
    })
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
        $('#insertSP').show();
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

        $.ajax({
            url: '/createProduct',
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
                alert(data)
            },
            error(err) {
                $('.thongbao').status(404)
            },
        })
    })

    var demsphot_ad = 0
    var demsphtg_ad = 0
    var demspcnt_ad = 0
    var demsptt_ad = 0
    var demspdgd_ad = 0
    $('#btndangdaugia').click(function () {
        $('#btnsphot2').click(function () {
            $('#insertSP').hide()
            $('#hot').show()
            loadSPHot('admin', demsphot_ad)
            demsphot_ad ++
        })

        $('#btnspshtg').click(function () {
            $('#insertSP').hide()
            $('#hetthoigian').show()
            loadSPHetThoiGianDau('admin', demsphtg_ad)
            demsphtg_ad ++
        })

        $('#btncongnghe2').click(function () {
            $('#insertSP').hide()
            loadSPCongNghe('admin', demspcnt_ad)
            demspcnt_ad ++
        })

        $('#btndogiadung2').click(function () {
            $('#insertSP').hide()
            loadSPDoGiaDung('admin', demspdgd_ad)
            demspdgd_ad ++
        })

        $('#btnthoitrang2').click(function () {
            $('#insertSP').hide()
            loadSPThoiTrang('admin', demsptt_ad)
            demsptt_ad ++
        })
    })

    $('#btndadaugia').click(function () {
        anALL()
        anRandom()
        $('#header_admin').show()
        $('#spDaDG').show();
        loadSPDaDG()
    })

    $('#btnkhongdaugia').click(function () {
        anALL()
        anRandom()
        $('#header_admin').show()
        $('#spKhongDG').show();
    })
}

function login(e) {
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
            if(data.status != "false"){
                loadAllSPDangDauGia()   // load sẵn thời gian chạy tự động trong trang chi tiết của tất cả các sản phẩm
                $.ajax({
                    url: '/setCookie/' + data.user,
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
                    showHome_User(0)
                else if(data.type == "admin")
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


function dangki(e) {
    $('#login').hide()
}