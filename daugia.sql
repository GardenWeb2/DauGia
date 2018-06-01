--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: loaisp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loaisp (
    maloaisp bigint NOT NULL,
    tenloai character varying(30)
);


ALTER TABLE public.loaisp OWNER TO postgres;

--
-- Name: loaisp_maloaisp_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loaisp_maloaisp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.loaisp_maloaisp_seq OWNER TO postgres;

--
-- Name: loaisp_maloaisp_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loaisp_maloaisp_seq OWNED BY public.loaisp.maloaisp;


--
-- Name: loaitk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loaitk (
    maloai bigint NOT NULL,
    tenloai character varying(30)
);


ALTER TABLE public.loaitk OWNER TO postgres;

--
-- Name: loaitk_maloai_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loaitk_maloai_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.loaitk_maloai_seq OWNER TO postgres;

--
-- Name: loaitk_maloai_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loaitk_maloai_seq OWNED BY public.loaitk.maloai;


--
-- Name: phiendaugia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phiendaugia (
    maphiendg bigint NOT NULL,
    masp integer,
    thoigianbd timestamp without time zone,
    thoigiandau time(6) without time zone,
    giathapnhat integer,
    giahientai integer,
    maphieudauthang integer,
    matinhtrang integer
);


ALTER TABLE public.phiendaugia OWNER TO postgres;

--
-- Name: phiendaugia_maphiendg_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phiendaugia_maphiendg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.phiendaugia_maphiendg_seq OWNER TO postgres;

--
-- Name: phiendaugia_maphiendg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phiendaugia_maphiendg_seq OWNED BY public.phiendaugia.maphiendg;


--
-- Name: phieudaugia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.phieudaugia (
    maphieudg bigint NOT NULL,
    maphiendg integer,
    matk integer,
    giadau integer,
    matinhtrang integer
);


ALTER TABLE public.phieudaugia OWNER TO postgres;

--
-- Name: phieudaugia_maphieudg_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.phieudaugia_maphieudg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.phieudaugia_maphieudg_seq OWNER TO postgres;

--
-- Name: phieudaugia_maphieudg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.phieudaugia_maphieudg_seq OWNED BY public.phieudaugia.maphieudg;


--
-- Name: sanpham; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sanpham (
    masp bigint NOT NULL,
    loaisp integer,
    hinhanh character varying(30),
    info text,
    isnew boolean,
    isdelete boolean,
    mota text
);


ALTER TABLE public.sanpham OWNER TO postgres;

--
-- Name: sanpham_masp_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sanpham_masp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sanpham_masp_seq OWNER TO postgres;

--
-- Name: sanpham_masp_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sanpham_masp_seq OWNED BY public.sanpham.masp;


--
-- Name: taikhoan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taikhoan (
    matk bigint NOT NULL,
    tentk character varying(30),
    matkhau character varying(30),
    loaitk integer
);


ALTER TABLE public.taikhoan OWNER TO postgres;

--
-- Name: taikhoan_matk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taikhoan_matk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taikhoan_matk_seq OWNER TO postgres;

--
-- Name: taikhoan_matk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taikhoan_matk_seq OWNED BY public.taikhoan.matk;


--
-- Name: thamso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.thamso (
    mathamso bigint NOT NULL,
    tenthamso character varying(30),
    giatri integer
);


ALTER TABLE public.thamso OWNER TO postgres;

--
-- Name: thamso_mathamso_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.thamso_mathamso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.thamso_mathamso_seq OWNER TO postgres;

--
-- Name: thamso_mathamso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.thamso_mathamso_seq OWNED BY public.thamso.mathamso;


--
-- Name: tinhtrangphiendg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tinhtrangphiendg (
    matinhtrangphiendg bigint NOT NULL,
    tentinhtrangphiendg character varying(30)
);


ALTER TABLE public.tinhtrangphiendg OWNER TO postgres;

--
-- Name: tinhtrangphiendg_matinhtrangphiendg_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tinhtrangphiendg_matinhtrangphiendg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tinhtrangphiendg_matinhtrangphiendg_seq OWNER TO postgres;

--
-- Name: tinhtrangphiendg_matinhtrangphiendg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tinhtrangphiendg_matinhtrangphiendg_seq OWNED BY public.tinhtrangphiendg.matinhtrangphiendg;


--
-- Name: tinhtrangphieudg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tinhtrangphieudg (
    matinhtrangphieudg bigint NOT NULL,
    tentinhtrangphieudg character varying(30)
);


ALTER TABLE public.tinhtrangphieudg OWNER TO postgres;

--
-- Name: tinhtrangphieudg_matinhtrangphieudg_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tinhtrangphieudg_matinhtrangphieudg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tinhtrangphieudg_matinhtrangphieudg_seq OWNER TO postgres;

--
-- Name: tinhtrangphieudg_matinhtrangphieudg_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tinhtrangphieudg_matinhtrangphieudg_seq OWNED BY public.tinhtrangphieudg.matinhtrangphieudg;


--
-- Name: loaisp maloaisp; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loaisp ALTER COLUMN maloaisp SET DEFAULT nextval('public.loaisp_maloaisp_seq'::regclass);


--
-- Name: loaitk maloai; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loaitk ALTER COLUMN maloai SET DEFAULT nextval('public.loaitk_maloai_seq'::regclass);


--
-- Name: phiendaugia maphiendg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phiendaugia ALTER COLUMN maphiendg SET DEFAULT nextval('public.phiendaugia_maphiendg_seq'::regclass);


--
-- Name: phieudaugia maphieudg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieudaugia ALTER COLUMN maphieudg SET DEFAULT nextval('public.phieudaugia_maphieudg_seq'::regclass);


--
-- Name: sanpham masp; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sanpham ALTER COLUMN masp SET DEFAULT nextval('public.sanpham_masp_seq'::regclass);


--
-- Name: taikhoan matk; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taikhoan ALTER COLUMN matk SET DEFAULT nextval('public.taikhoan_matk_seq'::regclass);


--
-- Name: thamso mathamso; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thamso ALTER COLUMN mathamso SET DEFAULT nextval('public.thamso_mathamso_seq'::regclass);


--
-- Name: tinhtrangphiendg matinhtrangphiendg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tinhtrangphiendg ALTER COLUMN matinhtrangphiendg SET DEFAULT nextval('public.tinhtrangphiendg_matinhtrangphiendg_seq'::regclass);


--
-- Name: tinhtrangphieudg matinhtrangphieudg; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tinhtrangphieudg ALTER COLUMN matinhtrangphieudg SET DEFAULT nextval('public.tinhtrangphieudg_matinhtrangphieudg_seq'::regclass);


--
-- Data for Name: loaisp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loaisp (maloaisp, tenloai) FROM stdin;
2	thoi trang
1	cong nghe
3	do gia dung
\.


--
-- Data for Name: loaitk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loaitk (maloai, tenloai) FROM stdin;
1	admin
2	user
\.


--
-- Data for Name: phiendaugia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phiendaugia (maphiendg, masp, thoigianbd, thoigiandau, giathapnhat, giahientai, maphieudauthang, matinhtrang) FROM stdin;
10	21	2018-06-10 04:30:00	00:05:20	11	11	\N	2
22	19	2018-05-12 10:00:20	00:00:00	1	1	\N	4
13	11	2018-05-11 11:30:00	00:00:00	1	1	\N	4
15	13	2018-06-01 05:30:00	00:00:00	5	5	\N	4
14	12	2018-12-23 00:30:10	01:05:10	2	2	\N	2
21	18	2018-06-12 10:00:20	00:44:12	1	1	\N	2
20	16	2018-06-11 09:10:20	00:53:12	15	15	\N	2
1	1	2018-06-10 08:00:00	01:05:20	1	1	\N	2
8	8	2018-05-10 09:00:00	00:00:00	5	55	4	3
19	14	2018-05-11 09:20:00	00:48:57	5	5	\N	1
23	32	2018-06-01 08:30:00	00:46:45	1	1	\N	1
5	5	2018-05-11 09:00:00	00:57:53	2	62	\N	1
18	31	2018-05-31 00:00:00	00:40:48	10	10	\N	1
7	7	2018-05-11 09:00:00	00:00:00	4	4	\N	4
12	10	2018-05-10 09:30:00	00:14:43	10	10	\N	1
6	6	2018-05-11 09:00:00	00:25:30	1	21	\N	1
17	29	2018-05-31 05:20:10	00:08:26	12	12	\N	1
11	9	2018-06-10 09:30:00	00:53:41	5	5	\N	1
2	2	2018-05-10 09:00:00	00:15:22	3	60	\N	1
3	3	2018-05-11 09:00:00	00:28:33	5	55	\N	1
4	4	2018-05-11 09:00:00	00:32:40	45	45	\N	1
9	20	2018-05-10 09:00:00	00:27:02	5	5	\N	1
\.


--
-- Data for Name: phieudaugia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phieudaugia (maphieudg, maphiendg, matk, giadau, matinhtrang) FROM stdin;
3	3	1	55	1
6	5	1	12	2
15	5	2	62	1
1	2	2	60	1
2	2	1	50	2
4	8	1	55	1
5	8	2	45	2
13	6	2	21	1
7	6	1	11	2
\.


--
-- Data for Name: sanpham; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sanpham (masp, loaisp, hinhanh, info, isnew, isdelete, mota) FROM stdin;
4	3	005.jpg	Nệm Hơi	t	f	sd
5	2	007.jpg	Giày thể thao: Đen	t	f	fbf we
6	2	014.jpg	Ba lô dây chéo	t	f	fbf we
7	1	012.jpg	Nhẫn giữ điện thoại	t	f	few s
1	1	010.jpg	Tai nghe Iphone	t	f	Thiết kế khoa học 3,5 mm cho phép bạn tận hưởng âm thanh trong trẻo như pha lê và không bị ảnh hưởng từ tiếng ồn xung quanh.\n\n- Thích hợp sử dụng với điện thoại di động, máy tính và các thiết bị điện tử khác\n- Chiều dài: 110 cm.\n- Màu sắc: Đen\n- Kiểm soát âm lượng
8	1	010.jpg	Tai nghe Iphone	t	f	sgdf s
2	3	004.jpg	Chảo Chống dính	t	f	Chuẩn bị cho các bữa ăn gia đình với chảo rán ! Đấu giá ngay!\n\nThông số kỹ thuật:\n\n- Chảo đa năng chuyên dành để chiên rán,v..v...\n- Được làm bằng inox chất lượng cao, tráng bằng lớp phủ không dính, bền đẹp\n- Thiết kế hiện đại, dễ sử dụng. Có thể sử dụng với bếp điện từ.\n- Sản phẩm không dễ bị cháy, lòng chảo có thiết kế khoa học, giữ nhiệt và dinh dưỡng của thực phẩm.\n- Lòng chảo có dáng cong, dễ dàng sử dụng và vệ sinh.\n- Kích thước: 12 "
3	3	001.jpg	Bộ dao	t	f	Bộ dao 5 món chất lượng hoàn hảo cung cấp cho bạn trải nghiệm tốt nhất khi làm bếp. Với lưỡi dao sắc bén bằng thép không gỉ, cán tay cầm vừa vặn, sản phẩm Bộ dao 5 món có thể đáp ứng mọi nhu cầu gọt, cắt thực phẩm của bạn. Đấu giá ngay!\n\nĐặc điểm sản phẩm:\n\n- Được làm bằng thép không gỉ và nhựa chất lượng cao\n- Gồm có: dao bào vỏ, kéo, dao gọt, dao thái, dao chặt\n- Tay cầm được thiết kế vừa vặn, giúp cầm nắm dễ dàng, chắc chắn\n- Được thiết kế với phong cách tối giản nhưng vẫn hiệu quả và toát lên vẻ sang trọng cho căn bếp nhà bạn\n- Xuất xứ: Trung Quốc
13	2	013.jpg	Mắt kính mát	t	f	sd\njh
18	1	006.jpg	Bộ nồi	t	f	sa
21	2	015.jpg	Nón kết	t	f	thd\nfefbf\nss
16	1	004.jpg	Chảo chống dính	t	f	sd
19	3	73-157-main_250.jpg	Case điện thoại	t	f	rr
29	3	008.jpg	Air Compressor	t	f	Bền \nĐẹp
31	2	016.jpg	Dây nịch Nam	t	f	Đẹp\nThời trang
32	1	010.jpg	Tai Nghe	t	f	Chất lượng\nĐẹp, bền
20	3	73-376_0111_250.jpg	Bình đun siêu tốc	t	f	- Công suất lớn 1500W\n- Khi đạt đến nhiệt độ sôi, ấm tự động ngắt điện, đảm bảo an toàn cho bạn.\n- Chất liệu inox bền đẹp, không độc hại\n- Thể tích 1.8 lít giúp bạn nấu được nhiều nước hơn khi cần sử dụng.\n- Thiết kế đẹp, hiện đại, tay cầm cách nhiệt an toàn, đế nhựa có thể xoay 360 độ tiện dụng.\n- Bảo hành: 3 tháng
12	1	009.jpg	Loa để bàn	t	f	sa
11	3	017.jpg	Thùng rác kim loại	t	f	gnfndl\nada
14	1	011.jpg	Loa bluetooth	t	f	d
10	2	015.jpg	Nón Nam	t	f	sa\njh\njhg
9	3	017.jpg	Thùng rác văn phòng	t	f	s\nlk
\.


--
-- Data for Name: taikhoan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taikhoan (matk, tentk, matkhau, loaitk) FROM stdin;
2	b	b	2
1	a	a	2
3	ad	ad	1
\.


--
-- Data for Name: thamso; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.thamso (mathamso, tenthamso, giatri) FROM stdin;
1	delta so tien	10
\.


--
-- Data for Name: tinhtrangphiendg; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tinhtrangphiendg (matinhtrangphiendg, tentinhtrangphiendg) FROM stdin;
1	dang dau gia
2	chua dau gia
3	da dau gia
4	khong co dau gia
\.


--
-- Data for Name: tinhtrangphieudg; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tinhtrangphieudg (matinhtrangphieudg, tentinhtrangphieudg) FROM stdin;
1	dau gia thanh cong
2	dau gia that bai
\.


--
-- Name: loaisp_maloaisp_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loaisp_maloaisp_seq', 3, true);


--
-- Name: loaitk_maloai_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loaitk_maloai_seq', 2, true);


--
-- Name: phiendaugia_maphiendg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phiendaugia_maphiendg_seq', 23, true);


--
-- Name: phieudaugia_maphieudg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phieudaugia_maphieudg_seq', 16, true);


--
-- Name: sanpham_masp_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sanpham_masp_seq', 32, true);


--
-- Name: taikhoan_matk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taikhoan_matk_seq', 3, true);


--
-- Name: thamso_mathamso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.thamso_mathamso_seq', 1, true);


--
-- Name: tinhtrangphiendg_matinhtrangphiendg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tinhtrangphiendg_matinhtrangphiendg_seq', 4, true);


--
-- Name: tinhtrangphieudg_matinhtrangphieudg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tinhtrangphieudg_matinhtrangphieudg_seq', 2, true);


--
-- Name: loaisp loaisp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loaisp
    ADD CONSTRAINT loaisp_pkey PRIMARY KEY (maloaisp);


--
-- Name: loaitk loaitk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loaitk
    ADD CONSTRAINT loaitk_pkey PRIMARY KEY (maloai);


--
-- Name: phiendaugia phiendaugia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phiendaugia
    ADD CONSTRAINT phiendaugia_pkey PRIMARY KEY (maphiendg);


--
-- Name: phieudaugia phieudaugia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieudaugia
    ADD CONSTRAINT phieudaugia_pkey PRIMARY KEY (maphieudg);


--
-- Name: sanpham sanpham_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sanpham
    ADD CONSTRAINT sanpham_pkey PRIMARY KEY (masp);


--
-- Name: taikhoan taikhoan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taikhoan
    ADD CONSTRAINT taikhoan_pkey PRIMARY KEY (matk);


--
-- Name: thamso thamso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.thamso
    ADD CONSTRAINT thamso_pkey PRIMARY KEY (mathamso);


--
-- Name: tinhtrangphiendg tinhtrangphiendg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tinhtrangphiendg
    ADD CONSTRAINT tinhtrangphiendg_pkey PRIMARY KEY (matinhtrangphiendg);


--
-- Name: tinhtrangphieudg tinhtrangphieudg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tinhtrangphieudg
    ADD CONSTRAINT tinhtrangphieudg_pkey PRIMARY KEY (matinhtrangphieudg);


--
-- Name: fki_FK_PhienDG_PhieuDG; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_PhienDG_PhieuDG" ON public.phiendaugia USING btree (maphieudauthang);


--
-- Name: fki_FK_PhienDG_SanPham; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_PhienDG_SanPham" ON public.phiendaugia USING btree (masp);


--
-- Name: fki_FK_PhienDG_TinhTrangPhienDG; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_PhienDG_TinhTrangPhienDG" ON public.phiendaugia USING btree (matinhtrang);


--
-- Name: fki_FK_PhieuDG_PhienDG; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_PhieuDG_PhienDG" ON public.phieudaugia USING btree (maphiendg);


--
-- Name: fki_FK_PhieuDG_TaiKhoan; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_PhieuDG_TaiKhoan" ON public.phieudaugia USING btree (matk);


--
-- Name: fki_FK_PhieuDG_TinhTrangPhieuDG; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_PhieuDG_TinhTrangPhieuDG" ON public.phieudaugia USING btree (matinhtrang);


--
-- Name: fki_FK_SanPham_LoaiSP; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_SanPham_LoaiSP" ON public.sanpham USING btree (loaisp);


--
-- Name: fki_FK_TaiKhoan_LoaiTK; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_FK_TaiKhoan_LoaiTK" ON public.taikhoan USING btree (loaitk);


--
-- Name: phiendaugia FK_PhienDG_PhieuDG; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phiendaugia
    ADD CONSTRAINT "FK_PhienDG_PhieuDG" FOREIGN KEY (maphieudauthang) REFERENCES public.phieudaugia(maphieudg);


--
-- Name: phiendaugia FK_PhienDG_SanPham; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phiendaugia
    ADD CONSTRAINT "FK_PhienDG_SanPham" FOREIGN KEY (masp) REFERENCES public.sanpham(masp);


--
-- Name: phiendaugia FK_PhienDG_TinhTrangPhienDG; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phiendaugia
    ADD CONSTRAINT "FK_PhienDG_TinhTrangPhienDG" FOREIGN KEY (matinhtrang) REFERENCES public.tinhtrangphiendg(matinhtrangphiendg);


--
-- Name: phieudaugia FK_PhieuDG_PhienDG; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieudaugia
    ADD CONSTRAINT "FK_PhieuDG_PhienDG" FOREIGN KEY (maphiendg) REFERENCES public.phiendaugia(maphiendg);


--
-- Name: phieudaugia FK_PhieuDG_TaiKhoan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieudaugia
    ADD CONSTRAINT "FK_PhieuDG_TaiKhoan" FOREIGN KEY (matk) REFERENCES public.taikhoan(matk);


--
-- Name: phieudaugia FK_PhieuDG_TinhTrangPhieuDG; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.phieudaugia
    ADD CONSTRAINT "FK_PhieuDG_TinhTrangPhieuDG" FOREIGN KEY (matinhtrang) REFERENCES public.tinhtrangphieudg(matinhtrangphieudg);


--
-- Name: sanpham FK_SanPham_LoaiSP; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sanpham
    ADD CONSTRAINT "FK_SanPham_LoaiSP" FOREIGN KEY (loaisp) REFERENCES public.loaisp(maloaisp);


--
-- Name: taikhoan FK_TaiKhoan_LoaiTK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taikhoan
    ADD CONSTRAINT "FK_TaiKhoan_LoaiTK" FOREIGN KEY (loaitk) REFERENCES public.loaitk(maloai);


--
-- PostgreSQL database dump complete
--

