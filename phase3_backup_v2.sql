--
-- PostgreSQL database dump
--

\restrict nklNQwJd5ZW9yld3xdCXlCBJUhWPyHEB9JGOtQGhzTlB2hwlGfHBsuMrjAVaJMV

-- Dumped from database version 17.10
-- Dumped by pg_dump version 17.10

-- Started on 2026-06-15 19:17:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16437)
-- Name: spots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spots (
    spot_id integer NOT NULL,
    spot_name character varying(255) NOT NULL,
    spot_description text,
    is_restaurant boolean DEFAULT false,
    spot_rating numeric(2,1),
    location_x numeric(10,7),
    location_y numeric(10,7),
    meal_type character varying(25),
    CONSTRAINT spots_spot_rating_check CHECK (((spot_rating >= (0)::numeric) AND (spot_rating <= (5)::numeric)))
);


ALTER TABLE public.spots OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16436)
-- Name: spots_spot_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spots_spot_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.spots_spot_id_seq OWNER TO postgres;

--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 217
-- Name: spots_spot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spots_spot_id_seq OWNED BY public.spots.spot_id;


--
-- TOC entry 4742 (class 2604 OID 16440)
-- Name: spots spot_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spots ALTER COLUMN spot_id SET DEFAULT nextval('public.spots_spot_id_seq'::regclass);


--
-- TOC entry 4893 (class 0 OID 16437)
-- Dependencies: 218
-- Data for Name: spots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spots (spot_id, spot_name, spot_description, is_restaurant, spot_rating, location_x, location_y, meal_type) FROM stdin;
1	Setia Alam Central Park	Setia Alam Central Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.4567115	3.0993775	\N
2	Taman Haiwan @TBNSA	Taman Haiwan @TBNSA is a recognized zoo located in Selangor, Malaysia, attracting many visitors.	f	4.0	101.5139530	3.1002360	\N
3	Bulatan Penchala	Bulatan Penchala is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6407567	3.0953881	\N
4	Gem Restaurant PJ	Gem Restaurant PJ is a popular dining spot in Selangor, well-known for its excellent north indian restaurant.	t	4.3	101.6513484	3.0946519	lunch,dinner
5	River walk Desaria	River walk Desaria is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	3.0	101.6217719	3.0769599	\N
6	Botanic Garden Canal	Botanic Garden Canal is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.4359069	2.9880156	\N
7	Taman Rekreasi Paya Bakau Kampung Sijangkang	Taman Rekreasi Paya Bakau Kampung Sijangkang is a recognized sports activity location located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.4232462	2.9399497	\N
8	Taman Bandar Bukit Raja	Taman Bandar Bukit Raja is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.4336525	3.0898765	\N
9	Woodfire Cyberjaya	Woodfire Cyberjaya is a popular dining spot in Selangor, well-known for its excellent hamburger restaurant.	t	4.6	101.6568452	2.9239047	lunch,dinner
10	Kak Long Cafe	Kak Long Cafe is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.7075443	2.8251488	\N
11	Selera 7	Selera 7 is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.2	101.4971044	2.8035098	breakfast,lunch
12	Bukit Lagong Trail Head	Bukit Lagong Trail Head is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.6390149	3.2575952	\N
13	FRIM-MNS	FRIM-MNS is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.6263220	3.2326980	\N
14	PJ Animales - Sri Gombak Fark Runsite	PJ Animales - Sri Gombak Fark Runsite is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	0.0	101.7019249	3.2453555	\N
15	Daddy’s Cafe Pangkor Island	Daddy’s Cafe Pangkor Island is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	100.5455922	4.2364234	breakfast,lunch,dinner
16	Selangor Golden Triangle	Selangor Golden Triangle is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.5	101.4824825	3.0648950	\N
17	巴生仙境山庄 ~ 仙境古城 Fairy Park Heritage City - Albert Tew	Fairy Park Heritage City - Albert Tew is a recognized cemetery located in Selangor, Malaysia, attracting many visitors.	f	5.0	101.4630014	3.1432839	\N
18	Kuala Renggam	Kuala Renggam is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5103087	3.0441755	\N
19	IOI Mall Damansara	IOI Mall Damansara is a bustling shopping mall, perfect for shopping, dining, and local experiences.	f	4.2	101.5931032	3.1491940	\N
20	KL Bird Park	Thousands of colourful birds in free-roaming areas, walk-through aviaries & traditional enclosures.	f	4.4	101.6884845	3.1431640	\N
21	Kebaabish Restaurant - Subang Jaya	Kebaabish Restaurant - Subang Jaya is a popular dining spot in Selangor, well-known for its excellent pakistani restaurant.	t	4.5	101.5867604	3.0461094	lunch,dinner
22	Laguna Park	Laguna Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.3568074	2.9473022	\N
23	Saudagar Nanas Agrofarm	Saudagar Nanas Agrofarm is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.7445277	2.9357349	breakfast,lunch
24	Monkeys Splash Zone	Monkeys Splash Zone is a beautiful water park, offering a relaxing outdoor and nature experience for visitors.	f	3.5	101.8487353	3.0480260	\N
25	Aldar Lounge	Aldar Lounge is a popular dining spot in Selangor, well-known for its excellent middle eastern restaurant.	t	4.8	101.6372892	2.9232702	lunch,dinner
26	The Botanist	The Botanist is a popular dining spot in Selangor, well-known for its excellent cafe.	t	4.4	101.6364782	2.9204675	breakfast,lunch
27	Samurai Yakiniku Kota Warisan	Samurai Yakiniku Kota Warisan is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.6951235	2.8069006	lunch,dinner
28	Lakeside Thai Pot	Lakeside Thai Pot is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.7054002	2.8400325	lunch,dinner
29	Restoran Ummi Aishah	Restoran Ummi Aishah is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.6945809	2.8194416	breakfast,lunch
30	LakeSide@SIC	LakeSide@SIC is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.7	101.7312403	2.7569766	breakfast,lunch,dinner
31	Hussin Fauzi Farm	Hussin Fauzi Farm is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.2737714	3.3598550	\N
32	Warung Soto Pasir Penambang	Warung Soto Pasir Penambang is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.2411071	3.3714767	lunch,dinner
33	D'Kuala Restaurant	D'Kuala Restaurant is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.1	101.2547700	3.3506600	lunch,dinner
34	Emerald Hiking Spot	Emerald Hiking Spot is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.1	101.5435152	3.3289105	\N
35	Villa Takun , Templer Park - Tropical Forest Retreat & Glamping	Villa Takun , Templer Park - Tropical Forest Retreat & Glamping is a recognized private guest room located in Selangor, Malaysia, attracting many visitors.	f	4.6	101.6394320	3.2997921	\N
36	Restoran Sambal	Restoran Sambal is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.5	101.5786008	3.3141819	\N
37	Eden Dim Sum Restaurant Rawang	Eden Dim Sum Restaurant Rawang is a popular dining spot in Selangor, well-known for its excellent dim sum restaurant.	t	4.5	101.5373880	3.3184524	breakfast,lunch
38	Uncle Mano Banana Leaf Restaurant	Uncle Mano Banana Leaf Restaurant is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	3.8	101.5958880	3.3032639	breakfast,lunch,dinner
39	Lorong Muhammad	Lorong Muhammad is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	5.0	101.4373999	2.7908845	\N
40	Amverton Riverine Splash	Amverton Riverine Splash is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.4119794	2.8447669	\N
41	Ohsem Delight	Ohsem Delight is a popular dining spot in Selangor, well-known for its excellent family restaurant.	t	4.8	101.5084825	2.8133581	lunch,dinner
42	Forest Skywalk Kepong	Forest Skywalk Kepong is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.6185882	3.2268340	\N
43	Forest Skywalk - FRIM	Forest Skywalk - FRIM is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.6191147	3.2275783	\N
44	Warung Puteri Taman Sri Gombak	Warung Puteri Taman Sri Gombak is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.7055444	3.2428286	breakfast,lunch
45	Pak Tam Sri Corner	Pak Tam Sri Corner is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.6895123	3.2330343	lunch,dinner
46	Kantin@SetorGombak	Kantin@SetorGombak is a popular dining spot in Selangor, well-known for its excellent food court.	t	4.2	101.7052513	3.2088435	dinner
47	Restoran Nasi Vanggey Sri Gombak	Restoran Nasi Vanggey Sri Gombak is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	3.9	101.6998781	3.2385284	lunch,dinner
48	Pan Heong Restaurant ? Batu Caves	Pan Heong Restaurant ? Batu Caves is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.0	101.6737340	3.2335220	breakfast,lunch
49	Restoran Sajian Teringin	Restoran Sajian Teringin is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.6989642	3.2372258	breakfast,lunch,dinner
50	The Nyaman Place Glamping	The Nyaman Place Glamping is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	2.0	101.8251179	3.1470200	\N
51	Lata Beringin	Lata Beringin is a recognized sports activity location located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.8254012	3.1742198	\N
52	Rinching ATV Adventure Park	Rinching ATV Adventure Park is a beautiful adventure sports center, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.8660960	3.0129241	\N
53	LiLLA Rainforest Retreat @ Hulu Langat, Selangor	LiLLA Rainforest Retreat @ Hulu Langat, Selangor is a recognized resort hotel located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.8390855	3.2035972	\N
54	Tepian Rimba Villa (garden wedding & event space)	Tepian Rimba Villa (garden wedding & event space) is a recognized event venue located in Selangor, Malaysia, attracting many visitors.	f	4.6	101.7867051	3.0951680	\N
55	Daging Salai House Hulu Langat	Daging Salai House Hulu Langat is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.8078966	3.1055789	breakfast,lunch
56	Langek Cafe - Steak, Coffee & Western Hulu Langat	Langek Cafe - Steak, Coffee & Western Hulu Langat is a recognized coffee shop located in Selangor, Malaysia, attracting many visitors.	t	4.8	101.8026363	3.1008224	breakfast,lunch
57	Lata Medang	Lata Medang is a beautiful nature preserve, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.7559781	3.5402370	\N
58	NK NASI KERABU KAMBING BAKAR	NK NASI KERABU KAMBING BAKAR is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.5	100.9686232	3.7625028	breakfast,lunch
59	Faridah Mentarang Bakar Sekinchan	Faridah Mentarang Bakar Sekinchan is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.2	101.0859132	3.5343027	lunch,dinner
60	Suang Le Restaurant	Suang Le Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.7	101.1708214	3.3998319	lunch,dinner
61	Restoran Ruza	Restoran Ruza is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.2	100.9829284	3.7650119	breakfast,lunch,dinner
62	Ukiran, Alam Impian	Ukiran, Alam Impian is a prominent castle and a must-visit cultural landmark in Selangor.	f	4.8	101.5194023	3.0211468	\N
63	Dapor Che Lah	Dapor Che Lah is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.4	101.5443666	3.0908062	breakfast,lunch,dinner
64	Tanah Aina Cafe	Tanah Aina Cafe is a popular dining spot in Selangor, well-known for its excellent cafe.	t	4.2	101.5589097	3.0770527	breakfast,lunch,dinner
65	joy raj	joy raj is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6135734	3.0895169	\N
66	The Paddock PJ	The Paddock PJ is a popular dining spot in Selangor, well-known for its excellent food court.	t	4.1	101.6085928	3.0902858	lunch,dinner
67	Authentic Chan Meng Kee	Authentic Chan Meng Kee is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.0	101.6227223	3.1198161	breakfast,lunch,dinner
68	Malgudi Restaurant	Malgudi Restaurant is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.5	101.6430319	3.1192849	lunch,dinner
69	Our Small Kingdom (OSK)	Our Small Kingdom (OSK) is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.5908420	3.0646355	\N
70	Game On Sport Hub (Subang Parade)	Game On Sport Hub (Subang Parade) is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.9	101.5851028	3.0814893	\N
71	The Bear Hug Restaurant & Cafe, Subang Jaya	The Bear Hug Restaurant & Cafe, Subang Jaya is a popular dining spot in Selangor, well-known for its excellent cafe.	t	4.8	101.5801667	3.0475723	breakfast,lunch,dinner
72	Mad Bebek SS15	Mad Bebek SS15 is a popular dining spot in Selangor, well-known for its excellent indonesian restaurant.	t	4.8	101.5888604	3.0763986	lunch
73	Rich Kopitiam Sunway Pyramid	Rich Kopitiam Sunway Pyramid is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.6083223	3.0717727	lunch
74	Restoran Ghuhan ? Yap Kee Banana Leaf	Restoran Ghuhan ? Yap Kee Banana Leaf is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	3.9	101.4487569	3.0430630	breakfast,lunch
75	Restoran Port Village	Restoran Port Village is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	3.9	101.3758157	3.0021689	breakfast,lunch,dinner
76	Restoran Peng Heong Hakka Paikut	Restoran Peng Heong Hakka Paikut is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.1	101.4448990	3.0483894	breakfast,lunch,dinner
77	Welcome to Bandar Baru Bangi Signage	Welcome to Bandar Baru Bangi Signage is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.3	101.7520113	2.9629115	\N
78	Conquer Indoor Extreme Park	Conquer Indoor Extreme Park is a recognized indoor playground located in Selangor, Malaysia, attracting many visitors.	f	3.5	101.8499525	3.0520082	\N
820	Tin Hong Si	Tin Hong Si is a prominent place of worship and a must-visit cultural landmark in Selangor.	f	4.8	101.7867554	2.9913554	\N
79	Three Sons Park @ Sungai Long Hill	Three Sons Park @ Sungai Long Hill is a beautiful botanical garden, offering a relaxing outdoor and nature experience for visitors.	f	3.7	101.8153281	3.0555695	\N
80	House of Grill Putra Kajang	House of Grill Putra Kajang is a popular dining spot in Selangor, well-known for its excellent steak house.	t	5.0	101.7741322	2.9789186	lunch,dinner
81	House of Grill Putrajaya	House of Grill Putrajaya is a popular dining spot in Selangor, well-known for its excellent steak house.	t	4.9	101.7246347	2.9462694	lunch,dinner
82	Bandar Puteri 12 Park	Bandar Puteri 12 Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.6303872	3.0101024	\N
83	Kinrara Residence Du 5	Kinrara Residence Du 5 is a beautiful wildlife refuge, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.5943066	3.0147894	\N
84	Teddyman Gallery	Teddyman Gallery is a recognized museum located in Selangor, Malaysia, attracting many visitors.	f	5.0	101.6451120	3.0476660	\N
85	Bayou Cafe ? SetiaWalk	Bayou Cafe ? SetiaWalk is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.7	101.6161061	3.0302651	breakfast,lunch,dinner
86	Nam Heong Ipoh @Puchong Jaya	Nam Heong Ipoh @Puchong Jaya is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.6220053	3.0404298	breakfast,lunch
87	Lookout Tower	Lookout Tower is a recognized observation deck located in Selangor, Malaysia, attracting many visitors.	f	4.0	101.6404844	2.9367370	\N
88	Perbadanan Putrajaya (PPj) Giant Vase	Perbadanan Putrajaya (PPj) Giant Vase is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.6832554	2.9231304	\N
89	0 km Putrajaya Cycling Route	0 km Putrajaya Cycling Route is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.6	101.6779052	2.9124815	\N
90	The Bund at Setia Eco Glades	The Bund at Setia Eco Glades is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	5.0	101.6372033	2.9395060	\N
91	KAWASAN LEMBU	KAWASAN LEMBU is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.7560859	2.7455016	\N
92	Umobile tower ECAR	Umobile tower ECAR is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6649638	2.8115721	\N
93	SAUJANA KLIA	SAUJANA KLIA is a recognized association or organization located in Selangor, Malaysia, attracting many visitors.	f	5.0	101.6875854	2.8180805	\N
94	Stadium Bandar Baru Salak Tinggi	Stadium Bandar Baru Salak Tinggi is a recognized stadium located in Selangor, Malaysia, attracting many visitors.	f	4.2	101.7234676	2.8212820	\N
95	Sepang South Africa Hiking Trail	Sepang South Africa Hiking Trail is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.0	101.7300000	2.6902500	\N
96	My Nature Leisure Farm	My Nature Leisure Farm is a recognized resort hotel located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.6940752	2.6482168	\N
97	Eco Sanctuary Urban Park	Eco Sanctuary Urban Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.8	101.5461970	2.9474975	\N
98	SHAM Lake Bukit Jelutong	SHAM Lake Bukit Jelutong is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.5210586	3.1168751	\N
99	Famous Thai Restaurant - Plaza Shah Alam	Famous Thai Restaurant - Plaza Shah Alam is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	4.0	101.5233439	3.0851347	dinner
100	Secret Of Louisiana At The Lake Restaurant	Secret Of Louisiana At The Lake Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.5981454	3.0943807	dinner
101	Hot Bird Subang Jaya SS15	Hot Bird Subang Jaya SS15 is a popular dining spot in Selangor, well-known for its excellent chicken restaurant.	t	4.9	101.5892343	3.0755669	dinner
102	Good Friends Restaurant & Cafe	Good Friends Restaurant & Cafe is a popular dining spot in Selangor, well-known for its excellent asian fusion restaurant.	t	4.2	101.5897291	3.0741216	dinner
103	Restoran Kar Heong SS14 Subang	Restoran Kar Heong SS14 Subang is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.0	101.5901437	3.0727041	dinner
104	DATARAN NOSTALGIA DEPOH	DATARAN NOSTALGIA DEPOH is a recognized history museum located in Selangor, Malaysia, attracting many visitors.	f	4.9	101.3965824	2.9991361	\N
105	Kota Raja Mahadi ???? ??? ?????	Kota Raja Mahadi ???? ??? ????? is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.4448923	3.0449356	\N
106	Kampung Baru Pandamaran	Kampung Baru Pandamaran is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.3	101.4164634	3.0092043	\N
107	Sultan Suleiman Royal Mosque	Sultan Suleiman Royal Mosque is a prominent mosque and a must-visit cultural landmark in Selangor.	f	4.7	101.4504646	3.0346219	\N
108	Kee Heong Bak Kut Teh	Kee Heong Bak Kut Teh is a popular dining spot in Selangor, well-known for its excellent cantonese restaurant.	t	4.1	101.4597679	3.0569686	dinner
109	Plaza Metro Kajang	6-floor urban shopping mall offering retail outlets & a food court along with a cinema & event hall.	f	4.0	101.7892036	2.9913580	\N
110	Catholic Church of The Holy Family (1899)	Catholic Church of The Holy Family (1899) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.7	101.7905556	2.9886111	\N
111	Paya Indah Wetlands	This 450-hectare wetland sanctuary features wildlife, boating, fishing, cycling trails & more.	f	3.9	101.6287688	2.8603798	\N
112	Daiki Shokudo - 大木日食馆	Daiki Shokudo is a popular dining spot in Selangor, well-known for its excellent japanese restaurant.	t	4.5	101.7904735	2.9905625	dinner
113	Ooh Lalapot ? 啦啦煲 ? Bandar Puteri Puchong ? 啦啦屋	Ooh Lalapot is a popular dining spot in Selangor, well-known for its excellent hot pot restaurant.	t	4.8	101.6166747	3.0277747	dinner
114	Taman Tasik Cyberjaya BBQ Station	Taman Tasik Cyberjaya BBQ Station is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.7	101.6437973	2.9366317	\N
115	Arabesq Express Cyberjaya	Arabesq Express Cyberjaya is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.9	101.6365242	2.9206106	dinner
116	Mustang terbakar	Mustang terbakar is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.6943026	2.8351456	\N
117	BBST WALK	BBST WALK is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.7382412	2.8108689	\N
118	KLIA Jungle Boardwalk	KLIA Jungle Boardwalk is a prominent botanical garden and a must-visit cultural landmark in Selangor.	f	4.3	101.7136399	2.7479295	\N
119	Statue of Tan Kah Kee, XMU Founder	Statue of Tan Kah Kee, XMU Founder is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	101.7039780	2.8298135	\N
120	XMUM Furong Lake	XMUM Furong Lake is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.9	101.7048902	2.8325152	\N
121	Tasik Taman Dahlia	Tasik Taman Dahlia is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.7201659	2.8348189	\N
122	KLIA T1 Observation Deck	KLIA T1 Observation Deck is a prominent observation deck and a must-visit cultural landmark in Selangor.	f	4.5	101.7057110	2.7522362	\N
123	Sepang Bay 13 Off-Road Ranch by MSF	Sepang Bay 13 Off-Road Ranch by MSF is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.7451473	2.7584607	\N
124	PARIT D	PARIT D is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.7069750	2.7921810	\N
125	Damai D’ Dusun	Damai D’ Dusun is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.7456789	2.8416741	\N
126	Pusat Kebudayaan Kampung Orang Asli Kelingsing	Pusat Kebudayaan Kampung Orang Asli Kelingsing is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.6992274	2.8149851	\N
127	Kampung Angkat MADANI Kementerian Komunikasi	Kampung Angkat MADANI Kementerian Komunikasi is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6952896	2.8124856	\N
128	National Automobile Museum	National Automobile Museum is a prominent museum and a must-visit cultural landmark in Selangor.	f	4.2	101.7317438	2.7594142	\N
129	Red Tower Hill Country Park - XMUM	Red Tower Hill Country Park - XMUM is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.8	101.7006104	2.8327124	\N
130	Taman Rekreasi Kota Warisan	Taman Rekreasi Kota Warisan is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.6983339	2.8254753	\N
131	Lim Passion Garden, Sungai Pelek, Sepang	Lim Passion Garden, Sungai Pelek, Sepang is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.7	101.7110365	2.6470014	\N
132	Pantai Bagan Lalang Sepang	Pantai Bagan Lalang Sepang is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.6909813	2.5984905	\N
133	BALAIRAYA KAMPUNG ORANG ASLI SUNGAI MELUT	BALAIRAYA KAMPUNG ORANG ASLI SUNGAI MELUT is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6825563	2.8315075	\N
134	ADMAL Aviation College Planes	ADMAL Aviation College Planes is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.7239564	2.8062979	\N
135	0 Km Sepang	0 Km Sepang is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.7523647	2.6916937	\N
136	Tugu Peringatan Kampung Giching	Tugu Peringatan Kampung Giching is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.7	101.7371732	2.7959134	\N
137	MD SHAMIM	MD SHAMIM is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6928080	2.8523740	\N
138	0 km Kg Giching	0 km Kg Giching is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.8	101.7373235	2.7961046	\N
139	HL Dragon Fruit Eco Farm X HL Restaurant & Cafe (HALAL)	HL Dragon Fruit Eco Farm X HL Restaurant & Cafe (HALAL) is a prominent farm and a must-visit cultural landmark in Selangor.	t	4.2	101.7426632	2.6809260	dinner
140	Sri Banting Old Tin Dredge	Sri Banting Old Tin Dredge is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.6499314	2.8614972	\N
141	Rumah Warisan Embah	Rumah Warisan Embah is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6748934	2.6556556	\N
142	The Gadung Sepang	The Gadung Sepang is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	5.0	101.7380316	2.6562261	\N
143	雪邦顺天宫	A prominent place of worship and a must-visit cultural landmark in Selangor.	f	4.4	101.7488687	2.6884784	\N
144	Giverny Park Sunsuria City	Giverny Park Sunsuria City is a recognized sports activity location located in Selangor, Malaysia, attracting many visitors.	f	4.6	101.7069609	2.8394104	\N
145	Bukit 527	Bukit 527 is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.7	101.7321133	2.8385799	\N
146	蔡徐坤公园	A recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	5.0	101.7024149	2.8329781	\N
147	Serenity Park	Serenity Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.7053908	2.8462776	\N
148	Leisure Garden Sepang	Leisure Garden Sepang is a recognized zoo located in Selangor, Malaysia, attracting many visitors.	f	4.8	101.6862955	2.6652943	\N
149	Kota Seriemas Lake Park (Laman Ilmu)	Kota Seriemas Lake Park (Laman Ilmu) is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.7858787	2.7871178	\N
150	Bukit 527 trailhead	Bukit 527 trailhead is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.9	101.7318257	2.8345147	\N
151	Rimba KLIA	Rimba KLIA is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	5.0	101.7134887	2.7480049	\N
152	Giverny Walk	Giverny Walk is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.8	101.7052446	2.8389288	\N
153	Bukit Melati Nilai Negeri Sembilan	Bukit Melati Nilai Negeri Sembilan is a prominent nature preserve and a must-visit cultural landmark in Selangor.	f	4.5	101.7641996	2.8162399	\N
154	Serenia City Central Park	Serenia City Central Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.6998217	2.8439056	\N
155	Taman Rekreasi Sunsuria City	Taman Rekreasi Sunsuria City is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	3.7	101.6954984	2.8348261	\N
156	KLIA Green Park	KLIA Green Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	5.0	101.7054213	2.7617357	\N
157	The Parc, Nilai Impian	The Parc, Nilai Impian is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.8040358	2.8355287	\N
158	Mitsui Outlet Park KLIA	Mitsui Outlet Park KLIA is a bustling shopping mall, perfect for shopping, dining, and local experiences.	f	4.2	101.6772793	2.7802014	\N
159	PETRONAS Sepang International Circuit	Grand prix & superbike circuit open since 1999 with event facilities, go karting track & tours.	f	4.5	101.7369094	2.7610100	\N
160	Sambal Bakar On Fire Kota Warisan	Sambal Bakar On Fire Kota Warisan is a popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	4.8	101.6925054	2.8244185	dinner
161	Bebeks by Top Global Kota Warisan	Bebeks by Top Global Kota Warisan is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.6945814	2.8196115	dinner
162	Mohd Chan Chinese Muslim Restaurant @ Kota Warisan Sepang	Mohd Chan Chinese Muslim Restaurant @ Kota Warisan Sepang is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.9	101.6942263	2.8200897	dinner
163	Soi 55 Thai Kitchen	Soi 55 Thai Kitchen is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	4.8	101.7074519	2.8288604	dinner
164	PappaGrill Sepang	PappaGrill Sepang is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.6947479	2.8212177	dinner
165	Mengrai Thai Restaurant	Mengrai Thai Restaurant is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	4.7	101.6945359	2.8204923	dinner
166	麻辣�T惑 Spicy Temptation @ Sepang (第六分行)	A highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.9	101.7065626	2.8286976	dinner
167	Bumbu Babah @ Kota Warisan, Sepang	Bumbu Babah @ Kota Warisan, Sepang is a popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	4.3	101.6830195	2.7985305	dinner
168	El Boney Quattro Formaggi	El Boney Quattro Formaggi is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.3	101.6941757	2.8220188	dinner
169	Hilltop Cuisine Kota Warisan	Hilltop Cuisine Kota Warisan is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	3.9	101.6970294	2.8282902	dinner
170	Pak Punjab Kota Warisan	Pak Punjab Kota Warisan is a popular dining spot in Selangor, well-known for its excellent pakistani restaurant.	t	4.3	101.6927769	2.8272807	dinner
171	LèTen Chinese Muslim Restaurant @ Mitsui Outlet Park	LèTen Chinese Muslim Restaurant @ Mitsui Outlet Park is a popular dining spot in Selangor, well-known for its excellent dim sum restaurant.	t	4.8	101.6769440	2.7806395	dinner
172	Salam Noodles Warisan Megah	Salam Noodles Warisan Megah is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.6	101.7062142	2.8250684	dinner
173	Farich Food House	Farich Food House is a popular dining spot in Selangor, well-known for its excellent cafe.	t	4.0	101.7073972	2.8246600	dinner
174	Restoran DarSA Kota Warisan	Restoran DarSA Kota Warisan is a bustling store, perfect for shopping, dining, and local experiences.	f	4.4	101.6921585	2.8243890	\N
175	AL-Sultan Restaurant - Kota Warisan	AL-Sultan Restaurant - Kota Warisan is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.9	101.6945721	2.8201812	dinner
176	PPG Signature @ Sepang	PPG Signature @ Sepang is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	5.0	101.6945870	2.8215606	dinner
177	GAO! GAO! Sunsuria	GAO! GAO! Sunsuria is a popular dining spot in Selangor, well-known for its excellent pizza restaurant.	t	4.8	101.6975205	2.8400932	dinner
178	Ayam Gepuk Top Global Kota Warisan	Ayam Gepuk Top Global Kota Warisan is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.5	101.6942555	2.8198653	dinner
179	Restaurant Golden Sunrise 金日升	Restaurant Golden Sunrise is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.5	101.6982290	2.8392460	dinner
180	Kuala Selangor Fireflies	Park offering evening boat trips to marvel at large colonies of fireflies living in the mangroves.	f	4.7	101.3015682	3.3606559	\N
181	(Official Jetty) Sky Mirror Kuala Selangor	Boat tours taking in a sandbar visible at low tide, known for its reflective waters & marine life.	f	4.3	101.2507617	3.3424349	\N
182	NYC Tour Sky Mirror Kuala Selangor	NYC Tour Sky Mirror Kuala Selangor is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.2463330	3.3548410	\N
183	Jetty D’Tours Kuala Selangor Sdn Bhd	Jetty D’Tours Kuala Selangor Sdn Bhd is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.2492754	3.3512291	\N
184	Malawati Hill ????? ??????	This historic museum, a one-time sultan's palace, has tombs, cannons, ladders & treasure caves.	f	4.2	101.2463485	3.3416401	\N
185	Bukit Belimbing Fireflies Park	Bukit Belimbing Fireflies Park is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.2791790	3.3865170	\N
186	Kampung Kuantan Fireflies Park (Selangor)	Tourist park offering sampan-boat river trips to see fireflies plus food & gift kiosks & playground.	f	4.4	101.3015477	3.3606857	\N
187	Pekan Lama Kuala Selangor	Pekan Lama Kuala Selangor is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.7	101.2487578	3.3413065	\N
188	Altingsburg Lighthouse	Altingsburg Lighthouse is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.4	101.2449326	3.3412187	\N
189	1188 天空之境	A prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.2492999	3.3515129	\N
190	Perigi Beracun	Perigi Beracun is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.9	101.2457790	3.3406430	\N
191	Sky Mirror Fun Life Jetty	Sky Mirror Fun Life Jetty is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	101.2511835	3.3491039	\N
192	萤火虫	A prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.2514514	3.3490729	\N
193	Dataran Malawati ?????? ???????	Dataran Malawati ?????? ??????? is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.2505589	3.3413144	\N
194	0 km Kuala Selangor	0 km Kuala Selangor is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.2500519	3.3412490	\N
195	Sky Mirror Rainbow Jetty	Sky Mirror Rainbow Jetty is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.3029495	3.2559436	\N
196	Fishermen Village	Fishermen Village is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.2517497	3.3479104	\N
197	Gerbang Malam Kuala Selangor (OFFICIAL)	Gerbang Malam Kuala Selangor (OFFICIAL) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.2503812	3.3413475	\N
198	瓜雪彩虹河堤 Rainbow Bund	Rainbow Bund is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.4	101.2441149	3.3565776	\N
199	Old Kuala Selangor Fire Station	Old Kuala Selangor Fire Station is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.2482981	3.3432751	\N
200	Kota Tanjung Keramat ???? ????? ?????	Kota Tanjung Keramat ???? ????? ????? is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	3.6	101.2414320	3.3461430	\N
201	Batu Hampar ???? ????	Batu Hampar ???? ???? is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.2	101.2464923	3.3423791	\N
202	Stesen Keretapi Lama Kuala Selangor	Stesen Keretapi Lama Kuala Selangor is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.2515634	3.3392985	\N
203	Kuala Selangor Cenotaph War Memorial	Kuala Selangor Cenotaph War Memorial is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.0	101.2490897	3.3432293	\N
204	Makam lama kuala selangor	Makam lama kuala selangor is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	3.0	101.2520355	3.3498163	\N
205	Sri Shakti Dhevasthanam Bukit Rotan	Sri Shakti Dhevasthanam Bukit Rotan is a prominent hindu temple and a must-visit cultural landmark in Selangor.	f	4.5	101.3165620	3.3087910	\N
206	Menara jam Kuala Selangor watch tower	Menara jam Kuala Selangor watch tower is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.0	101.2489670	3.3404110	\N
207	Kuala Selangor Town	Kuala Selangor Town is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.2497808	3.3392354	\N
208	Sasaran Art Park Kuala Selangor	Sasaran Art Park Kuala Selangor is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.3065975	3.2592680	\N
209	Kuala Selangor Nature Park- Community Mangrove Nursery	Kuala Selangor Nature Park- Community Mangrove Nursery is a recognized farm located in Selangor, Malaysia, attracting many visitors.	f	5.0	101.2361803	3.3353369	\N
210	Sky Mirror World ＆ Boat Cafe	Sky Mirror World ＆ Boat Cafe is a recognized travel agency located in Selangor, Malaysia, attracting many visitors.	f	4.6	101.2535629	3.3437666	\N
211	Blue Tears Kuala Selangor	Blue Tears Kuala Selangor is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.2299599	3.3364635	\N
212	Sky Mirror - Kuala Selangor	Sky Mirror - Kuala Selangor is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.1944340	3.2159162	\N
213	Sekinchan Paddy Field	Sekinchan Paddy Field is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.4	101.1231191	3.5273492	\N
214	Royal Selangor Visitor Centre	Visitor centre taking guests through the history of Royal Selangor's pewter manufacturing.	f	4.5	101.7244340	3.1966646	\N
215	港景海鲜楼 River View Seafood Restaurant	River View Seafood Restaurant is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.3	101.2514873	3.3481290	dinner
216	Restoran Makanan Laut Jeti	Restoran Makanan Laut Jeti is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.0	101.2517381	3.3478716	dinner
217	Kelip-Kelip Ikan Bakar Kuala Selangor	Kelip-Kelip Ikan Bakar Kuala Selangor is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.4	101.2719120	3.3206826	dinner
218	红绿灯海鲜餐馆 ? Traffic Light KS Seafood Restaurant	Traffic Light KS Seafood Restaurant is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.7	101.2528726	3.3537246	dinner
219	Qun Hua Kuala Selangor Seafood Restaurant	Qun Hua Kuala Selangor Seafood Restaurant is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	3.6	101.2491455	3.3517708	dinner
220	Restoran Seafood Hai Ung ? 海运海鲜楼	Restoran Seafood Hai Ung is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.0	101.2489164	3.3521508	dinner
221	Bagan Seafood Restaurant (Restoran Seafood View Port)	Bagan Seafood Restaurant (Restoran Seafood View Port) is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	3.6	101.2538218	3.3438963	dinner
222	Yu Jia Ren Seafood Restaurant (YUJIAREN)	Yu Jia Ren Seafood Restaurant (YUJIAREN) is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.7	101.2515724	3.3480741	dinner
223	Want To Eat Restaurant	Want To Eat Restaurant is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.4	101.2561775	3.3468099	dinner
224	Restoran Tian Wai Tian 天外天海鲜餐室	Restoran Tian Wai Tianis a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.1	101.2525018	3.3535134	dinner
225	Sin Hai Ping Seafood Restaurant新海滨海鲜楼	Sin Hai Ping Seafood Restaurant is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.2	101.2518389	3.3480947	dinner
226	Thyme Taste & Grill Restaurant	Thyme Taste & Grill Restaurant is a popular dining spot in Selangor, well-known for its excellent halal restaurant.	t	4.4	101.2562193	3.3465917	dinner
227	Mee Udang Banjir Kuala Selangor	Mee Udang Banjir Kuala Selangor is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	3.8	101.2417314	3.3705827	dinner
228	Hai Shang Ren Seafood Restaurant (Pork Free)	Hai Shang Ren Seafood Restaurant (Pork Free) is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.7	101.1695262	3.3969888	dinner
229	Yang Ming Seafood Restaurant 扬名海鲜餐馆	Yang Ming Seafood Restaurant is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.1	101.2495960	3.3511990	dinner
230	夏日风车海鲜馆 Summer Windmill Seafood Restaurant	Summer Windmill Seafood Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.2488232	3.3535803	dinner
231	Mustawa Family Cafe	Mustawa Family Cafe is a popular dining spot in Selangor, well-known for its excellent meal delivery.	t	4.3	101.2551835	3.3495078	dinner
232	Restoran Makanan Laut Ah Poh	Restoran Makanan Laut Ah Poh is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.3	101.2491800	3.3422273	dinner
233	Lai Pin Seafood Restaurant | 莱�e海鲜饭店 | Kuala Selangor	Lai Pin Seafood Restaurant is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.4	101.2755387	3.3162705	dinner
234	川记海鲜饭店芭尾 Kedai Makan Boon Chuan	Kedai Makan Boon Chuan is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.2524680	3.3468933	dinner
235	Teratak Tokwan	Teratak Tokwan is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.1	101.5971087	3.3129808	\N
236	Hidden Waterfall	Hidden Waterfall is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.6171910	3.3162390	\N
237	Templer’s Park Falls	Templer’s Park Falls is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.6196976	3.2989882	\N
238	Commonwealth Forest Park Falls	Nature area popular for its woodsy campsites & mild river, with a hike to a waterfall in the forest.	f	4.1	101.6135840	3.2957390	\N
239	Rawang Bypass, Malaysia	Rawang Bypass, Malaysia is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.5982805	3.3187198	\N
240	Taman Eko Rimba Kanching by Tourism Selangor	Multi-tiered waterfall with a swimming pond in an expansive forest reserve filled with wildlife.	f	4.3	101.6193205	3.2987806	\N
241	Kanching Waterfalls	Kanching Waterfalls is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.6192662	3.2998875	\N
242	Jing Loong Shan Wan Fo Shih	Jing Loong Shan Wan Fo Shih is a prominent buddhist temple and a must-visit cultural landmark in Selangor.	f	4.5	101.5862630	3.3553050	\N
243	Taman Eko Rimba Kanching Waterfalls	Taman Eko Rimba Kanching Waterfalls is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.6195011	3.2994592	\N
244	Taman Rimba Templer	Lush rainforest reserve on a river with a waterfall popular for hiking & camping.	f	4.1	101.6423531	3.2863498	\N
245	Bukit Takun	Bukit Takun is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.3	101.6337777	3.3024836	\N
246	Batu Arang Heritage Town Column	No official description.	f	4.6	101.4721352	3.3187403	\N
247	广西冯门陈式之墓	A prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5885598	3.3157415	\N
248	Tugu Lebuh Raya Utara Selatan	Tugu Lebuh Raya Utara Selatan is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	3.5	101.5585077	3.3303624	\N
249	广西冯成公之墓	A prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5877622	3.3155029	\N
250	Ummu Nova Huny	Ummu Nova Huny is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5969402	3.3065671	\N
251	Coal mining tunnel ( Terowong Batu Arang )	Coal mining tunnel ( Terowong Batu Arang ) is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.3	101.4705765	3.3127522	\N
252	煤炭山 Batu Arang, Selangor	Batu Arang, Selangor is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.5	101.4717221	3.3186425	\N
253	0 km Sungai Buaya	0 km Sungai Buaya is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.6	101.5234757	3.3919193	\N
254	Taman Rekreasi Perigi Tujuh	Taman Rekreasi Perigi Tujuh is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.8	101.6126676	3.3633644	\N
255	Batu Arang Stele	Batu Arang Stele is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.3	101.4721365	3.3187398	\N
256	ALLSTAR RAWANG ??	ALLSTAR RAWANG is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5324986	3.3270428	\N
257	Gm	Gm is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5312471	3.3280370	\N
258	Selangor Fruit Valley (SFV)	Selangor Fruit Valley (SFV) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.4488546	3.3897047	\N
259	Traditional Chinese Shop Houses	Traditional Chinese Shop Houses is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4714911	3.3165023	\N
260	DATARAN BATU ARANG	DATARAN BATU ARANG is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4708786	3.3173070	\N
261	Gamuda Gardens Central Park	Gamuda Gardens Central Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.5383393	3.2831667	\N
262	Saujana Rawang Park	Saujana Rawang Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.8	101.5150033	3.3372768	\N
263	Emerald Central Park	Emerald Central Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.5439909	3.3265082	\N
264	Puteri Central Park (PCP)	Puteri Central Park (PCP) is a prominent park and a must-visit cultural landmark in Selangor.	f	3.9	101.4773601	3.2882517	\N
265	Tasik Widuri Recreational Park	Tasik Widuri Recreational Park is a beautiful water park, offering a relaxing outdoor and nature experience for visitors.	t	4.3	101.5885490	3.4301118	lunch, dinner
266	Gamuda Gardens	Gamuda Gardens is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.5414358	3.2834886	\N
267	Hutan Lipur Bukit Lagong	Tropical forest laced with trails leading to waterfalls & natural pools popular for swimming.	f	4.0	101.6081733	3.2644875	\N
268	ManJa Garden	ManJa Garden is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.9	101.6023544	3.3327837	\N
269	Taman Negeri Selangor	Large area of tropical rainforest, with trails to waterfalls, plus camping & picnic facilities.	f	4.1	101.6980360	3.3119270	\N
270	Rawang Bypass Trailhead	Rawang Bypass Trailhead is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.7	101.5948620	3.3194498	\N
271	Rawang Bypass Peak Viewpoint	Rawang Bypass Peak Viewpoint is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.8	101.5990942	3.3188095	\N
272	Templer Park Rainforest Retreat	Modern quarters in a tranquil hotel offering views of the rainforest, plus an outdoor infinity pool.	f	4.8	101.6377242	3.3007337	\N
273	Kanching Waterfall Top	Kanching Waterfall Top is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.6	101.6198350	3.3070830	\N
274	Ramayana Cave - Suyambu Lingam	Ramayana Cave - Suyambu Lingam is a prominent hindu temple and a must-visit cultural landmark in Selangor.	f	3.6	101.6816297	3.2386421	\N
275	Rawang Bypass Hiking Trailhead	Rawang Bypass Hiking Trailhead is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.5963838	3.3260075	\N
276	Air Terjun Semangkuk	Air Terjun Semangkuk is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.7	101.7412222	3.6441111	\N
277	Nesan Curry House Sdn Bhd (BEST INDIAN RESTAURANT IN RAWANG?)?	Nesan Curry House Sdn Bhd (BEST INDIAN RESTAURANT IN RAWANG?)? is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	4.1	101.5748901	3.3209958	dinner
278	Appam Palace Rawang (HQ)	Appam Palace Rawang (HQ) is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.8	101.5762119	3.3204758	dinner
279	Taste of Chennai Restaurant	Taste of Chennai Restaurant is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	4.0	101.5750366	3.3206149	dinner
280	Real Me Restaurant	Real Me Restaurant is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.8	101.5797221	3.3241663	dinner
281	TKS V River Forest Seafood Restaurant	TKS V River Forest Seafood Restaurant is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.1	101.6346821	3.2853077	dinner
282	Restoran South Masalaa ? Rawang	Restoran South Masalaa ? Rawang is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	4.4	101.5745924	3.3217898	dinner
283	Tokyo Food Restaurant ? Restoran Tokyo Food	Tokyo Food Restaurant ? Restoran Tokyo Food is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	3.9	101.5783853	3.3289322	dinner
284	Mohd Chan Chinese Muslim Restaurant @ Rawang	Mohd Chan Chinese Muslim Restaurant @ Rawang is a popular dining spot in Selangor, well-known for its excellent halal restaurant.	t	4.6	101.5773417	3.3182851	dinner
285	Restoran Lan Je ? �m姐清蒸非洲鱼 ? 万绕 ? Rawang	Restoran Lan Je Rawang is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.5980472	3.3039972	dinner
286	Kinnaree Thai Cuisine Restaurant	Kinnaree Thai Cuisine Restaurant is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	4.1	101.5793703	3.3247865	dinner
287	美味家乡饭店 Restoran New Brilliant Hometown	Restoran New Brilliant Hometown is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.3	101.5801191	3.3259110	dinner
288	Village Restaurant	Village Restaurant is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.1	101.6002566	3.3024108	dinner
289	Madam Daun Pisang	Madam Daun Pisang is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.2	101.6383791	3.2884358	dinner
290	Punjabi Kitchen Restaurant	Punjabi Kitchen Restaurant is a popular dining spot in Selangor, well-known for its excellent pakistani restaurant.	t	4.8	101.5797628	3.3108205	dinner
291	Restoran Teratak Nogori	Restoran Teratak Nogori is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.5941590	3.3049438	dinner
292	Kantin Jepun, Sumomo	Kantin Jepun, Sumomo is a popular dining spot in Selangor, well-known for its excellent japanese restaurant.	t	4.9	101.5565082	3.3091259	dinner
293	Fu Wah Restaurant	Fu Wah Restaurant is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.3	101.5901041	3.3064588	dinner
294	Restoran Annapoorani	Restoran Annapoorani is a popular dining spot in Selangor, well-known for its excellent vegetarian restaurant.	t	4.5	101.5740300	3.3228984	dinner
295	Ayam Gepuk Pak Gembus Bandar Baru Rawang	Ayam Gepuk Pak Gembus Bandar Baru Rawang is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.5773804	3.3184524	dinner
296	Kim Wah Restaurant | 万挠蕉赖蒸鱼头	Kim Wah Restaurant is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.2	101.5801286	3.3281222	dinner
297	Morib Beach	Morib Beach is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.1	101.4408645	2.7540706	\N
298	Tadom Leisure Camp	Tadom Leisure Camp is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.1	101.6264641	2.8104925	\N
299	Dataran Banting	Dataran Banting is a prominent park and a must-visit cultural landmark in Selangor.	f	4.3	101.4946436	2.8030492	\N
300	Bukit Jugra Paragliding Park	Bukit Jugra Paragliding Park is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.4180136	2.8359244	\N
301	Paya Indah Lake Jetty	Paya Indah Lake Jetty is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.6137890	2.8586971	\N
302	Jugra Insitu Museum	Jugra Insitu Museum is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.1	101.4127950	2.8358746	\N
303	Taman Rekreasi Banting	Taman Rekreasi Banting is a prominent park and a must-visit cultural landmark in Selangor.	f	3.9	101.4974693	2.8120262	\N
304	Kolam Hippo	Kolam Hippo is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	101.6302424	2.8601571	\N
305	Bukit Jugra Viewing Point	Bukit Jugra Viewing Point is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.4175738	2.8354249	\N
306	Crocodile Lake	Crocodile Lake is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.6266807	2.8601015	\N
307	Kolam Pancing Paktam Udang Galah	Kolam Pancing Paktam Udang Galah is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.7	101.6302226	2.8316551	\N
308	Banting Waterfront	Banting Waterfront is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.8	101.5090625	2.8130181	\N
309	Pantai Batu Laut	Pantai Batu Laut is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.5154350	2.6752301	\N
310	Sultan Ala'eddin Royal Mosque	Sultan Ala'eddin Royal Mosque is a prominent mosque and a must-visit cultural landmark in Selangor.	f	4.6	101.4398303	2.8632142	\N
311	Log Boom	Log Boom is a recognized service located in Selangor, Malaysia, attracting many visitors.	f	0.0	101.6552174	2.8203491	\N
312	Paya Indah Discovery Wetlands (Gate 2)	Paya Indah Discovery Wetlands (Gate 2) is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.6329483	2.8601217	\N
313	Tanah gambut	Tanah gambut is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.5156200	2.7590560	\N
314	Start of WCE Highway	Start of WCE Highway is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.3	101.5575682	2.8348666	\N
315	Pejabat Lama Daerah Jugra	Pejabat Lama Daerah Jugra is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	3.9	101.4139550	2.8354900	\N
316	Kyra	Kyra is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.4907689	2.8069905	\N
317	Setor Peluru ???? ?????	Setor Peluru ???? ????? is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4146337	2.8369262	\N
318	Menara Banting	Menara Banting is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.4977732	2.8122520	\N
319	Makam Raja Berayun (Raja Ibrahim)	Makam Raja Berayun (Raja Ibrahim) is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4129077	2.8372043	\N
320	Makam Panglima Jagus Putra	Makam Panglima Jagus Putra is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4129553	2.8372931	\N
321	Makam Daeng Mamat	Makam Daeng Mamat is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.4416218	2.7943918	\N
322	Tugu Haji Sidek Kamar Malaysian Badminton Legenda	Tugu Haji Sidek Kamar Malaysian Badminton Legenda is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.7	101.4914639	2.7987022	\N
323	Jugra Lama	Jugra Lama is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.1	101.4178966	2.8330218	\N
324	Pusaka idaman	Pusaka idaman is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.4552912	2.7483358	\N
325	Lutfi widodo	Lutfi widodo is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6548560	2.8089350	\N
326	Wetlands Arboretum Centre	Wetlands Arboretum Centre is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.6136814	2.8795399	\N
327	Jugra Hill Trail	Jugra Hill Trail is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.5	101.4244482	2.8421335	\N
328	Kuan Wellness Eco Park	5-acre attraction aimed at educating about environmental issues, with an on-site visitor center.	f	3.6	101.4970422	2.6934259	\N
329	Abu Bakr Sanctuary	Abu Bakr Sanctuary is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.5168370	2.9321313	\N
330	Jugra Forest Reserve	Jugra Forest Reserve is a recognized woods located in Selangor, Malaysia, attracting many visitors.	f	0.0	101.4166667	2.8333333	\N
331	Bukit Jugra Peak	Bukit Jugra Peak is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.5	101.4244916	2.8422752	\N
332	Tadom Hill Resorts	Airy tents & huts in a tranquil, forested property featuring outdoor activities & free breakfast.	f	4.0	101.6285268	2.8105988	\N
333	Cove Aerobar @ Discovery Park	Cove Aerobar @ Discovery Park is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.1	101.6178013	2.8861536	\N
334	Morib Beach	Seaside area with a coastal promenade, shade trees & picnic pavilions, plus toilet facilities.	f	3.9	101.4426016	2.7495127	\N
335	Gold Coast Morib Resort	Gold Coast Morib Resort is a beautiful resort hotel, offering a relaxing outdoor and nature experience for visitors.	f	3.0	101.4604927	2.7155331	\N
336	Kampung Hills Eatery	Kampung Hills Eatery is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.3	101.4324889	2.8496778	dinner
337	Ayam Gepuk Top Global Banting	Ayam Gepuk Top Global Banting is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.5033859	2.8124950	dinner
338	Ole Lado	Ole Lado is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.5009447	2.8123003	dinner
339	Restoran Istana Bunian	Restoran Istana Bunian is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.3	101.6279943	2.8107409	dinner
340	The Chaiwalla Restaurant	The Chaiwalla Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.5080566	2.8133141	dinner
341	Chuan Xiang Yi Pin	Chuan Xiang Yi Pin is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.9	101.4986956	2.8111285	dinner
342	Ahmad Cafe	Ahmad Cafe is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.4544291	2.7309634	dinner
343	Nasi Arab Alshams Banting	Nasi Arab Alshams Banting is a popular dining spot in Selangor, well-known for its excellent family restaurant.	t	4.5	101.4973501	2.8122958	dinner
344	Juvita Seafood @ Kanchong Darat, Banting	Juvita Seafood @ Kanchong Darat, Banting is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.9	101.4888248	2.7952126	dinner
345	AllAce Banting	AllAce Banting is a popular dining spot in Selangor, well-known for its excellent fast food restaurant.	t	4.8	101.5009323	2.8128535	dinner
346	娘家kopitiam	A popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	4.7	101.5057067	2.8173235	dinner
347	Restoran Sayang Manis	Restoran Sayang Manis is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.1	101.5046961	2.8131134	dinner
348	Restoran Sin Loong Foong	Restoran Sin Loong Foong is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.8	101.4998883	2.8117416	dinner
349	Long Time No C Restaurant.	Long Time No C Restaurant. is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	3.9	101.5003373	2.8224708	dinner
350	Hailam Kopitiam Banting	Hailam Kopitiam Banting is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.9	101.5085710	2.8128091	dinner
351	Indah Desa Cafe	Indah Desa Cafe is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.4922469	2.7865483	dinner
352	Shamna nasi arab (western)	Shamna nasi arab (western) is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.4978401	2.8102400	dinner
353	Seni SattiSorru Banting	Seni SattiSorru Banting is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.9	101.5058629	2.8134208	dinner
354	Saha Coffee & Fruit Bar S/B (HQ)	Saha Coffee & Fruit Bar S/B (HQ) is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.5075853	2.8152972	dinner
355	Teratak Bunga Seribu, Banting	Teratak Bunga Seribu, Banting is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.6	101.4884127	2.7959571	dinner
356	Taman Eko Rimba, Sungai Tua	Taman Eko Rimba, Sungai Tua is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.6978055	3.3125463	\N
357	Lord Murugan Statue	This Murugan sculpture at the foot of Batu Caves is the tallest statue of a Hindu deity in Malaysia.	f	4.6	101.6839720	3.2374497	\N
358	Ulu Yam Waterfall	Ulu Yam Waterfall is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.7016689	3.3320002	\N
359	Muzium Orang Asli Gombak (MOAG)	Compact museum featuring exhibits about the history & culture of Malaysia's original inhabitants.	f	4.2	101.7321237	3.2942924	\N
360	Jungle School Gombak Malaysia (JSGM)	Jungle School Gombak Malaysia (JSGM) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.7	101.7270127	3.2763275	\N
361	Sungai Tua Waterfall	Sungai Tua Waterfall is a prominent nature preserve and a must-visit cultural landmark in Selangor.	f	4.2	101.7020786	3.3314563	\N
362	SUNGAI BUKIT LAGONG SELAYANG	SUNGAI BUKIT LAGONG SELAYANG is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.8	101.6387217	3.2583950	\N
363	Sri Subramaniar Swamy Temple	Sri Subramaniar Swamy Temple is a prominent hindu temple and a must-visit cultural landmark in Selangor.	f	4.5	101.6836039	3.2373027	\N
364	Gua Damai Extreme Park	Outdoor venue offering a range of activities including base jumping, rock climbing & skateboarding.	f	4.5	101.6879575	3.2478366	\N
365	Bukit Permata Peak (Sea Of Cloud)	Bukit Permata Peak (Sea Of Cloud) is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.8	101.7060141	3.2669938	\N
366	FRIM Museum	FRIM Museum is a prominent museum and a must-visit cultural landmark in Selangor.	f	4.4	101.6341621	3.2352821	\N
367	Batu Caves Immersive Experience Centre	Batu Caves Immersive Experience Centre is a recognized museum located in Selangor, Malaysia, attracting many visitors.	f	4.8	101.6744950	3.2477240	\N
368	Cave Villa Indian Food	Cave Villa Indian Food is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	2.7	101.6828325	3.2376597	dinner
369	Balai Polis Lama Gombak	Balai Polis Lama Gombak is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.6	101.7502802	3.3240577	\N
370	Dataran Ilmu KUIZM	Dataran Ilmu KUIZM is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.7018560	3.2230520	\N
371	Kelatan	Kelatan is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6735624	3.2627397	\N
372	GOMBAK -HULULANGAT GEOPARK Geotapak Singkapan Syal Shale Outcrop Geosite	GOMBAK -HULULANGAT GEOPARK Geotapak Singkapan Syal Shale Outcrop Geosite is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.4703361	3.3223019	\N
373	Dunia dinosaur	Dunia dinosaur is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6647406	3.2368940	\N
374	Sungai Pisang Waterfall Trailhead	A mellow wooded hike along a river leads to this small cascade, with nearby camping spots.	f	4.5	101.7351596	3.3062369	\N
375	Batu Caves Railway Line End	Batu Caves Railway Line End is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6809442	3.2435597	\N
376	Gua Damai XPark	Gua Damai XPark is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	101.6877204	3.2479508	\N
377	Taman Tasik Sri Gombak	Taman Tasik Sri Gombak is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.7031830	3.2474584	\N
378	Taman Rimba Bukit Lagong MPS	Taman Rimba Bukit Lagong MPS is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.6319811	3.2629745	\N
379	Kepong Botanic Gardens | FRIM - Forest Research Institute Malaysia	Kepong Botanic Gardens | FRIM - Forest Research Institute Malaysia is a prominent botanical garden and a must-visit cultural landmark in Selangor.	f	4.4	101.6233648	3.2248751	\N
380	The Jungle Rainforest Retreat, Templer Park	The Jungle Rainforest Retreat, Templer Park is a recognized private guest room located in Selangor, Malaysia, attracting many visitors.	f	4.2	101.6459635	3.2826085	\N
381	KL East Park	KL East Park is a beautiful hiking area, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.7325187	3.2281093	\N
382	River & Glamp.	River & Glamp. is a recognized health located in Selangor, Malaysia, attracting many visitors.	f	4.7	101.6957626	3.2993183	\N
383	Sungai Tua Recreational Forest	Sungai Tua Recreational Forest is a beautiful nature preserve, offering a relaxing outdoor and nature experience for visitors.	f	2.3	101.7239106	3.3335580	\N
384	Pisang Waterfall	Pisang Waterfall is a recognized sports activity location located in Selangor, Malaysia, attracting many visitors.	f	4.6	101.7330266	3.3161606	\N
385	Batu Caves	Batu Caves is a recognized natural feature located in Selangor, Malaysia, attracting many visitors.	f	4.2	101.6840385	3.2378844	\N
386	KL East Mall	KL East Mall is a bustling shopping mall, perfect for shopping, dining, and local experiences.	f	4.3	101.7304658	3.2247781	\N
387	Zoo Negara Malaysia	Open-concept zoo featuring a wide range of domestic & exotic animals, from elephants to seals.	f	4.1	101.7588245	3.2103543	\N
388	Polperro Steak House Gombak	Polperro Steak House Gombak is a popular dining spot in Selangor, well-known for its excellent steak house.	t	4.5	101.7058377	3.2409510	dinner
389	Seha Kitchen, Lontong Kacau Bilau	Seha Kitchen, Lontong Kacau Bilau is a popular dining spot in Selangor, well-known for its excellent family restaurant.	t	4.5	101.7030496	3.2415941	dinner
390	KOPIHUT (SRI GOMBAK)	KOPIHUT (SRI GOMBAK) is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.7002550	3.2385330	dinner
391	Wira Seafood Ikan Bakar (Taman Sri Gombak)	Wira Seafood Ikan Bakar (Taman Sri Gombak) is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	4.2	101.6973811	3.2391886	dinner
392	Sudu & Knife	Sudu & Knife is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.3	101.7054139	3.2427750	dinner
393	Medan Selera Taman Sri Gombak	Medan Selera Taman Sri Gombak is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.2	101.7044379	3.2404673	dinner
394	Mohammad Chow ? Gombak	Mohammad Chow ? Gombak is a popular dining spot in Selangor, well-known for its excellent halal restaurant.	t	3.9	101.7171778	3.2408576	dinner
395	Restoran Golek Golek Suasana Kampung	Restoran Golek Golek Suasana Kampung is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.9	101.7254748	3.2355061	dinner
396	Kapitan Tandoori House Sri Gombak	Kapitan Tandoori House Sri Gombak is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.6998355	3.2379802	dinner
397	Restoran Jom Sama Sama	Restoran Jom Sama Sama is a popular dining spot in Selangor, well-known for its excellent food court.	t	3.8	101.7061254	3.2428402	dinner, lunch, dinner
398	Restoran Bidayah Bistro (Taman Gombak Permai)	Restoran Bidayah Bistro (Taman Gombak Permai) is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.6870086	3.2518896	dinner
399	Bowlcrafted @ 168 Park Mall	Bowlcrafted @ 168 Park Mall is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.6490108	3.2489359	dinner
400	Restoran MaiiShellOud Port Seafood	Restoran MaiiShellOud Port Seafood is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.5	101.7050073	3.2421320	breakfast, dinner
401	Kari Kepala Ikan SG（HQ）	Kari Kepala Ikan SG（HQ） is a popular dining spot in Selangor, well-known for its excellent halal restaurant.	t	4.3	101.6989790	3.2380370	dinner
402	Pak Uda Kitchen & Grill	Pak Uda Kitchen & Grill is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.6982705	3.2291975	dinner
403	Jibby East Grill	Jibby East Grill is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.7	101.7285656	3.2261982	dinner
404	Secret Recipe Taman Sri Gombak	Secret Recipe Taman Sri Gombak is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.6	101.6998189	3.2386582	dinner
405	Restoran Thaqwa	Restoran Thaqwa is a popular dining spot in Selangor, well-known for its excellent breakfast restaurant.	t	3.8	101.7045423	3.2409286	breakfast, dinner
406	D' Best Gombak	D' Best Gombak is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.5	101.7128530	3.2172551	dinner
407	Gua Lepak	Gua Lepak is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.0	101.6944831	3.2385306	dinner
408	Chongkak Park & Resort by Tourism Selangor	Chongkak Park & Resort by Tourism Selangor is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.0	101.8432558	3.2100407	\N
409	Sungai Congkak Recreational Forest	Natural pools surrounded by rainforest, with BBQ stations, picnic spots & rental chalets.	f	4.2	101.8435170	3.2090530	\N
410	Lepoh Waterfall	Lepoh Waterfall is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.8658741	3.2511070	\N
411	Air Terjun Sungai Gabai	Popular picnic spot with steps leading to the top of the waterfall & a shallow pool at the bottom.	f	4.1	101.9090289	3.1660921	\N
412	Serai Bamboo Hot Spring	Serai Bamboo Hot Spring is a popular dining spot in Selangor, well-known for its excellent tourist attraction.	t	4.0	101.7946145	3.0907242	breakfast, lunch, dinner
413	Kolam Air Panas Surau Kg Dusun Tua	Kolam Air Panas Surau Kg Dusun Tua is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.8362815	3.1392215	\N
414	Kolam Air Panas Batu 16	Kolam Air Panas Batu 16 is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.8345202	3.1369170	\N
415	Dusun tua	Dusun tua is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.8335811	3.1339098	\N
416	SKYTREX Adventure Sg Congkak	Treetop ropeway circuits for varied levels in a rainforest, plus cooling swims at a nearby river.	f	4.7	101.8422029	3.2089852	\N
417	Tekali Valley	Tekali Valley is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	101.8529470	3.1263250	\N
418	Damai D'Hulu campsite	Damai D'Hulu campsite is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.9	101.8261707	3.1731573	\N
419	Gunung Nuang Recreational Forest	Gunung Nuang Recreational Forest is a prominent nature preserve and a must-visit cultural landmark in Selangor.	f	4.5	101.8827360	3.2173320	\N
420	Hot spring foot bath	Hot spring foot bath is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.8346126	3.1368677	\N
421	Wealthy Farmland	Wealthy Farmland is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.8321343	3.1204409	\N
422	Deen Paradise	Deen Paradise is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.8541713	3.1417199	\N
423	Batu Penanda Kampung Sg Tekali	Batu Penanda Kampung Sg Tekali is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.0	101.8521251	3.1090537	\N
424	Langat@18 Riverview	Langat@18 Riverview is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.8487656	3.1663997	\N
425	Jamsari Agro Farm	Jamsari Agro Farm is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.8214133	3.1313448	\N
426	Sungai Semungkis	Sungai Semungkis is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.8228947	3.1339562	\N
427	Ulu Langat Forest Reserve	Ulu Langat Forest Reserve is a prominent nature preserve and a must-visit cultural landmark in Selangor.	f	4.5	101.8552490	3.1396590	\N
428	Stor Hulu Langat	Stor Hulu Langat is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.8660122	3.1233063	\N
429	0km Batu 14 Hulu Langat (Route B116)	0km Batu 14 Hulu Langat (Route B116) is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.5	101.8160487	3.1126128	\N
430	Dataran Rekreasi Batu 18	Dataran Rekreasi Batu 18 is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.8505335	3.1675265	\N
431	Tempat Warisan Pembakaran Zaman British	Tempat Warisan Pembakaran Zaman British is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.0	101.8495525	3.1669082	\N
432	Abandoned Mansion	Abandoned Mansion is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.7730935	3.1633986	\N
433	Hulu langat	Hulu langat is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.8572689	3.2000708	\N
434	Abandoned twin mansions and guardhouse	Abandoned twin mansions and guardhouse is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.7729617	3.0831429	\N
435	Corner Wong	Corner Wong is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.0	101.8322117	3.1315314	\N
436	Bukit Saga Waterfall	Bukit Saga Waterfall is a recognized picnic ground located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.7817852	3.1044293	\N
437	Kampung Baru Batu 14 Hulu Langat	Kampung Baru Batu 14 Hulu Langat is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.8160862	3.1126797	\N
438	Ampang Lookout Point	Ampang Lookout Point is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.7870840	3.1266270	\N
439	Rumah Kebun Camping Ground (RKCG)	Rumah Kebun Camping Ground (RKCG) is a recognized campground located in Selangor, Malaysia, attracting many visitors.	f	4.6	101.8263759	3.1667315	\N
440	Hutan Rizab Hulu Langat	Hutan Rizab Hulu Langat is a prominent national park and a must-visit cultural landmark in Selangor.	f	4.3	101.8350000	3.1033333	\N
441	Sungai Semungkis waterfall @ jeram tinggi	Sungai Semungkis waterfall @ jeram tinggi is a beautiful nature preserve, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.8264174	3.1684609	\N
442	Laman Riadah Jeram Tinggi, Kg Sg Semungkis	Laman Riadah Jeram Tinggi, Kg Sg Semungkis is a beautiful nature preserve, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.8263478	3.1687710	\N
443	Moonkissed By The River	Moonkissed By The River is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.8262186	3.1709174	\N
444	Jeram Perlus Waterfall	Jeram Perlus Waterfall is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.9	101.9234893	3.2001809	\N
445	Bukit Puteh Waterfall	Bukit Puteh Waterfall is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.7752744	3.0892414	\N
446	Sungai Congkak	Sungai Congkak is a recognized campground located in Selangor, Malaysia, attracting many visitors.	f	4.3	101.8491459	3.2018955	\N
447	Taman Eko Langat	Taman Eko Langat is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.7739501	3.0079814	\N
448	Perdik Fall	Perdik Fall is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.8357099	3.2051530	\N
449	TEDUHAN @ Langat Retreat Resort	TEDUHAN @ Langat Retreat Resort is a recognized health located in Selangor, Malaysia, attracting many visitors.	f	3.9	101.8575236	3.1955760	\N
450	Dusun Tekali	Dusun Tekali is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.8682437	3.1392758	\N
451	Monkeys Canopy Resort	Monkeys Canopy Resort is a popular dining spot in Selangor, well-known for its excellent indoor playground.	t	3.9	101.8496511	3.0516694	dinner
452	Rakit buluh river side	Rakit buluh river side is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	101.8772906	3.2100327	\N
453	KL-View in Ampang	KL-View in Ampang is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.7870081	3.1258680	\N
454	Sangkot Garden	Sangkot Garden is a beautiful wedding venue, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.8339360	3.1369860	\N
455	Hammocks By The River	Hammocks By The River is a recognized campground located in Selangor, Malaysia, attracting many visitors.	f	4.2	101.8262741	3.1212504	\N
456	Restoran Terra Pong Batu 18	Restoran Terra Pong Batu 18 is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.8502997	3.1676063	dinner
457	Sempurna Garden Hulu Langat	Sempurna Garden Hulu Langat is a popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	4.6	101.8157197	3.1065609	dinner
458	Langat Forest Seafood and Beer Garden 呀吃盛林啤酒园 （山水鱼）	Langat Forest Seafood and Beer Garden is a popular dining spot in Selangor, well-known for its excellent korean restaurant.	t	3.6	101.8176445	3.1066132	dinner
459	Veg Fish Farm Thai Restaurant	Veg Fish Farm Thai Restaurant is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	3.8	101.8034537	3.1301820	dinner
460	Restoran Rimba Ikan Bakar	Restoran Rimba Ikan Bakar is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.1	101.7887312	3.0852241	dinner
461	Purnama Klasik	Purnama Klasik is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.7910049	3.0867807	dinner
462	JIBRIL Bangi	JIBRIL Bangi is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.9	101.7744700	2.9374857	dinner
463	Arina Seafood	Arina Seafood is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.8109840	3.1089590	dinner
464	Chalee Seafood	Chalee Seafood is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.7982865	3.0963795	dinner
465	Water View Thai Restaurant	Water View Thai Restaurant is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	3.8	101.8270187	3.1118800	dinner
466	The Hub Cafe @ Tanah Tara	The Hub Cafe @ Tanah Tara is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.8889412	3.1615578	dinner
467	Wooden House ? Chef Mary Kitchen ? Reservation Only	Wooden House ? Chef Mary Kitchen ? Reservation Only is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	3.9	101.8446958	3.1105870	dinner
468	Restaurant Chong Kee	Restaurant Chong Kee is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.3	101.8192520	3.1106410	dinner
469	Hing Restaurant | 兴呀吃�店	Hing Restaurant is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.3	101.8301840	3.1125152	dinner
470	WAN THAI SEAFOOD HULU LANGAT	WAN THAI SEAFOOD HULU LANGAT is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.8093612	3.1216692	dinner
471	Lontong King	Lontong King is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.8030514	3.0986613	dinner
472	Bahulu Classiq	Bahulu Classiq is a popular dining spot in Selangor, well-known for its excellent cafe.	t	4.2	101.8525415	3.1667235	breakfast, dinner
473	Secret Recipe Hulu Langat	Secret Recipe Hulu Langat is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.7985860	3.0968179	dinner
474	Pantai Bagan Nakhoda Omar	Pantai Bagan Nakhoda Omar is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.9	100.8733739	3.7673174	\N
475	Sabak Bernam Waterfront	Sabak Bernam Waterfront is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.7	100.9833671	3.7700610	\N
476	Pantai Siput Jalan Bumi Hijau	Pantai Siput Jalan Bumi Hijau is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	100.8958368	3.7504829	\N
477	Mokz Betta Sabak Bernam	Mokz Betta Sabak Bernam is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.8	100.9886995	3.7622318	\N
478	Port Camping Pantai Bumi Hijau	Port Camping Pantai Bumi Hijau is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	100.8973975	3.7481581	\N
479	Pantai Bumi Hijau (KIRI)	Pantai Bumi Hijau (KIRI) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	100.8979570	3.7475130	\N
480	MURAL NELAYAN SABAK BERNAM	MURAL NELAYAN SABAK BERNAM is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	100.9824010	3.7682575	\N
481	Jeti Pengkalan Sabak	Jeti Pengkalan Sabak is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.0	100.9815367	3.7698161	\N
482	Old Shophouse Row, Jalan Tebedu, Sabak	Old Shophouse Row, Jalan Tebedu, Sabak is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	100.9806346	3.7679658	\N
483	MURAL KUDA KEPANG	MURAL KUDA KEPANG is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.0	100.9813878	3.7684599	\N
484	Bagan Sungai Burong Blue Tear	Bagan Sungai Burong Blue Tear is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.0	100.9332962	3.6896635	\N
485	D Laman Chilli BNO	D Laman Chilli BNO is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	100.8833923	3.7734192	\N
486	Jeti BNO	Jeti BNO is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	100.8727255	3.7659246	\N
487	Teratak Wak Kopat	Teratak Wak Kopat is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.0352454	3.7456464	\N
488	Sabak Bernam Mural Art	Sabak Bernam Mural Art is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	100.9863617	3.6760861	\N
489	0 km Sabak	0 km Sabak is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.2	100.9821047	3.7679654	\N
490	Sawah Padi Sekinchan	Sawah Padi Sekinchan is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.5	101.1085885	3.5077192	\N
491	Agriculture and Fisheries Museum of Sabak Bernam	Agriculture and Fisheries Museum of Sabak Bernam is a recognized museum located in Selangor, Malaysia, attracting many visitors.	f	3.8	100.9841710	3.7709677	\N
492	Sabak Bernam Border	Sabak Bernam Border is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	100.9954010	3.7980247	\N
493	KAWASAN LEMBU	KAWASAN LEMBU is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.0213977	3.7806221	\N
494	Paddy Gallery	Sprawling rice-processing facility & museum featuring exhibits on traditional harvesting & more.	f	4.1	101.1287333	3.5208461	\N
495	Istana Raja Sehari	Istana Raja Sehari is a recognized wedding venue located in Selangor, Malaysia, attracting many visitors.	f	4.2	100.9830377	3.7701212	\N
496	Kubur Lama Bagan Nakhoda Omar	Kubur Lama Bagan Nakhoda Omar is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	100.8744227	3.7648122	\N
497	福德祠	A prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	100.9799110	3.7615220	\N
498	PASAR KARAT PAK MA'ON	PASAR KARAT PAK MA'ON is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.5	100.9816668	3.7689978	\N
499	MSekin Wonderland	MSekin Wonderland is a beautiful water park, offering a relaxing outdoor and nature experience for visitors.	f	3.8	101.0935128	3.5067938	\N
500	Taman Permainan Jalan Pegawai	Taman Permainan Jalan Pegawai is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	5.0	100.9904638	3.6791442	\N
501	Taman Pertama, Sabak Bernam	Taman Pertama, Sabak Bernam is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	4.0	100.9834687	3.7555868	\N
502	Kolam Takungan Mesra Alam KT23	Kolam Takungan Mesra Alam KT23 is a beautiful nature preserve, offering a relaxing outdoor and nature experience for visitors.	f	5.0	101.6815440	3.0393396	\N
503	Sekinchan Wishing Tree	Sekinchan Wishing Tree is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.0948436	3.5031263	\N
504	TERMINAL SEKINCHAN	TERMINAL SEKINCHAN is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.9	101.1442462	3.5217641	\N
505	JERAMI BAN KENAL	JERAMI BAN KENAL is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.3	101.0781328	3.6446284	dinner
506	Dulang RTok	Dulang RTok is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	100.9669525	3.7617481	dinner
507	Nawavi Seafood Sabak Bernam	Nawavi Seafood Sabak Bernam is a popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	4.3	100.9949018	3.7944217	dinner
508	Dapur Kak Mala	Dapur Kak Mala is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	100.9830102	3.7695191	dinner
509	SHAH WESTERN HOUSE (PROTTT)	SHAH WESTERN HOUSE (PROTTT) is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.6	100.9937835	3.7919003	dinner
510	Restoran Selera Rimba	Restoran Selera Rimba is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.1743013	3.7089352	dinner
511	Big Tas Tea Plus Lite Sabak Bernam	Big Tas Tea Plus Lite Sabak Bernam is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.5	100.9830451	3.7687487	dinner
512	Restoran Lembah Bernam, Sekinchan	Restoran Lembah Bernam, Sekinchan is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.3	101.1164294	3.5731153	dinner
513	Ley-Park Station | Sabak	Ley-Park Station | Sabak is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.4	100.9800970	3.7686646	dinner
514	Benteng Sabak Bernam	Benteng Sabak Bernam is a popular dining spot in Selangor, well-known for its excellent food court.	t	3.9	100.9815277	3.7680449	dinner, lunch, dinner
515	Warung Dani & Homestay	Warung Dani & Homestay is a popular dining spot in Selangor, well-known for its excellent breakfast restaurant.	t	4.9	100.9960703	3.7712410	breakfast, dinner
516	MR ADHA Ikan Bakar	MR ADHA Ikan Bakar is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	100.9238599	3.7303457	dinner
517	HM Sri Bagan Sepang	HM Sri Bagan Sepang is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.1	101.6859162	2.6099916	dinner
518	Kapten Seafood	Kapten Seafood is a popular dining spot in Selangor, well-known for its excellent cafe.	t	3.9	100.8843470	3.7723075	dinner
519	Aloha Cafe	Aloha Cafe is a popular dining spot in Selangor, well-known for its excellent family restaurant.	t	4.1	100.9806964	3.7673108	dinner
520	Restoran Haziq	Restoran Haziq is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.9	100.9828239	3.7681871	dinner
521	Ayam Gepuk Tok Pa	Ayam Gepuk Tok Pa is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	5.0	100.9821506	3.7687337	dinner
522	Warong Lalapan	Warong Lalapan is a popular dining spot in Selangor, well-known for its excellent indonesian restaurant.	t	4.3	100.9662431	3.6971427	dinner
523	Sabaks Cafe & Resto	Sabaks Cafe & Resto is a popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	3.5	101.0053212	3.6977476	dinner
524	National Botanic Gardens Shah Alam	Botanical garden featuring activities such as cycling, fishing, swimming & an adventure park.	f	4.2	101.5104943	3.0944963	\N
525	Zipline Adventure Shah Alam	Zipline Adventure Shah Alam is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.4	101.5138030	3.0748628	\N
526	Taman Tasik Shah Alam (Tasik Tengah)	Taman Tasik Shah Alam (Tasik Tengah) is a prominent park and a must-visit cultural landmark in Selangor.	f	4.4	101.5161200	3.0765180	\N
527	Shah Alam Independence Square	Shah Alam Independence Square is a prominent picnic ground and a must-visit cultural landmark in Selangor.	f	4.4	101.5223924	3.0754460	\N
528	Laman Budaya Musical Fountain	Laman Budaya Musical Fountain is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.5143375	3.0731666	\N
529	Sultan Alam Shah Museum	Modern museum complex featuring galleries devoted to local history, culture & Islamic heritage.	f	4.3	101.5209497	3.0745162	\N
530	Bukit Kayangan Palace	Bukit Kayangan Palace is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.5339968	3.0720028	\N
531	Taman Rekreasi Alam Megah	Taman Rekreasi Alam Megah is a prominent park and a must-visit cultural landmark in Selangor.	f	4.0	101.5635298	3.0076363	\N
532	Sri Maha Mariamman Devasthanam ? I-City	Sri Maha Mariamman Devasthanam ? I-City is a prominent hindu temple and a must-visit cultural landmark in Selangor.	f	4.7	101.4872877	3.0633663	\N
533	Wet World Water Park Shah Alam	Family-friendly water park featuring slides, tube rides & pirate-themed splash pools.	f	4.2	101.5125154	3.0722273	\N
534	SnoWalk i-City	Spot at iCity theme park featuring a climate-controlled snow space with ice sculptures & sledding.	f	4.1	101.4848116	3.0651630	\N
535	Laman Seni 7	A section of public alleyways featuring a curated selection of unique wall murals.	f	3.9	101.4887034	3.0680525	\N
536	Mestika Palace	Mestika Palace is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.4	101.5018243	3.0833773	\N
537	I-City Park - Immersive Winterland	I-City Park - Immersive Winterland is a prominent amusement center and a must-visit cultural landmark in Selangor.	f	4.3	101.4812318	3.0639920	\N
538	Kolam C	Kolam C is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.5122979	3.0986145	\N
539	I-City Park - AI World Experience Centre	I-City Park - AI World Experience Centre is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.4	101.4847758	3.0639381	\N
540	Taman Lembah Bukit SUK Shah Alam	Taman Lembah Bukit SUK Shah Alam is a prominent park and a must-visit cultural landmark in Selangor.	f	4.3	101.5133711	3.0808928	\N
541	sunset port	sunset port is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.5019245	3.0704613	\N
542	Klang	Klang is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.5184610	3.0732810	\N
543	Recreation Park Raja Lumu	Big, lush park offering a jogging track, playground & lake with freshwater birds, plus mosque views.	f	4.6	101.5191710	3.0754720	\N
544	Seri Hijauan Roundabout	Seri Hijauan Roundabout is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.5019219	3.1355875	\N
545	Terowong lori tinggi tak lepas!	Terowong lori tinggi tak lepas! is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4851520	3.0795940	\N
546	Kompleks Seni Islam Antarabangsa Selangor	Gallery & cultural center displaying contemporary Islamic art, design objects & Quran manuscripts.	f	4.6	101.5221837	3.0813263	\N
547	Selangor Memorial Monument	Selangor Memorial Monument is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.8	101.5157148	3.0805539	\N
548	Sultan Salahuddin Abdul Aziz Shah Mosque	Large, iconic mosque with a blue stained glass dome, soaring minarets & Malay-style interior.	f	4.8	101.5207975	3.0789952	\N
549	Yayasan Restu	Yayasan Restu is a prominent museum and a must-visit cultural landmark in Selangor.	f	4.6	101.5227281	3.0813109	\N
550	Taman Persahabatan Selangor - Jepun	Taman Persahabatan Selangor - Jepun is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.5223331	3.0764434	\N
551	Shah Alam Royal Mausoleum	Shah Alam Royal Mausoleum is a recognized monument located in Selangor, Malaysia, attracting many visitors.	f	4.8	101.5184756	3.0827375	\N
552	Shah Alam Art Gallery	Diverse exhibitions & events are showcased at this lakefront art space with wooden architecture.	f	4.2	101.5149603	3.0728145	\N
553	Selangor - Japan Friendship Garden	Selangor - Japan Friendship Garden is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.5219921	3.0767186	\N
554	仙境古城太和殿 Fairy Park Heritage City The Grand Ballroom	Fairy Park Heritage City The Grand Ballroom is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.4641774	3.1393534	\N
555	Trio Border Shah Alam-Petaling Jaya-Subang Jaya	Trio Border Shah Alam-Petaling Jaya-Subang Jaya is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5901018	3.0858905	\N
556	Bukit Jelutong Eco Community Park	Bukit Jelutong Eco Community Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.8	101.5215321	3.1170443	\N
557	Shah Alam Wetland Park	Shah Alam Wetland Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.5175919	3.0927510	\N
558	Shah Alam Community Forest Trail	Departure point for rugged, challenging trails leading through dense rainforest to lakes & peaks.	f	4.4	101.4765601	3.1214682	\N
559	Setia Alam Wetland	Setia Alam Wetland is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.4564878	3.1274107	\N
560	Shah Alam Lake Garden (West)	Sizable, popular park featuring a jogging track, scenic lake & kayak rentals, plus a playground.	f	4.5	101.5131820	3.0721667	\N
561	Permai Recreational Park	Permai Recreational Park is a prominent park and a must-visit cultural landmark in Selangor.	f	4.4	101.5152463	3.0716411	\N
562	Shah Alam Backyard Trail	Shah Alam Backyard Trail is a recognized sports activity location located in Selangor, Malaysia, attracting many visitors.	f	4.5	101.4869367	3.1003244	\N
563	Taman Tasik Alam Impian	Taman Tasik Alam Impian is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.5131361	3.0223552	\N
564	Peak Garden Setia Alam Trail	Peak Garden Setia Alam Trail is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.5	101.4770856	3.1214768	\N
565	Maya Park, Eco Ardence	Maya Park, Eco Ardence is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.4800712	3.0961621	\N
566	Denai Alam Recreational Park	Denai Alam Recreational Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.9	101.5159929	3.1607122	\N
567	Forest Park Hillpark	Forest Park Hillpark is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.4621295	3.2094827	\N
568	Kuala Selangor Nature Park	Mangrove forest & wetland park with hiking trails & observation platforms for wildlife viewing.	f	4.1	101.2448050	3.3390018	\N
569	Eco Ardence Crest Park	Eco Ardence Crest Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.7	101.4782251	3.0875507	\N
570	FunPark Gamuda Luge Gardens	FunPark Gamuda Luge Gardens is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.5525158	3.2747256	\N
571	WaterWorld i-City	WaterWorld i-City is a beautiful water park, offering a relaxing outdoor and nature experience for visitors.	f	3.8	101.4853066	3.0648486	\N
572	i-City Theme Park	Digitally integrated development with shops, hotels, a mall, ice sculptures & an amusement park.	f	4.2	101.4822713	3.0647235	\N
573	Fun Fun i-City	Fun Fun i-City is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.4829698	3.0648044	\N
574	Arabesq Restaurant Shah Alam	Arabesq Restaurant Shah Alam is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.9	101.4851650	3.0747813	dinner
575	Al-Sultan Restaurant - Glenmarie	Al-Sultan Restaurant - Glenmarie is a popular dining spot in Selangor, well-known for its excellent middle eastern restaurant.	t	4.8	101.5780818	3.0886320	dinner
576	Murni Discovery ? Shah Alam	Murni Discovery ? Shah Alam is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.0	101.4878933	3.0635460	dinner
577	Platform19 Shah Alam	Platform19 Shah Alam is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.5260576	3.0553830	dinner
578	South Sea Seafood	Spacious, upmarket seafood restaurant featuring diverse dishes sourced from on-site aquarium tanks.	t	4.3	101.5468694	3.1406407	dinner
579	Makan Kitchen	Makan Kitchen is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.5	101.4833120	3.0633152	dinner
580	Homst Shah Alam (Chinese Muslim Restaurant)	Homst Shah Alam (Chinese Muslim Restaurant) is a popular dining spot in Selangor, well-known for its excellent halal restaurant.	t	4.2	101.5496749	3.0761442	dinner
581	Shellambak Shah Alam	Shellambak Shah Alam is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.7	101.4967520	3.0750050	dinner
582	Smoked Kingdom by Don Daniyal	Smoked Kingdom by Don Daniyal is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.5242526	3.0705524	dinner
583	Craveat	Craveat is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.5	101.5140626	3.0161510	dinner
584	The Humble Food Company Shah Alam	The Humble Food Company Shah Alam is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.6	101.5458784	3.0894101	dinner
585	Mohd Chan Chinese Muslim Restaurant @ Shah Alam Seksyen 15	Mohd Chan Chinese Muslim Restaurant @ Shah Alam Seksyen 15 is a popular dining spot in Selangor, well-known for its excellent halal restaurant.	t	4.7	101.5389543	3.0643841	dinner
586	TheFOODtree Restaurant, Glenmarie	TheFOODtree Restaurant, Glenmarie is a popular dining spot in Selangor, well-known for its excellent breakfast restaurant.	t	4.4	101.5734483	3.0865581	breakfast, dinner
587	Moon’s Kitchen (Shah Alam)	Moon’s Kitchen (Shah Alam) is a popular dining spot in Selangor, well-known for its excellent steak house.	t	4.6	101.5265676	3.0839367	dinner
588	One Serambi Cafe	One Serambi Cafe is a popular dining spot in Selangor, well-known for its excellent cafe.	t	4.4	101.5282087	3.1033785	breakfast, dinner
589	Al-Rawsha Restaurant Seksyen 7	Al-Rawsha Restaurant Seksyen 7 is a popular dining spot in Selangor, well-known for its excellent middle eastern restaurant.	t	4.4	101.4926090	3.0809200	dinner
590	Dapur Darling	Dapur Darling is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.5261333	3.0842582	dinner
591	Ombak Kitchen Bukit Jelutong	Ombak Kitchen Bukit Jelutong is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.7	101.5364946	3.0976188	dinner
592	Mohd Chan Chinese Muslim Restaurant @ Glenmarie	Mohd Chan Chinese Muslim Restaurant @ Glenmarie is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.5784864	3.0874174	dinner
593	Cozy Escape Restaurant	Cozy Escape Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.6	101.5513251	3.0756298	dinner
594	Sunway Lagoon	Sprawling amusement park with a water zone, rides, a zoo & outdoor activities, plus dining & events.	f	4.5	101.6067533	3.0693932	\N
595	Petaling Jaya Museum	Petaling Jaya Museum is a prominent museum and a must-visit cultural landmark in Selangor.	f	4.1	101.6502808	3.1049123	\N
596	Central Park Bandar Utama	Central Park Bandar Utama is a prominent park and a must-visit cultural landmark in Selangor.	f	4.1	101.6142757	3.1494069	\N
597	Taman Aman Park	Taman Aman Park is a prominent park and a must-visit cultural landmark in Selangor.	f	4.4	101.6264329	3.1020340	\N
598	Sembang PJ Art Lane	Sembang PJ Art Lane is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.0	101.6445865	3.0992800	\N
599	Art Lane @ PJ State	Art Lane @ PJ State is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6449519	3.0985174	\N
600	PJ Street Art Lane	PJ Street Art Lane is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.9	101.6454701	3.0985126	\N
601	Laman MBPJ	Laman MBPJ is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.6444188	3.0978525	\N
602	KidZania Kuala Lumpur	Sprawling children's theme park offering immersive career role-play, from firefighter to surgeon.	f	4.6	101.6138072	3.1580958	\N
603	Taman Bandaran Kelana Jaya	Taman Bandaran Kelana Jaya is a prominent park and a must-visit cultural landmark in Selangor.	f	4.2	101.5952469	3.0986741	\N
604	Secret Garden ? 1 Utama	Secret Garden ? 1 Utama is a prominent garden and a must-visit cultural landmark in Selangor.	f	4.6	101.6158842	3.1503631	\N
605	malaysiakliatour	malaysiakliatour is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	101.6167606	3.1268353	\N
606	Creative PJ Section 52 Mural Art Street	Creative PJ Section 52 Mural Art Street is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	2.5	101.6457559	3.1006272	\N
607	KMI KELANA JAYA	KMI KELANA JAYA is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6025329	3.0992856	\N
608	Jump Street Asia (Kuala Lumpur)	Jump Street Asia (Kuala Lumpur) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.6340370	3.1171708	\N
609	The Curve Water Fountain	The Curve Water Fountain is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.6100743	3.1571922	\N
610	Forgiveness Mural	Forgiveness Mural is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.6204343	3.1187306	\N
611	Taman Aman Park	Taman Aman Park is a prominent park and a must-visit cultural landmark in Selangor.	f	4.4	101.6245960	3.1035760	\N
612	Thai Buddhist Chetawan Pagoda	Large, ornate Buddhist temple complex with traditional Thai architecture & popular festivals.	f	4.7	101.6518796	3.1025515	\N
613	Oasis Piazza	Oasis Piazza is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.7	101.5746673	3.1142632	\N
614	Malaysia’s Smallest Roundabout ??	Malaysia’s Smallest Roundabout is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6273687	3.0947047	\N
615	Koridor Sejarah 新村历史文物馆	Koridor Sejarah is a recognized museum located in Selangor, Malaysia, attracting many visitors.	f	4.7	101.6207996	3.0866023	\N
616	Monumen Kampung Tunku	Monumen Kampung Tunku is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.0	101.6199665	3.0991729	\N
617	The Abandoned House	The Abandoned House is a recognized event venue located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.6598460	3.0990520	\N
618	Istana Negara	An iconic landmark, this grand royal palace with golden domes is a popular place to take photos.	f	4.3	101.6634404	3.1614817	\N
619	Istana Sate	Istana Sate is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6277177	3.0976607	\N
620	Petronas Twin Towers	Once the world's tallest, these 88-story towers bear a modern Islamic design & a visitor skybridge.	f	4.7	101.7115639	3.1574693	\N
621	Bangunan Sultan Abdul Samad	Grand 1800s government building featuring copper domes & a large clocktower with a 1-ton bell.	f	4.7	101.6944582	3.1487179	\N
622	Menara Kuala Lumpur	One of the world's tallest, this landmark tower offers scenic city views & a revolving restaurant.	t	4.5	101.7038516	3.1528762	dinner
623	Seksyen 52@PJ	Seksyen 52@PJ is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6445871	3.1001461	\N
624	Merdeka Square	This landmark square has a 95m flagpole to mark the site of the first Malayan flag-raising.	f	4.5	101.6936592	3.1490605	\N
625	Rumah Penghulu Abu Seman (The Penghulu Abu Seman House)	Restored, traditional wooden Malay house, built in a Kedah village in the early 20th century.	f	4.5	101.7164636	3.1502709	\N
626	Istana Bandar	Istana Bandar is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.2	101.4412593	2.8596709	\N
627	Tangga APV	Tangga APV is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6337435	3.1162198	\N
628	Taman Jaya Park	Taman Jaya Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.6502329	3.1044946	\N
629	Hutan Pendidikan Bukit Gasing	Nature reserve with a popular network of forest trails & a suspension bridge, plus wild monkeys.	f	4.5	101.6588889	3.0955556	\N
630	Kota Damansara Community Forest Reserve	Lowland forest area on 800 acres, community-managed to conserve the urban-adjacent natural space.	f	4.3	101.5809490	3.1691460	\N
631	Subang Ria Recreational Park	Scenic green space with trees, benches & 3 lakes, plus pathways for walking & running.	f	4.2	101.5976307	3.0813678	\N
632	Kerinchi Hill Forest Park	Kerinchi Hill Forest Park is a prominent park and a must-visit cultural landmark in Selangor.	f	4.5	101.6615608	3.0968742	\N
633	Bukit Gasing Hiking Trail	Bukit Gasing Hiking Trail is a beautiful hiking area, offering a relaxing outdoor and nature experience for visitors.	f	4.7	101.6561508	3.0951521	\N
634	Ara Damansara Park	Ara Damansara Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.9	101.5848521	3.1204258	\N
635	Hutan Simpan Kota Damansara	Hutan Simpan Kota Damansara is a beautiful nature preserve, offering a relaxing outdoor and nature experience for visitors.	f	4.7	101.5998472	3.1776447	\N
636	Tropicana Park	Tropicana Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.5947849	3.1325033	\N
637	Taman Rimba Riang	Taman Rimba Riang is a prominent park and a must-visit cultural landmark in Selangor.	f	4.2	101.5836411	3.1814325	\N
638	TTDI Park	TTDI Park is a prominent park and a must-visit cultural landmark in Selangor.	f	4.5	101.6319335	3.1472949	\N
639	Taman Rimba Kiara	Photography, picnics & walks are popular in this serene jungle park, home to 40+ bird species.	f	4.3	101.6330463	3.1394920	\N
640	Tasik Kelana Jaya	Tasik Kelana Jaya is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.5961682	3.0992625	\N
641	Section 17 Neighbourhood Park	Section 17 Neighbourhood Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.6383100	3.1276160	\N
642	Bukit Jalil Recreational Park	Low-key, 80-acre park with jogging trails, picnic & playground areas & an international garden.	f	4.4	101.6755556	3.0522222	\N
643	Perdana Botanical Garden	Botanical gardens featuring tropical plants & rare fruit trees, plus a fish pond, waterfall & cafe.	f	4.5	101.6837917	3.1435203	\N
644	99 Wonderland Park	99 Wonderland Park is a prominent amusement park and a must-visit cultural landmark in Selangor.	f	4.1	101.6644931	3.2364583	\N
645	Starship Galatica	Starship Galatica is a recognized indoor playground located in Selangor, Malaysia, attracting many visitors.	f	4.3	101.6155514	3.1511544	\N
646	Farm In The City	Visitors can pet & feed many animals at this popular zoo with various habitats & a souvenir shop.	f	4.3	101.6616563	2.9801264	\N
647	Dataran Petaling Jaya	Dataran Petaling Jaya is a popular dining spot in Selangor, well-known for its excellent butcher shop.	t	4.0	101.6469509	3.1026879	dinner, lunch, dinner
648	Rainforest @ 1 Utama	Rainforest @ 1 Utama is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.6161770	3.1501770	\N
649	Secret Garden Putrajaya	Secret Garden Putrajaya is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.6990085	2.9422417	\N
650	VroomTown? Malaysia	VroomTown? Malaysia is a recognized playground located in Selangor, Malaysia, attracting many visitors.	f	4.7	101.6170779	3.1278949	\N
651	Village Park Restaurant	Village Park Restaurant is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.3	101.6233261	3.1376947	dinner
652	Little Heritage House	Little Heritage House is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.5	101.6379966	3.1265070	dinner
653	Bayleaf Kitchen Restaurant | Petaling Jaya	Bayleaf Kitchen Restaurant | Petaling Jaya is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	4.6	101.6457576	3.1000560	dinner
654	Restoran Green View Sdn Bhd	Restoran Green View Sdn Bhd is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.2	101.6290053	3.1178279	dinner
655	Table & Apron	Table & Apron is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.5	101.6264229	3.1346010	dinner
656	Strangers at 47	Strangers at 47 is a popular dining spot in Selangor, well-known for its excellent cafe.	t	4.5	101.6299577	3.1202499	breakfast, lunch, dinner
657	Tasty Chapathi Restaurant | PJ | Restoran Tasty Chapathi	Tasty Chapathi Restaurant | PJ | Restoran Tasty Chapathi is a popular dining spot in Selangor, well-known for its excellent north indian restaurant.	t	4.4	101.6321460	3.1113074	dinner
658	Kompassion	Kompassion is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	4.3	101.6258492	3.1346080	dinner
659	India Gate Restaurant ? Petaling Jaya	India Gate Restaurant ? Petaling Jaya is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	4.9	101.6415374	3.1006503	dinner
660	Out of Africa Restaurant & Kudu Bar	Out of Africa Restaurant & Kudu Bar is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.6464315	3.1014267	dinner
661	Piccadilly Restaurant	Southern cafeteria chain dishing up American comfort classics in a simple, family-friendly setting.	t	4.1	101.6347922	3.1051752	dinner
662	Farm To Plate	Farm To Plate is a popular dining spot in Selangor, well-known for its excellent salad shop.	t	4.3	101.6289980	3.1363750	dinner, lunch
663	Meng Kee Restaurant	Meng Kee Restaurant is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.4	101.5999748	3.1131268	dinner
664	Rafw Restaurant	Rafw Restaurant is a popular dining spot in Selangor, well-known for its excellent fine dining restaurant.	t	4.7	101.5955258	3.1515109	dinner
665	Serai Imago Jaya	Serai Imago Jaya is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.6	101.6371808	3.1091890	dinner
666	Fatty Crab Restaurant	Fatty Crab Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.6124566	3.1148277	dinner
667	Hee Lai Ton Restaurant	Hee Lai Ton Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.6390138	3.1112596	dinner
668	Kanna Curry House Restaurant	Kanna Curry House Restaurant is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	4.0	101.6298809	3.1197956	dinner
669	B.LAND PJ	B.LAND PJ is a popular dining spot in Selangor, well-known for its excellent food court.	t	4.2	101.6320768	3.0947440	dinner
670	Kam Heong Braised Duck @ Kam Heong Coffee Shop	Kam Heong Braised Duck @ Kam Heong Coffee Shop is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.0	101.6444330	3.0992783	dinner
671	Subang	Subang is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.6024829	3.0683743	\N
672	Big Bonsai Tree USJ	Big Bonsai Tree USJ is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.5750063	3.0382608	\N
673	Sunway Lagoon Main Entrance Parking	Sunway Lagoon Main Entrance Parking is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.0	101.6055019	3.0717157	\N
674	Bungy Jump @ Sunway Lagoon	Bungy Jump @ Sunway Lagoon is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.6080980	3.0687853	\N
675	Sunway South Quay Lake Yacht	Sunway South Quay Lake Yacht is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6024156	3.0623557	\N
676	Taman Rekreasi	Taman Rekreasi is a prominent park and a must-visit cultural landmark in Selangor.	f	4.3	101.5871406	3.0535651	\N
677	Millennium Park, SS13	Millennium Park, SS13 is a prominent park and a must-visit cultural landmark in Selangor.	f	3.5	101.5937224	3.0727335	\N
678	Nickelodeon Lost Lagoon at Sunway Lagoon	Family-friendly water park with thrill rides, water slides & splash playgrounds in a cartoon theme.	f	4.5	101.6064673	3.0673108	\N
679	Taman Rekreasi USJ 2	Taman Rekreasi USJ 2 is a beautiful city park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.5898225	3.0610077	\N
680	USJ 11/1 Park	USJ 11/1 Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.5790977	3.0431507	\N
681	USJ Urban Forest Park	USJ Urban Forest Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.5709034	3.0547304	\N
682	USJ 3D Park	USJ 3D Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.9	101.5717916	3.0622597	\N
683	god ?? stairs	god ?? stairs is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5911209	3.0570890	\N
684	Aluba Corner	Aluba Corner is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6024726	3.0715122	\N
685	tempat letupan gas putra heights	tempat letupan gas putra heights is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.5825959	3.0058751	\N
686	Taman Rekreasi Hutan Bandar MPSJ	Taman Rekreasi Hutan Bandar MPSJ is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.5710210	3.0551847	\N
687	PARC	PARC is a recognized community center located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.6007702	3.0819280	\N
688	Putra Heights Linear Park South Recreational Park	Putra Heights Linear Park South Recreational Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.5776553	2.9990887	\N
689	Tropicana Metropark Urban Park	Tropicana Metropark Urban Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.5	101.5649886	3.0720612	\N
690	Promenade, Central Park at Tropicana Metropark	Promenade, Central Park at Tropicana Metropark is a beautiful city park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.5648464	3.0707324	\N
691	Putra Heights Section 2 Jogging Park	Putra Heights Section 2 Jogging Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.5748768	3.0204315	\N
692	USJ17 Park	USJ17 Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	5.0	101.5785719	3.0330920	\N
693	Taman Saujana Hijau Putrajaya	This expansive park with themed gardens & sweeping views is a popular place for running & cycling.	f	4.7	101.6756394	2.9612403	\N
694	SS19/1G Park	SS19/1G Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.5775175	3.0771545	\N
695	USJ 9/3D Park	USJ 9/3D Park is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.5847839	3.0433211	\N
696	SS 18 Recreation Park	SS 18 Recreation Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.5849850	3.0728990	\N
697	Fun X World	Fun X World is a beautiful indoor playground, offering a relaxing outdoor and nature experience for visitors.	f	4.7	101.5935600	3.0599489	\N
698	Sky Park @ One City USJ	Sky Park @ One City USJ is a bustling gym, perfect for shopping, dining, and local experiences.	f	3.8	101.5803680	3.0221586	\N
699	Subang Parade	Sprawling, enduring complex of over 200 shops, plus casual eateries, cafes & a cinema.	f	4.0	101.5845738	3.0812316	\N
700	Gamuda Cove	Gamuda Cove is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.6220905	2.8843818	\N
701	NU Empire	Vibrant shopping mall offering global brands, beauty & health services & international eateries.	f	4.0	101.5828038	3.0817783	\N
702	Monsoon 360	Monsoon 360 is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.6076763	3.0680086	\N
703	SplashMania WaterPark	SplashMania WaterPark is a beautiful water park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.6164166	2.8888213	\N
704	Waterplexx 5D	Waterplexx 5D is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.6066647	3.0705329	\N
705	RATA Restaurant	RATA Restaurant is a popular dining spot in Selangor, well-known for its excellent asian fusion restaurant.	t	4.6	101.5926655	3.0795907	dinner
706	JIBRIL SS15	Funky cafe showcasing meat & seafood offerings with salted egg sauce, plus steak, pasta & mocktails.	t	4.7	101.5872806	3.0757760	dinner, lunch
707	Jibby & Co	Jibby & Co is a popular dining spot in Selangor, well-known for its excellent asian fusion restaurant.	t	4.4	101.5822828	3.0814053	breakfast, dinner
708	Three Plates Full	Three Plates Full is a popular dining spot in Selangor, well-known for its excellent wine bar.	t	4.5	101.5878349	3.0777383	dinner
709	La Cocina Sky View	La Cocina Sky View is a popular dining spot in Selangor, well-known for its excellent spanish restaurant.	t	4.3	101.5859503	3.0480127	dinner
710	Rinjin Shokudo @ Subang Jaya	Rinjin Shokudo @ Subang Jaya is a popular dining spot in Selangor, well-known for its excellent japanese restaurant.	t	4.8	101.5952875	3.0696196	dinner
711	Ole-Ole Bali	Ole-Ole Bali is a popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	4.3	101.5828038	3.0817783	dinner
712	Hakshan USJ Taipan	Hakshan USJ Taipan is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.5849923	3.0472378	dinner
713	Padi House Subang Parade	Padi House Subang Parade is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.5865773	3.0823963	dinner
714	Mu'sier Fine Meat & Steak	Mu'sier Fine Meat & Steak is a popular dining spot in Selangor, well-known for its excellent steak house.	t	4.3	101.5948707	3.0575378	dinner
715	Lalezar Restaurant @ USJ Heights	Lalezar Restaurant @ USJ Heights is a popular dining spot in Selangor, well-known for its excellent turkish restaurant.	t	4.7	101.5681179	3.0619175	dinner
716	Logenhaus Roast & Grill	Logenhaus Roast & Grill is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	3.9	101.5842509	3.0496747	dinner
717	Boleros Restaurant	Boleros Restaurant is a popular dining spot in Selangor, well-known for its excellent fusion restaurant.	t	4.8	101.5926752	3.0794514	dinner
718	Serai @ NU Empire	Serai @ NU Empire is a popular dining spot in Selangor, well-known for its excellent asian fusion restaurant.	t	4.6	101.5825902	3.0819266	dinner
719	Masala Grill Cuisine ? Subang Jaya	Masala Grill Cuisine ? Subang Jaya is a popular dining spot in Selangor, well-known for its excellent north indian restaurant.	t	4.8	101.5864008	3.0683176	dinner
720	Big Singh Chapati	Big Singh Chapati is a popular dining spot in Selangor, well-known for its excellent north indian restaurant.	t	4.7	101.5926522	3.0801375	dinner
721	FOWLBOYS SS15	FOWLBOYS SS15 is a popular dining spot in Selangor, well-known for its excellent american restaurant.	t	4.8	101.5876956	3.0759617	dinner
722	Murni Discovery USJ 9	Murni Discovery USJ 9 is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.0	101.5874987	3.0469426	dinner
723	Pasta Ohsem & Purple Monkey Subang Jaya SS15	Pasta Ohsem & Purple Monkey Subang Jaya SS15 is a popular dining spot in Selangor, well-known for its excellent cake shop.	t	4.7	101.5878226	3.0815784	dinner, lunch
724	Lao Jia Xiao Guan Restaurant	Lao Jia Xiao Guan Restaurant is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.7	101.5892250	3.0726860	dinner
725	Taman Awam Pangkalan Batu	Small riverfront park with landscaped gardens, a pond & a pavilion for community events.	f	4.2	101.4429051	3.0473120	\N
726	Kota Bridge	Kota Bridge is a prominent bridge and a must-visit cultural landmark in Selangor.	f	4.2	101.4466719	3.0458375	\N
727	Tapak POSITIF@GM KLANG (Food Truck)	Tapak POSITIF@GM KLANG (Food Truck) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.4	101.4486647	2.9898462	\N
728	Sultan Abdul Aziz Royal Gallery	Royal gallery of art housed in the elegant Sultan Suleiman Building, which was built in 1909.	f	4.5	101.4491882	3.0413230	\N
729	Rumah Papan Pandamaran	Rumah Papan Pandamaran is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	t	4.8	101.4181209	3.0114117	dinner, lunch, dinner
730	巴生壁画	A prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.0	101.4482255	3.0415656	\N
731	Klang Art Street (Safari Jejak Warisan)	Klang Art Street (Safari Jejak Warisan) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.4483412	3.0415480	\N
732	Tanjung Harapan	Tanjung Harapan is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.3602884	3.0103529	\N
733	Jalan-jalan Klang (巴生历史户外学堂)	Jalan-jalan Klang is a prominent tour agency and a must-visit cultural landmark in Selangor.	f	4.9	101.4496135	3.0427378	\N
734	PERSATUAN PENYOKONG RUMAH BERHALA KWAN IMM KLANG	Colorful pagoda-style place of worship with traditional stone carvings & Buddhist services.	f	4.6	101.4424898	3.0375624	\N
735	Pondok Misteri	Pondok Misteri is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.4494420	3.0224978	\N
736	Sri Nagara Thandayuthapani Temple	Sri Nagara Thandayuthapani Temple is a prominent hindu temple and a must-visit cultural landmark in Selangor.	f	4.5	101.4455304	3.0424500	\N
737	Jempol	Jempol is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.4487104	3.0180591	\N
738	Flying Crow Street Art	Flying Crow Street Art is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.4483866	3.0427529	\N
739	Port Klang Mural Wall Art (The Workman with a Hard Hat) by Judith de Leeuw	Port Klang Mural Wall Art (The Workman with a Hard Hat) by Judith de Leeuw is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.3967831	3.0017376	\N
740	Landmark Kg. Sungai Udang	Landmark Kg. Sungai Udang is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.4260679	3.0423867	\N
741	Klang Heritage Art deco	Klang Heritage Art deco is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.4484216	3.0427702	\N
742	Jetty Bagan Hailam	Jetty Bagan Hailam is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.9	101.3863606	3.0039653	\N
743	Cultural Village Projek SMG	Cultural Village Projek SMG is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.4347394	3.0551028	\N
744	Klang Little India (???????? ???????? ???????)	Klang Little India (???????? ???????? ???????) is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.4471122	3.0408419	\N
745	Klang The Seine river of Malaysia	Klang The Seine river of Malaysia is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4449590	3.0470522	\N
746	Tugu Keris ???? ????	Tugu Keris ???? ???? is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.0	101.4443877	3.0364516	\N
747	The Crown Of Klang	The Crown Of Klang is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.3	101.4257179	3.0977775	\N
748	Tiang Palang kasi buka gilerr	Tiang Palang kasi buka gilerr is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4850078	3.0105903	\N
749	Istana Kenangan	No official description.	f	4.4	101.4702447	3.0301743	\N
750	Gedung Raja Abdullah ???? ??? ???????	Hulking, 19th-century heritage structure known for its advanced age & traditional architecture.	f	3.8	101.4475321	3.0435164	\N
751	0 km Klang	No official description.	f	4.7	101.4491810	3.0418770	\N
752	Waguri kaoruko	Waguri kaoruko is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.9	101.4604096	3.0655060	\N
753	Sri Sundararaja Perumal Temple, Klang - Malaysia	Sri Sundararaja Perumal Temple, Klang - Malaysia is a prominent hindu temple and a must-visit cultural landmark in Selangor.	f	4.7	101.4376565	3.0337185	\N
754	Jalan Kastam,Perlabuhan Klang,Selangor	Jalan Kastam,Perlabuhan Klang,Selangor is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.4037858	3.0072284	\N
755	Canary Garden Central Park	Canary Garden Central Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.4668532	2.9593636	\N
756	Taman Rakyat	Taman Rakyat is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.4497445	3.0203420	\N
757	Lakepark @ Gravit8 Klang South	Lakepark @ Gravit8 Klang South is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.4422510	2.9815449	\N
758	Bandar Botanic Lake Park	Bandar Botanic Lake Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.6	101.4633922	2.9962534	\N
759	Parklands City People's Park	Parklands City People's Park is a prominent park and a must-visit cultural landmark in Selangor.	f	4.0	101.4554002	2.9690977	\N
760	Butterfly Park	Butterfly Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.8	101.4371150	2.9979260	\N
761	Bandar Bukit Raja Town Park	Bandar Bukit Raja Town Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.4255898	3.0961672	\N
762	Ijan's Corner	Green space with trails, exercise stations & fitness classes such as tai chi & Zumba on weekends.	t	4.2	101.4493709	3.0195637	dinner, lunch, dinner
763	Tasik Bandar Bukit Raja	Tasik Bandar Bukit Raja is a recognized sports activity location located in Selangor, Malaysia, attracting many visitors.	f	4.1	101.4344388	3.0894500	\N
764	Padang Laman Seni Safari Jejak Warisan Klang	Padang Laman Seni Safari Jejak Warisan Klang is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.4487336	3.0414157	\N
765	Sungai Lima.Pulau Ketam Eco Tour	Sungai Lima.Pulau Ketam Eco Tour is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.5	101.2792840	3.0391096	\N
766	Bukit Jugra Lighthouse	Bukit Jugra Lighthouse is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.4	101.4175198	2.8357026	\N
767	Batu Caves	Limestone caves at the top of steep steps housing Hindu temples & shrines, plus a huge deity statue.	f	4.4	101.6840385	3.2378844	\N
768	Setia Bayuemas Lake Park	Setia Bayuemas Lake Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.7	101.4399142	2.9783644	\N
769	G Glasshouse at Klang	G Glasshouse at Klang is a recognized event venue located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.4487323	3.0514619	\N
770	Chola Kitchen Restaurant	Chola Kitchen Restaurant is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.6	101.4460502	2.9958852	dinner
771	Teluk Pulai Bak Kut Teh	Teluk Pulai Bak Kut Teh is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.2	101.4742390	3.0563519	dinner
772	SORA	SORA is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.4672324	2.9575602	dinner
773	Gem Restaurant, Klang	Gem Restaurant, Klang is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.3	101.4462358	2.9945050	dinner
774	Restoran Windmill ? Bandar Baru Klang	Restoran Windmill ? Bandar Baru Klang is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.4	101.4696182	3.0639979	dinner
775	Restoran Moden Cuisine	Restoran Moden Cuisine is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.6	101.4547229	2.9883121	dinner
776	Bayleaf Kitchen Restaurant - Klang	Bayleaf Kitchen Restaurant - Klang is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.2	101.4482471	3.0405322	dinner
777	Seni Sattisorru Klang Branch	Seni Sattisorru Klang Branch is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.4488531	3.0401542	dinner
778	Nyonya Kitchen & Caterers Sdn Bhd	Nyonya Kitchen & Caterers Sdn Bhd is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.2	101.4305717	3.0157805	dinner
779	Feng Ling Kitchen - Klang	Feng Ling Kitchen - Klang is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.3	101.4453880	2.9972890	dinner
780	India Gate Restaurant @Klang	India Gate Restaurant @Klang is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.9	101.4518040	2.9884435	dinner
781	Hao Xiang Chi Seafood Restaurant | Meru Klang 好想吃海鲜大酒楼	Hao Xiang Chi Seafood Restaurant | Meru Klang is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.7	101.4496074	3.0519763	dinner
782	MOONLIGHT RESTAURANT & LOUNGE	MOONLIGHT RESTAURANT & LOUNGE is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.7	101.4628554	3.0528328	dinner
783	Teochew Nang Cafeteria (CL)	Teochew Nang Cafeteria (CL) is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.7	101.4521313	3.0410277	dinner
784	Uncle Don's (Klang)	Uncle Don's (Klang) is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.6	101.4316026	3.0137402	dinner
785	Kaara Saaram Claypot Klang	Kaara Saaram Claypot Klang is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.4489245	3.0399405	dinner
786	Garam Masala North Indian Restaurant	Garam Masala North Indian Restaurant is a popular dining spot in Selangor, well-known for its excellent north indian restaurant.	t	4.3	101.4387740	3.0078115	dinner
787	巴生伸波士�D餐室 Restoran Boston Baru Klang	Restoran Boston Baru Klang is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	3.9	101.4479207	3.0502964	dinner
788	Cas & Stan Cafe	Cas & Stan Cafe is a popular dining spot in Selangor, well-known for its excellent asian fusion restaurant.	t	4.4	101.4450945	2.9992460	dinner
789	Restoran Perlama Seafood	Restoran Perlama Seafood is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	3.8	101.3995251	2.9903168	dinner
790	Kajang Heritage Centre	Kajang Heritage Centre is a prominent museum and a must-visit cultural landmark in Selangor.	f	4.1	101.7866747	2.9919606	\N
791	Bangi Wonderland	Water park with slides, a swimming pool & thrill rides, plus a play area for kids & snack kiosks.	f	4.1	101.7909278	2.9046671	\N
792	Kajang Once Upon A Time Walk	Kajang Once Upon A Time Walk is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.8	101.7879834	2.9915054	\N
793	Kajang Dulu Dulu Mural Art	Kajang Dulu Dulu Mural Art is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.1	101.7879213	2.9914827	\N
794	TTDI Grove	TTDI Grove is a prominent park and a must-visit cultural landmark in Selangor.	f	3.9	101.8084679	2.9965549	\N
795	Jalan Mehmed	Jalan Mehmed is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.7878530	2.9704504	\N
796	CP 1	CP 1 is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.8117197	2.9962027	\N
797	SimpangWhy	SimpangWhy is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.7337914	2.8957868	\N
798	Low’s Dusun	Low’s Dusun is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.8073409	2.8960771	\N
799	Hall Sri Jenaris	Hall Sri Jenaris is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.8014444	3.0123001	\N
800	Traffic Light Merah Lama	Traffic Light Merah Lama is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.7865400	2.9932145	\N
801	MRT Stadium Kajang (KG34) GATE B	MRT Stadium Kajang (KG34) GATE B is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.5	101.7860696	2.9929103	\N
802	Bomboclat Avenue	Bomboclat Avenue is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.7930447	3.0397752	\N
803	Canal Park	Canal Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.8011608	2.9269828	\N
804	Amos Development Sdn Bhd	Amos Development Sdn Bhd is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.7991710	3.0112290	\N
805	Taman Rekreasi Sungai Chua	Taman Rekreasi Sungai Chua is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.7750488	2.9932990	\N
806	Sunset View Point Eco Majestic	Sunset View Point Eco Majestic is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	3.9	101.8403636	2.9026850	\N
807	Lovely Oyen	Lovely Oyen is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.7918662	2.9904939	\N
808	Origami Park	Origami Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.5	101.7580504	2.9924129	\N
809	Energy Bagua	Energy Bagua is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.7	101.7834042	2.9904721	\N
810	Sungai Tangkas	Sungai Tangkas is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.7654375	2.9059375	\N
811	Rumah Biru	Rumah Biru is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.7512513	2.9416501	\N
812	PINTU??GERBANG KAMPUNG SEMENYIH	PINTU GERBANG KAMPUNG SEMENYIH is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.8461981	2.9505378	\N
813	Replika Gong Universiti Kebangsaan Malaysia	Replika Gong Universiti Kebangsaan Malaysia is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.8	101.7780066	2.9298578	\N
814	POKOK LA APA LAGI	POKOK LA APA LAGI is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.7968018	2.9855406	\N
815	Gambang paha	Gambang paha is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.8068548	2.8774040	\N
816	Port patin	Port patin is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.7036957	2.8907400	\N
817	Bangi Landmark	Bangi Landmark is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	2.6	101.7629930	2.9335301	\N
818	Bulatan Desa Pinggiran Putra	Bulatan Desa Pinggiran Putra is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.2	101.7015700	2.8957567	\N
819	Ancestral Home of Lembang	Ancestral Home of Lembang is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.0	101.8365292	2.9383565	\N
821	Start Of South Klang Valley Expy	Start Of South Klang Valley Expy is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.7517840	2.9817929	\N
822	Pangkin ManJa's	Pangkin ManJa's is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.7476964	3.0491348	\N
823	Mercu Tanda Putrajaya, Laman Perdana	Mercu Tanda Putrajaya, Laman Perdana is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.6	101.6975546	2.9408690	\N
824	Galeri Warisan KAJANG 加影人文�^	Galeri Warisan KAJANG is a recognized museum located in Selangor, Malaysia, attracting many visitors.	f	5.0	101.7867295	2.9918733	\N
825	Jambatan pail	Jambatan pail is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.7	101.6966874	2.8930029	\N
826	UIS Susur Gajah	UIS Susur Gajah is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.7859037	2.8913045	\N
827	Sungai Long Hill	Sungai Long Hill is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.8175515	3.0553697	\N
828	Kajang Hill	Kajang Hill is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.1	101.8094610	2.9775920	\N
829	Bukit Kajang Perdana	Bukit Kajang Perdana is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.8286193	2.9975321	\N
830	Tropicana Heights Central Park	Tropicana Heights Central Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.8112304	2.9642368	\N
831	Setia Ecohill Park	Hilltop park with a kids' playground & 20km of jogging tracks, plus panoramic views of the city.	f	4.4	101.8427819	2.9235735	\N
832	Taman Botani Bangi UKM	Taman Botani Bangi UKM is a prominent park and a must-visit cultural landmark in Selangor.	f	4.5	101.7827528	2.9227424	\N
833	Taman Awam Jalan Timur	Taman Awam Jalan Timur is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.7925324	2.9962524	\N
834	Sungai Long Hiking	Sungai Long Hiking is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.5	101.8107269	3.0557670	\N
835	Oasis Park @ Bandar Puteri Bangi	Oasis Park @ Bandar Puteri Bangi is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.7916480	2.8751730	\N
836	Taman Kajang Utama	Taman Kajang Utama is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.7984252	2.9749258	\N
837	Taman Puncak @Sepang	Taman Puncak @Sepang is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.7625539	2.9073738	\N
838	Oasis Park	Oasis Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	3.8	101.8214614	2.9890525	\N
839	Sungai Long Waterfall	Sungai Long Waterfall is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.8253507	3.0493120	\N
840	Taman Rekreasi Sg Merab	Taman Rekreasi Sg Merab is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.8	101.7521255	2.9400414	\N
841	Broga Hill Park	Broga Hill Park is a prominent hiking area and a must-visit cultural landmark in Selangor.	f	4.4	101.9015444	2.9391113	\N
842	Dino Desert	Dino Desert is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.7	101.8549762	3.0475195	\N
843	WindMill Fun Park	WindMill Fun Park is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.8	101.8549113	2.9238272	\N
844	Safari Escape Playland	Safari Escape Playland is a recognized playground located in Selangor, Malaysia, attracting many visitors.	f	3.3	101.8499713	3.0520434	\N
845	Farmer Village 农德村庄	Farmer Village is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.3	101.8282517	2.9756633	dinner
846	Metro Point Complex	Metro Point Complex is a bustling shopping mall, perfect for shopping, dining, and local experiences.	f	4.0	101.7937220	2.9916367	\N
847	UK Fun Park	UK Fun Park is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.9282911	2.7250828	\N
848	Avenue Kingdom @ Bangi Avenue	Avenue Kingdom @ Bangi Avenue is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.7909783	2.9014466	\N
849	Kajang	Kajang is a recognized locality located in Selangor, Malaysia, attracting many visitors.	f	0.0	101.7877607	2.9933226	\N
850	Kajang Stadium	Kajang Stadium is a recognized stadium located in Selangor, Malaysia, attracting many visitors.	f	4.2	101.7871499	2.9946801	\N
851	Shree Uchi Vinayagar Temple, Off Jalan Bukit, Kajang	Shree Uchi Vinayagar Temple, Off Jalan Bukit, Kajang is a prominent hindu temple and a must-visit cultural landmark in Selangor.	f	4.5	101.7932000	2.9895335	\N
852	Skyline Luge Kuala Lumpur	Skyline Luge Kuala Lumpur is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.5515406	3.2732579	\N
853	Mingmom Chinese Cuisine	Mingmom Chinese Cuisine is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.6	101.7912417	2.9904913	dinner
854	Rumah Makan Cibiuk	Rumah Makan Cibiuk is a popular dining spot in Selangor, well-known for its excellent halal restaurant.	t	4.2	101.7728155	2.9792841	dinner
855	Bhai Biryani ? Kajang	Bhai Biryani ? Kajang is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.6	101.7899794	2.9928289	dinner
856	Meet & Dine	Meet & Dine is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.5	101.7758296	3.0341167	dinner
857	SETALAM? Masakan Kampung - Kajang Utama, Selangor	SETALAM? Masakan Kampung - Kajang Utama, Selangor is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.8	101.7993440	2.9750590	dinner
858	Restoran Sate Kajang Hj Samuri	Restoran Sate Kajang Hj Samuri is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.0	101.7870178	2.9936121	dinner
859	Songkhla Prima Saujana Kajang	Songkhla Prima Saujana Kajang is a popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	4.5	101.8044217	3.0080885	dinner
860	Restoran Satay Putera Kajang	Restoran Satay Putera Kajang is a popular dining spot in Selangor, well-known for its excellent indonesian restaurant.	t	3.9	101.7866201	2.9926224	dinner
861	Arabian House Restaurant - ???? ????? ??????	Arabian House Restaurant - ???? ????? ?????? is a popular dining spot in Selangor, well-known for its excellent shawarma restaurant.	t	4.5	101.7726659	2.9789517	breakfast, dinner
862	The Brew House @ MKH Boulevard, Kajang	The Brew House @ MKH Boulevard, Kajang is a popular dining spot in Selangor, well-known for its excellent family restaurant.	t	4.5	101.7931137	2.9901528	dinner
863	Basil Leaves Restaurant - Kajang	Basil Leaves Restaurant - Kajang is a popular dining spot in Selangor, well-known for its excellent indian restaurant.	t	4.0	101.7959040	2.9773354	dinner
864	Nasi Dulang Daun Pisang Bangi ? Al Mubarakah	Nasi Dulang Daun Pisang Bangi ? Al Mubarakah is a popular dining spot in Selangor, well-known for its excellent malaysian restaurant.	t	4.1	101.7577690	2.9740916	dinner
865	Al Diafah Restaurant - Kajang	Al Diafah Restaurant - Kajang is a popular dining spot in Selangor, well-known for its excellent middle eastern restaurant.	t	4.4	101.7737891	2.9790804	dinner
866	Warung Bunian	Warung Bunian is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.0	101.7273163	2.9087828	dinner
867	Soi 55	Soi 55 is a popular dining spot in Selangor, well-known for its excellent thai restaurant.	t	4.8	101.8156068	2.9833753	dinner
868	AllAce Abdul Aziz Kajang	AllAce Abdul Aziz Kajang is a popular dining spot in Selangor, well-known for its excellent fast food restaurant.	t	4.9	101.7900745	2.9916169	dinner
869	Restoran Paandi Kajang ?????? ??????	Restoran Paandi Kajang ?????? ?????? is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	3.4	101.7901349	2.9927636	dinner
870	Restoran Kee V Sdn Bhd	Restoran Kee V Sdn Bhd is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	3.9	101.7839971	2.9834921	dinner
871	Kedai Makanan Wan Fatt	Kedai Makanan Wan Fatt is a popular dining spot in Selangor, well-known for its excellent seafood restaurant.	t	4.0	101.7871604	2.9913029	dinner
872	21st Century Cafe	21st Century Cafe is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	3.7	101.7956273	2.9877955	dinner
873	Tasik Puchong	Tasik Puchong is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.6030206	2.9963000	\N
874	Kichu port	Kichu port is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6175562	2.9909128	\N
875	Swiftlet Eco Culture Museum 金丝燕窝生态文化馆	Swiftlet Eco Culture Museum is a prominent museum and a must-visit cultural landmark in Selangor.	f	4.9	101.6205353	3.0090431	\N
876	Mural by The One Academy	Mural by The One Academy is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6204610	3.0447882	\N
877	Taman Rekreasi Jalan Tempua 2	Taman Rekreasi Jalan Tempua 2 is a prominent park and a must-visit cultural landmark in Selangor.	f	4.0	101.6249990	3.0455388	\N
878	Puchong Puteri Town Park	Puchong Puteri Town Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.6148151	3.0194711	\N
879	Taman Wawasan Recreational Park	Taman Wawasan Recreational Park is a prominent gym and a must-visit cultural landmark in Selangor.	f	4.3	101.6237203	3.0341342	\N
880	Bozouki's Shrine	Bozouki's Shrine is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6027437	2.9821619	\N
881	0 KM Puchong	0 KM Puchong is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.0	101.6206940	3.0095690	\N
882	The Biggest Toiletbowl in Malaysia	The Biggest Toiletbowl in Malaysia is a prominent cultural landmark and a must-visit cultural landmark in Selangor.	f	3.7	101.6214660	3.0422866	\N
883	Wah Kong Temple	Wah Kong Temple is a prominent buddhist temple and a must-visit cultural landmark in Selangor.	f	4.5	101.6127705	2.9626725	\N
884	Sau Seng Lum Puchong Exhibition Centre	Sau Seng Lum Puchong Exhibition Centre is a prominent buddhist temple and a must-visit cultural landmark in Selangor.	f	4.3	101.6018630	2.9307575	\N
885	Uptown Puchong Night Bazaar	Large warehouse with small shops selling diverse wares, plus informal eateries & hair salons.	f	3.9	101.6136529	2.9793825	\N
886	Nanyang Old Street Kopitiam ? 南洋老街茶铺 ? Puchong	Nanyang Old Street Kopitiam Puchong is a popular dining spot in Selangor, well-known for its excellent brunch restaurant.	t	4.1	101.6149105	3.0331397	breakfast, dinner
887	Sungai Besi Heritage Walk	Sungai Besi Heritage Walk is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	4.5	101.7098315	3.0638490	\N
888	Malawati Fort	Malawati Fort is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.2461812	3.3421994	\N
889	Puchong	Puchong is a prominent place of worship and a must-visit cultural landmark in Selangor.	f	5.0	101.6255897	3.0252017	\N
890	Istana Darul Ehsan	Tudor-style lakefront palace of the Sultan of Selangor, completed in 2000 (not open to the public).	f	4.4	101.6862962	2.9332121	\N
891	Saujana Puchong Car Park(ABANDONED, To Be Demolished)	Saujana Puchong Car Park(ABANDONED, To Be Demolished) is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6393139	2.9906693	\N
892	Bukit Wawasan Puchong Hiking	Bukit Wawasan Puchong Hiking is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.5	101.6297815	3.0247495	\N
893	Hutan Simpan Air Hitam Puchong	Hutan Simpan Air Hitam Puchong is a beautiful nature preserve, offering a relaxing outdoor and nature experience for visitors.	f	5.0	101.6465301	3.0221644	\N
894	A-Park	A-Park is a recognized wedding venue located in Selangor, Malaysia, attracting many visitors.	f	4.5	101.6317197	2.9644627	\N
895	SetiaWalk	SetiaWalk is a bustling shopping mall, perfect for shopping, dining, and local experiences.	f	3.8	101.6168062	3.0309621	\N
896	Taman Botani Putrajaya	Large lakeside public garden with 700+ species of plants & flowers, plus trails & bicycle rentals.	f	4.5	101.6955157	2.9448069	\N
897	IOI Mall Puchong	Sprawling shopping center featuring chain department stores, boutiques & eateries, plus a cinema.	f	4.3	101.6183585	3.0463256	\N
898	Putrajaya Wetlands Park	Large wetlands area suited for activities like picnics, walking, biking & wildlife viewing.	f	4.3	101.6956668	2.9616867	\N
899	安然韩式纳米汗蒸养生馆 Anran Nami Wellness Centre (Puchong)	Anran Nami Wellness Centre (Puchong) is a recognized wellness center located in Selangor, Malaysia, attracting many visitors.	f	4.9	101.6181546	3.0322869	\N
900	Wetland Studios Putrajaya	Wetland Studios Putrajaya is a beautiful amusement park, offering a relaxing outdoor and nature experience for visitors.	f	4.1	101.6947396	2.9600505	\N
901	iSHIN Fine Dine @Puchong	iSHIN Fine Dine @Puchong is a popular dining spot in Selangor, well-known for its excellent japanese restaurant.	t	4.8	101.6230399	3.0198677	dinner
902	Bumbu Bali	Bumbu Bali is a popular dining spot in Selangor, well-known for its excellent asian restaurant.	t	4.3	101.6154584	3.0231390	dinner
903	幸湘菜馆蒲种 | Restaurant Luckypot Puchong lucky pot	Restaurant Luckypot Puchong lucky pot is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.8	101.6147354	3.0218067	dinner
904	Naughty Root | Puchong	Naughty Root | Puchong is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.8	101.6185081	3.0083229	dinner
905	老湖南 Lao Hu Nan @ IOI Puchong Mall	老湖南 Lao Hu Nan @ IOI Puchong Mall is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.9	101.6185819	3.0457989	dinner
906	Meat One Cuisine | Puchong	Meat One Cuisine | Puchong is a popular dining spot in Selangor, well-known for its excellent steak house.	t	4.6	101.6231181	3.0448900	dinner
907	Ground Eatery	Ground Eatery is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.3	101.6157455	3.0275869	dinner
908	Rasputin Restaurant & Bar	Rasputin Restaurant & Bar is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.7	101.6039704	3.0314855	dinner
909	LUCK BROS KOPI @ Puchong	LUCK BROS KOPI @ Puchong is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.6136332	3.0086387	dinner
910	7BBQ	7BBQ is a popular dining spot in Selangor, well-known for its excellent barbecue restaurant.	t	4.9	101.6211850	2.9931529	dinner
911	Hakshan Bandar Puteri Puchong	Hakshan Bandar Puteri Puchong is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.7	101.6167495	3.0276613	dinner
912	Old Fatt Kee Restaurant ? 猪肉粉	Old Fatt Kee Restaurant is a popular dining spot in Selangor, well-known for its excellent chinese noodle restaurant.	t	4.3	101.6149942	3.0323157	dinner
913	Restoran Soon Lok Roast Duck | Puchong Jaya	Restoran Soon Lok Roast Duck | Puchong Jaya is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.6218738	3.0440769	dinner
914	PITBOYBBQ	PITBOYBBQ is a popular dining spot in Selangor, well-known for its excellent barbecue restaurant.	t	4.5	101.6210890	2.9846489	dinner
915	Xiao Xiang Zi Restaurant | 小巷子 | Bandar Puteri Puchong	Xiao Xiang Zi Restaurant Bandar Puteri Puchong is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.2	101.6168613	3.0265703	dinner
916	Ryoshi Izakaya (Puchong)	Ryoshi Izakaya (Puchong) is a popular dining spot in Selangor, well-known for its excellent japanese restaurant.	t	4.7	101.6195209	3.0249075	dinner
917	Shin Zushi Puchong	Shin Zushi Puchong is a popular dining spot in Selangor, well-known for its excellent sushi restaurant.	t	4.7	101.6155332	3.0235912	dinner
918	Empat Sekawan (Puchong Jaya)	Empat Sekawan (Puchong Jaya) is a popular dining spot in Selangor, well-known for its excellent cafe.	t	4.7	101.6229023	3.0404318	breakfast, lunch, dinner
919	Siong Tong Gai	Siong Tong Gai is a popular dining spot in Selangor, well-known for its excellent chinese restaurant.	t	4.6	101.6205049	2.9927405	dinner
920	India Gate Restaurant	India Gate Restaurant is a popular dining spot in Selangor, well-known for its excellent south indian restaurant.	t	4.9	101.6189755	3.0249663	dinner
921	Cyberjaya Lake Park	Cyberjaya Lake Park is a prominent park and a must-visit cultural landmark in Selangor.	f	4.5	101.6414138	2.9358715	\N
922	Cyberjaya Park (Taman Mini Cyberjaya)	Cyberjaya Park (Taman Mini Cyberjaya) is a prominent park and a must-visit cultural landmark in Selangor.	f	4.3	101.6494320	2.9226738	\N
923	Fun Malaysia	Fun Malaysia is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6619327	2.9225067	\N
924	Cyberjaya Sunset spot	Cyberjaya Sunset spot is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	5.0	101.6283879	2.9004003	\N
925	Cyberjaya Sign	Cyberjaya Sign is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.3	101.6607412	2.9131824	\N
926	Putrajaya Lake	Putrajaya Lake is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.6	101.6711809	2.9079226	\N
927	Kembara DIY	Kembara DIY is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	0.0	101.6442225	2.9114867	\N
928	Pantai Floria	Pantai Floria is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.6794076	2.9140586	\N
929	Raja Haji Fi Sabilillah Mosque	Raja Haji Fi Sabilillah Mosque is a prominent mosque and a must-visit cultural landmark in Selangor.	f	4.8	101.6484702	2.9321891	\N
930	China-Malaysia Friendship Garden 中马友谊花园	China-Malaysia Friendship Garden is a prominent monument and a must-visit cultural landmark in Selangor.	f	4.4	101.6776299	2.9125073	\N
931	Moroccan Pavilion Putrajaya	Moorish-style building in a botanical garden, with ornate carvings, colorful tiles & fountains.	f	4.2	101.6933547	2.9430771	\N
932	Perdana Lake, Jogging Track, Sunrise Point	Perdana Lake, Jogging Track, Sunrise Point is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.6691381	2.9149631	\N
933	Seri Perdana Bridge	Seri Perdana Bridge is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.7	101.6897360	2.9415471	\N
934	Selangor Cyber Valley Lake Park	Selangor Cyber Valley Lake Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.6270478	2.9166801	\N
935	Cyberjaya LakeFront Park	Cyberjaya LakeFront Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.6331938	2.9292450	\N
936	Cyberjaya Lakeside	Cyberjaya Lakeside is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.6694311	2.9146995	\N
937	Dataran Pahlawan Negara	Dataran Pahlawan Negara is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.4	101.7055044	2.9402413	\N
938	MMU Cyber Park	MMU Cyber Park is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.6447451	2.9296157	\N
939	Tangga Putrajaya	Tangga Putrajaya is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.7	101.6986933	2.9419423	\N
940	04 Headquarters	04 Headquarters is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6498221	2.9156908	\N
941	Ahmed’s Hideout	Ahmed’s Hideout is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	5.0	101.6544104	2.9478863	\N
942	ROYALE PALACE CYBERJAYA	ROYALE PALACE CYBERJAYA is a recognized event venue located in Selangor, Malaysia, attracting many visitors.	f	4.4	101.6535676	2.9370068	\N
943	Cyborg DS	Cyborg DS is a prominent historical landmark and a must-visit cultural landmark in Selangor.	f	0.0	101.6270972	2.9221976	\N
944	Tangga Putrajaya Steps	Tangga Putrajaya Steps is a recognized hiking area located in Selangor, Malaysia, attracting many visitors.	f	4.7	101.6957146	2.9391237	\N
945	Tamarind Square	No official description.	f	4.4	101.6370508	2.9197048	\N
946	Putrajaya Wetland Adventure Park	Putrajaya Wetland Adventure Park is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.6949672	2.9691649	\N
947	Taman Saujana Hijau (European Garden)	Taman Saujana Hijau (European Garden) is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	4.5	101.6731295	2.9592558	\N
948	Cyberjaya Mini Forest	Cyberjaya Mini Forest is a beautiful wildlife park, offering a relaxing outdoor and nature experience for visitors.	f	4.0	101.6368275	2.9287702	\N
949	Perdana Lakeview sunrise lookout	Perdana Lakeview sunrise lookout is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.6	101.6700339	2.9153287	\N
950	Taman Awam Cyber 3	Taman Awam Cyber 3 is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.2	101.6663282	2.9505496	\N
951	Swan Lake	Swan Lake is a beautiful wildlife park, offering a relaxing outdoor and nature experience for visitors.	f	4.4	101.6972996	2.9576734	\N
952	Taman Cabaran	Taman Cabaran is a prominent sports activity location and a must-visit cultural landmark in Selangor.	f	4.4	101.6654460	2.8891100	\N
953	Paya Indah Discovery Wetlands (Gate 1)	Paya Indah Discovery Wetlands (Gate 1) is a beautiful park, offering a relaxing outdoor and nature experience for visitors.	f	4.3	101.6170833	2.8859373	\N
954	Cyber Farm-Ur	Cyber Farm-Ur is a beautiful garden, offering a relaxing outdoor and nature experience for visitors.	f	5.0	101.6553951	2.9147468	\N
955	Lorong Belakang Cyberjaya	Lorong Belakang Cyberjaya is a bustling market, perfect for shopping, dining, and local experiences.	f	4.4	101.6608500	2.9232500	\N
956	Sembunyi Spa, Cyberview Resort & Spa	Sembunyi Spa, Cyberview Resort & Spa is a recognized spa located in Selangor, Malaysia, attracting many visitors.	f	4.9	101.6672381	2.9245369	\N
957	The Lookout Tower	The Lookout Tower is a prominent tourist attraction and a must-visit cultural landmark in Selangor.	f	4.2	101.6954498	2.9629016	\N
958	Namo Garden	Namo Garden is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.7	101.6608382	2.9231975	dinner
959	Giggles & Geeks	Giggles & Geeks is a popular dining spot in Selangor, well-known for its excellent western restaurant.	t	4.6	101.6285078	2.9162665	dinner
960	Texas BBQ Barn Restaurant Cyberjaya	Texas BBQ Barn Restaurant Cyberjaya is a popular dining spot in Selangor, well-known for its excellent barbecue restaurant.	t	4.6	101.6505812	2.9261919	dinner
961	10gram Cyberjaya	10gram Cyberjaya is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.5	101.6362512	2.9209597	dinner
962	Kaysha Dine & Beauty	Kaysha Dine & Beauty is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.3	101.6370384	2.9212154	dinner
963	Kocha Lala	Kocha Lala is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.6	101.6367963	2.9200779	dinner
964	Padi House Prima Cyberjaya	Padi House Prima Cyberjaya is a popular dining spot in Selangor, well-known for its excellent asian fusion restaurant.	t	3.9	101.6570463	2.9211817	dinner
965	Canton Boy @ Dpulze Cyberjaya	Canton Boy @ Dpulze Cyberjaya is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.6507462	2.9224360	dinner
966	After Seven Lounge	After Seven Lounge is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.6358392	2.9210284	dinner
967	Sana’a Restaurant Cyberjaya	Sana’a Restaurant Cyberjaya is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.6497556	2.9172974	dinner
968	SABA Restaurant Cyberjaya	SABA Restaurant Cyberjaya is a popular dining spot in Selangor, well-known for its excellent mediterranean restaurant.	t	4.2	101.6513864	2.9228584	dinner
969	Glaze Eatery - Tamarind Square	Glaze Eatery - Tamarind Square is a popular dining spot in Selangor, well-known for its excellent cake shop.	t	4.3	101.6361151	2.9210386	dinner
970	RESTORAN ZAM IKAN BAKAR	RESTORAN ZAM IKAN BAKAR is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.4	101.6510210	2.9254088	dinner
971	Strawberry Fields Cafe Cyberjaya	Strawberry Fields Cafe Cyberjaya is a popular dining spot in Selangor, well-known for its excellent family restaurant.	t	4.7	101.6571395	2.9245342	dinner
972	Noir Restaurant	Noir Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.8	101.6361682	2.9196342	dinner
973	Verandah Restaurant	Verandah Restaurant is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.1	101.6672488	2.9234976	dinner
974	Jaipur Mahal Cyberjaya	Jaipur Mahal Cyberjaya is a popular dining spot in Selangor, well-known for its excellent vegan restaurant.	t	4.2	101.6558625	2.9268288	dinner
975	SukhoThai Cuisine Cyberjaya	SukhoThai Cuisine Cyberjaya is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.5	101.6364864	2.9210367	dinner
976	Kars Fine Meat And Steak (Streetmall Cyberjaya)	Kars Fine Meat And Steak (Streetmall Cyberjaya) is a popular dining spot in Selangor, well-known for its excellent steak house.	t	4.8	101.6509067	2.9209342	dinner
977	Volcano Shabu Shabu Cyberjaya	Volcano Shabu Shabu Cyberjaya is a highly-rated restaurant offering a delightful dining experience in Selangor.	t	4.2	101.6622604	2.9233517	dinner
\.


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 217
-- Name: spots_spot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spots_spot_id_seq', 977, true);


-- Completed on 2026-06-15 19:17:48

--
-- PostgreSQL database dump complete
--

\unrestrict nklNQwJd5ZW9yld3xdCXlCBJUhWPyHEB9JGOtQGhzTlB2hwlGfHBsuMrjAVaJMV

