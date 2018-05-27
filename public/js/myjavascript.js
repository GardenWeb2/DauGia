function anRandom() {
    $('#hot').hide()
    $('#hetthoigian').hide()
}

function anLoaiSP() {
    $('.sp_hot').html("")
    $('.sp_hettg').html("")
    $('.chitiet_sp').html("")
    $('#congnghe').hide()
    $('#thoitrang').hide()
    $('#dogiadung').hide()
    $('#chitietsp').hide()
}
$(document).ready(() => {
    $.ajax({
        url: '/load/sp_hot',
        method: 'get',
        success(data) {
            anLoaiSP()
            data.forEach(x => {
                // function intervalFunc() {
                //     console.log(x.thoigiandau);
                //     //x.thoigiandau--;
                // }
                // setInterval(intervalFunc, 1000)
                
                $('.sp_hot').append(
                    `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                    x.hinhanh +
                    `" width="300" hight="300"><div class="caption"><h3>` + x.info +
                    `</h3>Thời gian:      <strong>` +
                    x.thoigiandau +
                    `</strong><br> Giá:<span style="color: red">` +
                    x.giahientai + "K" +
                    `</span></br>
                        <button class="btn-default" onclick="xemChitiet(this)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                )
            });
        },
        error(err) {
            $('.sp_hot').status(404)
        },
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
                    `</h3>Thời gian:      <strong>` +
                    x.thoigiandau + `</strong><br> Giá:<span style="color: red">` +
                    x.giahientai + "K" +
                    `</span></br>   
                    <button class="btn-default" onclick="xemChitiet(this)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                )
            });
        },
        error(err) {
            $('.sp_hettg').status(404)
        },
    })

    $('#btncongnghe').click(function () {
        $.ajax({
            url: '/load/sp_congnghe',
            method: 'get',
            success(data) {
                anLoaiSP()
                anRandom()
                $('#congnghe').show()
                data.forEach(x => {
                    $('.sp_congnghe').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` +
                        x.info + `</h3>Thời gian:      <strong>` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red">` +
                        x.giahientai + "K" + `</span></br>
                            <button class="btn-default" onclick="xemChitiet(this)" value="` +
                        x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    )
                });
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
                anLoaiSP()
                anRandom()
                $('#thoitrang').show()
                data.forEach(x => {
                    $('.sp_thoitrang').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` +
                        x.info + `</h3>Thời gian:      <strong>` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red">` +
                        x.giahientai + "K" +
                        `</span></br>   
                        <button class="btn-default" onclick="xemChitiet(this)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    )
                });
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
                anLoaiSP()
                anRandom()
                $('#dogiadung').show()
                data.forEach(x => {
                    $('.sp_dogiadung').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` +
                        x.info + `</h3>Thời gian:      <strong>` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red">` +
                        x.giahientai + "K" +
                        `</span></br>  
                        <button class="btn-default" onclick="xemChitiet(this)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    )
                });
            },
            error(err) {
                $('.sp_dogiadung').status(404)
            },
        })
    })

    $('#btnhome').click(function () {
        $.ajax({
            url: '/load/sp_hot',
            method: 'get',
            success(data) {
                anLoaiSP()
                $('#hot').show()
                data.forEach(x => {
                    $('.sp_hot').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` +
                        x.info +
                        `</h3>Thời gian:      <strong>` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red">` +
                        x.giahientai + "K" +
                        `</span></br>   
                        <button class="btn-default" onclick="xemChitiet(this)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    ) 
                });
            },
            error(err) {
                $('.sp_hot').status(404)
            },
        })

        $.ajax({
            url: '/load/sp_hettg',
            method: 'get',
            success(data) {
                $('#hetthoigian').show()
                data.forEach(x => {
                    $('.sp_hettg').append(
                        `<div class="col-sm-3 col-md-3"><div class="thumbnail" style="height:500"> <img src="./img/` +
                        x.hinhanh +
                        `" width="300" hight="300"><div class="caption"><h3>` +
                        x.info +
                        `</h3>Thời gian:      <strong>` +
                        x.thoigiandau +
                        `</strong><br> Giá:<span style="color: red">` +
                        x.giahientai + "K" +
                        `</span></br>   
                        <button class="btn-default" onclick="xemChitiet(this)" value="` +
                    x.masp + `"> Đấu Giá Ngay</button></div></div></div>`
                    )
                });
            },
            error(err) {
                $('.sp_hettg').status(404)
            },
        })
    })

})

function xemChitiet(e) {
    //alert($(e).val())
    var id = $(e).val()
    $.ajax({
    url: '/load/chitiet/' + id,
        method: 'get',
        success(data) {
            anLoaiSP()
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
                                        <input value="`+ x.giahientai +`" id="giadau" class="form-control input-number" type="text" style="width: 50px">
                                        <button onclick="giaTienThayDoi(this)" value="cong" class="btn btn-success btn-number" data-type="plus" data-field="quant">
                                            <span class="glyphicon glyphicon-plus"></span>
                                        </button>
                                    </div>
                                    <br>
                                    
                                    <button onclick="dauGia(this)" value class="btn btn-default" role="button"> Đấu Giá </button>
                                </p>
                                <input id="deltasoluong" value="`+ x.giatri +`"type="hidden">
                                <input id="idmaPhienDG" value="`+ x.maphiendg +`"type="hidden">
                                

                            </div>
                        </div>
                    </div>
                        <!--    Phần dưới chi tiết thông tin       !-->
                        <div class="panel panel-default">
                            <div class="panel-heading">

                                <h3> Thông tin sản phẩm </h3>
                            </div>
                            <div class="panel-body">
                                <span> <p> Chi tiết sản phẩm</p>`+ x.mota +`</span>
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
        url: '/daugia/' + giadau + '/'+ loai + '/' + giathau + '/' + delta,
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