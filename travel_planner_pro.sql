-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2025 at 10:22 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travel_planner_pro`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_reviews`
--

CREATE TABLE `app_reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT 5,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_reviews`
--

INSERT INTO `app_reviews` (`id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 5, 'แอปใช้งานง่ายมากครับ วางแผนเที่ยวสนุกขึ้นเยอะเลย!', '2025-12-05 20:21:15'),
(2, 1, 4, 'ชอบฟีเจอร์คำนวณค่าใช้จ่าย ช่วยคุมงบได้ดีมาก', '2025-12-05 20:21:15'),
(3, 1, 5, 'หาที่เที่ยวใหม่ๆ ได้เพียบ แนะนำเลยครับ', '2025-12-05 20:21:15'),
(4, 5, 5, 'ded', '2025-12-05 20:25:24'),
(5, 5, 1, 'เหม็นมาก', '2025-12-05 21:11:52'),
(6, 7, 1, 'เจ้าของอ้วนย', '2025-12-07 18:40:47');

-- --------------------------------------------------------

--
-- Table structure for table `places`
--

CREATE TABLE `places` (
  `id` int(11) NOT NULL,
  `trip_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `description` text DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  `visit_order` int(11) DEFAULT 0,
  `price` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `places`
--

INSERT INTO `places` (`id`, `trip_id`, `name`, `latitude`, `longitude`, `description`, `visit_date`, `visit_order`, `price`) VALUES
(4, 1, 'วัดพระสิง', 18.78818909, 98.98138690, 'นัดเจอ', NULL, 0, 0.00),
(5, 1, 'หนองหอย', 18.75773823, 99.00728012, 'ที่ 1', NULL, 0, 110.00),
(6, 2, 'บ้าน', 13.79372764, 100.58828747, 'นัดรวม', NULL, 0, 0.00),
(7, 2, 'เลิง', 16.19641436, 104.51617632, 'บ้าน', NULL, 0, 2000.00),
(8, 3, 'เริ่มไป', 13.79375890, 100.58827136, 'อ้วย', NULL, 0, 0.00),
(9, 3, 'ลาว', 17.96350256, 102.61322402, '', NULL, 0, 10000.00),
(12, 6, 'กรุงเทพมหานคร, ประเทศไทย', 13.75249380, 100.49350890, 'ออก', NULL, 0, 0.00),
(14, 6, 'โรงแรม', 13.76085310, 100.50407767, '', NULL, 0, 0.00),
(15, 6, 'ไปบ้าน', 13.79348904, 100.58834195, '', NULL, 0, 0.00),
(16, 6, 'ยโสธร, สำราญ, อำเภอเมืองยโสธร, จังหวัดยโสธร, 35000, ประเทศไทย', 15.79267510, 104.14529030, '', NULL, 0, 0.00),
(17, 6, 'วัดพระแก้ว', 13.75160000, 100.49260000, 'วัดคู่บ้านคู่เมือง สถาปัตยกรรมวิจิตรตระการตา', NULL, 0, 500.00),
(18, 7, 'เทศบาลนครเชียงใหม่, ฟ้าฮ่าม, อำเภอเมืองเชียงใหม่, จังหวัดเชียงใหม่, ประเทศไทย', 18.78827780, 98.98588020, 'รวมตัว', NULL, 0, 100.00),
(19, 7, 'เลิงนกทา, สวาท, อำเภอเลิงนกทา, จังหวัดยโสธร, 35120, ประเทศไทย', 16.19635390, 104.51787770, 'ถึง', NULL, 0, 3000.00),
(20, 7, 'อุทยานแห่งชาติเขาใหญ่', 14.43900000, 101.37220000, 'สูดอากาศบริสุทธิ์ ชมน้ำตกเหวสุวัต และสัตว์ป่ามากมาย', NULL, 0, 400.00),
(24, 10, 'อุทยานแห่งชาติเขาใหญ่', 14.43900000, 101.37220000, 'สูดอากาศบริสุทธิ์ ชมน้ำตกเหวสุวัต และสัตว์ป่ามากมาย', NULL, 0, 400.00),
(25, 10, 'จุดกาง', 14.43362042, 101.37298465, '', NULL, 0, 0.00),
(26, 9, 'ฟฟ', 13.79367919, 100.58835670, 'ฟฟ', NULL, 0, 0.00),
(28, 11, 'อุทยานแห่งชาติเขาใหญ่', 14.43900000, 101.37220000, 'สูดอากาศบริสุทธิ์ ชมน้ำตกเหวสุวัต และสัตว์ป่ามากมาย', NULL, 0, 400.00),
(29, 11, 'ยโสธร, สำราญ, อำเภอเมืองยโสธร, จังหวัดยโสธร, 35000, ประเทศไทย', 15.79267510, 104.14529030, '', NULL, 0, 0.00),
(30, 9, ';', 13.75572596, 100.62163353, '', NULL, 0, 0.00),
(31, 9, 'ภูกระดึง', 16.88450000, 101.79460000, 'พิชิตยอดภู ดูพระอาทิตย์ขึ้นที่ผานกแอ่น', NULL, 0, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `place_reviews`
--

CREATE TABLE `place_reviews` (
  `id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT 5,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `place_reviews`
--

INSERT INTO `place_reviews` (`id`, `place_id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 1, 5, 'สวยมากครับ อากาศดีสุดๆ', '2025-12-05 21:55:00'),
(2, 1, 1, 4, 'คนเยอะไปนิดแต่วิวคุ้มค่ามาก', '2025-12-05 21:55:00'),
(3, 18, 5, 3, 'ไม่มีจิง', '2025-12-05 21:58:56'),
(4, 2, 7, 1, 'พระหัวโล้น', '2025-12-07 18:41:05');

-- --------------------------------------------------------

--
-- Table structure for table `recommended_places`
--

CREATE TABLE `recommended_places` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT 0.00,
  `category` enum('nature','sea','city','camp','culture') NOT NULL,
  `image_url` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT 0.00000000,
  `longitude` decimal(11,8) DEFAULT 0.00000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recommended_places`
--

INSERT INTO `recommended_places` (`id`, `name`, `description`, `price`, `category`, `image_url`, `latitude`, `longitude`) VALUES
(1, 'อุทยานแห่งชาติเขาใหญ่', 'สูดอากาศบริสุทธิ์ ชมน้ำตกเหวสุวัต และสัตว์ป่ามากมาย', 400.00, 'nature', 'https://www.khaoyainationalpark.com/application/files/7316/3297/6568/DSC06823.JPG', 14.43900000, 101.37220000),
(2, 'ดอยอินทนนท์', 'จุดสูงสุดแดนสยาม สัมผัสอากาศหนาวและทะเลหมอก', 0.00, 'nature', 'https://image-tc.galaxy.tf/wijpeg-sxrfid5inslt46adwg0pwpho/intanon_standard.jpg?crop=112%2C0%2C1777%2C1333', 18.58860000, 98.48710000),
(3, 'ภูกระดึง', 'พิชิตยอดภู ดูพระอาทิตย์ขึ้นที่ผานกแอ่น', 0.00, 'nature', 'https://www.dasta.or.th/uploads/article/202107/1625238812_bf3b710888a73246b84a.jpg', 16.88450000, 101.79460000),
(4, 'เกาะล้าน', 'น้ำใส ทรายขาว ใกล้กรุงเทพฯ เดินทางสะดวก', 200.00, 'sea', 'https://www.ananda.co.th/blog/thegenc/wp-content/uploads/2024/05/%E0%B8%94%E0%B8%B5%E0%B9%84%E0%B8%8B%E0%B8%99%E0%B9%8C%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B8%A2%E0%B8%B1%E0%B8%87%E0%B9%84%E0%B8%A1%E0%B9%88%E0%B9%84%E0%B8%94%E0%B9%89%E0%B8%95%E0%B8%B1%E0%B9%89%E0%B8%87%E0%B8%8A%E0%B8%B7%E0%B9%88%E0%B8%AD-2024-05-22T125922.412.png', 12.92130000, 100.77970000),
(5, 'หมู่เกาะสิมิลัน', 'สวรรค์ของคนรักทะเล ทรายขาวละเอียด น้ำสีฟ้าคราม', 500.00, 'sea', 'https://cms.dmpcdn.com/travel/2023/04/14/b15331d0-daa2-11ed-aa1a-17654dc7e7cf_webp_original.jpg', 8.66030000, 97.64960000),
(6, 'เกาะเต่า', 'แหล่งดำน้ำระดับโลก ปะการังสวยงาม', 0.00, 'sea', 'https://my.kapook.com/imagescontent/fb_img/640/s_640_8037.jpg', 10.10110000, 99.83060000),
(7, 'ตึกมหานคร', 'ชมวิวกรุงเทพฯ แบบ 360 องศา บนตึกระฟ้า', 850.00, 'city', 'https://www.wonderfulpackage.com/uploads/article/cover-king-power_-mahanakhon.jpg?v=217', 13.72250000, 100.52920000),
(8, 'ไอคอนสยาม', 'ห้างสรรพสินค้าริมแม่น้ำเจ้าพระยา แหล่งรวมไลฟ์สไตล์', 0.00, 'city', 'https://mpics-cdn.mgronline.com/pics/Images/564000009181501.JPEG', 13.72660000, 100.51060000),
(9, 'เยาวราช', 'สวรรค์แห่ง Street Food ยามค่ำคืน', 100.00, 'city', 'https://www.makesend.asia/wp-content/uploads/2023/05/%E0%B9%80%E0%B8%A2%E0%B8%B2%E0%B8%A7%E0%B8%A3%E0%B8%B2%E0%B8%8A.jpg', 13.74040000, 100.50880000),
(10, 'สวนผึ้ง ราชบุรี', 'กางเต็นท์ริมลำธาร บรรยากาศชิลๆ ใกล้กรุง', 300.00, 'camp', 'https://cms.dmpcdn.com/travel/2020/08/08/ba4904a0-d950-11ea-a0b4-232d08119930_original.jpg', 13.54220000, 99.34090000),
(11, 'ปางอุ๋ง', 'สวิตเซอร์แลนด์เมืองไทย ล่องแพไม้ไผ่ในสายหมอก', 150.00, 'camp', 'https://img.salehere.co.th/p/1200x0/2022/04/29/kzii7t0lgkr0.jpg', 19.49930000, 97.91260000),
(12, 'เขาค้อ', 'นอนดูดาว สัมผัสลมหนาวและไร่กังหันลม', 0.00, 'camp', 'https://www.chillpainai.com/src/wewakeup/scoop/images/19d0d9a3031ce230c5a3f132886ab687a8590ff6.jpg', 16.63220000, 101.00240000),
(13, 'วัดพระแก้ว', 'วัดคู่บ้านคู่เมือง สถาปัตยกรรมวิจิตรตระการตา', 500.00, 'culture', 'https://cms.dmpcdn.com/travel/2021/08/06/f6bee040-f690-11eb-8d2d-519418dcfda4_original.jpg', 13.75160000, 100.49260000),
(14, 'อยุธยา', 'เที่ยวชมเมืองเก่า มรดกโลกทางวัฒนธรรม', 0.00, 'culture', 'https://cms.dmpcdn.com/travel/2023/08/29/2eb0d530-4621-11ee-ab47-43302f37ddcc_webp_original.webp', 14.35820000, 100.56780000),
(15, 'วัดร่องขุ่น', 'ศิลปะปูนปั้นสีขาวสุดอลังการ โดย อ.เฉลิมชัย', 100.00, 'culture', 'https://cms.dmpcdn.com/travel/2023/02/08/e8434100-a774-11ed-921b-b74716496218_webp_original.jpg', 19.82420000, 99.76310000),
(16, 'น้ำตกทีลอซู', 'น้ำตกที่สวยและยิ่งใหญ่ที่สุดในไทย กลางป่าอุ้มผาง', 0.00, 'nature', 'https://cms.dmpcdn.com/travel/2021/10/03/90307450-23ff-11ec-acea-393ee52b3545_webp_original.jpg', 15.92640000, 98.75420000),
(17, 'น้ำตกเอราวัณ', 'น้ำตก 7 ชั้น สีเขียวมรกต สวยงามดั่งสวรรค์ชั้น 7', 100.00, 'nature', 'https://media.thairath.co.th/image/GtbrmXtX5gt3XFEOaqv8s1a2hMW9AI0wTOPT6p1V2v0QbtGUWwe9vA1.wepb', 14.36860000, 99.14380000),
(18, 'ดอยอ่างขาง', 'ชมดอกนางพญาเสือโคร่ง และไร่ชา 2000 ท่ามกลางหุบเขา', 0.00, 'nature', 'https://cms.dmpcdn.com/travel/2021/12/30/10c35000-6948-11ec-8066-ffb72c13e721_webp_original.jpg', 19.90190000, 99.04080000),
(19, 'ภูชี้ฟ้า', 'จุดชมทะเลหมอกและพระอาทิตย์ขึ้นที่สวยที่สุดในเชียงราย', 0.00, 'nature', 'https://www.tatnewsthai.org/storage/Interesting_articles/cover%20new.jpg', 19.85190000, 100.45330000),
(20, 'สระมรกต กระบี่', 'สระน้ำธรรมชาติสีเขียวมรกตใจกลางป่า น้ำใสแจ๋ว', 200.00, 'nature', 'https://cms.dmpcdn.com/travel/2021/01/27/67c91060-605c-11eb-9fcf-39c19ee7986d_original.jpg', 7.92340000, 99.26040000),
(21, 'เสม็ดนางชี', 'จุดชมวิวอ่าวพังงาที่สวยจนต้องตะลึง เห็นวิวแบบพาโนรามา', 50.00, 'nature', 'https://s.isanook.com/tr/0/ui/280/1403829/18301471_1984644275096833_7837983488492022116_n_1494214203.jpg', 8.24060000, 98.44850000),
(22, 'หมู่เกาะพีพี', 'อัญมณีแห่งอันดามัน น้ำใส ทรายขาว แหล่งดำน้ำระดับโลก', 400.00, 'sea', 'https://cms.dmpcdn.com/travel/2023/04/24/78401d80-e28c-11ed-93fb-db9db47017f6_webp_original.jpg', 7.74070000, 98.77840000),
(23, 'หาดไร่เลย์', 'หาดสวยที่ล้อมรอบด้วยหน้าผาหินปูน ปีนผาชมวิวทะเล', 0.00, 'sea', 'https://s359.kapook.com/pagebuilder/13915cbc-2638-4745-b838-a9ba1769d891.jpg', 8.01130000, 98.83740000),
(24, 'เกาะหลีเป๊ะ', 'มัลดีฟส์เมืองไทย ปะการังสวย น้ำใสราวกระจก', 200.00, 'sea', 'https://res.klook.com/images/fl_lossy.progressive,q_65/c_fill,w_3000,h_1687/w_80,x_15,y_15,g_south_west,l_Klook_water_br_trans_yhcmh3/activities/gpqkq54d9i0tki8qmzhi/%E0%B8%97%E0%B8%B1%E0%B8%A7%E0%B8%A3%E0%B9%8C%E0%B8%A5%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B8%AD%E0%B8%AB%E0%B8%B2%E0%B8%87%E0%B8%A2%E0%B8%B2%E0%B8%A7%E0%B9%81%E0%B8%9A%E0%B8%9A%E0%B8%AA%E0%B9%88%E0%B8%A7%E0%B8%99%E0%B8%95%E0%B8%B1%E0%B8%A7%E0%B8%9E%E0%B8%A3%E0%B9%89%E0%B8%AD%E0%B8%A1%E0%B8%81%E0%B8%B4%E0%B8%88%E0%B8%81%E0%B8%A3%E0%B8%A3%E0%B8%A1%E0%B8%94%E0%B9%8D%E0%B8%B2%E0%B8%99%E0%B9%89%E0%B9%8D%E0%B8%B2%E0%B8%95%E0%B8%B7%E0%B9%89%E0%B8%99(%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%99%E0%B8%97%E0%B8%B2%E0%B8%87%E0%B8%88%E0%B8%B2%E0%B8%81%E0%B9%80%E0%B8%81%E0%B8%B2%E0%B8%B0%E0%B8%AB%E0%B8%A5%E0%B8%B5%E0%B9%80%E0%B8%9B%E0%B9%8A%E0%B8%B0)-Klook%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%97%E0%B8%A8%E0%B9%84%E0%B8%97%E0%B8%A2.jpg', 6.48830000, 99.30330000),
(25, 'เกาะสมุย', 'เกาะสวรรค์กลางอ่าวไทย ครบเครื่องทั้งที่เที่ยวและที่พักหรู', 0.00, 'sea', 'https://blog.bangkokair.com/wp-content/uploads/2023/11/%E0%B9%80%E0%B8%81%E0%B8%B2%E0%B8%B0%E0%B8%AA%E0%B8%A1%E0%B8%B8%E0%B8%A2.png', 9.51200000, 100.01360000),
(26, 'เกาะช้าง', 'เกาะใหญ่ที่มีครบทั้งภูเขา น้ำตก และทะเลสวย', 0.00, 'sea', 'https://cms.dmpcdn.com/travel/2024/03/25/bd7b5720-ea7e-11ee-b43a-f3f35529e778_webp_original.webp', 12.04690000, 102.31640000),
(27, 'อ่าวมาหยา', 'ชายหาดชื่อดังระดับโลก ทรายขาวละเอียด น้ำสีฟ้าคราม', 400.00, 'sea', 'https://cms.dmpcdn.com/travel/2023/04/14/c2ad0630-daad-11ed-a144-7946c6734ffa_webp_original.jpg', 7.67780000, 98.76560000),
(28, 'เอเชียทีค', 'แหล่งช้อปปิ้งริมแม่น้ำเจ้าพระยา พร้อมชิงช้าสวรรค์ยักษ์', 0.00, 'city', 'https://cms.dmpcdn.com/travel/2023/04/20/4809c5b0-df6e-11ed-a131-c9993d72c65c_webp_original.jpg', 13.70460000, 100.50320000),
(29, 'ตลาดนัดจตุจักร', 'แหล่งช้อปปิ้งวันหยุดที่ใหญ่ที่สุด ของกินของใช้เพียบ', 0.00, 'city', 'https://image.kkday.com/v2/image/get/w_1900%2Cc_fit/s1.kkday.com/product_135974/20221117092427_TvyNN/jpg', 13.80000000, 100.55130000),
(30, 'จอดแฟร์ พระราม 9', 'ตลาดนัดกลางคืนสุดฮิต ของกินอร่อย บรรยากาศดี', 0.00, 'city', 'https://maitriaapi.maitriahotels.com/public/jodd-fairs-1-1683631590-1738642744095.jpg', 13.75710000, 100.56580000),
(31, 'สวนเบญจกิติ', 'สวนป่าใจกลางกรุง ถ่ายรูปสวย วิ่งออกกำลังกายชิลๆ', 0.00, 'city', 'https://cms.dmpcdn.com/travel/2023/07/06/1b3b9490-1bc9-11ee-963a-ab3f7a955c7e_webp_original.webp', 13.72960000, 100.55760000),
(32, 'ดรีมเวิลด์', 'สวนสนุกระดับโลก เครื่องเล่นมันส์ๆ สำหรับทุกวัย', 600.00, 'city', 'https://www.phuketdreamcompany.com/wp-content/uploads/2023/03/%E0%B8%82%E0%B8%B2%E0%B8%A2%E0%B8%9A%E0%B8%B1%E0%B8%95%E0%B8%A3-%E0%B9%80%E0%B8%82%E0%B9%89%E0%B8%B2%E0%B8%AA%E0%B8%A7%E0%B8%99%E0%B8%AA%E0%B8%99%E0%B8%B8%E0%B8%81-%E0%B8%94%E0%B8%A3%E0%B8%B5%E0%B8%A1%E0%B9%80%E0%B8%A7%E0%B8%B4%E0%B8%A5%E0%B8%94%E0%B9%8C-%E0%B8%81%E0%B8%A3%E0%B8%B8%E0%B8%87%E0%B9%80%E0%B8%97%E0%B8%9E.jpg', 13.98770000, 100.67500000),
(33, 'ถนนนิมมานเหมินท์', 'ย่านฮิปสเตอร์เชียงใหม่ คาเฟ่สวย ร้านอาหารอร่อย', 0.00, 'city', 'https://img.wongnai.com/p/1920x0/2018/10/25/ed82820a0e2c493093ae9fe6837e59ee.jpg', 18.79830000, 98.96800000),
(34, 'เจ็ดคต-โป่งก้อนเส้า', 'กางเต็นท์ริมอ่างเก็บน้ำ ใกล้กรุง บรรยากาศเงียบสงบ', 50.00, 'camp', 'https://my.kapook.com/imagescontent/fb_img/210/s_148763_9595.jpg', 14.49390000, 101.16000000),
(35, 'เขื่อนแก่งกระจาน', 'แคมป์ปิ้งริมเขื่อน ชมพระอาทิตย์ตก ข้ามสะพานแขวน', 100.00, 'camp', 'https://cms.dmpcdn.com/travel/2021/02/15/fc5d0200-6f51-11eb-acb8-553b17c0f0e4_original.jpg', 12.87930000, 99.37920000),
(36, 'ดอยเสมอดาว', 'นอนดูดาวเต็มฟ้าที่น่าน บรรยากาศโรแมนติกสุดๆ', 50.00, 'camp', 'https://my.kapook.com/imagescontent/fb_img/952/s_135547_5558.jpg', 18.37420000, 100.83530000),
(37, 'ภูทับเบิก', 'กางเต็นท์บนยอดภู ชมไร่กะหล่ำปลีและทะเลหมอก', 0.00, 'camp', 'https://cms.dmpcdn.com/travel/2025/04/04/c1e4fc40-110a-11f0-a7a4-63d1736630f3_webp_original.webp', 16.90220000, 101.10700000),
(38, 'ทุ่งแสลงหลวง', 'ทุ่งหญ้าสะวันนาเมืองไทย ปั่นจักรยานสูดอากาศบริสุทธิ์', 100.00, 'camp', 'https://intercaravanas.com/wp-content/uploads/2021/09/intercaravan1-3.jpg', 16.58640000, 100.88780000),
(39, 'วัดอรุณราชวราราม', 'พระปรางค์วัดอรุณ สัญลักษณ์ความงามริมแม่น้ำเจ้าพระยา', 100.00, 'culture', 'https://bktemple.wordpress.com/wp-content/uploads/2018/09/cropped-1-zvqo976jklnpve9gyg6sfw.jpeg?w=2000&h=1200&crop=1', 13.74370000, 100.48890000),
(40, 'อุทยานประวัติศาสตร์สุโขทัย', 'มรดกโลกย้อนรอยอดีตราชธานีแห่งแรกของไทย', 100.00, 'culture', 'https://cms.dmpcdn.com/travel/2023/06/09/55a03730-068e-11ee-b704-e11b1c7d3a39_webp_original.jpg', 17.01830000, 99.70370000),
(41, 'วัดพระธาตุดอยสุเทพ', 'วัดคู่บ้านคู่เมืองเชียงใหม่ ชมวิวเมืองจากมุมสูง', 30.00, 'culture', 'https://f.tpkcdn.com/review-source/b1307263-c6b5-7ad4-8afc-60471d78f19c.png', 18.80490000, 98.92150000),
(42, 'ปราสาทสัจธรรม', 'สถาปัตยกรรมไม้แกะสลักทั้งหลัง ริมทะเลพัทยา', 500.00, 'culture', 'https://db.sac.or.th/museum/images/Museum/840/02-002.JPG', 12.97270000, 100.88910000),
(43, 'อุทยานประวัติศาสตร์พนมรุ้ง', 'ปราสาทหินบนยอดภูเขาไฟ ดินแดนอารยธรรมขอม', 100.00, 'culture', 'https://esportivida.com/wp-content/uploads/2021/01/1533022367_28516318_1876770029061735_3686300493350608248_o-e1610253975389.jpg', 14.53230000, 102.94270000),
(44, 'วัดเจดีย์หลวง', 'เจดีย์หลวงโบราณกลางเมืองเชียงใหม่ เก่าแก่และขลังมาก', 40.00, 'culture', 'https://cms.dmpcdn.com/travel/2020/08/28/9d5c5da0-e8f1-11ea-a27d-31c865fbbd8e_original.jpg', 18.78690000, 98.98650000);

-- --------------------------------------------------------

--
-- Table structure for table `trips`
--

CREATE TABLE `trips` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `cover_image` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trips`
--

INSERT INTO `trips` (`id`, `user_id`, `name`, `start_date`, `end_date`, `cover_image`, `created_at`) VALUES
(1, 1, 'แบกเป้เที่ยวเชียงใหม่', '2023-12-25', '2023-12-28', 'https://images.unsplash.com/photo-1598936753593-1742fa741487', '2025-11-21 10:36:34'),
(2, 1, 'ไปยโส', '2025-11-21', '2025-11-30', '', '2025-11-21 11:57:06'),
(3, 1, 'ไปลาว', '2025-11-27', '2025-11-30', '', '2025-11-27 08:18:25'),
(6, 3, 'ไปลาว', '2025-12-05', '2025-12-04', '', '2025-12-05 18:11:50'),
(7, 3, 'ไปยโส', '2025-12-05', '2025-12-06', '', '2025-12-05 19:19:12'),
(9, 5, 'ไปยโส', '2025-12-05', '2025-12-06', '', '2025-12-05 20:44:55'),
(10, 5, 'ล', '2025-12-06', '2025-12-30', '', '2025-12-05 20:45:14'),
(11, 7, 'ล', '2025-12-06', '2025-12-30', '', '2025-12-07 18:38:50'),
(12, 7, 'ไปลาว', '2025-12-08', '2025-12-07', '', '2025-12-07 18:41:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `bio` text DEFAULT NULL,
  `avatar_seed` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`, `bio`, `avatar_seed`) VALUES
(1, 'dew', '123456', '2025-11-21 10:36:34', NULL, NULL),
(2, 'wa', '1234', '2025-11-21 11:32:37', NULL, NULL),
(3, 'wasu', '1234', '2025-12-04 17:58:01', 'อ้วนจัง', NULL),
(4, 'a', '1234', '2025-12-04 18:54:13', NULL, NULL),
(5, 'f', '123456', '2025-12-05 20:08:15', 'ฉันเปนก', 'Jack'),
(6, 'd', '123456', '2025-12-05 22:19:52', NULL, NULL),
(7, 'g', '123456', '2025-12-07 18:38:12', 'กูร้อก', 'Misty');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_reviews`
--
ALTER TABLE `app_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `places`
--
ALTER TABLE `places`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trip_id` (`trip_id`);

--
-- Indexes for table `place_reviews`
--
ALTER TABLE `place_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `place_id` (`place_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `recommended_places`
--
ALTER TABLE `recommended_places`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trips`
--
ALTER TABLE `trips`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_reviews`
--
ALTER TABLE `app_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `places`
--
ALTER TABLE `places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `place_reviews`
--
ALTER TABLE `place_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `recommended_places`
--
ALTER TABLE `recommended_places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `trips`
--
ALTER TABLE `trips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `app_reviews`
--
ALTER TABLE `app_reviews`
  ADD CONSTRAINT `app_reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `places`
--
ALTER TABLE `places`
  ADD CONSTRAINT `places_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `trips` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `place_reviews`
--
ALTER TABLE `place_reviews`
  ADD CONSTRAINT `place_reviews_ibfk_1` FOREIGN KEY (`place_id`) REFERENCES `recommended_places` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `place_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `trips`
--
ALTER TABLE `trips`
  ADD CONSTRAINT `trips_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
