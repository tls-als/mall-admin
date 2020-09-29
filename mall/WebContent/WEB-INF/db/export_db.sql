-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.3.24-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 테이블 mall.admin 구조 내보내기
DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` varchar(250) CHARACTER SET utf8 NOT NULL,
  `admin_pw` varchar(50) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 테이블 데이터 mall.admin:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` (`admin_id`, `admin_pw`) VALUES
	('admin@gd.com', '1234'),
	('goodee@gd.com', '1234');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

-- 테이블 mall.category 구조 내보내기
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `category_pic` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT 'category.jpg',
  `category_ck` enum('Y','N') NOT NULL DEFAULT 'Y' COMMENT 'Y:추천, N:추천아님',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- 테이블 데이터 mall.category:~8 rows (대략적) 내보내기
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `category_name`, `category_pic`, `category_ck`) VALUES
	(1, '과일', 'category.jpeg', 'Y'),
	(2, '채소', 'category.jpeg', 'Y'),
	(10, '수산물', 'category.jpeg', 'Y'),
	(11, '생활용품', 'category.jpeg', 'Y'),
	(12, '전자제품', 'category.jpeg', 'Y'),
	(13, '식품', 'category.jpeg', 'Y'),
	(14, '문구류', 'category.jpeg', 'Y'),
	(15, '운동품', 'category.jpeg', 'Y');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- 테이블 mall.member 구조 내보내기
DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `member_email` varchar(250) CHARACTER SET utf8 NOT NULL,
  `member_pw` varchar(50) CHARACTER SET utf8 NOT NULL,
  `member_name` varchar(50) CHARACTER SET utf8 NOT NULL,
  `member_date` datetime NOT NULL,
  PRIMARY KEY (`member_email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 테이블 데이터 mall.member:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`member_email`, `member_pw`, `member_name`, `member_date`) VALUES
	('gildong@gd.com', '1234', '길동', '2020-09-28 14:52:06'),
	('shin@naver.com', '1234', '신민준', '2020-09-24 15:02:47');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

-- 테이블 mall.notice 구조 내보내기
DROP TABLE IF EXISTS `notice`;
CREATE TABLE IF NOT EXISTS `notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT,
  `notice_title` varchar(200) CHARACTER SET utf8 NOT NULL,
  `notice_content` mediumtext CHARACTER SET utf8 NOT NULL,
  `notice_date` datetime NOT NULL,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- 테이블 데이터 mall.notice:~5 rows (대략적) 내보내기
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` (`notice_id`, `notice_title`, `notice_content`, `notice_date`) VALUES
	(1, '공지1', '공지1 내용', '2020-09-24 10:01:57'),
	(2, '공지2', '공지2 내용', '2020-09-24 10:03:10'),
	(3, '공지3', '공지3 내용을 수정', '2020-09-24 11:31:59'),
	(4, '공지사항4', '공지4내용', '2020-09-28 17:55:49'),
	(6, '공지5', '공지5 내용입니다.', '2020-09-28 18:10:40');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;

-- 테이블 mall.orders 구조 내보내기
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `orders_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `orders_amount` int(11) NOT NULL COMMENT '수량',
  `orders_price` int(11) NOT NULL COMMENT '주문한 가격(할인)',
  `member_email` varchar(250) CHARACTER SET utf8 NOT NULL,
  `orders_addr` varchar(250) CHARACTER SET utf8 NOT NULL,
  `orders_state` enum('결제완료','배송준비중','배송완료','주문취소') CHARACTER SET utf8 NOT NULL COMMENT '주문상태',
  `orders_date` datetime NOT NULL,
  PRIMARY KEY (`orders_id`),
  KEY `FK__product` (`product_id`),
  KEY `FK_orders_member` (`member_email`),
  CONSTRAINT `FK__product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_orders_member` FOREIGN KEY (`member_email`) REFERENCES `member` (`member_email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- 테이블 데이터 mall.orders:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`orders_id`, `product_id`, `orders_amount`, `orders_price`, `member_email`, `orders_addr`, `orders_state`, `orders_date`) VALUES
	(15, 1, 1, 5000, 'shin@naver.com', '울산', '결제완료', '2020-09-25 15:53:09');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- 테이블 mall.product 구조 내보내기
DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `product_name` varchar(200) CHARACTER SET utf8 NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_content` text CHARACTER SET utf8 NOT NULL,
  `product_soldout` enum('Y','N') CHARACTER SET utf8 NOT NULL COMMENT 'Y면 품절',
  `product_pic` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT 'default.jpg',
  PRIMARY KEY (`product_id`),
  KEY `FK_product_category` (`category_id`),
  CONSTRAINT `FK_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

-- 테이블 데이터 mall.product:~58 rows (대략적) 내보내기
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`product_id`, `category_id`, `product_name`, `product_price`, `product_content`, `product_soldout`, `product_pic`) VALUES
	(1, 1, '바나나', 5000, '설명', 'N', 'banana1.jpg'),
	(2, 2, '배추', 5000, '설명', 'Y', 'default.jpg'),
	(3, 1, '사과', 1000, '설명', 'Y', 'default.jpg'),
	(4, 1, '포도', 3000, '설명', 'N', 'default.jpg'),
	(5, 2, '상추', 1500, '설명', 'Y', 'default.jpg'),
	(6, 10, '오징어', 7000, '설명\r\n', 'Y', 'default.jpg'),
	(7, 11, '의자', 30000, '책상의자', 'N', 'default.jpg'),
	(9, 10, '고등어', 5000, '등푸른생선 고등어', 'N', 'default.jpg'),
	(10, 11, '테이프', 1000, '박스 밀봉 테이프', 'Y', 'default.jpg'),
	(12, 13, '비비고만두', 13000, '맛있는 만두', 'N', 'default.jpg'),
	(13, 14, '모나미볼펜', 900, '볼펜입니다', 'Y', 'default.jpg'),
	(14, 12, '갤럭시노트10', 1600000, '삼성에서 출시한 스마트폰', 'N', 'default.jpg'),
	(15, 15, '런닝머신', 1200000, '런닝하는 기구', 'N', 'default.jpg'),
	(16, 2, '당근', 2000, '당근입니다.', 'N', 'default.jpg'),
	(17, 15, 'Arsenicum 30c, Bryonia 30c, Carbo Animalis 30c, Carbo Veg 30c, Nat Phos 30c, Nux Vomica 30c, Mag Phos 30c, Pulsatilla 30c, Sepia 30c', 29893, 'tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna', 'Y', 'default.jpg'),
	(18, 1, 'Amoxicillin', 6401, 'non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id', 'Y', 'default.jpg'),
	(19, 15, 'Povidone-iodine', 29307, 'odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis', 'Y', 'default.jpg'),
	(20, 1, 'Captopril', 9552, 'justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit', 'Y', 'default.jpg'),
	(21, 12, 'HYOSCYAMINE SULFATE', 89598, 'fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel', 'Y', 'default.jpg'),
	(22, 10, 'Russian Olive Elaeagnus angustifolia', 3204, 'congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus', 'Y', 'default.jpg'),
	(23, 10, 'Octisalate, Octocrylene, Avobenzone, Ensulizole', 3807, 'in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut', 'Y', 'default.jpg'),
	(24, 1, 'Dimethicone', 7828, 'cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero', 'N', 'default.jpg'),
	(25, 15, 'Cactus Grandiflorus, Calendula Officinalis, Convallaria Majalis, Dulcamara, Leptandra Virginica, Solidago Virgaurea', 91712, 'in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis', 'N', 'default.jpg'),
	(26, 13, 'Lisinopril', 93971, 'leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti', 'Y', 'default.jpg'),
	(27, 2, 'Ananassa Resina', 47955, 'est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede', 'Y', 'default.jpg'),
	(28, 13, 'Hydromorphone Hydrochloride', 80118, 'nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat', 'N', 'default.jpg'),
	(29, 10, 'Lovastatin', 54692, 'erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus', 'N', 'default.jpg'),
	(30, 15, 'acyclovir', 41524, 'nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel', 'N', 'default.jpg'),
	(31, 2, 'Aluminum Zirconium Tetrachlorohydrex GLY', 90920, 'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue', 'N', 'default.jpg'),
	(32, 11, 'valacyclovir hydrochloride', 68521, 'proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia', 'Y', 'default.jpg'),
	(33, 14, 'HYDROQUINONE', 53045, 'odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit', 'N', 'default.jpg'),
	(34, 2, 'Phenylephrine Hydrochloride', 32736, 'ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit', 'Y', 'default.jpg'),
	(35, 15, 'Adrenocorticotrophin, Agnus castus, Baryta carbonica, Calcarea carbonica, Iodium, Lac caninum, Natrum muriaticum, Phosphoricum acidum, Sepia, Thyroidinum suis,', 55004, 'ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales', 'N', 'default.jpg'),
	(36, 1, 'Tolnaftate', 6071, 'ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut', 'N', 'default.jpg'),
	(37, 15, 'TETRACYCLINE HYDROCHLORIDE', 46475, 'congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque', 'Y', 'default.jpg'),
	(38, 2, 'POTASSIUM ACETATE', 87533, 'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar', 'N', 'default.jpg'),
	(39, 2, 'Sulfamethoxazole and Trimethoprim', 22643, 'platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla', 'Y', 'default.jpg'),
	(40, 2, 'Bacillus cereus', 28053, 'molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus', 'Y', 'default.jpg'),
	(41, 15, 'Potassium Chloride', 57473, 'congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut', 'Y', 'default.jpg'),
	(42, 1, 'Omeprazole Magnesium', 82294, 'tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue', 'Y', 'default.jpg'),
	(43, 2, 'Aluminum Zirconium Tetrachlorohydrex GLY', 78098, 'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel', 'N', 'default.jpg'),
	(44, 14, 'ASIAN GINSENG', 48552, 'nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra', 'N', 'default.jpg'),
	(45, 1, 'perampanel', 26532, 'in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros', 'Y', 'default.jpg'),
	(46, 15, 'Oxazepam', 94153, 'dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id', 'Y', 'default.jpg'),
	(47, 2, 'Treatment Set TS331977', 93116, 'eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam', 'N', 'default.jpg'),
	(48, 1, 'SPONGIA OFFICINALIS SKELETON, ROASTED', 34806, 'sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum', 'Y', 'default.jpg'),
	(49, 1, 'Ethylhexl Methoxycinnamate, Zinc Oxide', 60521, 'ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer', 'N', 'default.jpg'),
	(50, 12, 'Anticoagulant Citrate Phosphate Dextrose Adenine', 99538, 'in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam', 'N', 'default.jpg'),
	(51, 10, 'SODIUM MONOFLUOROPHOSPHATE', 75705, 'erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis', 'N', 'default.jpg'),
	(52, 12, 'Yellow Jacket hymenoptera venom Venomil Diagnostic', 43466, 'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel', 'Y', 'default.jpg'),
	(53, 14, 'CP2D/AS-3 Anticoagulant and Additive System', 84843, 'praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis', 'Y', 'default.jpg'),
	(54, 15, 'Hydrocodone Bitartrate and Acetaminophen', 43663, 'duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget', 'N', 'default.jpg'),
	(55, 14, 'Cetirizine Hydrochloride', 20736, 'magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce', 'Y', 'default.jpg'),
	(56, 11, 'Benazepril Hydrochloride', 54940, 'ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac', 'N', 'default.jpg'),
	(57, 14, 'interferon beta-1b', 80132, 'volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio', 'Y', 'default.jpg'),
	(58, 13, 'Sodium Fluoride', 31692, 'nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate', 'N', 'default.jpg'),
	(59, 1, 'Phenylephrine Hydrochloride and Fat, Hard', 5226, 'magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc', 'N', 'default.jpg'),
	(60, 15, 'terconazole', 2284, 'est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet', 'Y', 'default.jpg');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- 테이블 mall.x 구조 내보내기
DROP TABLE IF EXISTS `x`;
CREATE TABLE IF NOT EXISTS `x` (
  `a` int(11) NOT NULL,
  `b` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 테이블 데이터 mall.x:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `x` DISABLE KEYS */;
INSERT INTO `x` (`a`, `b`) VALUES
	(1, 2),
	(7, 8);
/*!40000 ALTER TABLE `x` ENABLE KEYS */;

-- 테이블 mall.y 구조 내보내기
DROP TABLE IF EXISTS `y`;
CREATE TABLE IF NOT EXISTS `y` (
  `b` int(11) NOT NULL,
  `c` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 테이블 데이터 mall.y:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `y` DISABLE KEYS */;
INSERT INTO `y` (`b`, `c`) VALUES
	(2, 3);
/*!40000 ALTER TABLE `y` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
