function anRandom() {
    $('#hot').hide()
    $('#hetthoigian').hide()
}

function anAll() {
    $('.sp_hot').html("")
    $('.sp_hettg').html("")
    $('.chitiet_sp').html("")
    $('.sp_congnghe').html("")
    $('.sp_thoitrang').html("")
    $('.sp_dogiadung').html("")
    $('#congnghe').hide()
    $('#thoitrang').hide()
    $('#dogiadung').hide()
    $('#chitietsp').hide()
    $('.sp_DaDG').html("")
    $('.sp_KhongDG').html("")
    $('#header_admin').hide()
    $('#insertSP').hide()
    $('#spDaDG').hide()
    $('#spKhongDG').hide()
}

// setInterval cho thời gian thay đổi
function thoiGianGiam(data, loaiid){
    setInterval(function() {
        for(var i=0; i< data.length; i++){
            var tagId = "#" + loaiid + data[i].masp + ""
            var arr = []
            arr = $(tagId).text().split(":"); // 00:03:40
            var gio = parseInt(arr[0])
            var phut = parseInt(arr[1])
            var giay = parseInt(arr[2])
            
            var thoigiantd =""
            if (gio > 0 && phut == 0 && giay == 0){
                gio = gio - 1
                giay = 60
            }
            else if (phut > 0 && giay == 0){
                phut = phut - 1
                giay = 60
            }
            else if (gio == 0 && phut == 0 && giay == 0)
                giay = giay + 1
            giay = giay - 1

            thoigiantd = gio + ':' + phut + ':' + giay
            $(tagId).text(thoigiantd)
            console.log($(tagId).text());
        }
    }, 1000)
}

function showHome() {
    $('#login').hide()
    $('#header_user').show()
    $('#hot').show()
    $('#hetthoigian').show()
    //$('#idusername').text)
    showHomePage()
}

function showHomeAdmin() {
    $('#login').hide()
}

function showHomePage() {
    anAll()
    $('#hot').show()
    $('#hetthoigian').show()
    $.ajax({
        url: '/load/sp_hot',
        method: 'get',
        success(data) {
                data.forEach(x => {
                    $('.sp_hot').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` + x.info +
                        `</h3>Thời gian:      <strong id="idhot`+ x.masp+`" >` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red" class="gia" >` +
                        x.giahientai + "K" +
                        `</span></br>
                            <button class="btn-default" onclick="xemChitiet(this)" value="` +
                        x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    )
                })
                thoiGianGiam(data,"idhot")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
        },
        error(err) {
            $('.sp_hot').status(404)
        }
    })

    $.ajax({
        url: '/load/sp_hettg',
        method: 'get',
        success(data) {
            data.forEach(x => {
                $('.sp_hettg').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    x.hinhanh +
                    `" width="300" hight="300"><div class="caption"><h3>` + x.info +
                    `</h3>Thời gian:      <strong id="idhettg`+ x.masp+`">` +
                    x.thoigiandau + `</strong><br> Giá:<span style="color: red">` +
                    x.giahientai + "K" +
                    `</span></br>   
                    <button class="btn-default" onclick="xemChitiet(this)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                )
            })
            thoiGianGiam(data,"idhettg")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
        },
        error(err) {
            $('.sp_hettg').status(404)
        },
    })
}

$(document).ready(() => {
    anRandom()
    anAll()
    $('#header_user').hide()


    $('#btncongnghe').click(function () {
        $.ajax({
            url: '/load/sp_congnghe',
            method: 'get',
            success(data) {
                anAll()
                anRandom()
                $('#congnghe').show()
                data.forEach(x => {
                    $('.sp_congnghe').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` +
                        x.info + `</h3>Thời gian:      <strong id="idspcn`+ x.masp+`">` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red">` +
                        x.giahientai + "K" + `</span></br>
                            <button class="btn-default" onclick="xemChitiet(this)" value="` +
                        x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    )
                })
                thoiGianGiam(data,"idspcn")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
            },
            error(err) {
                $('.sp_congnghe').status(404)
            },
        })
    })

    $('#btnthoitrang').click(function () {
        $.ajax({
            url: '/load/sp_thoitrang',
            method: 'get',
            success(data) {
                anAll()
                anRandom()
                $('#thoitrang').show()
                data.forEach(x => {
                    $('.sp_thoitrang').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` +
                        x.info + `</h3>Thời gian:      <strong id="idsptt`+ x.masp+`">` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red">` +
                        x.giahientai + "K" +
                        `</span></br>   
                        <button class="btn-default" onclick="xemChitiet(this)" value="` +
                        x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    )
                })
                thoiGianGiam(data,"idsptt")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
            },
            error(err) {
                $('.sp_thoitrang').status(404)
            },
        })
    })

    $('#btndogiadung').click(function () {
        $.ajax({
            url: '/load/sp_dogiadung',
            method: 'get',
            success(data) {
                anAll()
                anRandom()
                $('#dogiadung').show()
                data.forEach(x => {
                    $('.sp_dogiadung').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` +
                        x.info + `</h3>Thời gian:      <strong id="idspdgd`+ x.masp+`">` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red">` +
                        x.giahientai + "K" +
                        `</span></br>  
                        <button class="btn-default" onclick="xemChitiet(this)" value="` +
                        x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    )
                })
                thoiGianGiam(data,"idspdgd")  // truyền vào 2 tham số 1: database postgre; 2: loại id thời gian của 1 sp cụ thể
            },
            error(err) {
                $('.sp_dogiadung').status(404)
            },
        })
    })

    $('#btnhome').click(function () {
        showHomePage()
    })

})

function xemChitiet(e) {
    //alert($(e).val())
    var id = $(e).val()
    $.ajax({
        url: '/load/chitiet/' + id,
        method: 'get',
        success(data) {
            anAll()
            anRandom()
            $('#chitietsp').show()
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
                                        <strong>` + x.thoigiandau + `</strong>
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
                                        <input value="` + x.giahientai + `" id="giadau" class="form-control input-number" type="text" style="width: 50px">
                                        <button onclick="giaTienThayDoi(this)" value="cong" class="btn btn-success btn-number" data-type="plus" data-field="quant">
                                            <span class="glyphicon glyphicon-plus"></span>
                                        </button>
                                    </div>
                                    <br>
                                    
                                    <button onclick="dauGia()" class="btn btn-default" role="button"> Đấu Giá </button>
                                </p>
                                <input id="deltasoluong" value="` + x.giatri + `"type="hidden">
                                <input id="idmaPhienDG" value="` + x.maphiendg + `"type="hidden">
                                

                            </div>
                        </div>
                    </div>
                        <!--    Phần dưới chi tiết thông tin       !-->
                        <div class="panel panel-default">
                            <div class="panel-heading">

                                <h3> Thông tin sản phẩm </h3>
                            </div>
                            <div class="panel-body">
                                <span> <p> Chi tiết sản phẩm</p>` + x.mota + `</span>
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

function dauGia() {
    var maphiendg = $('#idmaPhienDG').val()
    var matk = 2;
    var giadau = $('#giadau').val()
    var tinhtrangphieu = 1
    // var masanpham = $(e).val()
    $.ajax({
        url: '/create_update_PhieuDG',
        method: 'get',
        data: {
            maphien: maphiendg,
            // masp: masanpham,
            matk: matk,
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

function login(e) {
    var name = $('#nametxt').val()
    var pass = $('#passtxt').val()
    $.ajax({
        url: '/login',
        method: 'get',
        data: {
            username: name,
            password: pass
        },
        success(data) {
            console.log(data)
            if (data == "user")
                showHome()
            if (data == "admin")
                showHomeAdmin()
        },
        error(err) {
            console.log(err)
        },
    })
}


function dangki(e) {
    $('#login').hide()
}