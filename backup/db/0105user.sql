-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        5.7.32-log - MySQL Community Server (GPL)
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- java02_kdd 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `java02_kdd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `java02_kdd`;

-- 테이블 java02_kdd.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(50) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telecom` varchar(50) NOT NULL,
  `phoneNb` varchar(50) NOT NULL,
  `userNm` varchar(50) NOT NULL,
  `nickNm` varchar(50) NOT NULL,
  `membership` int(11) DEFAULT '0',
  `membershipDate` datetime DEFAULT NULL,
  `membershipCnt` int(11) DEFAULT '0',
  `withdrawal` int(11) DEFAULT '0',
  `profileImg` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- 테이블 데이터 java02_kdd.user:~4 rows (대략적) 내보내기
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`idx`, `userId`, `pwd`, `email`, `telecom`, `phoneNb`, `userNm`, `nickNm`, `membership`, `membershipDate`, `membershipCnt`, `withdrawal`, `profileImg`) VALUES
	(2, 'admin', '$2a$10$gSaoVHeD6auJAMaGnVFe4uUjOefS.etiiSkRBDsplCgjOdQYjme2m', 'power6120@naver.com', 'LGU+', '01044435001', '김관리', '관리자', -1, NULL, 0, 0, ''),
	(3, 'hkd1234', '$2a$10$ZO4D0uABXe78yJoeKrD2.u0VkxsO2XB7fCPSMDgVodmCCGHjQQqau', 'hkd1234@email.com', 'KT', '01012345678', '홍길동', '홍장군', 0, NULL, 0, 0, 'hkd1234_d2.jpg'),
	(4, 'dd1234', '$2a$10$jzQm/f3ybONpZf9fkcoHyOYZids./O4B3Oux48vbHBtOojvCT/Ia2', 'power6120@naver.com', 'KT', '01011111111', '이멜텥', '이멜텥', 0, NULL, 0, 0, 'dd1234_p18.jpg'),
	(5, 'kms1234', '$2a$10$8BDw22D4DZPIgbKzQOIWx.xEbAjSxEAbXO.UO5k56ABQS6GnXJWsq', 'kms1234@email.com', 'KT', '01098765432', '김말숙', '말술', 0, NULL, 0, 0, NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
