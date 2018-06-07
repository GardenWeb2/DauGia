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
    matinhtrang integer,
    thanhtoan boolean
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
    loaitk integer,
    sdt character varying(20),
    diachi text
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

COPY public.phiendaugia (maphiendg, masp, thoigianbd, thoigiandau, giathapnhat, giahientai, maphieudauthang, matinhtrang, thanhtoan) FROM stdin;
8	8	2018-05-10 09:00:00	00:00:00	5	55	4	3	t
13	11	2018-05-11 11:30:00	02:00:00	1	1	\N	2	f
26	35	2018-06-20 00:20:30	00:52:20	1	1	\N	2	f
1	1	2018-06-10 08:00:00	01:05:20	1	1	\N	2	f
22	19	2018-05-12 10:00:20	00:00:00	1	1	\N	4	f
21	18	2018-06-12 10:00:20	01:44:12	1	1	\N	2	f
3	3	2018-05-11 09:00:00	00:00:00	5	55	3	3	t
24	33	2018-06-02 00:50:00	00:00:00	10	20	19	3	f
54	64	2018-06-07 11:15:00	00:02:34	10	10	\N	1	f
19	14	2018-05-11 09:20:00	00:00:00	5	5	\N	4	f
27	37	2018-06-05 03:20:00	03:08:30	3	3	\N	2	f
55	65	2018-06-07 11:15:00	00:15:58	1	1	\N	1	f
57	67	2018-06-07 11:20:00	00:15:58	1	1	\N	1	f
40	50	2018-06-07 10:52:00	00:19:17	1	1	\N	1	f
45	55	2018-06-07 11:00:00	00:20:46	3	3	\N	1	f
44	54	2018-06-07 10:58:00	00:20:47	5	5	\N	1	f
56	66	2018-06-07 11:17:00	00:28:33	1	1	\N	1	f
53	63	2018-06-07 11:05:00	00:00:00	5	5	\N	4	f
48	58	2018-06-07 11:05:00	00:00:13	1	1	\N	4	f
49	59	2018-06-07 11:07:00	00:00:15	1	1	\N	4	f
51	61	2018-06-07 11:10:00	00:00:26	1	1	\N	4	f
23	32	2018-06-01 08:30:00	00:00:00	1	1	\N	4	f
43	53	2018-06-07 10:57:00	00:27:08	100	100	\N	1	f
47	57	2018-06-07 11:05:00	00:09:20	12	12	\N	1	f
46	56	2018-06-07 11:05:00	00:00:00	1	1	\N	4	f
50	60	2018-06-07 11:08:00	00:05:36	2	2	\N	1	f
52	62	2018-06-07 11:15:00	01:01:35	1	1	\N	1	f
11	9	2018-06-10 09:30:00	00:00:00	5	5	\N	4	f
9	20	2018-05-10 09:00:00	00:00:00	5	25	18	3	f
31	41	2018-06-05 04:27:00	00:00:00	23	23	\N	4	f
34	44	2018-06-05 04:37:00	00:00:00	23	23	\N	4	f
37	47	2018-06-05 04:45:00	00:00:00	12	12	\N	4	f
42	52	2018-06-07 10:55:00	00:20:49	1	1	\N	1	f
7	7	2018-05-11 09:00:00	01:02:35	4	4	\N	1	f
14	12	2018-12-23 00:30:10	00:20:51	2	2	\N	1	f
32	42	2018-06-05 04:30:00	01:25:32	2	2	\N	1	f
39	49	2018-06-05 04:52:00	00:43:51	3	3	\N	1	f
30	40	2018-06-05 04:25:00	01:25:31	3	3	\N	1	f
41	51	2018-06-07 10:53:00	00:00:00	10	10	\N	4	f
4	4	2018-05-11 09:00:00	00:14:21	45	45	\N	1	f
33	43	2018-06-05 04:35:00	00:19:11	34	34	\N	1	f
17	29	2018-05-31 05:20:10	02:23:27	12	12	\N	1	f
25	34	2018-06-03 04:15:00	00:28:43	10	10	\N	1	f
35	45	2018-06-05 04:40:00	00:00:00	34	34	\N	4	f
28	38	2018-06-05 04:20:00	01:28:19	2	2	\N	1	f
12	10	2018-05-10 09:30:00	04:25:26	10	10	\N	1	f
15	13	2018-06-01 05:30:00	01:22:50	5	5	\N	1	f
10	21	2018-06-10 04:30:00	01:38:18	11	11	\N	1	f
18	31	2018-05-31 00:00:00	01:21:17	10	10	\N	1	f
29	39	2018-06-05 04:23:00	01:29:05	2	2	\N	1	f
38	48	2018-06-05 04:50:00	00:00:00	3	3	\N	4	f
36	46	2018-06-05 04:30:00	00:00:00	5	5	\N	4	f
5	5	2018-05-11 09:00:00	00:00:00	2	82	15	3	f
6	6	2018-05-11 09:00:00	00:00:00	1	31	7	3	f
2	2	2018-05-10 09:00:00	00:00:00	3	20	2	3	f
\.


--
-- Data for Name: phieudaugia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phieudaugia (maphieudg, maphiendg, matk, giadau, matinhtrang) FROM stdin;
3	3	1	55	1
2	2	1	20	1
1	2	2	10	2
4	8	1	55	1
5	8	2	45	2
18	9	1	25	1
17	9	2	15	2
7	6	1	31	1
13	6	2	21	2
15	5	2	82	1
6	5	1	72	2
19	24	4	20	1
\.


--
-- Data for Name: sanpham; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sanpham (masp, loaisp, hinhanh, info, isnew, isdelete, mota) FROM stdin;
37	2	027.jpg	Giày gót vuông	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Sản xuất tại Việt Nam<br>- Bảo hành kỹ thuật 1 năm<br>- Có quai hậu dễ dàng điều chỉnh<br>- Chất liệu da PU<br>- Đế cao khoảng 4 cm<br>- Thiết kế giày quai ngang, hở mũi, mang đến sự thoải mái cho đôi chân<br>- Kích cỡ: 35-39<br></span>
32	1	010.jpg	Tai Nghe	t	t	<span id="ContentPlaceHolder1_lbProductFacts">- Thích hợp sử dụng với điện thoại di động, máy tính và các thiết bị điện tử khác<br>- Màu trắng<br>- Chiều dài: 110cm</span>
36	2	026.jpg	Túi Tote: Hình cún con	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Được làm bằng vật liệu bền chất lượng<br>- Kích thước nhỏ gọn với thiết kế phong cách<br>- Có 1 ngăn có khoá <br>- Kích thước: 24 x 14 cm.<br>- Chiều rộng: 8 cm.<br>- Dây quai: 17 cm.<br>- Màu: hồng</span>
43	1	033.jpg	TV Màn Hình Cong	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Mẫu: UHD 3200T2<br>- Bảo hành 2 năm<br>- Độ phân giải: HD<br>- Kích cỡ màn hình: 32 inch<br>- Hỗ trợ 3 HDMI, 2 USB và 1 PC(VGA) cực kì hoàn hảo<br>- Tính năng 2 trong 1: vừa làm màn hình tivi vừa làm màn hình máy tính<br>- Công suất : 60 W<br>- Công suất loa: 16 W ( 2 loa mỗi loa 8 W )<br>- Có tích hợp đầu thu kỹ thuật số DVB-T2<br>- Kích thước có chân: 778  x 122 x 498 (mm)<br>- Trọng lượng: 5 kg<br>- Trang bị độ phân giải HD cho khả năng hiển thị hình ảnh rực rỡ, sinh động, đáp ứng được nhu cầu giải trí trong gia đình bạn. Kết hợp với công nghệ hiển thị tiên tiến, từng khung hình sẽ được tái hiện thật sống động với độ sáng và màu sắc phù hợp với không gian nhà bạn.<br>- Được trang bị 2 loa với tổng công suất 106 W cùng công nghệ âm thanh Dolby Digital đem lại hiệu ứng âm thanh vòm lan tỏa, mang đến trải nghiệm âm thanh chân thực, sống động, như một rạp phim ngay chính trong nhà bạn.<br>- Đầu thu KTS được trang bị trên Tivi LED DARLING cho phép bạn thu được ít nhất 15 kênh truyền hình kỹ thuật số miễn phí với đường truyền ổn định, chất lượng cao.<br>- Với màn hình cong cùng kích thước nhỏ gọn cho bạn tiết kiệm được không gian nhưng vẫn đảm bảo chất lượng hình ảnh vượt trội.<br>- Đi kèm 2 pin AAA, đinh ốc để định vị, 1 điều khiển từ xa<br>- Xuất xứ Việt Nam</span>
42	3	032.jpg	Cây lau nhà	t	f	<span id="ContentPlaceHolder1_lbDescription">Đặc điểm sản phẩm:<br><br>- Đầu chổi quét linh động có thể xoay 360 độ và dễ luồn lách đến các khe hẹp, ngóc ngách trong nhà<br>- Chổi quét nhà thông minh tự động quét và gom rác vào ngăn chứa được thiết kế sẵn trong máy<br>- Được kết cấu từ chất liệu nhựa ABS chất lượng cao và inox chắc chắn, bền lâu với thời gian<br>- Cán tay cầm dài 1m, chỉ cần một động tác đẩy chổi hết sức nhẹ nhàng là có thể dọn dẹp dễ dàng<br>- Hệ thống chổi quét được thiết kế thông minh với sợi tổng hợp<br>- Kích thước: 43 x 12 cm<br>- Xuất xứ Trung Quốc</span>
41	3	031.jpg	Máy đánh trứng	t	f	<span id="ContentPlaceHolder1_lbDescription">Máy đánh trứng cầm tay BigSun giúp bạn tạo ra những chiếc bánh thơm ngon phục vụ gia đình, bạn bè và cả bản thân bạn. Động cơ 200 W mạnh mẽ, 7 mức tốc độ cùng các loại que trộn sẽ giúp công đoạn đánh bột mệt nhọc trở nên nhẹ nhàng hơn rất nhiều. Máy đánh trứng cầm tay BigSun là một sự bổ sung hoàn hảo cho nhà bếp của bạn. Hãy sáng tạo với Máy đánh trứng cầm tay BigSun. Đấu giá ngay!</span>
38	2	028.jpg	Kính mát nữ	t	f	<span id="ContentPlaceHolder1_lbDescription">Nâng tầm phong cách với dòng kính mát dành cho nữ đến từ thương hiệu EVE, sản phẩm cho bạn một vẻ ngoài thật sành điệu, thời trang và thích hợp để dùng trong các chuyến đi chơi biển, hoặc có thể thậm chí chỉ là một buổi shopping nho nhỏ. Đấu giá ngay!</span>
33	2	45-575-01_250.jpg	Ba Lô Nam	t	f	<span id="ContentPlaceHolder1_lbDescription">Ba-lô in hình hoa EVE giúp bạn mang theo đồ đạc một cách tiện lợi và đầy phong cách nhờ thiết kế dây đeo dễ dàng điều chỉnh, chất liệu cao cấp và kiểu dáng trẻ trung. Đấu giá ngay!</span>
34	1	020.jpg	Máy quay phim	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Tính năng, đặc điểm:<br><br>- Pixel: Pixel 5.0 MP<br>- LCD: TFT LCD 1.8 inch<br>- Phóng to: zoom kỹ thuật số 4X<br>- Độ phân giải video: 320 x 240 ºQVGA (30fps) / 640 x 480, VGA (30fps).<br>- Độ phân giải hình ảnh: 640x480 / 1280x1024 / 2048x1536 / 2592x1944<br>- Các chế độ chụp ảnh: chụp một lần, ba lần liên tục, chụp tự ảnh 10 giây<br>- Các chế độ khác: ghi âm, quay video, phát lại<br>- Bộ nhớ ngoài: Thẻ SD hoặc MMC, Tối đa 32GB (Không bao gồm thẻ nhớ)<br>- Tiêu điểm: 0,5m đến vô cùng từ máy ảnh<br>- Định dạng tệp: JPEG &amp; AVI<br>- Phơi sáng: +/- 2.0 EV<br><br>Thông số kỹ thuật:<br>&nbsp;<br>- Cân bằng trắng: tự động, ánh sáng ban ngày, có mây, sáng chói, huỳnh quang<br>- Các chế độ Flash: tự động bù ánh sáng trắng LED<br>- Điều khiển nguồn: đóng bằng tay, đóng tự động (1 phút, 3 phút, 5 phút)<br>- Giao diện kết nối: USB 2.0<br>- Ngôn ngữ: tiếng Anh, tiếng Trung<br>- Đĩa di động PCCAM cam / MSDC<br>- Công suất: Pin khô AAAx3 4.5V (Không bao gồm)<br>- Pin và thẻ nhớ (Không bao gồm)<br>- Chức năng TV out: Có<br>- Kích thước: 10 x 6,0 x 3,5 cm.<br><br>Bộ bao gồm:<br>&nbsp;<br>- 1 máy ảnh số<br>- 1 x Hướng dẫn sử dụng<br>- 1 cáp USB<br>- 1 cáp TV</span>
20	3	73-376_0111_250.jpg	Bình đun siêu tốc	t	f	<span id="ContentPlaceHolder1_lbDescription"><br>- Công suất lớn 1500W<br>- Khi đạt đến nhiệt độ sôi, ấm tự động ngắt điện, đảm bảo an toàn cho bạn.<br>- Chất liệu inox bền đẹp, không độc hại<br>- Thể tích 1.8 lít giúp bạn nấu được nhiều nước hơn khi cần sử dụng.<br>- Thiết kế đẹp, hiện đại, tay cầm cách nhiệt an toàn, đế nhựa có thể xoay 360 độ tiện dụng.<br>- Bảo hành: 3 tháng</span>
55	1	046.jpg	Ống kính tích hợp	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Hệ thống ống kính có khả năng đính vào (clip-on), tương thích với mọi loại điện thoại thông minh.<br><br>Một bộ bao gồm:<br><br>1. Ống kính mắt cá: Ống kính để chụp một góc tròn và rộng lên đến 160-170 độ theo chiều dọc và chiều ngang<br><br>2. Ống kính rộng: Ống kính để chụp một góc rộng (90-120 độ)<br><br>3. Ống kính Macro: Ống kính làm tăng chi tiết, có thể làm bạn gần như 1,5 cm.<br><br>4. Nắp ống kính (nhựa): 2 miếng</span>
49	3	040.jpg	Máy cắt rau củ	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Máy cắt rau củ<br><br>Thông số kỹ thuật:<br><br>- Được làm từ nhựa PP kết hợp nhựa ABS chất lượng cao<br>- Lưỡi dao bằng thép không gỉ cho phép cắt liên tục<br>- Sử dụng đơn giản bằng cách kéo móc vận hành<br>- Dễ dàng lau chùi và an toàn <br>- Có thể được sử dụng cắt trái cây, rau, các loại hạt, và thịt<br><br></span>
48	3	039.jpg	Máy nạo rau củ	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Dụng cụ này giúp cắt hoa trang trí và tạo hình xoắn ốc - chẳng hạn như cà rốt và các loại rau củ có rễ khác<br>- Rau củ được bào tương tự như quá trình gọt một cây bút chì<br>- Lưỡi lượn sóng có khả năng cắt rãnh giúp tạo ra những nếp sắc cạnh đầy hấp dẫn<br>- Được làm bằng nhựa và thép không gỉ chất lượng cao<br>- Chiều dài: 16 cm.<br></span>
44	1	034.jpg	Microphone mini	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Bluetooth v.4.0 + EDR<br>- Chế độ: Bluetooth / tai nghe / A2DP<br>- Kích thước nhỏ nhắn, dễ dàng mang theo nhưng sẽ không rơi ra khỏi tai của bạn<br>- Tương thích với mọi thiết bị Bluetooth (iPhone / Samsung)<br>- Quay số bằng giọng nói và chức năng gọi lại<br>- Phát và tạm dừng chức năng nghe nhạc<br>- Phạm vi không dây: tối đa 10 mét<br>- Thời gian thoại: lên đến 3 giờ<br>- Thời gian nghe nhạc: lên đến 3 giờ<br>- Thời gian chờ: 120 giờ<br>- Kích thước: 28 x 16 x 15 mm.<br>- Trọng lượng: 6 g.<br>- Màu: xanh da trời/ kem/ trắng/ hồng/ đen</span>
52	1	043.jpg	Đầu chuyển sạc	t	f	<span id="ContentPlaceHolder1_lbProductFacts"><br>Thông số kỹ thuật:<br><br>- Micro USB 2 trong 1 từ và cổng USB.<br>- Tương thích với Android 2.3 trở lên, Samsung / HTC / LG và nhiều hơn nữa.<br>- Hỗ trợ sạc và truyền dữ liệu cho thiết bị Android.<br>- Trong khi sạc, đầu nối từ có thể được sử dụng như phích cắm chống bụi.<br>- Sử dụng vật liệu thân thiện với môi trường TPE<br>- Kích thước nhỏ gọn, dễ sử dụng và mang theo.<br>- Kích thước: 0,5 x 0,5 cm.<br>- Chiều dài cáp: 1 m<br>Cáp USB Micronetic Micro cho các thiết bị Android cho phép bạn truyền dữ liệu một cách dễ dàng và thuận tiện. Trả giá ngay!</span>
54	1	045.jpg	Đồng hồ	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm:<br><br>- Thân đồng hồ bằng kim loại<br>- Dây đeo bằng nhựa<br>- Thiết kế mặt đồng hồ theo phong cách cổ điển<br>- Kim đồng hồ màu trắng<br>- Màu sắc: Đen/ Xanh lá</span>
47	1	038.jpg	Loa Bluetooth	t	t	<span id="ContentPlaceHolder1_lbProductFacts"><br>- Kết nối Bluetooth cho điện thoại di động, loa có khả năng trả lời và gọi điện thoại<br><br>- Tương thích với bất kỳ máy nghe nhạc Bluetooth hoặc điện thoại + Siri tương thích<br> <br>- Được kết nối hoàn toàn (thông qua đường dây bluetooth hoặc audio): điện thoại di động, máy tính xách tay, MP3, MP4, máy tính để bàn, DVD, VCD, CD, PMP, trò chơi điện tử và tất cả các thiết bị có đầu ra âm thanh số<br><br>- Màu sắc: Đen/ đỏ</span>
51	1	042.jpg	Đèn chiếu 3D	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Chất liệu: kính và nhựa<br>- Điện áp đầu vào: 4,5-5 V<br>- Công suất đầu vào: nguồn điện 5 V hoặc pin 3-AA<br>- Công suất ra: 2-2.5W<br>- Chức năng điều khiển từ xa<br>- 16 đèn màu tự động thay đổi mức sáng<br>- Chức năng điều khiển cảm ứng:<br>(1) Bật tắt<br>(2) Đèn mờ đầy màu sắc - 7 màu<br>(3) Sáng hoặc Tối - 1 màu</span>
56	1	047.jpg	Bảng viết màn hình	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Được làm từ nhựa ABS<br>- Dùng để ghi chú nhanh, chỉ cần nhấn nút là dễ dàng xóa bảng</span>
50	1	041.jpg	Tai nghe không dây	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Bluetooth v.4.0 + EDR<br>- Chế độ: Bluetooth / tai nghe / A2DP<br>- Kích thước nhỏ nhắn, dễ dàng mang theo nhưng sẽ không rơi ra khỏi tai của bạn<br>- Tương thích với mọi thiết bị Bluetooth (iPhone / Samsung)<br>- Quay số bằng giọng nói và chức năng gọi lại<br>- Phát và tạm dừng chức năng nghe nhạc<br>- Phạm vi không dây: tối đa 10 mét<br>- Thời gian thoại: lên đến 3 giờ<br>- Thời gian nghe nhạc: lên đến 3 giờ<br>- Thời gian chờ: 120 giờ<br>- Kích thước: 28 x 16 x 15 mm.<br>- Trọng lượng: 6 g.<br>- Màu: xanh da trời/ kem/ trắng/ hồng/ đen</span>
45	1	036.jpg	Máy chụp ảnh	t	f	<span id="ContentPlaceHolder1_lbProductFacts"><br>Máy ảnh không gương lật<br><br>Thông số kỹ thuật:<br><br>- Độ phân giải: 0.3 MP (VGA)<br>- Màn hình: Màn hình LCD 2,8 inch<br>- Sở hữu công nghệ chống rung điện tử (EIS)<br>- Có thể điều chỉnh chất lượng hình ảnh và định dạng video<br>- Có ba chế độ đo sáng cho cả chụp ảnh và quay video<br>- Chức năng cân bằng trắng cho cả chụp ảnh và quay video<br>- Có sẵn ba chế độ chụp<br>- Chỉnh sửa hình ảnh bằng 6 bộ lọc (filters), dành cho cả chụp ảnh và quay video<br>- Có chức năng in ngày tháng chụp<br>- Dùng 4 pin AAA (không kèm theo sản phẩm)<br><br></span>
4	3	005.jpg	Nệm Hơi	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Cân được thiết kế đẹp mắt trên nền tảng kính cường lực bền.<br>- Trọng lượng cao 180 kg.<br>- Đơn vị đo lường: kg / lb (người dùng tự chọn)<br>- Cân kỹ thuật số sử dụng các cảm biến chính xác cao cho độ chính xác cao. - Màn hình LCD rộng để dễ nhìn.<br>- Cần 2 pin AAA.<br>- Kích thước: 21 x 25 x 2 cm.</span>
60	2	051.jpg	Ví đeo vai nữ	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Được làm từ da PU cao cấp, bền nhẹ<br>- Rộng rãi với một ngăn chứa đồ bổ sung, dùng để bảo quản chìa khóa hoặc các vật dụng nhỏ khác<br>- Thiết kế hình chú chó bull màu đen trắng, cùng dòng chữ PUPPY che ngang<br>- Dễ dàng kết hợp với các loại phụ kiện, trang phục khác<br>- Kích thước: 30 x 1.5 x 35.5 cm.</span>
35	2	002.jpg	Xe trượt	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Ắc quy: 36V/4400mAH<br>- Công suất: 158W<br>- Thời gian sạc: 2 đến 3 giờ<br>- Thời gian sạc ban đầu: 8-10 h<br>- Điện áp: 36 V<br>- Kích thước bánh xe: 6.5 inch<br>- Nhiệt độ khi hoạt động: 15 đến 50 độ C<br>- Kích thước: 64.5 x 24 x 23.5 cm<br>- Có thể leo dốc nghiêng tối đa 30 độ<br>- Trọng lượng: 12 kg<br>- Tốc độ tối đa: 12 km/h<br>- Tải trọng tối đa: 100 kg<br>- Tải trọng tối thiểu: 20kg<br>- Quãng đường khi sạc đầy: 15-20 km (Khoảng cách quãng đường có thể thay đổi theo địa hình và trọng lượng cơ thể khác nhau của người sử dụng)<br>- Xe có gắn thiết bị cảm biến chuyển động dưới 2 bàn đệm cao su với một công tắc điều khiển 3 trạng thái được trải đều trên 3 vị trí: mũi bàn chân, lòng bàn chân, và gót chân. Người dùng có thể điều khiển xe bằng cách nhún chân về trước hoặc sau để tiến lên hay lùi lại.<br>- Thiết kế trẻ trung, gọn nhẹ, động cơ chạy êm ái, không gây ồn<br>- Phụ kiện đi kèm:<br>1 sạc, 1 HDSD<br>- Xuất xứ Trung Quốc<br></span>
58	2	049.jpg	Túi xách tay nữ	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Làm từ da PU chất lượng cao<br>- 2 dây đeo vai, có thể tháo rời<br>- Sức chứa cao, giữ mọi thứ của bạn được tổ chức<br>- Khóa nam châm<br>- Đẳng cấp và thanh lịch<br>- Chiều dài dây đeo: 72 cm.<br>- Kích thước: 8 x 22 x 18 cm.</span>
59	2	050.jpg	Túi đeo vai nữ	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Được làm từ da PU cao cấp<br>- Dễ dàng phối với các loại phụ kiện, quần áo khác<br>- Thích hợp để dùng hàng ngày<br>- Kích thước: 25 x 14 x 28 cm</span>
2	3	004.jpg	Chảo Chống dính	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Được làm bằng hợp kim nhôm giúp dẫn nhiệt nhanh chóng và tiết kiệm chi phí khi đun nấu.<br>- Lòng chảo được phủ lớp chống dính cao cấp giúp thức ăn không bị dính vào chảo khi nấu và có thể dễ dàng vệ sinh sạch sẽ.<br>- Một bộ gồm 3 chảo với kích thước khác nhau: 18 cm, 22 cm, 26 cm, phù hợp với mọi nhu cầu<br>- Không chứa hóa chất độc hại<br>- Tay cầm có lỗ tròn nhỏ, giúp bạn dễ dàng treo sản phẩm, tiết kiệm không gian<br>- Có trang bị cán tay cầm cách nhiệt, giúp bạn nấu nướng tiện lợi, dễ dàng hơn.<br>- Đường kính chảo lần lượt: 18 cm, 22 cm, 26 cm<br></span>
1	1	010.jpg	Tai nghe Iphone	t	f	<span id="ContentPlaceHolder1_lbProductFacts">- Thích hợp sử dụng với điện thoại di động, máy tính và các thiết bị điện tử khác<br>- Màu trắng<br>- Chiều dài: 110cm</span>
3	3	001.jpg	Bộ dao	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Bộ dụng cụ nhà bếp gồm 5 món, giúp bạn nấu ăn ngon hơn, dễ dàng hơn<br>- Được làm từ chất liệu cao cấp, chịu nhiệt và bền chắc<br>- Dễ dàng vệ sinh<br>- Đi kèm một giá treo, giúp bạn dễ dàng sắp xếp tiện lợi<br>- Chiều dài dụng cụ: 29 cm<br>- Kích thước giá: 33 x 6.5 x 18.8 cm.</span>
6	2	014.jpg	Ba lô dây chéo	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm kỹ thuật :<br><br>- Có thể được sử dụng như một túi đeo vai hoặc túi đeo hông<br>- Được làm từ vải chất lượng cao, có hơi và bền<br>- 2 túi kéo để tăng dung lượng lưu trữ<br>- Điều chỉnh dây đeo bằng khóa nhựa<br>- Chiều dài dây: 67,5 cm.<br>- Kích thước túi: 14 x 34 cm.</span>
5	2	007.jpg	Giày thể thao: Đen	t	f	<span id="ContentPlaceHolder1_lbProductFacts">NEAT Truknit Dòng: Màu xám<br><br>Thông số kỹ thuật:<br><br>- Đệm màu trắng, nền kaki xanh và ren<br>- Xuất xứ từ chất lượng, vật liệu nhẹ, linh hoạt và thoải mái<br>- Phù hợp với bất kỳ kiểu dáng và phong cách nào<br>- Kích thước: 40-45 (EU)<br><br><br></span>
8	1	010.jpg	Tai nghe Iphone	t	f	<span id="ContentPlaceHolder1_lbProductFacts">- Thích hợp sử dụng với điện thoại di động, máy tính và các thiết bị điện tử khác<br>- Chiều dài: 110 cm.<br>- Màu sắc: Đen<br>- Kiểm soát âm lượng</span>
7	1	012.jpg	Nhẫn giữ điện thoại	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- 8 món dụng cụ thay màn hình Iphone 6<br>- Mặt kính cảm ứng màn hình cảm ứng chất lượng cao<br>- Tự sửa chữa hoặc thay thế màn hình cũ, vỡ, nứt, bị hỏng<br>- Tính năng: Độ nét cao, chống xước, bảo vệ màn hình<br>- Vui lòng yêu cầu các chuyên gia tháo rời Front Glass Lens và bộ số cảm ứng của màn hình LCD ban đầu của bạn trước khi thay đổi kính thủy tinh phía trước của bạn.<br><br></span>
10	2	015.jpg	Nón Nam	t	f	<span id="ContentPlaceHolder1_lbProductFacts"><br>- Lưỡi nón snapback thiết kế hiện đại, hoàn hảo.<br>- Làm từ vải chất lượng cao, thoáng khí và mềm.<br>- Thiết kế viền xanh dương và đen.<br>- Khóa nhựa có thể điều chỉnh được.<br>- Kích thước: 24 x 21 x 16 cm.<br></span>
9	3	017.jpg	Thùng rác VP	t	f	<span id="ContentPlaceHolder1_lbProductFacts"><br><br>Đặc điểm kỹ thuật:<br><br>- Dùng để bảo quản bàn chải đánh răng và ống kem đánh răng<br>- Giữ cho kem đánh răng sạch / khô<br>- Dễ dàng lắp đặt và sử dụng<br>- Làm bằng nhựa, nhẹ và bền<br>- Thiết kế bọ rùa đáng yêu<br>- Kích thước: 12 x 5 x 14 cm.<br><br></span>
12	1	009.jpg	Loa để bàn	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Hỗ trợ PC, máy tính xách tay, iPod và máy nghe nhạc MP3<br>- Âm thanh stereo, loa được bảo vệ từ bằng nam châm<br>- Âm thanh có độ trung thực cao với thiết bị tản nhiệt cộng hưởng<br>- 80 decibel<br>- Tần số: 90-20 K / Hz<br>- Điện áp: 5V</span>
14	1	011.jpg	Loa bluetooth	t	f	<span id="ContentPlaceHolder1_lbProductFacts"><br>- Kết nối Bluetooth cho điện thoại di động, loa có khả năng trả lời và gọi điện thoại<br><br>- Tương thích với bất kỳ máy nghe nhạc Bluetooth hoặc điện thoại + Siri tương thích<br> <br>- Được kết nối hoàn toàn (thông qua đường dây bluetooth hoặc audio): điện thoại di động, máy tính xách tay, MP3, MP4, máy tính để bàn, DVD, VCD, CD, PMP, trò chơi điện tử và tất cả các thiết bị có đầu ra âm thanh số<br><br>- Màu sắc: Đen/ đỏ</span>
13	2	013.jpg	Mắt kính mát	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Kính mát tròng xanh gọng đen<br>- Chiều rộng mắt kính 5.5 cm<br>- Chiều cao mắt kính 5 cm<br>- Cầu mũi 1 cm<br>- Càng kính: 14 cm<br></span>
19	3	73-157-main_250.jpg	Case điện thoại	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Dùng để truyền dữ liệu từ điện thoại di động<br>- Thiết kế tuyệt vời<br>- Độ bền chắc chắn<br>- Tương thích với thiết bị Android<br>- Chiều dài: 90 cm.<br>- Màu sắc: Bạc/ xanh</span>
18	1	006.jpg	Bộ nồi	t	f	<span id="ContentPlaceHolder1_lbDescription">Đặc điểm sản phẩm:<br><br>- Lớp chống dính cao cấp, đảm bảo an toàn vệ sinh thực phẩm, không sinh ra phản ứng phụ khi nấu ăn, dễ dàng chùi rửa, thạn chế lượng dầu mỡ khi chế biến.<br>- Chất liệu nhôm sáng bóng, bền đẹp<br>- Bộ nồi chống dính cao cấp với thiết kế nhỏ gọn vô cùng tiện lợi, cho bạn dễ dàng di chuyển và lau dọn.<br>- Tay cầm bằng nhựa cách nhiệt<br>- Kèm theo nắp kính<br>- Có thể sử dụng cho bếp ga, bếp điện, bếp điện từ<br>- Một bộ gồm:<br>1 nồi có cán dài: 18 cm<br>1 chảo: 24 cm<br>1 nồi: 24 cm</span>
21	2	015.jpg	Nón kết	t	f	<span id="ContentPlaceHolder1_lbProductFacts"><br>- Lưỡi nón snapback thiết kế hiện đại, hoàn hảo.<br>- Làm từ vải chất lượng cao, thoáng khí và mềm.<br>- Thiết kế viền xanh dương và đen.<br>- Khóa nhựa có thể điều chỉnh được.<br>- Kích thước: 24 x 21 x 16 cm.<br></span>
31	2	016.jpg	Dây nịch Nam	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Làm từ da PU chất lượng cao, chắc và bền<br>- khóa màu vàng bạc hình chữ U<br>- 5 kích thước vòng eo để điều chỉnh<br>- Thắt lưng được làm một nửa da và một nửa dây (nổi bật khỏi đám đông)<br><br>Kích cỡ<br>- M: 3,5 x 115 cm.<br>- L: 3,5 x 126 cm.<br>- Màu: nâu đậm</span>
29	3	008.jpg	Air Compressor	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br>- Màu: đen/xanh/trắng<br>- Màn hình TFT độ phân giải cao<br>- Chế độ phim: Hỗ trợ tất cả các định dạng video<br>- Hỗ trợ các tập tin như: RMVB, 3GP, MP4, AVI, WMV ...<br>- Nghe nhạc: Hỗ trợ tất cả các định dạng tập tin âm thanh đầy đủ APE, FLAC, MP3, WMA, WAV, RM-Audio, AMR, AAL-LC, AAC ...<br>- Trò chơi: Hỗ trợ trò chơi định dạng NES các trò chơi Net, trò chơi định dạng BIN 32 bit, trò chơi 64 bit.<br>- Supper TV-OUT: Quay video DVD.<br>- Hỗ trợ quay phim và quay phim DV.<br>- Hỗ trợ định dạng JPG với hiệu ứng xem 3D.<br>- Hỗ trợ chức năng e-book.<br>- Ngôn ngữ: Đa ngôn ngữ.<br>- Loa: Loa lắp sẵn.<br>- USB: Ver.2.0<br>- Thẻ SD: Thẻ SD MINI<br>- Ghi âm: Ghi âm MIC<br>- Kích thước: 17 x 7.5 x 1.7 cm.</span>
63	2	054.jpg	Túi Duffle	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Túi đeo vai bằng da mềm, phối kèm dây đeo sợi xích, tạo thành một món phụ kiện đầy phong cách cho mọi dịp<br>- Nhỏ gọn, dễ mang đi, có thể bảo quản được nhiều đồ dùng<br>- Có một ngăn trong để dễ dàng giữ các món đồ cá nhân<br>- Kích thước: 36 x 17 x 28 cm<br>- Chiều dài dây: 75 cm<br></span>
62	2	053.jpg	Đồng hồ nữ	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Được làm từ da PU chất lượng cao<br>- Mặt số tròn màu vàng<br>- Mặt số: 3.5 cm<br>- Độ dài dây đeo: 21 cm</span>
65	3	056.jpg	Bộ dao 5 món	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Bộ dụng cụ nhà bếp gồm 5 món, giúp bạn nấu ăn ngon hơn, dễ dàng hơn<br>- Được làm từ chất liệu cao cấp, chịu nhiệt và bền chắc<br>- Dễ dàng vệ sinh<br>- Đi kèm một giá treo, giúp bạn dễ dàng sắp xếp tiện lợi<br>- Chiều dài dụng cụ: 29 cm<br>- Kích thước giá: 33 x 6.5 x 18.8 cm.</span>
64	3	055.jpg	Máy mài dao	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Không dây và có động cơ, có chức năng mài dao hoặc các loại lưỡi kim loại khác trong nháy mắt<br>- Đi kèm khay nhỏ đựng rác, tiện lợi và sạch sẽ<br>- Kích thước nhỏ gọn, dễ dàng mang theo và bền chắc<br>- Kích thước: 8.5 x 6 x 14 cm</span>
67	3	058.jpg	Giá để giày	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Giá giày dáng đứng. Nó có màu trắng và 10 kệ. Có thể chứa 3 đôi giày trên mỗi kệ.<br><br>Chiều rộng: 16 cm<br><br>Chiều dài: 50,5 cm<br><br>Chiều cao: 139 cm<br><br>Trọng lượng: 1,5 kg<br></span>
66	3	057.jpg	Chảo không dính	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm kỹ thuật:<br><br>- Được làm từ thép không gỉ, độ bền cao<br>- Có tráng lớp chống dính<br>- Kích thước: 37 x 22/38 x 24 cm / 39 x 26 cm<br></span>
61	2	052.jpg	Đồng hồ đeo tay	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Được làm từ da PU chất lượng cao<br>- Mặt số tròn màu vàng<br>- Mặt số: 3.5 cm<br>- Độ dài dây đeo: 21 cm</span>
53	1	044.jpg	TV LED 32 inch	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm sản phẩm:<br><br>- Mẫu: UHD 3200T2<br>- Bảo hành 2 năm<br>- Độ phân giải: HD<br>- Kích cỡ màn hình: 32 inch<br>- Hỗ trợ 3 HDMI, 2 USB và 1 PC(VGA) cực kì hoàn hảo<br>- Tính năng 2 trong 1: vừa làm màn hình tivi vừa làm màn hình máy tính<br>- Công suất : 60 W<br>- Công suất loa: 16 W ( 2 loa mỗi loa 8 W )<br>- Có tích hợp đầu thu kỹ thuật số DVB-T2<br>- Kích thước có chân: 778  x 122 x 498 (mm)<br>- Trọng lượng: 5 kg<br>- Trang bị độ phân giải HD cho khả năng hiển thị hình ảnh rực rỡ, sinh động, đáp ứng được nhu cầu giải trí trong gia đình bạn. Kết hợp với công nghệ hiển thị tiên tiến, từng khung hình sẽ được tái hiện thật sống động với độ sáng và màu sắc phù hợp với không gian nhà bạn.<br>- Được trang bị 2 loa với tổng công suất 106 W cùng công nghệ âm thanh Dolby Digital đem lại hiệu ứng âm thanh vòm lan tỏa, mang đến trải nghiệm âm thanh chân thực, sống động, như một rạp phim ngay chính trong nhà bạn.<br>- Đầu thu KTS được trang bị trên Tivi LED DARLING cho phép bạn thu được ít nhất 15 kênh truyền hình kỹ thuật số miễn phí với đường truyền ổn định, chất lượng cao.<br>- Với màn hình cong cùng kích thước nhỏ gọn cho bạn tiết kiệm được không gian nhưng vẫn đảm bảo chất lượng hình ảnh vượt trội.<br>- Đi kèm 2 pin AAA, đinh ốc để định vị, 1 điều khiển từ xa<br>- Xuất xứ Việt Nam</span>
57	1	048.jpg	Máy chiếu ĐT	t	f	<span id="ContentPlaceHolder1_lbProductFacts"><br>Máy ảnh không gương lật<br><br>Thông số kỹ thuật:<br><br>- Độ phân giải: 0.3 MP (VGA)<br>- Màn hình: Màn hình LCD 2,8 inch<br>- Sở hữu công nghệ chống rung điện tử (EIS)<br>- Có thể điều chỉnh chất lượng hình ảnh và định dạng video<br>- Có ba chế độ đo sáng cho cả chụp ảnh và quay video<br>- Chức năng cân bằng trắng cho cả chụp ảnh và quay video<br>- Có sẵn ba chế độ chụp<br>- Chỉnh sửa hình ảnh bằng 6 bộ lọc (filters), dành cho cả chụp ảnh và quay video<br>- Có chức năng in ngày tháng chụp<br>- Dùng 4 pin AAA (không kèm theo sản phẩm)<br><br></span>
39	2	029.jpg	Túi xách nữ 	t	f	<span id="ContentPlaceHolder1_lbProductFacts">Đặc điểm kỹ thuật :<br><br>- Túi hình vuông, nhỏ cho phụ nữ.<br>- Làm từ da PU chất lượng cao, mềm và không bẩn.<br>- 2 ngăn chứa có khóa kéo.<br>- Dây đeo vai được làm từ da và xích<br>- Chiều dài dây: 124 cm.<br>- Túi có kích thước: 9 x 20 x 16 cm.<br>- Màu: Đen/ xám</span>
40	3	030.jpg	Bộ dụng cụ nhà bếp	t	f	<span id="ContentPlaceHolder1_lbDescription">Đặc điểm sản phẩm:<br><br>- Được làm bằng thép không gỉ và nhựa chất lượng cao<br>- Gồm có: dao bào vỏ, kéo, dao gọt, dao thái, dao chặt<br>- Tay cầm được thiết kế vừa vặn, giúp cầm nắm dễ dàng, chắc chắn<br>- Được thiết kế với phong cách tối giản nhưng vẫn hiệu quả và toát lên vẻ sang trọng cho căn bếp nhà bạn<br>- Xuất xứ: Trung Quốc<br></span>
11	3	017.jpg	Thùng rác kim loại	t	f	<div class="top-feature-item bullet-wrap">                                                                                                  <p>Dung tích: 10L</p>                                 <p>Chất liệu ki loại bền bỉ</p>                                                                                                                                                             <p>Kiểu dáng gọn nhẹ, chắc chắn và hiện đại</p>                                                                                                                                                           <p>Thiết kế nắp bật thông minh, dễ sử dụng</p>  </div>
46	1	037.jpg	Sạc không dây 	t	t	<span id="ContentPlaceHolder1_lbProductFacts">Thông số kỹ thuật:<br><br>- Rất dễ dàng để thay đổi cáp USB vi để 8pin cáp.<br>- Đây chỉ là bộ chuyển đổi, cáp vi mô không bao gồm.<br>- Hỗ trợ cho: iPhone6, iPhone6P, iPhone5s, iPhone5c, iPhone5, iPad4, iPadmini, Nano7 và iPodTouch5<br>- Kích thước: 2.2 x 1 x 0.5 cm.<br></span>
\.


--
-- Data for Name: taikhoan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.taikhoan (matk, tentk, matkhau, loaitk, sdt, diachi) FROM stdin;
4	c	c	2	0169458123	12 Hùng Vương, Q.5, tpHCM
2	b	b	2	0169452018	56 Hàng Xanh, Hà Nội
1	a	a	2	090356812	105 Nguyễn Văn Cừ, Q.1, tpHCM
3	ad	ad	1	0919352148	104 Nguyễn Duy Dương, Q.5 
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
5	khong thanh toan
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

SELECT pg_catalog.setval('public.phiendaugia_maphiendg_seq', 57, true);


--
-- Name: phieudaugia_maphieudg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phieudaugia_maphieudg_seq', 19, true);


--
-- Name: sanpham_masp_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sanpham_masp_seq', 67, true);


--
-- Name: taikhoan_matk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taikhoan_matk_seq', 4, true);


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

