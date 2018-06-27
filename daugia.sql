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
2	2	2018-05-10 09:00:00	00:00:00	3	20	2	3	f
8	8	2018-05-10 09:00:00	00:00:00	5	55	4	3	f
27	36	2018-06-19 00:00:00	00:00:00	10	10	\N	4	f
6	6	2018-05-11 09:00:00	00:00:00	1	31	7	5	f
14	12	2018-12-23 00:30:10	00:00:00	2	42	22	3	f
31	40	2018-06-27 00:09:00	01:18:10	1	1	\N	1	f
15	13	2018-06-01 05:30:00	02:00:06	5	5	\N	4	f
34	44	2018-06-27 01:03:30	01:42:40	5	5	\N	1	f
5	5	2018-05-11 09:00:00	00:00:00	2	110	15	3	f
29	38	2018-06-27 00:08:00	00:26:22	11	11	\N	1	f
74	84	2018-06-27 20:00:00	01:58:20	3	3	\N	1	f
13	11	2018-05-11 11:30:00	01:24:02	1	1	\N	1	f
73	83	2018-06-27 20:00:00	01:24:50	1	1	\N	1	f
58	68	2018-06-27 11:00:00	01:15:37	1	1	\N	1	f
54	64	2018-06-27 00:00:00	01:03:23	1	1	\N	1	f
37	47	2018-06-27 05:00:00	00:19:27	30	30	\N	1	f
22	19	2018-05-12 10:00:20	00:24:23	1	1	\N	1	f
71	81	2018-06-27 16:00:00	01:51:45	1	1	\N	1	f
38	48	2018-06-27 00:30:00	00:21:06	1	1	\N	1	f
68	78	2018-06-27 00:00:00	01:50:52	1	1	\N	1	f
28	37	2018-06-27 00:00:00	01:40:15	10	10	\N	1	f
59	69	2018-06-27 00:00:00	01:11:00	1	1	\N	1	f
1	1	2018-06-10 08:00:00	02:00:20	1	1	\N	2	f
41	51	2018-06-27 00:00:00	01:35:39	100	100	\N	1	f
66	76	2018-06-27 10:54:00	01:14:45	1	1	\N	1	f
40	50	2018-06-27 10:00:00	01:12:39	100	100	\N	1	f
39	49	2018-06-27 00:10:00	00:27:21	1	1	\N	1	f
67	77	2018-06-27 11:00:00	01:46:43	1	1	\N	1	f
21	18	2018-06-12 10:00:20	01:44:12	1	1	\N	2	f
49	59	2018-06-27 05:00:00	00:59:19	1	1	\N	1	f
57	67	2018-06-27 00:00:00	01:25:40	20	20	\N	1	f
48	58	2018-06-27 05:00:00	01:01:58	1	1	\N	1	f
77	87	2018-06-27 21:00:00	01:25:08	99	99	\N	1	f
70	80	2018-06-27 09:30:00	01:27:43	1	1	\N	1	f
64	74	2018-06-27 10:25:00	01:19:46	1	1	\N	1	f
35	45	2018-06-27 10:00:00	00:43:52	1	1	\N	1	f
33	43	2018-06-27 01:03:30	01:14:55	10	10	\N	1	f
47	57	2018-06-27 10:00:00	00:56:00	1	1	\N	1	f
75	85	2018-06-27 08:00:00	01:25:25	1	1	\N	1	f
43	53	2018-06-27 09:00:00	02:04:28	10	10	\N	1	f
52	62	2018-06-27 10:00:00	01:06:46	1	1	\N	1	f
46	56	2018-06-27 09:00:00	00:59:20	1	1	\N	1	f
36	46	2018-06-27 12:00:00	01:37:09	1	1	\N	1	f
45	55	2018-06-27 08:00:00	01:26:20	1	1	\N	1	f
50	60	2018-06-27 07:00:00	01:09:26	1	1	\N	1	f
53	63	2018-06-27 10:00:00	01:15:35	1	1	\N	1	f
62	72	2018-06-27 08:00:00	01:13:50	1	1	\N	1	f
44	54	2018-06-27 00:30:30	00:28:08	1	1	\N	1	f
42	52	2018-06-27 08:30:00	01:04:27	1	1	\N	1	f
61	71	2018-06-27 13:00:00	01:16:05	1	1	\N	1	f
63	73	2018-06-27 15:00:00	01:15:45	1	1	\N	1	f
51	61	2018-06-27 01:25:00	01:03:08	1	1	\N	1	f
30	39	2018-06-27 00:08:00	01:39:13	1	1	\N	1	f
32	41	2018-06-27 00:12:00	00:56:29	1	1	\N	1	f
55	65	2018-06-27 10:00:00	01:08:44	11	11	\N	1	f
26	35	2018-06-20 00:20:30	01:21:10	1	1	\N	1	f
11	9	2018-06-10 09:30:00	00:00:00	5	5	\N	4	f
20	16	2018-06-11 09:10:20	00:17:38	15	15	\N	1	f
9	20	2018-05-10 09:00:00	01:10:29	5	74	\N	1	f
4	4	2018-05-11 09:00:00	00:53:20	1	45	\N	1	f
65	75	2018-06-27 00:10:00	01:51:10	1	1	\N	1	f
17	29	2018-05-31 05:20:10	01:39:28	12	12	\N	1	f
25	34	2018-06-03 04:15:00	00:00:00	10	10	\N	4	f
56	66	2018-06-27 10:00:00	01:35:39	1	1	\N	1	f
24	33	2018-06-02 00:50:00	00:17:27	10	23	\N	1	f
7	7	2018-05-11 09:00:00	01:48:40	4	4	\N	1	f
3	3	2018-05-11 09:00:00	00:00:00	5	55	3	3	f
60	70	2018-06-27 00:00:00	01:44:57	30	30	\N	1	f
10	21	2018-06-10 04:30:00	01:15:17	11	11	\N	1	f
69	79	2018-06-27 11:20:00	01:03:11	1	1	\N	1	f
12	10	2018-05-10 09:30:00	00:56:24	10	21	\N	1	f
76	86	2018-06-27 19:00:00	01:25:23	30	30	\N	1	f
19	14	2018-05-11 09:20:00	00:00:00	5	5	\N	4	f
23	32	2018-06-01 08:30:00	00:00:00	1	1	\N	4	f
18	31	2018-05-31 00:00:00	00:00:00	10	10	\N	4	f
72	82	2018-06-27 08:20:00	01:20:25	1	1	\N	1	f
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
15	5	2	110	1
7	6	1	31	1
13	6	2	21	2
6	5	1	108	2
22	14	2	42	1
21	14	1	41	2
20	12	1	21	1
24	9	4	74	1
17	9	2	73	2
18	9	1	71	2
23	24	1	23	1
19	24	4	22	2
\.


--
-- Data for Name: sanpham; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sanpham (masp, loaisp, hinhanh, info, isnew, isdelete, mota) FROM stdin;
16	1	041.jpg	HeadPhone Lớn	t	f	Chất lượng cao\nChống ồn khi nghe nhạc
2	3	004.jpg	Chảo Chống dính	t	f	Chuẩn bị cho các bữa ăn gia đình với chảo rán ! Đấu giá ngay!\n\nThông số kỹ thuật:\n\n- Chảo đa năng chuyên dành để chiên rán,v..v...\n- Được làm bằng inox chất lượng cao, tráng bằng lớp phủ không dính, bền đẹp\n- Thiết kế hiện đại, dễ sử dụng. Có thể sử dụng với bếp điện từ.\n- Sản phẩm không dễ bị cháy, lòng chảo có thiết kế khoa học, giữ nhiệt và dinh dưỡng của thực phẩm.\n- Lòng chảo có dáng cong, dễ dàng sử dụng và vệ sinh.\n- Kích thước: 12 "
3	3	001.jpg	Bộ dao	t	f	Bộ dao 5 món chất lượng hoàn hảo cung cấp cho bạn trải nghiệm tốt nhất khi làm bếp. Với lưỡi dao sắc bén bằng thép không gỉ, cán tay cầm vừa vặn, sản phẩm Bộ dao 5 món có thể đáp ứng mọi nhu cầu gọt, cắt thực phẩm của bạn. Đấu giá ngay!\n\nĐặc điểm sản phẩm:\n\n- Được làm bằng thép không gỉ và nhựa chất lượng cao\n- Gồm có: dao bào vỏ, kéo, dao gọt, dao thái, dao chặt\n- Tay cầm được thiết kế vừa vặn, giúp cầm nắm dễ dàng, chắc chắn\n- Được thiết kế với phong cách tối giản nhưng vẫn hiệu quả và toát lên vẻ sang trọng cho căn bếp nhà bạn\n- Xuất xứ: Trung Quốc
11	3	003.jpg	Máy nạo rau củ	t	f	Dễ dàng và nhanh chóng nạo rau củ như cà rốt, củ cải ..! Dụng cụ tuyệt vời không thể thiếu để làm các món ăn nhẹ chiên giòn từ rau củ hay làm sợi mỳ chay! Đấu giá ngay!\n\nMáy nạo rau củ\n- Làm từ nhựa và thép không gỉ chất lượng cao \n- Dễ dàng làm sạch\n\nKích thước\n- Cho rau củ : 20-54 mm.\n\n- kích thước nạo : 7 x 13 cm
4	3	005.jpg	Nệm giường hơi	t	f	Sản phẩm là giường hơi dành cho 2 người, có thể dùng cho cả trong nhà và ngoài trời. Rất dễ sử dụng và dễ dàng vệ sinh.\n\nThông số kỹ thuật:\n\n- Nệm cỡ nhỏ có thể thổi phồng khi sử dụng trong nhà và ngoài trời.\n- Dễ dàng vệ sinh, chống thấm nước, phù hợp cho việc cắm trại\n- Thiết kế bề mặt sóng đồng đều, giúp giấc ngủ thêm sâu\n- Lý tưởng cho hoạt động cắm trại, tiệc ngoài trời BBQ hoặc bơi bãi biển...\n- Trọng lượng nhẹ và tiết kiệm không gian.\n- Không kèm theo máy bơm hơi\n- Kích thước: 191 x 137 x 22 cm.
19	3	73-157-main_250.jpg	Case điện thoại	t	t	Dễ sử dụng\nBền, chất liệu tốt
21	2	73-210-Main1_250.jpg	Nón Bảo Hiểm	t	f	Nón bảo hiểm 3/4 đầu được làm từ nhựa ABS chất lượng cao, đệm lót trong êm ái, đảm bảo an toàn cho sức khỏe và độ bền chắc kéo dài theo thời gian với khả năng chống chịu va đập tốt.\n\nĐặc điểm sản phẩm:\n\n- Chất liệu: nhựa ABS nguyên sinh, đệm vải mềm\n- Kích thước: 25 x 24 x 23 cm\n- Vỏ nón được làm từ nhựa ABS chịu được tác động mạnh của ngoại lực và bền chắc theo thời gian.\n- Lớp đệm lót bên trong êm ái được thiết kế ôm trọn vòng đầu, tạo cảm giác thoải mái, có khả năng chống ẩm và vi khuẩn tốt, bảo vệ người sử dụng khi xảy ra va chạm.\n- Khóa nón bền, linh hoạt, dây quai nón chắc chắn và có thể dễ dàng điều chỉnh, phù hợp với từng vòng đầu.\n- Thiết kế bao 3/4 vòng đầu, tăng cường sự an toàn khi tham gia giao thông\n- Kiểu dáng trẻ trung, và đầy phong cách thể thao mạnh mẽ, năng động\n- Có 2 màu thời trang cho bạn lựa chọn: Đen/Trắng\n- Xuất xứ Việt Nam
8	1	010.jpg	Tai nghe Iphone	t	f	Tai nghe thời trang\nSử dụng được với hầu hết tất cả điện thoại\n
10	2	015.jpg	Nón Kết Nam	t	f	Thời trang\nKiểu dáng mới nhất
29	3	008.jpg	Air Compressor	t	f	Bền \nĐẹp
31	2	016.jpg	Dây nịch Nam	t	f	Đẹp\nThời trang
20	3	73-376_0111_250.jpg	Bình đun siêu tốc	t	f	- Công suất lớn 1500W\n- Khi đạt đến nhiệt độ sôi, ấm tự động ngắt điện, đảm bảo an toàn cho bạn.\n- Chất liệu inox bền đẹp, không độc hại\n- Thể tích 1.8 lít giúp bạn nấu được nhiều nước hơn khi cần sử dụng.\n- Thiết kế đẹp, hiện đại, tay cầm cách nhiệt an toàn, đế nhựa có thể xoay 360 độ tiện dụng.\n- Bảo hành: 3 tháng
35	2	002.jpg	Xe trượt	t	f	Tiện dụng\nĐẹp\nDành cho các bé
36	1	022.jpg	điện thoại Iphone	t	f	Tiện lợi\nThanh lịch\nSang trọng
9	3	017.jpg	Thùng rác VP	t	f	Bền\nChắc chắn\nKhông sét vì làm từ inox
34	1	020.jpg	Máy quay phim	t	f	Máy quay phim chất lượng cao\nSắc nét
33	2	45-575-01_250.jpg	Ba Lô Nam	t	f	Ba lô NEAT với thiết kế 1 ngăn kéo chính, ngăn phụ bên hồng túi kèm dây đai có thể điều chỉnh thuận tiện để đựng các vật dụng cần thiết của bạn .Đấu giá ngay cho sản phẩm này!\n\nBalo NEAT\n\n- Thiết kế 1 ngăn kéo chính kèm ngăn phụ bên hông túi\n- Dây đai điều chỉnh tiện lợi\n- Được làm từ vật liệu chất lượng cao, nhẹ và thoáng khí\n- Kích thước: 35 x 14 x 44 cm
1	1	010.jpg	Tai nghe	t	f	Thiết kế khoa học 3,5 mm cho phép bạn tận hưởng âm thanh trong trẻo như pha lê và không bị ảnh hưởng từ tiếng ồn xung quanh.\n\n- Thích hợp sử dụng với điện thoại di động, máy tính và các thiết bị điện tử khác\n- Chiều dài: 110 cm.\n- Màu sắc: Đen\n- Kiểm soát âm lượng
32	1	010.jpg	Tai Nghe	t	t	Chất lượng\nĐẹp, bền
12	1	009.jpg	Loa để bàn	t	f	Trải nghiệm âm thanh sống động\nBass cực êm tai
14	1	011.jpg	Loa bluetooth	t	f	Âm thanh cực lớn\nKiểu dáng thời trang\nSang trọng
13	2	013.jpg	Mắt kính mát	t	f	Kính mát đen là phụ kiện hoàn hảo để hoàn thiện vẻ đẹp của bạn. Nổi bật với các thông số kỹ thuật mắt kính tròn / đen mang đến phong cách cá tính. Mắt kính tròn lớn hơn thật sự lý tưởng cho những người có khuôn mặt vuông, dài, hoặc hình trái xoan. Trả giá ngay!\n\nKính mát với khung đen.\n- Chiều rộng mắt kính 6 cm.\n- Chiều dài mắt kính 5 cm.\n- Cầu mũi 2 cm.\n- Chiều dài 14 cm.
18	1	006.jpg	Bộ nồi	t	f	Độ bền cao\nKích thước lớn\nDễ dàng sử dụng
6	2	014.jpg	Ba lô dây chéo	t	f	Thời trang 2018\nPhù hợp với mọi lứa tuổi
5	2	007.jpg	Giày thể thao: Đen	t	f	Giày thể thao đẹp, phù hợp với các bạn trẻ\nĐế giày chắc chắn\nKhông bung keo
37	1	023.jpg	Xe trượt điện tử	t	f	Thiết kế đẹp\nDành cho các bạn trẻ
38	1	021.jpg	Đồng hồ điện tử	t	f	Thiết kế của tương lai\nSử dụng dễ dàng
39	2	025.jpg	Balo nữ	t	f	Balo nữ tính.\nPhù hợp cho các bạn nữ
40	2	027.jpg	Giày cao gót	t	f	Kiểu dáng thanh lịch.\nLàm từ da thật\nHÀng chính hãng
42	3	032.jpg	Cây lau nhà	t	f	Lau sàn cực nhanh.\nKhông để lại nước.
43	2	053.jpg	Đồng hồ nam	t	f	Sản phẩm Đồng hồ đeo tay Nam NEAT phù hợp với mọi cá tính, nổi bật với thiết kế mặt số tròn cổ điển với nét đơn giản, tinh tế có thể hợp với hầu hết mọi nơi, mọi lúc. Đấu giá ngay!\n\nĐặc điểm sản phẩm:\n\n- Mặt số hình tròn\n- Thân và cốt đồng hồ: Nhựa resin\n- Dây đồng hồ: da PU\n- Đồng hồ có 3 kim (giờ, phút, giây)\n- Thiết kế đơn giản và thanh nhã, phù hợp với mọi loại trang phục
44	2	050.jpg	Túi xách nữ	t	f	Hãy bảo quản các vật dụng, tài sản cá nhân của bạn cùng Túi đeo vai vải calico, một sản phẩm được gia công từ chất liệu vải calico cao cấp, cộng thêm đường may tỉ mỉ, bảo đảm độ bền chắc.\n\nĐặc điểm sản phẩm:\n\n- Bảo quản vật dụng, tài sản cá nhân một cách tiện lợi\n- Được làm từ vải calico cao cấp, cùng đường may chắc chắn, sắc sảo\n- Có thể dùng làm ví cầm tay hoặc túi đeo vai\n- Nhẹ, nhỏ gọn, dễ mang theo\n- Kích thước: 20 x 9 x 17 cm.
41	3	031.jpg	Máy đánh trứng	t	f	Đồ bền cao.\nDễ dàng sử dụng.
7	1	012.jpg	Nhẫn giữ điện thoại	t	f	Nhẫn giữ điện thoại giúp bạn không làm rơi điện thoại trong khi chụp ảnh, hoặc cũng có thể làm giá đỡ để xem video. Đấu giá ngay!\n\nThông số kỹ thuật:\n \n- Chất liệu và màu sắc cao cấp\n- Kiểu dáng sang trọng\n- Thiết kế chắc chắn\n- Có chân đứng và ngang\n- Xoay 360 độ / quay 180 độ\n- Thiết kế nhỏ gọn và mỏng\n- Kích thước: 4,3 x 3,5 x 0,2 cm
47	3	024.jpg	Khung Dán TV	t	f	Làm bằn thép không gỉ.\nCứng cáp, chắc chắn
48	3	038.jpg	Cây Đèn	t	f	Thời trang.\nThanh lịch.\nThiết kế đơn giản
45	2	019.jpg	Giày thể thao EVE	t	f	Giày thể thao EVE với họa tiết Mandala đầy phong cách sẽ giúp bạn bước đi đầy tự tin. Đấu giá ngay!\n\nĐặc điểm sản phẩm:\n\n- Một sản phẩm với thiết kế đầy phong cách đến từ thương hiệu EVE\n- Được làm từ chất liệu cao cấp, nhẹ và bền chắc\n- Sản phẩm giày thể thao của chúng tôi phù hợp với mọi phong cách và cho bạn một vẻ ngoài đầy sành điệu\n- Kích cỡ: 36-41 (EU)
49	3	030.jpg	Bộ xẻng bếp	t	f	Bộ đồ dùng đa năng.\nĐủ mọi kích cỡ.
50	1	033.jpg	Tivi 32inch	t	f	Thiết kế sang rọng.\nMàn hình lớn, tràn viền.\nChăc chắn.
51	1	036.jpg	Máy chụp hình	t	f	Máy chụp hình chất lượng cao\nLấy nét nhanh.\nChống rung quang học
52	1	037.jpg	Đế sạc không dây	t	f	Đé sạc hỗ trợ sạc nhanh.\nDùng cho các điên thoại android.
53	2	029.jpg	Túi đeo vai nữ	t	f	Hãy để túi đeo vai nữ EVE làm bạn xinh đẹp hàng ngày! Đấu giá ngay!\n\nThông số kỹ thuật:\n\n- Thiết kế phong cách cho túi đeo vai, lý tưởng cho điện thoại, ví, mỹ phẩm và thiết bị điện tử cỡ nhỏ\n- Xuất xứ từ da PU chất lượng\n- Điều chỉnh dây đeo\n- 1 ngăn với khóa kéo dài\n- Chiều dài dây: 60 cm.\n- Túi Kích thước: 31 x 22 x 8 cm.\n- Màu: đen/ đỏ rượu vang
54	3	042.jpg	Đèn ngủ 3D	t	f	Thiết kế lạ mắt.\nDẫn đầu xu hướng
55	1	043.jpg	Cổng chuyển đầu usb	t	f	Dễ dàng tháo lắp.\nSử dụng đơn giản
56	1	045.jpg	Loa Bluetooth để bàn	t	f	Nhỏ gọn.\nBán kính sử dụng 20m.\n
46	2	052.jpg	Đồng hồ thời trang	t	f	Sản phẩm Đồng hồ đeo tay Nữ NEAT phù hợp với mọi cá tính, nổi bật với thiết kế mặt số tròn cổ điển với nét đơn giản, tinh tế có thể hợp với hầu hết mọi nơi, mọi lúc. Đấu giá ngay!
57	1	047.jpg	LCD writing tablet	t	f	Thiết kế đẹp mắt.\nDành cho các bạn trẻ thời thượng
58	1	046.jpg	 Bộ Lend chụp hình	t	f	Nhiều kích cỡ lựa chọn.\nKhẩu độ lấy nét chuẩn\n
59	3	058.jpg	Kệ để giày dép	t	f	Chiều cao 1m5.\nĐể được khoảng 20 đôi giày dép.\nChất liêu inox.
60	2	049.jpg	Túi xách dải thô	t	f	Túi xách cho các bạn nữ.\nChắc chắn.\nCó thể chịu trọng lượng lên đến 5kg.
61	3	040.jpg	Máy xay rau củ bằng tay	t	f	Có thể xay mọi loại rau quả.\nTiện dụng.\nKhông tốn điện.
62	3	055.jpg	Máy mày dao, kéo	t	f	Máy mày nhỏ gọn\nTiện dụng\nBền đẹp, chất lượng cao
63	2	054.jpg	Túi du lịch NEAT	t	f	Đi du lịch theo phong cách với Túi du lịch dành cho nam giới này từ NEAT. Với dung lượng lưu trữ cao và thiết kế thông minh đơn giản, túi này chắc chắn sẽ là chuyến đi của bạn trong bất kỳ chuyến đi nào!\n\nTúi du lịch NEAT dành cho nam giới: Màu xanh đậm\n\nThông số kỹ thuật:\n\n- Du lịch túi lớn (Duffle Bag thiết kế) lý tưởng cho du lịch, thể thao, và\n- Đi kèm với dây đeo và tay cầm có thể tháo rời\n- Xuất xứ từ da PU chất lượng cao, bền và bền\n- 1 ngăn kéo dây kéo có công suất lớn với ngăn kéo nhỏ hơn\n- Thiết kế thông minh đơn giản\n- Chiều dài dây: 85 cm.\n- Kích thước túi: 30 x 60 x 24 cm.
64	3	41-687-1_250.jpg	Máy nước uống đứng	t	f	Máy nước uống đứng có chế độ nóng và lạnh cùng thiết kế đơn giản và hợp lý có thể phù hợp với bất cứ ngôi nhà nào! Đấu giá ngay!\n\nThông số kỹ thuật:\n\n- Chống điện giật hiệu quả và van nước nóng an toàn với trẻ em.\n- Cooler có hệ thống bảo vệ nước tràn không thường xuyên và chỉ thị LED.\n- Nhiệt độ nước lạnh dưới 15 ° C và nhiệt độ nước nóng là 85 ° C đến 95 ° C\n- Linh hoạt, đủ để chứa 18 lít nước một lần.\n- Điện áp: 75W\n- Công suất làm mát 0.5L / hr\n- Kích thước: 27 x 23 x 76 cm.\n- Không bao gồm chai
65	3	41-137-Main1_250.jpg	Máy hút bụi xe hơi	t	f	Máy hút bụi xe hơi giúp xóa tan nỗi lo về những hạt bụi khó chịu, chiếc xe của bạn sẽ sạch bong như mới. Đấu giá ngay!\n\nVới hiệu năng cao, sản phẩm Máy hút bụi xe hơi cho phép bạn làm sạch những ngóc ngách nhỏ nhất trên xe. Sản phẩm sở hữu ống dẫn linh hoạt, vỏ nhựa ABS bền chắc, dây nguồn dài. Hoạt động bằng nguồn điện 12V và có kích thước nhỏ gọn.\n\nThông số kỹ thuật:\n\n- Hộp chứa bụi bằng nhựa ABS bền chắc\n- Kèm phụ kiện dễ sử dụng\n- Dây điện dài.\n- Có thể tiếp cận mọi ngóc ngách.\n- Nguồn điện 12V.
66	3	059.jpg	Màn chống muỗi	t	f	Bảo vệ bé yêu của bạn khỏi muỗi và côn trùng, thiết kế tiện dụng kèm nhạc sẽ giúp bé vui và thoải mái! Đấu giá ngay!\n\n\nThông số kỹ thuật:\n\n- Bảo vệ muỗi và côn trùng.\n- Chất lượng tốt Polyester, độ bền và thông gió rất tốt.\n- Rất dễ sử dụng và làm sạch.\n- Đi kèm với âm nhạc, có thể giúp trẻ em ngủ ngon.\n- Kích thước: 63 x 109 x 42 cm.
67	1	45-918-Main4_250.jpg	Máy chụp ảnh dưới nước	t	f	Tạo dáng và nắm bắt những khoảnh khắc khó quên cùng Máy chụp ảnh dưới nước, một sản phẩm chuyên dùng cho film 35 mm và được bảo quản trong hộp đựng chống nước bền chắc. Đấu giá ngay!\n\nĐặc điểm sản phẩm:\n\n- Máy chụp ảnh phim được bảo quản trong hộp chống nước có thể tách rời\n- Ống kính: 28 mm f/9.0 \n- Lấy nét cố định\n- Cơ chế nạp phim nhanh chóng, dễ dàng\n- Có kèm dây đeo cổ tay\n- Chỉ sử dụng với film 35 mm\n- Không bao gồm phim\n- Kích thước máy ảnh: 6.5 x 10 x 3 cm\n- Kích thước hộp: 8 x 12 x 4 cm
68	3	55-034-001_250.jpg	Bóng đèn Stick Up	t	f	Đó là tất cả những gì bạn phải làm để thắp sáng tủ quần áo, cầu thang, phòng đựng thức ăn, đồ thể thao hay bất cứ nơi đâu cần ánh sáng. Sản phẩm cầm tay, chỉ cần trượt bóng đèn ra khỏi đế và sử dụng. Sản phẩm tuyệt vời bất cứ khi nào bạn cần ánh sáng. Đừng bỏ lỡ và trả giá ngay!\n\nBóng đèn Stick Up này là một bóng đèn không dây tuyệt vời bạn cài đặt bất cứ nơi nào, không đòi hỏi dây hay điện để lắp đặt và cung cấp ánh sáng bất cứ khi nào bạn cần. Chỉ cần mở vỏ ra và gắn đế sau đó bạn có thể sử dụng sản phẩm cách mạng này.\n\nThông số kỹ thuật:\n\n- Đèn Stick Up là bóng đèn hoạt động bằng pin, bạn có thể cài đặt mà không cần điện.\n- Đơn giản chỉ cần gắn vào bất cứ nơi nào bạn cần ánh sáng, trượt trong bóng đèn, kéo dây và đó là nó!\n- Không dây và không thuê thợ điện.\n- Các bóng đèn được làm mát để dễ dàng sử dụng và không thấm nước, do đó, nó an toàn cho trẻ em và vật nuôi.
69	1	40-521_250.jpg	Đế giữ điện thoại đa năng	t	f	Đễ giữ điện thoại đa năng có thể đem theo và dùng với bất kì bàn, giường, ghế, ô tô và nhiều nơi khác. Đấu giá ngay!\n\n- Cắm điện thoại vào đế giữ này sẽ giúp bạn không cần phải sử dụng tay. Được thiết kế tiện dụng, sản phẩm này có thể gập và xoay với nhiều góc độ.\n-Nấc giữ có thể thay đổi với kích thước của điện thoại (rộng tới 97mm và dài 70cm)
70	1	46-269-main_250.jpg	Tai nghe phiên dịch PEIKO	t	f	- Tai nghe phiên dịch tiện lợi cho việc tìm phương hướng khi ở nước ngoài\n- Sử dụng được với nhiều mục đích\n- Hỗ trợ 23 ngôn ngữ\n- Không dây\n- Khoảng cách giao tiếp : 10m\n- Thời gian nói : 405 giờ\n- Pin : Polymer\n- Pin : 90mAh\n- Sạc : 2 giờ\n- Trọng lượng : 8.6g\n- Kích thước : 6.1 x 1.8 . 0.8 cm
71	2	45-476-0001_250.jpg	Giày búp bê in hoa EVE	t	f	Hãy điểm xuyết thêm cho bộ trang phục của bạn bằng đôi giày búp bê in hoa EVE, nữ tính mà vẫn mang lại hiệu quả tối đa. Được gia công từ chất liệu chất lượng cao, nhẹ nhàng và vô cùng thoáng khí. Đấu giá ngay!\n\nGiày búp bê in hoa EVE\nĐặc điểm sản phẩm:\n\n- Hãy để mỗi ngày của bạn là một sự khác biệt với đôi giày được thổi ý tưởng từ hoa lá\n- Được gia công từ chất liệu cao cấp, nhẹ và dễ di chuyển\n- Thoáng khí, đem lại sự thoải mái cho đôi chân\n- Kích cỡ: 36-41
72	2	73-300-Main1_250.jpg	Xăng-đan nữ đế bệt: Đen	t	f	Với thiết kế quai kẹp năng động cùng gam màu đen sang trọng dễ dàng phối với nhiều trang phục khác nhau, góp phần tăng thêm phong cách thời trang trẻ trung, mang tính ứng dụng cao cho phái đẹp.\n\nĐặc điểm sản phẩm:\n\n- Chất liệu: Da PU, đế cao su tổng hợp, có rãnh chống trượt\n- Quai hậu có thể co giãn để vừa vặn với phần cổ chân\n- Kiểu dáng sandals dây chéo trẻ trung, năng động, mang lại cho bạn gái nét nữ tính mà vẫn không kém phần khỏe khoắn\n- Thiết kế quai kẹp xỏ ngón tiện lợi\n- Dễ dàng phối với nhiều kiểu trang phục, phù hợp với hầu hết mọi phong cách\n- Đế cao khoảng 1.5 cm\n- Phù hợp cho các nàng đi học, đi làm và cả đi dạo phố.\n- Kích cỡ: 35-39
73	2	60-143-001_250.jpg	Hộp đựng kính mát	t	f	Thời trang\nSang trọng\nKiểu dáng đẹp
74	1	42-378-12_250.jpg	Máy tính điện tử	t	f	Máy tính 12 chữ số cho kết quả chính xác và tốc độ! Đấu giá ngay!\n\nThông số kỹ thuật:\n\n- Số: 12 chữ số\n- Chất liệu: Nhựa\n- Cho kết quả nhanh và chính xác\n- Tắt nguồn tự động.\n- Dùng để tính toán, thích hợp cho các công việc liên quan đến tài chính, kế toán...\n- Kích thước: 120 x 150 x 35 mm
75	3	50-049_01_250.jpg	Bộ ống và vòi phun	t	f	Bộ ống và vòi phun có thể dễ dàng nối với nguồn nước để bạn có thể rửa xe, tưới cây và hơn thế nữa, đấu giá ngay!\n\nMàu: Xanh lá xây\nĐộ dài: 10m
76	1	41-243-Main1_250.jpg	Bộ sạc đôi cho xe hơi	t	f	Bộ sạc USB tiện dụng, gọn gàng, dễ dàng lắp vào bảng điều khiển xe ô-tô. Sản phẩm cho phép bạn sạc 2 thiết bị USB cùng lúc. Một sản phẩm rất hữu ích và thiết thực, chuyên dùng để sạc các thiết bị điện tử. Hãy đấu giá ngay!\n\nThông số kỹ thuật:\n\n- Bộ sạc cho các thiết bị điện tử trong xe\n- Hỗ trợ: iPad, iPhone và iPod\n- Đi kèm với 2 cổng USB\n- Cổng vào: 12-24VDC\n- Cổng ra: 5V\n- Kích thước: 6 x 3 cm.
77	1	41-622-main_250.jpg	Sạc để bàn cho Androi	t	f	Ngoài tính năng sạc, sản phẩm còn giúp bạn truyền nhạc hoặc dữ liệu! Còn chờ gì nữa, đấu giá ngay!\n\nSạc để bàn cho Androi\nThông số kỹ thuật:\n\n- Bộ sạc cho máy tính để bàn dock station Thiết bị sạc pin di động USB cho thiết bị Android\n- Thiết bị di động và có kiểu dáng đẹp\n- 8 pin dữ liệu đồng bộ cáp cradle ga dock sạc\n-Cho phép bạn tính phí điện thoại và đồng bộ hóa dữ liệu cùng một lúc\n- Đầu ra: 12V\n- Các thông số đầu vào: 24V\n- Sạc hiện tại: 1000 (mA),\n- Kích thước: 7,3 x 4 x 5.4 cm.
78	1	40-195-Main1_250.jpg	Quạt máy tính	t	f	Quạt máy tính di động hiệu quả cho những ngày trời nóng. Chỉ cần kết nối với một cổng USB, không gian quanh bạn sẽ dịu mát ngay!\n\nĐặc điểm sản phẩm:\n\nSản phẩm quạt máy tính di động có thể gắn vào máy tính để bàn hoặc cổng USB của máy tính xách tay.\n\n- Kích thước: 149.73 x 96.3 x 146.5 mm.\n- Màu sắc: Màu đen / xanh / hồng / đỏ / xanh nhạt
79	2	73-327-Main4_250.jpg	Chì kẻ chân mày SILKY GIRL: Đen nhạt	t	f	Chì kẻ chân mày SILKY GIRL với dạng chì chuốt truyền thống, được gia công từ chất liệu tự nhiên, cao cấp chắc chắn sẽ mang lại cho bạn một đôi chân mày thật tự nhiên và đều đặn, tinh tế và hoàn hảo.\n\nĐặc điểm sản phẩm:\n\n- Thành phần lành tính, không gây kích ứng, phù hợp với mọi loại da.\n- Chất chì mềm mại dễ sử dụng cùng với độ bám dính cao, không lem, tạo vẻ đẹp tự nhiên\n- Thiết kế dạng bút thon dài, nhỏ gọn, cầm chắc tay, giúp bạn tạo ra những đường kẻ thật chính xác\n- Không chứa Paraben\n- HSD: 01.2020\n- Xuất xứ Cộng Hòa Séc
80	2	15-168_250.jpg	Lược chải tóc	t	f	Hãy sáng tạo nên những kiểu tóc của riêng bạn với Lược chải tóc của chúng tôi, một sản phẩm tích hợp đầy đủ các chức năng mà bạn muốn. Đừng bỏ lỡ, đấu giá ngay!\n\n\nLà sản phẩm có công dụng tạo kiểu tóc thẳng, Lược chải tóc của chúng tôi cực kỳ dễ sử dụng và bền chắc.\n\n- Chiều dài: 22 cm.
81	3	43-216_0111_01_250.jpg	Dụng cụ dọn rác cầm tay	t	f	Dụng cụ dọn rác cầm tay có chức năng gắp rác trên sàn một cách dễ dàng. Sản phẩm còn có thể gấp lại để thuận tiện hơn trong quá trình sử dụng. Còn gì tuyệt vời hơn khi sắm cho mình một chiếc để vệ sinh nhà cửa? Đấu giá ngay!\n\nĐặc điểm sản phẩm:\n- Bóp chặt tay cầm để gắp rác trên sàn, sạch sẽ và tiện lợi\n- Thiết kế đẹp, an toàn, bền chắc, dễ dàng mang đi\n- Có thể treo trên tường, cực kỳ thuận tiện\n- Thích hợp trong môi trường nhà máy, nhà ở, bệnh viện, chợ, xe lửa, đài phun nước, vườn, công viên, danh lam thắng cảnh ...\n- Vật liệu: hợp kim nhôm và nhựa\n- Kích thước: (Gấp) 14 x 43 x 5 cm. / (Mở) 12 x 80 x 6 cm.
82	1	40-420-100_250.jpg	Quạt USB Slim: Trắng	t	f	Quạt Mini mới USB Powered với 2 loại Cài đặt Tốc độ, Luồng không khí nhẹ và Thiết kế nhỏ gọn. Trả giá ngay bây giờ!
83	3	43-098-12_250.jpg	Giá để giày treo tường	t	f	Tiết kiệm diện tích một cách tối đa với giá để giày treo tường! Đấu giá ngay!\n\n\nThông số kỹ thuật:\n \n- Dễ dàng sử dụng, chỉ cần dán vào tường\n- Kích thước: 25.5 x 6.5 x 7 cm.
84	2	70-730-2_250.jpg	Đai tập đi cho bé	t	f	Đai tập đi cho bé giúp cho cả cha mẹ và bé yêu có thời gian an toàn và thoải mái khi dạy cho bé tập đi. Đấu giá ngay!\n\nGiúp bé yêu của bạn học cách đi bộ, dạy cho trẻ cân bằng và đứng vững trên đôi chân của chúng và cũng giúp cho bé có thể gần bạn và vui vẻ khi đi ra ngoài\n\nĐai tập đi làm cho việc đi bộ dễ dàng hơn, không khiến cha mẹ phải cúi xuống trong khi dạy cho bé đi bộ. Giúp trẻ đi bộ một cách an toàn với sự trợ giúp của người lớn. Giúp cho trẻ đi bộ và cân bằng thoải mái. Được thiết kế để giúp trẻ đi bộ thoải mái và an toàn.\n\nThích hợp cho trẻ em từ 6 tháng đến 14 tháng. Lưu trữ ngoài tầm với của trẻ em. Luôn luôn sử dụng với sự giám sát của người lớn. Không để trẻ em một mình khi sử dụng mặt hàng này.\n\nThông số kỹ thuật:\n\n- Đi bộ an toàn & thoải mái với sự trợ giúp của người lớn\n- Trẻ học cách đi bộ với niềm vui và sự tự tin\n- Kích thước: 62 cm x 22 cm.\n- Trọng lượng tối đa: 35 kg.
85	2	73-293-001_250.jpg	Quần shorts nữ lưng cao	t	f	- Chất liệu: vải cao cấp, co giãn cực tốt, có độ mềm mại và thông thoáng tối ưu.\n- Đặc biệt, vải không bị biến dạng, dão chảy sau khi giặt.\n- Thiết kế thời trang, form quần tôn dáng người mặc\n- Kèm theo một dây lưng điểm tô nét nữ tính cho phái đẹp\n- Sắc trắng trung tính cùng sọc đen, dễ dàng phối đồ cùng áo thun, sơ mi..., thích hợp để mặc dạo phố, đi tiệc hay gặp gỡ bạn bè...\n- Thiết kế khóa kéo tiện lợi\n- Gồm 3 size: S/M/L\n- Kích cỡ size (cm)\n+ S: Rộng: 29 Dài: 40 \n+ M: Rộng: 30 Dài: 42\n+ L: Rộng: 32 Dài: 44\n- Xuất xứ Việt Nam
86	2	55-007-12_250.jpg	Quần Jeans	t	f	- Chất liệu: 95% Polyester / 5% Spandex\n- Giống như quần jeans nhưng cảm giác như xà cạp mềm,\n- Công nghệ Flex Slim cho một hình ảnh sexy,\n- Không có nút khó chịu, khóa kéo hoặc đinh tán.\n- Máy giặt được (30 °)\n- Kích thước: Free size
87	3	43-108-1_250.jpg	Giường sofa hơi	t	f	- Giường Sofa hơi là đồ nội thất đa chức năng mới nhất mà bạn phải có.\n- Chất lượng tốt và thoải mái cho 3 người, ngay lập tức chuyển đổi thành giường nếu bạn muốn.\n- Đơn giản chỉ cần gỡ ra khỏi hộp, thêm gối và chăn ga, bạn có thể thư giãn thoải mái! có thể để và sử dụng bất cứ nơi nào trong nhà!\n- Ghế sofa tiện nghi, thoải mái, ghế sofa và giường gấp, tất cả trong một.\n- Bơm đầy trong vòng chưa đầy 3 phút Air Lounge sẽ phóng to vào một chiếc ghế sofa có kích thước vừa đủ phù hợp với bất kỳ phòng nào trong nhà bạn. (* Máy bơm không khí có điện không bao gồm trong hộp *)\n- Khởi động và ngay lập tức, nó chuyển thành một chiếc nệm không khí / giường ngủ thoải mái.\n- Công nghệ Air Suspension Air Technology hỗ trợ cơ thể của bạn thoải mái.\n- Hoàn hảo thuận tiện, nhanh chóng và dễ dàng lắp chỉ cần bơm nó lên!\n- Khi bạn không sử dụng, bạn có thể dễ dàng cất giữ.\n- Nó đủ nhẹ để được vận chuyển đến bất kỳ phần nào của ngôi nhà hoặc nó có thể được gấp lại để vào thành túi đựng bao gồm có nghĩa là bạn có thể thực sự mang nó bất cứ nơi đâu bạn đi!\n- Có thể dễ dàng trở thành một chiếc giường thoải mái hay ghế tựa. Chỉ cần lật mở giường từ bên dưới ghế sofa, và bạn đã có một nơi tốt để ngủ!\n- Kích thước nới rộng: 160 x 60 x 160 cm.
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
2	delta thoi gian sap ket thuc	20
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

SELECT pg_catalog.setval('public.phiendaugia_maphiendg_seq', 77, true);


--
-- Name: phieudaugia_maphieudg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phieudaugia_maphieudg_seq', 24, true);


--
-- Name: sanpham_masp_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sanpham_masp_seq', 87, true);


--
-- Name: taikhoan_matk_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taikhoan_matk_seq', 4, true);


--
-- Name: thamso_mathamso_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.thamso_mathamso_seq', 2, true);


--
-- Name: tinhtrangphiendg_matinhtrangphiendg_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tinhtrangphiendg_matinhtrangphiendg_seq', 5, true);


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

