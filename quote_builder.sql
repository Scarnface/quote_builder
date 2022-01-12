-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2022 at 09:57 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quote_builder`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2021_12_16_133848_create_quotes_table', 1),
(6, '2021_12_16_140820_create_products_table', 1),
(7, '2022_01_07_081543_create_product_quote_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(9,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `created_at`, `updated_at`) VALUES
(1, 'quos', 'Est ut quia et tempore quas incidunt aut voluptas.', '13.36', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(2, 'eius', 'Laboriosam temporibus dolor debitis quasi labore rem.', '25.66', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(3, 'voluptas', 'Aperiam officia odit harum.', '77.60', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(4, 'distinctio', 'Explicabo voluptatibus esse recusandae quos placeat sapiente.', '6.94', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(5, 'labore', 'Dolor et in omnis ea quasi occaecati.', '85.43', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(6, 'veniam', 'Quia unde rerum veritatis quia a quae distinctio.', '90.17', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(7, 'magni', 'Qui enim laudantium ut iusto ipsam itaque eius.', '50.87', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(8, 'recusandae', 'Velit eveniet possimus inventore autem.', '39.28', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(9, 'facilis', 'Doloribus occaecati eveniet et magni fugiat soluta.', '40.82', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(10, 'incidunt', 'Voluptas molestiae aut saepe cumque quia.', '37.48', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(11, 'cupiditate', 'Quam sed cupiditate officiis eum suscipit.', '32.40', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(12, 'ex', 'Asperiores dolore porro natus distinctio vero eveniet.', '13.40', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(13, 'aut', 'Quaerat repellat et maxime.', '40.23', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(14, 'iusto', 'Illo laudantium cupiditate aliquid quo quia commodi pariatur deserunt.', '62.61', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(15, 'nesciunt', 'Ut nesciunt quas ea commodi et fugit.', '25.11', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(16, 'nemo', 'Aut exercitationem et quibusdam beatae.', '11.40', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(17, 'eligendi', 'Velit voluptates facere omnis provident sequi.', '45.85', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(18, 'quod', 'Et corporis laboriosam ea.', '14.14', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(19, 'quas', 'In nostrum rem natus molestiae hic neque veritatis.', '19.86', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(20, 'doloremque', 'Accusantium dolorem quasi eligendi nihil non et laborum.', '25.11', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(21, 'provident', 'Alias error et adipisci corporis quia reprehenderit est.', '24.47', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(22, 'nihil', 'Culpa quod ut libero excepturi officia.', '84.04', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(23, 'deserunt', 'Dolores consequuntur voluptates quo dolores impedit minima provident.', '43.16', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(24, 'sit', 'Aliquid qui deserunt alias vel quae.', '47.01', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(25, 'qui', 'Sequi et aut dolore quia voluptas est est.', '88.10', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(26, 'et', 'Veniam sed ipsa minima sit quae.', '38.84', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(27, 'vitae', 'Nihil accusamus dolorem recusandae architecto quia voluptas.', '92.96', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(28, 'officiis', 'Ut sed consequuntur voluptatem ad.', '99.46', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(29, 'voluptatem', 'Rerum totam ea suscipit incidunt saepe quae nesciunt.', '88.61', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(30, 'dolores', 'Repellendus est rerum amet molestias aut debitis debitis.', '2.07', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(31, 'aliquid', 'Sunt ea quos voluptatem laborum dignissimos.', '3.30', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(32, 'tempora', 'Repellat iusto odit saepe doloribus voluptatibus possimus accusantium.', '5.76', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(33, 'unde', 'Exercitationem dignissimos ut delectus nihil.', '61.71', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(34, 'quia', 'Aut ut est sunt nesciunt.', '57.52', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(35, 'adipisci', 'Dolor eum adipisci ullam sit earum ad.', '1.23', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(36, 'beatae', 'Alias corporis qui in.', '89.09', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(37, 'expedita', 'Consequatur vel nihil aut at sunt sunt ut.', '95.31', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(38, 'delectus', 'Rerum illo et ad pariatur cum.', '23.40', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(39, 'blanditiis', 'Fugit sint deserunt laudantium odio unde et quis.', '39.03', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(40, 'hic', 'Totam dolor nostrum est sit velit aperiam.', '57.41', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(41, 'ipsum', 'Dolorem quia non molestias deleniti et.', '73.38', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(42, 'vel', 'Vitae et et eum quo.', '95.27', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(43, 'eos', 'Et ducimus explicabo esse enim.', '38.57', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(44, 'omnis', 'Sed eum sint consequatur distinctio modi ducimus illo.', '32.87', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(45, 'assumenda', 'Itaque modi amet odio nam ea.', '9.68', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(46, 'ad', 'Dolores sint quia doloribus maiores voluptatum aut nihil.', '9.38', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(47, 'sint', 'Non molestias voluptatem similique quisquam qui laboriosam fugiat et.', '12.08', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(48, 'harum', 'Deserunt error quae voluptatem voluptatem saepe odit.', '9.29', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(49, 'reiciendis', 'Cumque maiores debitis enim ex.', '45.07', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(50, 'libero', 'Aperiam velit omnis perspiciatis veniam fugit qui.', '17.06', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(51, 'aspernatur', 'Natus id a facere quis eaque id.', '67.66', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(52, 'rem', 'Provident dolores ipsa fugit temporibus eum nemo.', '13.74', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(53, 'temporibus', 'Ipsa sunt ea asperiores repellat accusamus.', '15.23', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(54, 'cumque', 'Veritatis doloremque sunt accusamus et pariatur illo voluptatem voluptate.', '67.62', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(55, 'veritatis', 'Et quos quia provident nobis enim eius cumque.', '43.42', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(56, 'ducimus', 'Illo facilis aut ratione consequatur.', '77.76', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(57, 'similique', 'Consectetur in iste nulla incidunt ut rerum sed quia.', '56.00', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(58, 'ut', 'Optio aut ut et dolores aperiam quis et sed.', '61.69', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(59, 'nobis', 'Asperiores totam consequatur nam aliquam dolores voluptates.', '59.73', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(60, 'itaque', 'Rem nihil ratione ipsum soluta beatae asperiores sint.', '99.90', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(61, 'mollitia', 'Adipisci qui totam tempora quos totam provident et.', '33.39', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(62, 'consequatur', 'Labore vel possimus soluta minima iste officiis.', '70.52', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(63, 'dolor', 'Eum totam reprehenderit id consectetur voluptatem.', '72.16', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(64, 'minima', 'Iste nihil quam fugit assumenda recusandae hic.', '91.34', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(65, 'earum', 'Omnis totam iusto et possimus.', '88.13', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(66, 'atque', 'Laudantium molestias non neque architecto.', '9.14', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(67, 'totam', 'Consequatur magni consequatur sequi repudiandae doloribus in aspernatur.', '39.54', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(68, 'est', 'Voluptatibus vel quod iure ea quidem.', '67.63', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(69, 'sed', 'Repudiandae ullam eos eum consequuntur.', '95.63', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(70, 'enim', 'Nisi qui quia distinctio voluptates.', '53.93', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(71, 'odit', 'Ut dolorem et quibusdam.', '84.87', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(72, 'doloribus', 'Dolore dolores eveniet delectus maiores quia ullam eveniet.', '69.29', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(73, 'ullam', 'Ipsam voluptatem omnis nesciunt.', '77.41', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(74, 'repellat', 'Aliquid aut qui tenetur autem est minus.', '10.57', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(75, 'sunt', 'Ipsa perspiciatis et natus ipsum ut ratione quia.', '86.28', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(76, 'accusamus', 'Blanditiis hic assumenda tenetur dolorum possimus dolores excepturi.', '64.76', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(77, 'rerum', 'Iste molestiae perspiciatis ut magnam.', '22.61', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(78, 'nulla', 'Animi qui qui pariatur.', '48.57', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(79, 'ipsam', 'Perferendis delectus incidunt facilis aut.', '48.67', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(80, 'soluta', 'Iusto ut reiciendis consequatur ut temporibus ut.', '65.82', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(81, 'autem', 'Ipsam ut eum omnis voluptatem.', '49.14', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(82, 'laborum', 'Nihil voluptatum magni quisquam et necessitatibus.', '82.28', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(83, 'maiores', 'Mollitia facilis aperiam neque dignissimos est.', '79.10', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(84, 'asperiores', 'Beatae esse sint dicta qui.', '36.31', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(85, 'neque', 'Et non eveniet corporis.', '68.87', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(86, 'nisi', 'Placeat occaecati aut optio ea et.', '65.18', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(87, 'non', 'Incidunt dolores aut illo nesciunt laudantium.', '71.17', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(88, 'iste', 'Qui tempore repellendus est repellat quisquam.', '84.15', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(89, 'optio', 'Sed quis eos adipisci vel vel omnis.', '32.77', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(90, 'id', 'Fugit enim magni qui impedit laborum in corrupti.', '71.63', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(91, 'nostrum', 'Occaecati molestiae exercitationem est sed eveniet quam sequi.', '37.67', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(92, 'quis', 'Error necessitatibus unde distinctio esse in sed repellat.', '68.18', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(93, 'molestiae', 'Aperiam dolores maiores vel ut dignissimos reiciendis.', '1.76', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(94, 'velit', 'Aut unde expedita itaque nesciunt aut quidem ut.', '19.00', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(95, 'dignissimos', 'Necessitatibus alias quidem quisquam aperiam velit.', '71.33', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(96, 'magnam', 'Quia soluta hic enim error ab voluptatem.', '64.15', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(97, 'minus', 'Possimus ab facere atque sunt.', '6.78', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(98, 'maxime', 'Alias vel ut in.', '29.74', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(99, 'perferendis', 'Molestias non ad soluta dolores non.', '93.50', '2022-01-07 08:29:07', '2022-01-07 08:29:07'),
(100, 'exercitationem', 'In facere ut laborum ut quo quos quae.', '98.33', '2022-01-07 08:29:07', '2022-01-07 08:29:07');

-- --------------------------------------------------------

--
-- Table structure for table `product_quote`
--

CREATE TABLE `product_quote` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quote_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` smallint(5) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_quote`
--

INSERT INTO `product_quote` (`id`, `product_id`, `quote_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 5, '2022-01-07 08:32:04', '2022-01-07 08:32:04'),
(2, 2, 1, 3, '2022-01-07 08:32:04', '2022-01-07 08:32:04');

-- --------------------------------------------------------

--
-- Table structure for table `quotes`
--

CREATE TABLE `quotes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total` decimal(9,2) DEFAULT NULL,
  `vat` decimal(9,2) DEFAULT NULL,
  `total` decimal(9,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotes`
--

INSERT INTO `quotes` (`id`, `first_name`, `last_name`, `email`, `address`, `sub_total`, `vat`, `total`, `created_at`, `updated_at`) VALUES
(1, 'Testy', 'McTesty', 'testing@test.com', 'Somewhere, Anywhere, NW1 8QT', NULL, NULL, NULL, '2022-01-07 08:30:04', '2022-01-07 10:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Willard Rodriguez', 'admin@admin.com', '2022-01-07 08:29:07', '$2y$10$l5Fa1y/KwZe2h/iOQEKG5ePNBau80cRCQdSV1M084fohaOijS0GkO', 'DV4ZVBClsC', '2022-01-07 08:29:07', '2022-01-07 08:29:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_quote`
--
ALTER TABLE `product_quote`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quotes`
--
ALTER TABLE `quotes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `product_quote`
--
ALTER TABLE `product_quote`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quotes`
--
ALTER TABLE `quotes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
