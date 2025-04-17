-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.41 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para indiegamestore
CREATE DATABASE IF NOT EXISTS `indiegamestore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `indiegamestore`;

-- Volcando estructura para tabla indiegamestore.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla indiegamestore.categories: ~2 rows (aproximadamente)
INSERT INTO `categories` (`id`, `name`) VALUES
	(1, 'Carreras'),
	(2, 'Plataformas 2D');

-- Volcando estructura para tabla indiegamestore.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `message` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla indiegamestore.notifications: ~0 rows (aproximadamente)

-- Volcando estructura para tabla indiegamestore.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `description` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `main_image` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `author` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `rating` float DEFAULT '0',
  `seller_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `seller_id` (`seller_id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla indiegamestore.products: ~2 rows (aproximadamente)
INSERT INTO `products` (`id`, `title`, `description`, `price`, `main_image`, `author`, `category_id`, `rating`, `seller_id`) VALUES
	(1, 'Donut Riders', '¡Esto es Donut Riders!\r\nEl videojuego en donde las donas cobran vida para correr carreras en mundos abiertos, pelear batallas y enfrentarse en minijuegos que divertirán a grandes y pequeños.\r\n¿Están listos para crear su dona favorita y competir por una dulce victoria? 🎮 🍩 🏁 🏆', 90.00, '/assets/DonutRiders.jpg', 'OUTRISE studios', 1, 4.5, 1),
	(2, 'LUCID', 'Descubre tu propia leyenda en LUCID. Avanza por un mundo cristalino desgarrado por la calamidad, absorbe poderosas habilidades que amplían el movimiento y mejoran el combate contra un variado elenco de enemigos y jefes, todo ello en un magnífico arte de píxeles inspirado en la edad de oro de los sidescrollers en 2D.', 85.00, '/assets/Lucid.jpg', 'The Matte Black Studio', 2, 3.8, 1);

-- Volcando estructura para tabla indiegamestore.product_media
CREATE TABLE IF NOT EXISTS `product_media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `media_url` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `media_type` enum('image','video') COLLATE utf8mb4_spanish_ci NOT NULL,
  `position` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_media_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla indiegamestore.product_media: ~0 rows (aproximadamente)

-- Volcando estructura para tabla indiegamestore.purchases
CREATE TABLE IF NOT EXISTS `purchases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `purchase_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `price_paid` decimal(10,2) DEFAULT NULL,
  `download_link` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla indiegamestore.purchases: ~0 rows (aproximadamente)

-- Volcando estructura para tabla indiegamestore.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `is_seller` tinyint(1) DEFAULT '0',
  `is_verified` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- Volcando datos para la tabla indiegamestore.users: ~1 rows (aproximadamente)
INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `is_seller`, `is_verified`, `created_at`) VALUES
	(1, 'Kirito55', 'jmendozachavez55@gmail.com', '$2b$10$U.hW2v/xpwJJ4Ts.TG.6S.FvjCFNiAeJESYKKrNtLq.1oF.cH/Tl.', 1, 1, '2025-04-15 18:56:05');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
