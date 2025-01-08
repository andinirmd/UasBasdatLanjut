-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 08, 2025 at 02:29 PM
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
-- Database: `dblatihan`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_kategori`
--

CREATE TABLE `tbl_kategori` (
  `id` int(11) UNSIGNED NOT NULL,
  `kategori` varchar(200) NOT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `aktif` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_kategori`
--

INSERT INTO `tbl_kategori` (`id`, `kategori`, `slug`, `aktif`, `created_at`, `updated_at`) VALUES
(1, 'Kategori 1', NULL, 'Y', '2025-01-07 15:43:00', '2025-01-07 15:43:00'),
(2, 'Kategori 2', NULL, 'Y', '2025-01-07 15:43:00', '2025-01-07 15:43:00'),
(3, 'Kategori 3', NULL, 'Y', '2025-01-07 15:43:00', '2025-01-07 15:43:00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_log`
--

CREATE TABLE `tbl_log` (
  `id` int(11) NOT NULL,
  `keterangan` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `user` varchar(100) NOT NULL,
  `waktu` datetime NOT NULL,
  `title_lama` varchar(255) DEFAULT NULL,
  `title_baru` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_posts`
--

CREATE TABLE `tbl_posts` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(100) DEFAULT 'Noimage.jpg',
  `hits` int(11) DEFAULT 0,
  `aktif` enum('Y','N') NOT NULL DEFAULT 'Y',
  `status` enum('publish','draft') NOT NULL DEFAULT 'publish',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_posts`
--

INSERT INTO `tbl_posts` (`id`, `title`, `slug`, `user_id`, `content`, `image`, `hits`, `aktif`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Title 1', 'title-1', 1, 'Content 1', 'image1.jpg', 0, 'Y', 'publish', '2025-01-07 15:42:42', '2025-01-07 15:42:42'),
(2, 'Title 2', 'title-2', 2, 'Content 2', 'image2.jpg', 0, 'Y', 'publish', '2025-01-07 15:42:42', '2025-01-07 15:42:42'),
(3, 'Title 3', 'title-3', 3, 'Content 3', 'image3.jpg', 0, 'Y', 'publish', '2025-01-07 15:42:42', '2025-01-07 15:42:42'),
(4, 'Title 4', 'title-4', 4, 'Content 4', 'image4.jpg', 0, 'Y', 'publish', '2025-01-07 15:42:42', '2025-01-07 15:42:42'),
(5, 'Title 5', 'title-5', 5, 'Content 5', 'image5.jpg', 0, 'Y', 'publish', '2025-01-07 15:42:42', '2025-01-07 15:42:42'),
(6, 'Title 6', 'title-6', 6, 'Content 6', 'image6.jpg', 0, 'Y', 'publish', '2025-01-07 15:42:42', '2025-01-07 15:42:42');

--
-- Triggers `tbl_posts`
--
DELIMITER $$
CREATE TRIGGER `log_delete_posts` BEFORE DELETE ON `tbl_posts` FOR EACH ROW BEGIN
    INSERT INTO tbl_log (keterangan, user, waktu, title_lama, title_baru)
    VALUES (
        'DELETE',
        CURRENT_USER(),
        NOW(),
        OLD.title,
        NULL
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `log_insert_posts` AFTER INSERT ON `tbl_posts` FOR EACH ROW BEGIN
    INSERT INTO tbl_log (keterangan, user, waktu, title_lama, title_baru)
    VALUES (
        'INSERT', 
        CURRENT_USER(), 
        NOW(), 
        NULL, 
        NEW.title
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `log_update_posts` BEFORE UPDATE ON `tbl_posts` FOR EACH ROW BEGIN
    INSERT INTO tbl_log (keterangan, user, waktu, title_lama, title_baru)
    VALUES (
        'UPDATE',
        CURRENT_USER(),
        NOW(),
        OLD.title,
        NEW.title
    );
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_kategori`
--
ALTER TABLE `tbl_kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_log`
--
ALTER TABLE `tbl_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_posts`
--
ALTER TABLE `tbl_posts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_kategori`
--
ALTER TABLE `tbl_kategori`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_log`
--
ALTER TABLE `tbl_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_posts`
--
ALTER TABLE `tbl_posts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
