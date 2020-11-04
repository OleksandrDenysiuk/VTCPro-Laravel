-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 17, 2020 at 07:04 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `onlyvtc`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_password_resets`
--

CREATE TABLE `account_password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `guard_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `zip_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `note` text COLLATE utf8_unicode_ci NOT NULL,
  `fleet_id` int(10) NOT NULL DEFAULT 0,
  `created_by` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `guard_id`, `name`, `email`, `mobile`, `country_code`, `password`, `picture`, `language`, `remember_token`, `address`, `zip_code`, `city`, `country`, `note`, `fleet_id`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 0, 'vtcpro', 'admin@vtcpro.fr', NULL, '', '$2y$10$fMyoE5GwLGwp9PtAQyqV/OGBo9zGBc67uCVszheWQ7Gi65YwhxE16', NULL, 'en', 'kUOPdDqh9mgwCxT9Jk8nUtP4WM8V0rb8dejhLGaWWMaICnQqqhSGnc2hzPRE', 'Address', '123456', 'Lyon', 'France', 'Test admin Account note', 0, '', '2019-02-26 22:46:06', '2020-02-23 21:33:35'),
(2, 1, 'Demo Dispatcher', 'dispatcher@vtcpro.fr', NULL, '', '$2y$10$HFlkKjvcrZ6VmHBsvEA8AuF2ZM/IWMs.XQsWR7HmXC3tIfrD7mDLq', NULL, 'fr', NULL, '', '', '', '', '', 0, '', '2019-02-26 22:46:06', '2019-11-14 23:53:14'),
(3, 1, 'Demo Account', 'account@vtcpro.fr', NULL, '', '$2y$10$6VJwf/XJ352FByQK3QzoBe/6d22x1yxJkwHbVCbakZtyI.RtWsWri', NULL, 'fr', NULL, '', '', '', '', '', 0, '', '2019-02-26 22:46:06', '2019-08-17 07:25:29'),
(4, 1, 'Demo Dispute', 'dispute@vtcpro.fr', NULL, '', '$2y$10$t.zg0UxNsOaDlVK4hxiHTOvj6WYQIlxJFxQecYL3fo8e2YL4.BgTa', NULL, 'fr', NULL, '', '', '', '', '', 0, '', '2019-02-26 22:46:06', '2019-08-17 09:05:31'),
(8, 0, 'sub-admin', 'subadmin@gmail.com', NULL, '', '$2y$10$hF.b.fy7X6q5KjgQO4ugZeFyqWVbD/S9V5zV3nr0I3gvNWLer10py', NULL, NULL, NULL, '', '', '', '', '', 0, '', '2019-10-26 09:31:48', '2019-10-26 09:31:48');

-- --------------------------------------------------------

--
-- Table structure for table `admin_wallet`
--

CREATE TABLE `admin_wallet` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `transaction_alias` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_type` int(11) DEFAULT NULL COMMENT '1-commission,2-userrecharge,3-tripdebit,4-providerrecharge,5-providersettle,6-fleetrecharge,7-fleetcommission,8-fleetsettle,9-taxcredit,10-discountdebit,11-discountrecharge,12-userreferral,13-providerreferral,14-peakcommission,15-waitingcommission,16-userdispute,17-providerdispute',
  `type` enum('C','D') COLLATE utf8_unicode_ci NOT NULL,
  `amount` double(15,8) NOT NULL DEFAULT 0.00000000,
  `open_balance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `close_balance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `payment_mode` enum('BRAINTREE','CARD','PAYPAL','PAYUMONEY','PAYTM','CASH','WALLET') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `advertisements`
--

CREATE TABLE `advertisements` (
  `id` int(11) NOT NULL,
  `type` enum('ALL','PROVIDER','USER') NOT NULL DEFAULT 'ALL',
  `image` varchar(500) NOT NULL,
  `click_url` text NOT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `last_four` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `card_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `brand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `id` int(10) UNSIGNED NOT NULL,
  `request_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('up','pu') COLLATE utf8_unicode_ci NOT NULL,
  `delivered` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `iso` char(2) NOT NULL,
  `name` varchar(80) NOT NULL,
  `nicename` varchar(80) NOT NULL,
  `iso3` char(3) DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  `phonecode` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`) VALUES
(1, 'AF', 'AFGHANISTAN', 'Afghanistan', 'AFG', 4, 93),
(2, 'AL', 'ALBANIA', 'Albania', 'ALB', 8, 355),
(3, 'DZ', 'ALGERIA', 'Algeria', 'DZA', 12, 213),
(4, 'AS', 'AMERICAN SAMOA', 'American Samoa', 'ASM', 16, 1684),
(5, 'AD', 'ANDORRA', 'Andorra', 'AND', 20, 376),
(6, 'AO', 'ANGOLA', 'Angola', 'AGO', 24, 244),
(7, 'AI', 'ANGUILLA', 'Anguilla', 'AIA', 660, 1264),
(8, 'AQ', 'ANTARCTICA', 'Antarctica', NULL, NULL, 0),
(9, 'AG', 'ANTIGUA AND BARBUDA', 'Antigua and Barbuda', 'ATG', 28, 1268),
(10, 'AR', 'ARGENTINA', 'Argentina', 'ARG', 32, 54),
(11, 'AM', 'ARMENIA', 'Armenia', 'ARM', 51, 374),
(12, 'AW', 'ARUBA', 'Aruba', 'ABW', 533, 297),
(13, 'AU', 'AUSTRALIA', 'Australia', 'AUS', 36, 61),
(14, 'AT', 'AUSTRIA', 'Austria', 'AUT', 40, 43),
(15, 'AZ', 'AZERBAIJAN', 'Azerbaijan', 'AZE', 31, 994),
(16, 'BS', 'BAHAMAS', 'Bahamas', 'BHS', 44, 1242),
(17, 'BH', 'BAHRAIN', 'Bahrain', 'BHR', 48, 973),
(18, 'BD', 'BANGLADESH', 'Bangladesh', 'BGD', 50, 880),
(19, 'BB', 'BARBADOS', 'Barbados', 'BRB', 52, 1246),
(20, 'BY', 'BELARUS', 'Belarus', 'BLR', 112, 375),
(21, 'BE', 'BELGIUM', 'Belgium', 'BEL', 56, 32),
(22, 'BZ', 'BELIZE', 'Belize', 'BLZ', 84, 501),
(23, 'BJ', 'BENIN', 'Benin', 'BEN', 204, 229),
(24, 'BM', 'BERMUDA', 'Bermuda', 'BMU', 60, 1441),
(25, 'BT', 'BHUTAN', 'Bhutan', 'BTN', 64, 975),
(26, 'BO', 'BOLIVIA', 'Bolivia', 'BOL', 68, 591),
(27, 'BA', 'BOSNIA AND HERZEGOVINA', 'Bosnia and Herzegovina', 'BIH', 70, 387),
(28, 'BW', 'BOTSWANA', 'Botswana', 'BWA', 72, 267),
(29, 'BV', 'BOUVET ISLAND', 'Bouvet Island', NULL, NULL, 0),
(30, 'BR', 'BRAZIL', 'Brazil', 'BRA', 76, 55),
(31, 'IO', 'BRITISH INDIAN OCEAN TERRITORY', 'British Indian Ocean Territory', NULL, NULL, 246),
(32, 'BN', 'BRUNEI DARUSSALAM', 'Brunei Darussalam', 'BRN', 96, 673),
(33, 'BG', 'BULGARIA', 'Bulgaria', 'BGR', 100, 359),
(34, 'BF', 'BURKINA FASO', 'Burkina Faso', 'BFA', 854, 226),
(35, 'BI', 'BURUNDI', 'Burundi', 'BDI', 108, 257),
(36, 'KH', 'CAMBODIA', 'Cambodia', 'KHM', 116, 855),
(37, 'CM', 'CAMEROON', 'Cameroon', 'CMR', 120, 237),
(38, 'CA', 'CANADA', 'Canada', 'CAN', 124, 1),
(39, 'CV', 'CAPE VERDE', 'Cape Verde', 'CPV', 132, 238),
(40, 'KY', 'CAYMAN ISLANDS', 'Cayman Islands', 'CYM', 136, 1345),
(41, 'CF', 'CENTRAL AFRICAN REPUBLIC', 'Central African Republic', 'CAF', 140, 236),
(42, 'TD', 'CHAD', 'Chad', 'TCD', 148, 235),
(43, 'CL', 'CHILE', 'Chile', 'CHL', 152, 56),
(44, 'CN', 'CHINA', 'China', 'CHN', 156, 86),
(45, 'CX', 'CHRISTMAS ISLAND', 'Christmas Island', NULL, NULL, 61),
(46, 'CC', 'COCOS (KEELING) ISLANDS', 'Cocos (Keeling) Islands', NULL, NULL, 672),
(47, 'CO', 'COLOMBIA', 'Colombia', 'COL', 170, 57),
(48, 'KM', 'COMOROS', 'Comoros', 'COM', 174, 269),
(49, 'CG', 'CONGO', 'Congo', 'COG', 178, 242),
(50, 'CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 'Congo, the Democratic Republic of the', 'COD', 180, 242),
(51, 'CK', 'COOK ISLANDS', 'Cook Islands', 'COK', 184, 682),
(52, 'CR', 'COSTA RICA', 'Costa Rica', 'CRI', 188, 506),
(53, 'CI', 'COTE D\'IVOIRE', 'Cote D\'Ivoire', 'CIV', 384, 225),
(54, 'HR', 'CROATIA', 'Croatia', 'HRV', 191, 385),
(55, 'CU', 'CUBA', 'Cuba', 'CUB', 192, 53),
(56, 'CY', 'CYPRUS', 'Cyprus', 'CYP', 196, 357),
(57, 'CZ', 'CZECH REPUBLIC', 'Czech Republic', 'CZE', 203, 420),
(58, 'DK', 'DENMARK', 'Denmark', 'DNK', 208, 45),
(59, 'DJ', 'DJIBOUTI', 'Djibouti', 'DJI', 262, 253),
(60, 'DM', 'DOMINICA', 'Dominica', 'DMA', 212, 1767),
(61, 'DO', 'DOMINICAN REPUBLIC', 'Dominican Republic', 'DOM', 214, 1809),
(62, 'EC', 'ECUADOR', 'Ecuador', 'ECU', 218, 593),
(63, 'EG', 'EGYPT', 'Egypt', 'EGY', 818, 20),
(64, 'SV', 'EL SALVADOR', 'El Salvador', 'SLV', 222, 503),
(65, 'GQ', 'EQUATORIAL GUINEA', 'Equatorial Guinea', 'GNQ', 226, 240),
(66, 'ER', 'ERITREA', 'Eritrea', 'ERI', 232, 291),
(67, 'EE', 'ESTONIA', 'Estonia', 'EST', 233, 372),
(68, 'ET', 'ETHIOPIA', 'Ethiopia', 'ETH', 231, 251),
(69, 'FK', 'FALKLAND ISLANDS (MALVINAS)', 'Falkland Islands (Malvinas)', 'FLK', 238, 500),
(70, 'FO', 'FAROE ISLANDS', 'Faroe Islands', 'FRO', 234, 298),
(71, 'FJ', 'FIJI', 'Fiji', 'FJI', 242, 679),
(72, 'FI', 'FINLAND', 'Finland', 'FIN', 246, 358),
(73, 'FR', 'FRANCE', 'France', 'FRA', 250, 33),
(74, 'GF', 'FRENCH GUIANA', 'French Guiana', 'GUF', 254, 594),
(75, 'PF', 'FRENCH POLYNESIA', 'French Polynesia', 'PYF', 258, 689),
(76, 'TF', 'FRENCH SOUTHERN TERRITORIES', 'French Southern Territories', NULL, NULL, 0),
(77, 'GA', 'GABON', 'Gabon', 'GAB', 266, 241),
(78, 'GM', 'GAMBIA', 'Gambia', 'GMB', 270, 220),
(79, 'GE', 'GEORGIA', 'Georgia', 'GEO', 268, 995),
(80, 'DE', 'GERMANY', 'Germany', 'DEU', 276, 49),
(81, 'GH', 'GHANA', 'Ghana', 'GHA', 288, 233),
(82, 'GI', 'GIBRALTAR', 'Gibraltar', 'GIB', 292, 350),
(83, 'GR', 'GREECE', 'Greece', 'GRC', 300, 30),
(84, 'GL', 'GREENLAND', 'Greenland', 'GRL', 304, 299),
(85, 'GD', 'GRENADA', 'Grenada', 'GRD', 308, 1473),
(86, 'GP', 'GUADELOUPE', 'Guadeloupe', 'GLP', 312, 590),
(87, 'GU', 'GUAM', 'Guam', 'GUM', 316, 1671),
(88, 'GT', 'GUATEMALA', 'Guatemala', 'GTM', 320, 502),
(89, 'GN', 'GUINEA', 'Guinea', 'GIN', 324, 224),
(90, 'GW', 'GUINEA-BISSAU', 'Guinea-Bissau', 'GNB', 624, 245),
(91, 'GY', 'GUYANA', 'Guyana', 'GUY', 328, 592),
(92, 'HT', 'HAITI', 'Haiti', 'HTI', 332, 509),
(93, 'HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'Heard Island and Mcdonald Islands', NULL, NULL, 0),
(94, 'VA', 'HOLY SEE (VATICAN CITY STATE)', 'Holy See (Vatican City State)', 'VAT', 336, 39),
(95, 'HN', 'HONDURAS', 'Honduras', 'HND', 340, 504),
(96, 'HK', 'HONG KONG', 'Hong Kong', 'HKG', 344, 852),
(97, 'HU', 'HUNGARY', 'Hungary', 'HUN', 348, 36),
(98, 'IS', 'ICELAND', 'Iceland', 'ISL', 352, 354),
(99, 'IN', 'INDIA', 'India', 'IND', 356, 91),
(100, 'ID', 'INDONESIA', 'Indonesia', 'IDN', 360, 62),
(101, 'IR', 'IRAN, ISLAMIC REPUBLIC OF', 'Iran, Islamic Republic of', 'IRN', 364, 98),
(102, 'IQ', 'IRAQ', 'Iraq', 'IRQ', 368, 964),
(103, 'IE', 'IRELAND', 'Ireland', 'IRL', 372, 353),
(104, 'IL', 'ISRAEL', 'Israel', 'ISR', 376, 972),
(105, 'IT', 'ITALY', 'Italy', 'ITA', 380, 39),
(106, 'JM', 'JAMAICA', 'Jamaica', 'JAM', 388, 1876),
(107, 'JP', 'JAPAN', 'Japan', 'JPN', 392, 81),
(108, 'JO', 'JORDAN', 'Jordan', 'JOR', 400, 962),
(109, 'KZ', 'KAZAKHSTAN', 'Kazakhstan', 'KAZ', 398, 7),
(110, 'KE', 'KENYA', 'Kenya', 'KEN', 404, 254),
(111, 'KI', 'KIRIBATI', 'Kiribati', 'KIR', 296, 686),
(112, 'KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF', 'Korea, Democratic People\'s Republic of', 'PRK', 408, 850),
(113, 'KR', 'KOREA, REPUBLIC OF', 'Korea, Republic of', 'KOR', 410, 82),
(114, 'KW', 'KUWAIT', 'Kuwait', 'KWT', 414, 965),
(115, 'KG', 'KYRGYZSTAN', 'Kyrgyzstan', 'KGZ', 417, 996),
(116, 'LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', 'Lao People\'s Democratic Republic', 'LAO', 418, 856),
(117, 'LV', 'LATVIA', 'Latvia', 'LVA', 428, 371),
(118, 'LB', 'LEBANON', 'Lebanon', 'LBN', 422, 961),
(119, 'LS', 'LESOTHO', 'Lesotho', 'LSO', 426, 266),
(120, 'LR', 'LIBERIA', 'Liberia', 'LBR', 430, 231),
(121, 'LY', 'LIBYAN ARAB JAMAHIRIYA', 'Libyan Arab Jamahiriya', 'LBY', 434, 218),
(122, 'LI', 'LIECHTENSTEIN', 'Liechtenstein', 'LIE', 438, 423),
(123, 'LT', 'LITHUANIA', 'Lithuania', 'LTU', 440, 370),
(124, 'LU', 'LUXEMBOURG', 'Luxembourg', 'LUX', 442, 352),
(125, 'MO', 'MACAO', 'Macao', 'MAC', 446, 853),
(126, 'MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF', 'Macedonia, the Former Yugoslav Republic of', 'MKD', 807, 389),
(127, 'MG', 'MADAGASCAR', 'Madagascar', 'MDG', 450, 261),
(128, 'MW', 'MALAWI', 'Malawi', 'MWI', 454, 265),
(129, 'MY', 'MALAYSIA', 'Malaysia', 'MYS', 458, 60),
(130, 'MV', 'MALDIVES', 'Maldives', 'MDV', 462, 960),
(131, 'ML', 'MALI', 'Mali', 'MLI', 466, 223),
(132, 'MT', 'MALTA', 'Malta', 'MLT', 470, 356),
(133, 'MH', 'MARSHALL ISLANDS', 'Marshall Islands', 'MHL', 584, 692),
(134, 'MQ', 'MARTINIQUE', 'Martinique', 'MTQ', 474, 596),
(135, 'MR', 'MAURITANIA', 'Mauritania', 'MRT', 478, 222),
(136, 'MU', 'MAURITIUS', 'Mauritius', 'MUS', 480, 230),
(137, 'YT', 'MAYOTTE', 'Mayotte', NULL, NULL, 269),
(138, 'MX', 'MEXICO', 'Mexico', 'MEX', 484, 52),
(139, 'FM', 'MICRONESIA, FEDERATED STATES OF', 'Micronesia, Federated States of', 'FSM', 583, 691),
(140, 'MD', 'MOLDOVA, REPUBLIC OF', 'Moldova, Republic of', 'MDA', 498, 373),
(141, 'MC', 'MONACO', 'Monaco', 'MCO', 492, 377),
(142, 'MN', 'MONGOLIA', 'Mongolia', 'MNG', 496, 976),
(143, 'MS', 'MONTSERRAT', 'Montserrat', 'MSR', 500, 1664),
(144, 'MA', 'MOROCCO', 'Morocco', 'MAR', 504, 212),
(145, 'MZ', 'MOZAMBIQUE', 'Mozambique', 'MOZ', 508, 258),
(146, 'MM', 'MYANMAR', 'Myanmar', 'MMR', 104, 95),
(147, 'NA', 'NAMIBIA', 'Namibia', 'NAM', 516, 264),
(148, 'NR', 'NAURU', 'Nauru', 'NRU', 520, 674),
(149, 'NP', 'NEPAL', 'Nepal', 'NPL', 524, 977),
(150, 'NL', 'NETHERLANDS', 'Netherlands', 'NLD', 528, 31),
(151, 'AN', 'NETHERLANDS ANTILLES', 'Netherlands Antilles', 'ANT', 530, 599),
(152, 'NC', 'NEW CALEDONIA', 'New Caledonia', 'NCL', 540, 687),
(153, 'NZ', 'NEW ZEALAND', 'New Zealand', 'NZL', 554, 64),
(154, 'NI', 'NICARAGUA', 'Nicaragua', 'NIC', 558, 505),
(155, 'NE', 'NIGER', 'Niger', 'NER', 562, 227),
(156, 'NG', 'NIGERIA', 'Nigeria', 'NGA', 566, 234),
(157, 'NU', 'NIUE', 'Niue', 'NIU', 570, 683),
(158, 'NF', 'NORFOLK ISLAND', 'Norfolk Island', 'NFK', 574, 672),
(159, 'MP', 'NORTHERN MARIANA ISLANDS', 'Northern Mariana Islands', 'MNP', 580, 1670),
(160, 'NO', 'NORWAY', 'Norway', 'NOR', 578, 47),
(161, 'OM', 'OMAN', 'Oman', 'OMN', 512, 968),
(162, 'PK', 'PAKISTAN', 'Pakistan', 'PAK', 586, 92),
(163, 'PW', 'PALAU', 'Palau', 'PLW', 585, 680),
(164, 'PS', 'PALESTINIAN TERRITORY, OCCUPIED', 'Palestinian Territory, Occupied', NULL, NULL, 970),
(165, 'PA', 'PANAMA', 'Panama', 'PAN', 591, 507),
(166, 'PG', 'PAPUA NEW GUINEA', 'Papua New Guinea', 'PNG', 598, 675),
(167, 'PY', 'PARAGUAY', 'Paraguay', 'PRY', 600, 595),
(168, 'PE', 'PERU', 'Peru', 'PER', 604, 51),
(169, 'PH', 'PHILIPPINES', 'Philippines', 'PHL', 608, 63),
(170, 'PN', 'PITCAIRN', 'Pitcairn', 'PCN', 612, 0),
(171, 'PL', 'POLAND', 'Poland', 'POL', 616, 48),
(172, 'PT', 'PORTUGAL', 'Portugal', 'PRT', 620, 351),
(173, 'PR', 'PUERTO RICO', 'Puerto Rico', 'PRI', 630, 1787),
(174, 'QA', 'QATAR', 'Qatar', 'QAT', 634, 974),
(175, 'RE', 'REUNION', 'Reunion', 'REU', 638, 262),
(176, 'RO', 'ROMANIA', 'Romania', 'ROM', 642, 40),
(177, 'RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643, 70),
(178, 'RW', 'RWANDA', 'Rwanda', 'RWA', 646, 250),
(179, 'SH', 'SAINT HELENA', 'Saint Helena', 'SHN', 654, 290),
(180, 'KN', 'SAINT KITTS AND NEVIS', 'Saint Kitts and Nevis', 'KNA', 659, 1869),
(181, 'LC', 'SAINT LUCIA', 'Saint Lucia', 'LCA', 662, 1758),
(182, 'PM', 'SAINT PIERRE AND MIQUELON', 'Saint Pierre and Miquelon', 'SPM', 666, 508),
(183, 'VC', 'SAINT VINCENT AND THE GRENADINES', 'Saint Vincent and the Grenadines', 'VCT', 670, 1784),
(184, 'WS', 'SAMOA', 'Samoa', 'WSM', 882, 684),
(185, 'SM', 'SAN MARINO', 'San Marino', 'SMR', 674, 378),
(186, 'ST', 'SAO TOME AND PRINCIPE', 'Sao Tome and Principe', 'STP', 678, 239),
(187, 'SA', 'SAUDI ARABIA', 'Saudi Arabia', 'SAU', 682, 966),
(188, 'SN', 'SENEGAL', 'Senegal', 'SEN', 686, 221),
(189, 'CS', 'SERBIA AND MONTENEGRO', 'Serbia and Montenegro', NULL, NULL, 381),
(190, 'SC', 'SEYCHELLES', 'Seychelles', 'SYC', 690, 248),
(191, 'SL', 'SIERRA LEONE', 'Sierra Leone', 'SLE', 694, 232),
(192, 'SG', 'SINGAPORE', 'Singapore', 'SGP', 702, 65),
(193, 'SK', 'SLOVAKIA', 'Slovakia', 'SVK', 703, 421),
(194, 'SI', 'SLOVENIA', 'Slovenia', 'SVN', 705, 386),
(195, 'SB', 'SOLOMON ISLANDS', 'Solomon Islands', 'SLB', 90, 677),
(196, 'SO', 'SOMALIA', 'Somalia', 'SOM', 706, 252),
(197, 'ZA', 'SOUTH AFRICA', 'South Africa', 'ZAF', 710, 27),
(198, 'GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 'South Georgia and the South Sandwich Islands', NULL, NULL, 0),
(199, 'ES', 'SPAIN', 'Spain', 'ESP', 724, 34),
(200, 'LK', 'SRI LANKA', 'Sri Lanka', 'LKA', 144, 94),
(201, 'SD', 'SUDAN', 'Sudan', 'SDN', 736, 249),
(202, 'SR', 'SURINAME', 'Suriname', 'SUR', 740, 597),
(203, 'SJ', 'SVALBARD AND JAN MAYEN', 'Svalbard and Jan Mayen', 'SJM', 744, 47),
(204, 'SZ', 'SWAZILAND', 'Swaziland', 'SWZ', 748, 268),
(205, 'SE', 'SWEDEN', 'Sweden', 'SWE', 752, 46),
(206, 'CH', 'SWITZERLAND', 'Switzerland', 'CHE', 756, 41),
(207, 'SY', 'SYRIAN ARAB REPUBLIC', 'Syrian Arab Republic', 'SYR', 760, 963),
(208, 'TW', 'TAIWAN, PROVINCE OF CHINA', 'Taiwan, Province of China', 'TWN', 158, 886),
(209, 'TJ', 'TAJIKISTAN', 'Tajikistan', 'TJK', 762, 992),
(210, 'TZ', 'TANZANIA, UNITED REPUBLIC OF', 'Tanzania, United Republic of', 'TZA', 834, 255),
(211, 'TH', 'THAILAND', 'Thailand', 'THA', 764, 66),
(212, 'TL', 'TIMOR-LESTE', 'Timor-Leste', NULL, NULL, 670),
(213, 'TG', 'TOGO', 'Togo', 'TGO', 768, 228),
(214, 'TK', 'TOKELAU', 'Tokelau', 'TKL', 772, 690),
(215, 'TO', 'TONGA', 'Tonga', 'TON', 776, 676),
(216, 'TT', 'TRINIDAD AND TOBAGO', 'Trinidad and Tobago', 'TTO', 780, 1868),
(217, 'TN', 'TUNISIA', 'Tunisia', 'TUN', 788, 216),
(218, 'TR', 'TURKEY', 'Turkey', 'TUR', 792, 90),
(219, 'TM', 'TURKMENISTAN', 'Turkmenistan', 'TKM', 795, 7370),
(220, 'TC', 'TURKS AND CAICOS ISLANDS', 'Turks and Caicos Islands', 'TCA', 796, 1649),
(221, 'TV', 'TUVALU', 'Tuvalu', 'TUV', 798, 688),
(222, 'UG', 'UGANDA', 'Uganda', 'UGA', 800, 256),
(223, 'UA', 'UKRAINE', 'Ukraine', 'UKR', 804, 380),
(224, 'AE', 'UNITED ARAB EMIRATES', 'United Arab Emirates', 'ARE', 784, 971),
(225, 'GB', 'UNITED KINGDOM', 'United Kingdom', 'GBR', 826, 44),
(226, 'US', 'UNITED STATES', 'United States', 'USA', 840, 1),
(227, 'UM', 'UNITED STATES MINOR OUTLYING ISLANDS', 'United States Minor Outlying Islands', NULL, NULL, 1),
(228, 'UY', 'URUGUAY', 'Uruguay', 'URY', 858, 598),
(229, 'UZ', 'UZBEKISTAN', 'Uzbekistan', 'UZB', 860, 998),
(230, 'VU', 'VANUATU', 'Vanuatu', 'VUT', 548, 678),
(231, 'VE', 'VENEZUELA', 'Venezuela', 'VEN', 862, 58),
(232, 'VN', 'VIET NAM', 'Viet Nam', 'VNM', 704, 84),
(233, 'VG', 'VIRGIN ISLANDS, BRITISH', 'Virgin Islands, British', 'VGB', 92, 1284),
(234, 'VI', 'VIRGIN ISLANDS, U.S.', 'Virgin Islands, U.s.', 'VIR', 850, 1340),
(235, 'WF', 'WALLIS AND FUTUNA', 'Wallis and Futuna', 'WLF', 876, 681),
(236, 'EH', 'WESTERN SAHARA', 'Western Sahara', 'ESH', 732, 212),
(237, 'YE', 'YEMEN', 'Yemen', 'YEM', 887, 967),
(238, 'ZM', 'ZAMBIA', 'Zambia', 'ZMB', 894, 260),
(239, 'ZW', 'ZIMBABWE', 'Zimbabwe', 'ZWE', 716, 263);

-- --------------------------------------------------------

--
-- Table structure for table `custom_pushes`
--

CREATE TABLE `custom_pushes` (
  `id` int(10) UNSIGNED NOT NULL,
  `send_to` enum('ALL','USERS','PROVIDERS') COLLATE utf8_unicode_ci NOT NULL,
  `condition` enum('ACTIVE','LOCATION','RIDES','AMOUNT') COLLATE utf8_unicode_ci NOT NULL,
  `condition_data` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sent_to` int(11) NOT NULL DEFAULT 0,
  `schedule_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `street` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `zipcode` varchar(75) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dispatchers`
--

CREATE TABLE `dispatchers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fleet_id` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dispatcher_password_resets`
--

CREATE TABLE `dispatcher_password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `disputes`
--

CREATE TABLE `disputes` (
  `id` int(10) UNSIGNED NOT NULL,
  `dispute_type` enum('user','provider') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `dispute_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `disputes`
--

INSERT INTO `disputes` (`id`, `dispute_type`, `dispute_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'provider', 'User not familiar with route and changed route', 'active', '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(2, 'provider', 'User arrogant and rude', 'active', '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(3, 'provider', 'User not paid amount', 'active', '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(4, 'user', 'I didn\'t feel safe during the ride', 'active', '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(5, 'user', 'Driver Unprofessional', 'active', '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(6, 'user', 'Driver took long and incorrect route', 'active', '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(7, 'user', 'Driver Delayed Pickup', 'active', '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(8, 'user', 'Driver changed route and charged extra amont', 'active', '2019-02-26 22:46:26', '2019-02-26 22:46:26');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('DRIVER','VEHICLE') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `name`, `type`, `created_at`, `updated_at`) VALUES
(10, 'Carte VTC', 'DRIVER', '2020-02-23 19:58:44', '2020-02-23 19:58:44'),
(11, 'Assurance RC Pro', 'DRIVER', '2020-02-23 19:59:30', '2020-02-23 20:18:35'),
(12, 'Permis de conduire', 'DRIVER', '2020-02-23 20:00:03', '2020-02-23 20:00:03'),
(13, 'Pièce d\'identité', 'DRIVER', '2020-02-23 20:00:22', '2020-02-23 20:00:22'),
(14, 'Assurance véhicule', 'VEHICLE', '2020-02-23 20:01:04', '2020-02-23 20:01:04'),
(15, 'Carte grise', 'VEHICLE', '2020-02-23 20:19:02', '2020-02-23 20:19:02');

-- --------------------------------------------------------

--
-- Table structure for table `driving_zones`
--

CREATE TABLE `driving_zones` (
  `id` int(11) UNSIGNED NOT NULL,
  `country_list` text DEFAULT NULL,
  `location_original` varchar(100) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `radius` varchar(50) DEFAULT '50',
  `active` tinyint(1) DEFAULT 0,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `eventcontacts`
--

CREATE TABLE `eventcontacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favourite_locations`
--

CREATE TABLE `favourite_locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` double(15,8) DEFAULT NULL,
  `longitude` double(15,8) DEFAULT NULL,
  `type` enum('home','work','recent','others') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'others',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fleets`
--

CREATE TABLE `fleets` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `commission` double(5,2) NOT NULL DEFAULT 0.00,
  `wallet_balance` double(10,2) NOT NULL DEFAULT 0.00,
  `stripe_cust_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fleet_cards`
--

CREATE TABLE `fleet_cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `last_four` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `brand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fleet_password_resets`
--

CREATE TABLE `fleet_password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fleet_wallet`
--

CREATE TABLE `fleet_wallet` (
  `id` int(10) UNSIGNED NOT NULL,
  `fleet_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `transaction_alias` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('C','D') COLLATE utf8_unicode_ci NOT NULL,
  `amount` double(15,8) NOT NULL DEFAULT 0.00000000,
  `open_balance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `close_balance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `payment_mode` enum('BRAINTREE','CARD','PAYPAL','PAYUMONEY','PAYTM') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ltm_translations`
--

CREATE TABLE `ltm_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `group` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ltm_translations`
--

INSERT INTO `ltm_translations` (`id`, `status`, `locale`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 0, 'ar', 'admin', 'back', 'الى الخلف', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(2, 0, 'ar', 'admin', 'demomode', '\"تم تعطيل ميزة CRUD \"على لوحة المشرف التوضيحية. سيتم تمكين هذه الميزة على منتجك الذي ستقوم بشرائه ، وفي الوقت نفسه إذا كان لديك أي استفسارات لا تتردد في الاتصال بدعم 24/7 على info@appdupe.com.', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(3, 0, 'ar', 'admin', 'fleet.fleet_owners', 'مالك أسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(4, 0, 'ar', 'admin', 'fleet.add_new_fleet_owner', 'اضف جديد مالك أسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(5, 0, 'ar', 'admin', 'fleet.show_provider', 'إظهار موفر\n', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(6, 0, 'ar', 'admin', 'fleet.add_fleet_owner', 'إضافة مالك أسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(7, 0, 'ar', 'admin', 'fleet.company_name', 'اسم الشركة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(8, 0, 'ar', 'admin', 'fleet.company_logo', 'شعار الشركة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(9, 0, 'ar', 'admin', 'fleet.fleet_commission', 'عمولة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(10, 0, 'ar', 'admin', 'fleet.update_fleet_owner', 'تحديث مالك أسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(11, 0, 'ar', 'admin', 'fleet.update_fleet', 'تحديث سريع', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(12, 0, 'ar', 'admin', 'fleet.fleet_name', 'اسم الاسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(13, 0, 'ar', 'admin', 'edit', 'تصحيح', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(14, 0, 'ar', 'admin', 'delete', 'حذف', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(15, 0, 'ar', 'admin', 'something_wrong', 'هناك خطأ ما!', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(16, 0, 'ar', 'admin', 'something_wrong_dashboard', 'شيء ما خاطئ مع لوحة القيادة!', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(17, 0, 'ar', 'admin', 'request_delete', 'طلب المحذوفة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(18, 0, 'ar', 'admin', 'profile_update', 'تحديث الملف الشخصي', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(19, 0, 'ar', 'admin', 'password_update', 'تم تحديث كلمة السر', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(20, 0, 'ar', 'admin', 'password_not_match', 'كلمة المرور التي تم إدخالها غير متطابقة الصحيحة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(21, 0, 'ar', 'admin', 'password_error', 'يرجى إدخال كلمة المرور', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(22, 0, 'ar', 'admin', 'location_updated', 'تم تحديث الموقع بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(23, 0, 'ar', 'admin', 'service.per_hour', 'في الساعة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(24, 0, 'ar', 'admin', 'service.total_hour', 'مجموع الساعات', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(25, 0, 'ar', 'admin', 'service.Base_Price', 'السعر الأساسي', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(26, 0, 'ar', 'admin', 'service.Base_Distance', 'المسافة الأساسية', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(27, 0, 'ar', 'admin', 'service.per_minute', 'لكل دقيقة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(28, 0, 'ar', 'admin', 'service.total_minute', 'مجموع الدقائق', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(29, 0, 'ar', 'admin', 'service.per', 'لكل', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(30, 0, 'ar', 'admin', 'service.total', 'مجموع', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(31, 0, 'ar', 'admin', 'service.Service_Image', 'صورة الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(32, 0, 'ar', 'admin', 'service.Add_Service_Type', 'أضف نوع الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(33, 0, 'ar', 'admin', 'service.Service_Name', 'اسم الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(34, 0, 'ar', 'admin', 'service.Provider_Name', 'اسم المزود', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(35, 0, 'ar', 'admin', 'service.hourly_Price', 'سعر الساعة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(36, 0, 'ar', 'admin', 'service.unit_time', 'تسعير وحدة الوقت (For Rental amount per hour / 60) ', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(37, 0, 'ar', 'admin', 'service.unit', 'سعر وحدة المسافة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(38, 0, 'ar', 'admin', 'service.Seat_Capacity', 'سعة المقعد', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(39, 0, 'ar', 'admin', 'service.Pricing_Logic', 'منطق التسعير', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(40, 0, 'ar', 'admin', 'service.Description', 'وصف', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(41, 0, 'ar', 'admin', 'service.Update_User', 'تحديث المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(42, 0, 'ar', 'admin', 'service.Update_Service_Type', 'تحديث نوع الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(43, 0, 'ar', 'admin', 'service.peak_title', 'Peak Time (Minute Fare)', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(44, 0, 'ar', 'admin', 'service.peak_id', 'ID', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(45, 0, 'ar', 'admin', 'service.peak_time', 'Time', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(46, 0, 'ar', 'admin', 'service.peak_price', 'Peak Price', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(47, 0, 'ar', 'admin', 'service.waiting_title', 'Waiting Charges', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(48, 0, 'ar', 'admin', 'service.waiting_wave', 'Waive off minutes', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(49, 0, 'ar', 'admin', 'service.waiting_charge', 'Per Minute Fare', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(50, 0, 'ar', 'admin', 'setting.map_key', 'فتاح خريطة جوجل', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(51, 0, 'ar', 'admin', 'setting.fb_app_version', 'نسخة التطبيق FB', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(52, 0, 'ar', 'admin', 'setting.fb_app_id', 'معرف التطبيق FB', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(53, 0, 'ar', 'admin', 'setting.fb_app_secret', 'FB التطبيق السري', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(54, 0, 'ar', 'admin', 'setting.Android_user_link', 'رابط المستخدم Playstore', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(55, 0, 'ar', 'admin', 'setting.Android_provider_link', 'رابط مزود Playstore', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(56, 0, 'ar', 'admin', 'setting.Ios_user_Link', 'رابط المستخدم Appstore', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(57, 0, 'ar', 'admin', 'setting.Ios_provider_Link', 'رابط مزود Appstore', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(58, 0, 'ar', 'admin', 'setting.Facebook_Link', 'رابط الفيس بوك', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(59, 0, 'ar', 'admin', 'setting.Twitter_Link', 'رابط تويتر', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(60, 0, 'ar', 'admin', 'setting.Site_Settings', 'إعدادات الموقع', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(61, 0, 'ar', 'admin', 'setting.Site_Name', 'اسم الموقع', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(62, 0, 'ar', 'admin', 'setting.Site_Logo', 'شعار الموقع', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(63, 0, 'ar', 'admin', 'setting.Site_Icon', 'أيقونة الموقع', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(64, 0, 'ar', 'admin', 'setting.Copyright_Content', 'محتوى حقوق الطبع البحث مقدم الشعاع', '2019-06-11 20:40:47', '2019-06-11 20:41:25'),
(65, 0, 'ar', 'admin', 'setting.Provider_Accept_Timeout', 'موفر قبول مهلة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(66, 0, 'ar', 'admin', 'setting.Provider_Search_Radius', 'البحث مقدم الشعاع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(67, 0, 'ar', 'admin', 'setting.SOS_Number', 'رقم استغاثة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(68, 0, 'ar', 'admin', 'setting.Contact_Number', 'رقم الاتصال', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(69, 0, 'ar', 'admin', 'setting.Contact_Email', 'تواصل بالبريد الاكتروني', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(70, 0, 'ar', 'admin', 'setting.Social_Login', 'تسجيل الدخول الاجتماعي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(71, 0, 'ar', 'admin', 'setting.Update_Site_Settings', 'تحديث إعدادات الموقع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(72, 0, 'ar', 'admin', 'setting.distance', 'مسافه: بعد', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(73, 0, 'ar', 'admin', 'setting.referral', 'Referral', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(74, 0, 'ar', 'admin', 'setting.referral_count', 'Referral count', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(75, 0, 'ar', 'admin', 'setting.referral_amount', 'Referral amount', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(76, 0, 'ar', 'admin', 'setting.send_mail', 'Send Mail', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(77, 0, 'ar', 'admin', 'setting.mail_host', 'Host', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(78, 0, 'ar', 'admin', 'setting.mail_username', 'Username', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(79, 0, 'ar', 'admin', 'setting.mail_password', 'Password', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(80, 0, 'ar', 'admin', 'setting.mail_from_address', 'From Address', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(81, 0, 'ar', 'admin', 'setting.mail_from_name', 'From Name', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(82, 0, 'ar', 'admin', 'setting.mail_port', 'Port', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(83, 0, 'ar', 'admin', 'setting.mail_encryption', 'Encryption', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(84, 0, 'ar', 'admin', 'setting.mail_domain', 'Domain', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(85, 0, 'ar', 'admin', 'setting.mail_secret', 'Secret', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(86, 0, 'ar', 'admin', 'setting.mail_driver', 'Driver', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(87, 0, 'ar', 'admin', 'payment.card_payments', 'شريط (مدفوعات بطاقة)', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(88, 0, 'ar', 'admin', 'payment.cash_payments', 'التسديد نقذا', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(89, 0, 'ar', 'admin', 'payment.payment_history', 'تاريخ الدفع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(90, 0, 'ar', 'admin', 'payment.request_id', 'طلب معرف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(91, 0, 'ar', 'admin', 'payment.transaction_id', 'معرف المعاملة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(92, 0, 'ar', 'admin', 'payment.from', 'من عند', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(93, 0, 'ar', 'admin', 'payment.to', 'إلى', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(94, 0, 'ar', 'admin', 'payment.total_amount', 'المبلغ الإجمالي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(95, 0, 'ar', 'admin', 'payment.provider_amount', 'كمية مقدم الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(96, 0, 'ar', 'admin', 'payment.payment_mode', 'طريقة الدفع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(97, 0, 'ar', 'admin', 'payment.payment_status', 'حالة السداد', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(98, 0, 'ar', 'admin', 'payment.payment_modes', 'طرق الدفع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(99, 0, 'ar', 'admin', 'payment.stripe_secret_key', 'شريط سر مفتاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(100, 0, 'ar', 'admin', 'payment.stripe_publishable_key', 'شريط للنشر الرئيسية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(101, 0, 'ar', 'admin', 'payment.payment_settings', 'إعدادات الدفع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(102, 0, 'ar', 'admin', 'payment.daily_target', 'الهدف اليومي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(103, 0, 'ar', 'admin', 'payment.tax_percentage', 'نسبة الضريبة (%)', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(104, 0, 'ar', 'admin', 'payment.surge_trigger_point', 'نقطة تصاعد الزناد', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(105, 0, 'ar', 'admin', 'payment.surge_percentage', 'النسبة المئوية للزيادة(%)', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(106, 0, 'ar', 'admin', 'payment.commission_percentage', 'نسبة العمولة(%)', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(107, 0, 'ar', 'admin', 'payment.provider_commission_percentage', 'نسبة عمولة مقدمي الخدمة(%)', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(108, 0, 'ar', 'admin', 'payment.fleet_commission_percentage', 'نسبة اسطول اللجنة(%)', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(109, 0, 'ar', 'admin', 'payment.booking_id_prefix', 'معرف الحجز البادئة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(110, 0, 'ar', 'admin', 'payment.currency', 'دقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(111, 0, 'ar', 'admin', 'payment.update_site_settings', 'تحديث إعدادات الموقع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(112, 0, 'ar', 'admin', 'addsettle', 'مستوطنة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(113, 0, 'ar', 'admin', 'prd_settle', 'تسوية المزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(114, 0, 'ar', 'admin', 'flt_settle', 'تسوية الأسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(115, 0, 'ar', 'admin', 'document.add_Document', 'إضافة وثيقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(116, 0, 'ar', 'admin', 'document.document_name', 'اسم الملف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(117, 0, 'ar', 'admin', 'document.document_type', 'نوع الوثيقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(118, 0, 'ar', 'admin', 'document.driver_review', 'استعراض سائق', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(119, 0, 'ar', 'admin', 'document.vehicle_review', 'استعراض السيارة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(120, 0, 'ar', 'admin', 'document.update_document', 'تحديث الوثيقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(121, 0, 'ar', 'admin', 'document.document', 'وثيقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(122, 0, 'ar', 'admin', 'account-manager.account_manager', 'إدارة حساب المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(123, 0, 'ar', 'admin', 'account-manager.add_new_account_manager', 'اضف جديد إدارة حساب المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(124, 0, 'ar', 'admin', 'account-manager.add_account_manager', 'أضف مدير الحساب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(125, 0, 'ar', 'admin', 'account-manager.full_name', 'الاسم الكامل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(126, 0, 'ar', 'admin', 'account-manager.password_confirmation', 'تأكيد كلمة المرور', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(127, 0, 'ar', 'admin', 'account-manager.update_account_manager', 'تحديث مدير الحساب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(128, 0, 'ar', 'admin', 'dispatcher.dispatcher', 'المرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(129, 0, 'ar', 'admin', 'dispatcher.add_new_dispatcher', 'اضف جديد المرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(130, 0, 'ar', 'admin', 'dispatcher.add_dispatcher', 'أضف المرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(131, 0, 'ar', 'admin', 'dispatcher.update_dispatcher', 'تحديث المرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(132, 0, 'ar', 'admin', 'provides.download', 'تحميل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(133, 0, 'ar', 'admin', 'provides.providers', 'مقدمي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(134, 0, 'ar', 'admin', 'provides.provider_name', 'اسم المزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(135, 0, 'ar', 'admin', 'provides.approve', 'يوافق', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(136, 0, 'ar', 'admin', 'provides.delete', 'حذف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(137, 0, 'ar', 'admin', 'provides.add_provider', 'أضف موفر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(138, 0, 'ar', 'admin', 'provides.password_confirmation', 'تأكيد كلمة المرور', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(139, 0, 'ar', 'admin', 'provides.update_provider', 'تحديث موفر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(140, 0, 'ar', 'admin', 'provides.type_allocation', 'موفر خدمة نوع التخصيص', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(141, 0, 'ar', 'admin', 'provides.service_name', 'اسم الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(142, 0, 'ar', 'admin', 'provides.service_number', 'رقم الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(143, 0, 'ar', 'admin', 'provides.service_model', 'نموذج الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(144, 0, 'ar', 'admin', 'provides.provider_documents', 'وثائق مقدم الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(145, 0, 'ar', 'admin', 'provides.document_type', 'نوع الوثيقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(146, 0, 'ar', 'admin', 'provides.add_new_provider', 'اضف جديد مزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(147, 0, 'ar', 'admin', 'provides.total_requests', 'مجموع الطلبات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(148, 0, 'ar', 'admin', 'provides.full_name', 'الاسم الكامل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(149, 0, 'ar', 'admin', 'provides.accepted_requests', 'الطلبات المقبولة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(150, 0, 'ar', 'admin', 'provides.cancelled_requests', 'الطلبات الملغاة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(151, 0, 'ar', 'admin', 'provides.service_type', 'المستندات / نوع الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(152, 0, 'ar', 'admin', 'provides.online', 'عبر الانترنت', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(153, 0, 'ar', 'admin', 'provides.Provider_Details', 'تفاصيل مقدم الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(154, 0, 'ar', 'admin', 'provides.Approved', 'وافق', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(155, 0, 'ar', 'admin', 'provides.Not_Approved', 'غير مقبول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(156, 0, 'ar', 'admin', 'provides.Total_Rides', 'إجمالي ركوب الخيل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(157, 0, 'ar', 'admin', 'provides.Total_Earning', 'مجموع الأرباح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(158, 0, 'ar', 'admin', 'provides.Commission', 'عمولة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(159, 0, 'ar', 'admin', 'provides.Joined_at', 'انضم في', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(160, 0, 'ar', 'admin', 'provides.Details', 'تفاصيل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(161, 0, 'ar', 'admin', 'History', 'التاريخ', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(162, 0, 'ar', 'admin', 'Statements', 'صياغات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(163, 0, 'ar', 'admin', 'include.profile', 'الملف الشخصي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(164, 0, 'ar', 'admin', 'include.sign_out', 'خروج', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(165, 0, 'ar', 'admin', 'include.reviews', 'التعليقات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(166, 0, 'ar', 'admin', 'include.add_new_promocode', 'اضف جديد رمز ترويجي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(167, 0, 'ar', 'admin', 'include.admin_dashboard', 'لوحة تحكم المشرف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(168, 0, 'ar', 'admin', 'include.dashboard', 'لوحة القيادة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(169, 0, 'ar', 'admin', 'include.fleet_dashboard', 'لوحة القيادة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(170, 0, 'ar', 'admin', 'include.dispatcher_dashboard', 'لوحة المرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(171, 0, 'ar', 'admin', 'include.account_dashboard', 'لوحة حساب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(172, 0, 'ar', 'admin', 'include.account_statements', 'بيانات الحسابات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(173, 0, 'ar', 'admin', 'include.dispatcher_panel', 'لوحة مرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(174, 0, 'ar', 'admin', 'include.heat_map', 'خريطة الحرارة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(175, 0, 'ar', 'admin', 'include.members', 'أفراد\n', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(176, 0, 'ar', 'admin', 'include.users', 'المستخدمين', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(177, 0, 'ar', 'admin', 'include.list_users', 'قائمة المستخدمين', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(178, 0, 'ar', 'admin', 'include.add_new_user', 'اضف جديد المستعمل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(179, 0, 'ar', 'admin', 'include.providers', 'مقدمي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(180, 0, 'ar', 'admin', 'include.list_providers', 'قائمة مقدمي الخدمات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(181, 0, 'ar', 'admin', 'include.add_new_provider', 'اضف جديد مزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(182, 0, 'ar', 'admin', 'include.dispatcher', 'المرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(183, 0, 'ar', 'admin', 'include.list_dispatcher', 'قائمة مرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(184, 0, 'ar', 'admin', 'include.add_new_dispatcher', 'اضف جديد المرسل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(185, 0, 'ar', 'admin', 'include.fleet_owner', 'مالك أسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(186, 0, 'ar', 'admin', 'include.list_fleets', 'قائمة الاساطيل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(187, 0, 'ar', 'admin', 'include.add_new_fleet_owner', 'اضف جديد مالك أسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(188, 0, 'ar', 'admin', 'include.account_manager', 'إدارة حساب المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(189, 0, 'ar', 'admin', 'include.list_account_managers', 'قائمة مدراء الحسابات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(190, 0, 'ar', 'admin', 'include.add_new_account_manager', 'اضف جديد إدارة حساب المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(191, 0, 'ar', 'admin', 'include.accounts', 'حسابات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(192, 0, 'ar', 'admin', 'include.statements', 'صياغات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(193, 0, 'ar', 'admin', 'include.overall_ride_statments', 'بيانات ركوب العام', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(194, 0, 'ar', 'admin', 'include.provider_statement', 'بيان مزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(195, 0, 'ar', 'admin', 'include.daily_statement', 'البيان اليومي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(196, 0, 'ar', 'admin', 'include.today_statement', 'بيان اليوم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(197, 0, 'ar', 'admin', 'include.monthly_statement', 'البيان الشهري', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(198, 0, 'ar', 'admin', 'include.yearly_statement', 'بيان سنوي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(199, 0, 'ar', 'admin', 'include.overall_ride_earnings', 'إجمالي أرباح ركوب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(200, 0, 'ar', 'admin', 'include.provider_earnings', 'أرباح مزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(201, 0, 'ar', 'admin', 'include.daily_earnings', 'الأرباح اليومية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(202, 0, 'ar', 'admin', 'include.today_earnings', 'أرباح اليوم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(203, 0, 'ar', 'admin', 'include.monthly_earnings', 'الدخل الشهري', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(204, 0, 'ar', 'admin', 'include.yearly_earnings', 'بيان سنوي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(205, 0, 'ar', 'admin', 'include.statement_from', 'ركوب بيان من', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(206, 0, 'ar', 'admin', 'include.statement_to', 'إلى', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(207, 0, 'ar', 'admin', 'include.details', 'تفاصيل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(208, 0, 'ar', 'admin', 'include.map', 'خريطة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(209, 0, 'ar', 'admin', 'include.ratings', 'تصنيفات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(210, 0, 'ar', 'admin', 'include.user_ratings', 'تقييم المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(211, 0, 'ar', 'admin', 'include.provider_ratings', 'تقييمات موفر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(212, 0, 'ar', 'admin', 'include.requests', 'طلبات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(213, 0, 'ar', 'admin', 'include.request_history', 'طلب التاريخ', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(214, 0, 'ar', 'admin', 'include.scheduled_rides', 'رحلات مجدولة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(215, 0, 'ar', 'admin', 'include.general', 'جنرال لواء', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(216, 0, 'ar', 'admin', 'include.service_types', 'أنواع الخدمات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(217, 0, 'ar', 'admin', 'include.list_service_types', 'قائمة أنواع الخدمات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(218, 0, 'ar', 'admin', 'include.add_new_service_type', 'اضف جديد نوع الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(219, 0, 'ar', 'admin', 'include.documents', 'مستندات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(220, 0, 'ar', 'admin', 'include.list_documents', 'قائمة الوثائق', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(221, 0, 'ar', 'admin', 'include.add_new_document', 'اضف جديد وثيقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(222, 0, 'ar', 'admin', 'include.promocodes', 'Promocodes', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(223, 0, 'ar', 'admin', 'include.list_promocodes', 'قائمة Promocodes', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(224, 0, 'ar', 'admin', 'include.payment_details', 'بيانات الدفع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(225, 0, 'ar', 'admin', 'include.payment_history', 'تاريخ الدفع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(226, 0, 'ar', 'admin', 'include.payment_settings', 'إعدادات الدفع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(227, 0, 'ar', 'admin', 'include.settings', 'الإعدادات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(228, 0, 'ar', 'admin', 'include.site_settings', 'إعداد الموقع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(229, 0, 'ar', 'admin', 'include.others', 'الآخرين', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(230, 0, 'ar', 'admin', 'include.cms_pages', 'Cms Pages', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(231, 0, 'ar', 'admin', 'include.help', 'مساعدة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(232, 0, 'ar', 'admin', 'include.custom_push', 'دفع مخصص', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(233, 0, 'ar', 'admin', 'include.translations', 'ترجمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(234, 0, 'ar', 'admin', 'include.account', 'الحساب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(235, 0, 'ar', 'admin', 'include.account_settings', 'إعدادت الحساب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(236, 0, 'ar', 'admin', 'include.change_password', 'غير كلمة السر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(237, 0, 'ar', 'admin', 'include.transaction', 'المستوطنات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(238, 0, 'ar', 'admin', 'include.provider_request', 'مستودعات المزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(239, 0, 'ar', 'admin', 'include.fleet_request', 'مستوطنات الأسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(240, 0, 'ar', 'admin', 'include.all_transaction', 'كل الحركات المالية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(241, 0, 'ar', 'admin', 'include.wallet', 'محفظة نقود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(242, 0, 'ar', 'admin', 'include.debit_card', 'بطاقات الخصم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(243, 0, 'ar', 'admin', 'include.transfer', 'نقل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(244, 0, 'ar', 'admin', 'include.logout', 'الخروج', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(245, 0, 'ar', 'admin', 'include.reason', 'Cancel Reasons', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(246, 0, 'ar', 'admin', 'include.peaktime', 'Peak Times', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(247, 0, 'ar', 'admin', 'account.change_password', 'غير كلمة السر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(248, 0, 'ar', 'admin', 'account.old_password', 'كلمة المرور القديمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(249, 0, 'ar', 'admin', 'account.password', 'كلمه السر ', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(250, 0, 'ar', 'admin', 'account.password_confirmation', 'تأكيد كلمة المرور', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(251, 0, 'ar', 'admin', 'account.update_profile', 'تحديث الملف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(252, 0, 'ar', 'admin', 'account.new_password', 'كلمة السر الجديدة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(253, 0, 'ar', 'admin', 'account.retype_password', 'أعد كتابة كلمة السر الجديدة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(254, 0, 'ar', 'admin', 'help', 'مساعدة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(255, 0, 'ar', 'admin', 'email', 'البريد الإلكتروني', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(256, 0, 'ar', 'admin', 'password', 'كلمه السر ', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(257, 0, 'ar', 'admin', 'auth.remember_me', 'تذكرنى', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(258, 0, 'ar', 'admin', 'auth.reset_password', 'إعادة ضبط كلمة المرور', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(259, 0, 'ar', 'admin', 'auth.admin_login', 'اتسجيل الدخول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(260, 0, 'ar', 'admin', 'auth.login_here', 'تسجيل الدخول هنا', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(261, 0, 'ar', 'admin', 'auth.sign_in', 'تسجيل الدخول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(262, 0, 'ar', 'admin', 'auth.forgot_your_password', 'نسيت رقمك السري', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(263, 0, 'ar', 'admin', 'auth.request_scheduled', 'الركوب المقرر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(264, 0, 'ar', 'admin', 'auth.request_already_scheduled', 'ركوب المقرر بالفعل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(265, 0, 'ar', 'admin', 'promocode.add_promocode', 'أضف الرمز الترويجي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(266, 0, 'ar', 'admin', 'promocode.discount', 'خصم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(267, 0, 'ar', 'admin', 'promocode.expiration', 'انتهاء الصلاحية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(268, 0, 'ar', 'admin', 'promocode.promocode', 'رمز ترويجي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(269, 0, 'ar', 'admin', 'promocode.update_promocode', 'تحديث الرمز الترويجي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(270, 0, 'ar', 'admin', 'promocode.used_count', 'العد المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(271, 0, 'ar', 'admin', 'promocode.promocodes', 'الرموز الترويجية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(272, 0, 'ar', 'admin', 'promocode.discount_type', 'الرمز الترويجي الاستخدام ', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(273, 0, 'ar', 'admin', 'promocode.percentage', 'النسبة المئوية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(274, 0, 'ar', 'admin', 'promocode.max_amount', 'أقصى مبلغ', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(275, 0, 'ar', 'admin', 'promocode.promo_description', 'وصف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(276, 0, 'ar', 'admin', 'reason.title', 'Cancel Reasons', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(277, 0, 'ar', 'admin', 'reason.add_reason', 'Add Reason', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(278, 0, 'ar', 'admin', 'reason.update_reason', 'Update Reason', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(279, 0, 'ar', 'admin', 'reason.reason', 'Reason', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(280, 0, 'ar', 'admin', 'reason.type', 'Type', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(281, 0, 'ar', 'admin', 'reason.status', 'Status', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(282, 0, 'ar', 'admin', 'peaktime.title', 'Peak Times', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(283, 0, 'ar', 'admin', 'peaktime.add_time', 'Add Peak Time', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(284, 0, 'ar', 'admin', 'peaktime.update_time', 'Update Peak Time', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(285, 0, 'ar', 'admin', 'peaktime.start_time', 'Start Time', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(286, 0, 'ar', 'admin', 'peaktime.end_time', 'End Time', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(287, 0, 'ar', 'admin', 'users.Users', 'المستخدمين', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(288, 0, 'ar', 'admin', 'users.Add_User', 'أضف المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(289, 0, 'ar', 'admin', 'users.Update_User', 'تحديث المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(290, 0, 'ar', 'admin', 'users.Rating', 'تقييم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(291, 0, 'ar', 'admin', 'users.Wallet_Amount', 'مبلغ المحفظة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(292, 0, 'ar', 'admin', 'users.User_Details', 'بيانات المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(293, 0, 'ar', 'admin', 'users.Wallet_Balance', 'رصيد المحفظة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(294, 0, 'ar', 'admin', 'name', 'اسم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(295, 0, 'ar', 'admin', 'first_name', 'الاسم الاول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(296, 0, 'ar', 'admin', 'last_name', 'الكنية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(297, 0, 'ar', 'admin', 'picture', 'صورة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(298, 0, 'ar', 'admin', 'mobile', 'التليفون المحمول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(299, 0, 'ar', 'admin', 'cancel', 'إلغاء', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(300, 0, 'ar', 'admin', 'view', 'رأي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(301, 0, 'ar', 'admin', 'update', 'تحديث\n', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(302, 0, 'ar', 'admin', 'id', 'هوية شخصية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(303, 0, 'ar', 'admin', 'gender', 'جنس', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(304, 0, 'ar', 'admin', 'address', 'عنوان', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(305, 0, 'ar', 'admin', 'action', 'عمل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(306, 0, 'ar', 'admin', 'Enable', 'مكن', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(307, 0, 'ar', 'admin', 'Disable', 'تعطيل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(308, 0, 'ar', 'admin', 'type', 'نوع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(309, 0, 'ar', 'admin', 'status', 'الحالة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(310, 0, 'ar', 'admin', 'message', 'رسالة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(311, 0, 'ar', 'admin', 'amount', 'كمية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(312, 0, 'ar', 'admin', 'company', 'شركة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(313, 0, 'ar', 'admin', 'logo', 'شعار', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(314, 0, 'ar', 'admin', 'service_select', 'يرجى إنشاء نوع الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(315, 0, 'ar', 'admin', 'pages.pages', 'صفحات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(316, 0, 'ar', 'admin', 'request.Booking_ID', 'معرف الحجز', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(317, 0, 'ar', 'admin', 'request.User_Name', 'اسم المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(318, 0, 'ar', 'admin', 'request.Date_Time', 'التاريخ & amp؛ زمن', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(319, 0, 'ar', 'admin', 'request.Provider_Name', 'اسم المزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(320, 0, 'ar', 'admin', 'request.Payment_Mode', 'طريقة الدفع', '2019-06-11 20:40:47', '2019-06-11 20:40:47'),
(321, 0, 'ar', 'admin', 'request.Payment_Status', 'حالة السداد', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(322, 0, 'ar', 'admin', 'request.Request_Id', 'طلب معرف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(323, 0, 'ar', 'admin', 'request.Scheduled_Date_Time', 'تاريخ ووقت مجدول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(324, 0, 'ar', 'admin', 'request.picked_up', 'التقط', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(325, 0, 'ar', 'admin', 'request.dropped', 'إسقاط', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(326, 0, 'ar', 'admin', 'request.request_details', 'طلب تفاصيل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(327, 0, 'ar', 'admin', 'request.commission', 'عمولة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(328, 0, 'ar', 'admin', 'request.date', 'بتاريخ', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(329, 0, 'ar', 'admin', 'request.status', 'الحالة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(330, 0, 'ar', 'admin', 'request.earned', 'حصل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(331, 0, 'ar', 'admin', 'request.provider_not_assigned', 'موفر لم يتم تعيينه بعد!', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(332, 0, 'ar', 'admin', 'request.total_distance', 'المسافة الكلية', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(333, 0, 'ar', 'admin', 'request.ride_scheduled_time', 'ركوب الوقت المجدول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(334, 0, 'ar', 'admin', 'request.ride_start_time', 'Ride Start Time', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(335, 0, 'ar', 'admin', 'request.ride_end_time', 'ركوب نهاية الوقت', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(336, 0, 'ar', 'admin', 'request.pickup_address', 'عنوان لاقط', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(337, 0, 'ar', 'admin', 'request.drop_address', 'إسقاط العنوان', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(338, 0, 'ar', 'admin', 'request.base_price', 'السعر الأساسي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(339, 0, 'ar', 'admin', 'request.minutes_price', 'سعر الدقيقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(340, 0, 'ar', 'admin', 'request.hours_price', 'سعر الساعات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(341, 0, 'ar', 'admin', 'request.distance_price', 'المسافة السعر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(342, 0, 'ar', 'admin', 'request.fleet_commission', 'لجنة الاسطول', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(343, 0, 'ar', 'admin', 'request.discount_price', 'سعر الخصم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(344, 0, 'ar', 'admin', 'request.tax_price', 'سعر الضريبة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(345, 0, 'ar', 'admin', 'request.surge_price', 'السعر المفاجئ', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(346, 0, 'ar', 'admin', 'request.tips', 'نصائح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(347, 0, 'ar', 'admin', 'request.total_amount', 'المبلغ الإجمالي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(348, 0, 'ar', 'admin', 'request.wallet_deduction', 'خصم المحفظة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(349, 0, 'ar', 'admin', 'request.paid_amount', 'المبلغ المدفوع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(350, 0, 'ar', 'admin', 'request.provider_earnings', 'أرباح مزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(351, 0, 'ar', 'admin', 'request.ride_status', 'وضع الركوب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(352, 0, 'ar', 'admin', 'request.cash_amount', 'مبلغ نقدي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(353, 0, 'ar', 'admin', 'request.card_amount', 'مبلغ البطاقة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(354, 0, 'ar', 'admin', 'review.Request_ID', 'طلب معرف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(355, 0, 'ar', 'admin', 'review.Rating', 'تقييم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(356, 0, 'ar', 'admin', 'review.Comments', 'تعليقات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(357, 0, 'ar', 'admin', 'review.Provider_Reviews', 'موفر مراجعات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(358, 0, 'ar', 'admin', 'review.User_Reviews', 'مراجعات المستخدم', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(359, 0, 'ar', 'admin', 'dashboard.Rides', 'العدد الإجمالي للركوب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(360, 0, 'ar', 'admin', 'dashboard.Revenue', 'إيرادات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(361, 0, 'ar', 'admin', 'dashboard.service', 'عدد أنواع الخدمات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(362, 0, 'ar', 'admin', 'dashboard.cancel_count', 'مستخدم تم إلغاء العد', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(363, 0, 'ar', 'admin', 'dashboard.provider_cancel_count', 'مقدم إلغاء ملغى', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(364, 0, 'ar', 'admin', 'dashboard.fleets', 'عدد الاساطيل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(365, 0, 'ar', 'admin', 'dashboard.providers', 'عدد مقدمي الخدمات', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(366, 0, 'ar', 'admin', 'dashboard.scheduled', 'عدد رحلات المجدولة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(367, 0, 'ar', 'admin', 'dashboard.Recent_Rides', 'ركوب الأخيرة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(368, 0, 'ar', 'admin', 'dashboard.View_Ride_Details', 'عرض تفاصيل القيادة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(369, 0, 'ar', 'admin', 'dashboard.No_Details_Found', 'لا توجد تفاصيل وجدت', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(370, 0, 'ar', 'admin', 'dashboard.cancel_rides', 'جولات ملغاة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(371, 0, 'ar', 'admin', 'dashboard.over_earning', 'على كل الكسب', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(372, 0, 'ar', 'admin', 'dashboard.over_commission', 'على جميع اللجان', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(373, 0, 'ar', 'admin', 'heatmap.Ride_Heatmap', 'ركوب هيت', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(374, 0, 'ar', 'admin', 'push.Push_Notification', 'دفع الإخطار', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(375, 0, 'ar', 'admin', 'push.Sent_to', 'ارسل الى', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(376, 0, 'ar', 'admin', 'push.message', 'الرسالة المرسلة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(377, 0, 'ar', 'admin', 'push.Push_Now', 'ادفع الآن', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(378, 0, 'ar', 'admin', 'push.Schedule_Push', 'الجدول الزمني دفع', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(379, 0, 'ar', 'admin', 'push.Condition', 'شرط', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(380, 0, 'ar', 'admin', 'push.Notification_History', 'تاريخ الإخطار', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(381, 0, 'ar', 'admin', 'push.Sent_on', 'أرسلت في', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(382, 0, 'ar', 'admin', 'transaction_ref', 'معرف المعاملة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(383, 0, 'ar', 'admin', 'transaction_desc', 'وصف', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(384, 0, 'ar', 'admin', 'sno', 'سنو', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(385, 0, 'ar', 'admin', 'by', 'إرسال / استقبال', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(386, 0, 'ar', 'admin', 'current_balance', 'الرصيد الحالي', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(387, 0, 'ar', 'admin', 'transfer', 'نقل', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(388, 0, 'ar', 'admin', 'send', 'إرسال', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(389, 0, 'ar', 'admin', 'datetime', 'التاريخ & amp؛ زمن', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(390, 0, 'ar', 'admin', 'approve', 'إرسال', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(391, 0, 'ar', 'admin', 'settle', 'تستقر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(392, 0, 'ar', 'admin', 'account_manager_msgs.account_saved', 'تفاصيل مدير الحسابات المحفوظة بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(393, 0, 'ar', 'admin', 'account_manager_msgs.account_not_found', 'مدير الحساب غير موجود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(394, 0, 'ar', 'admin', 'account_manager_msgs.account_update', 'تم تحديث مدير الحساب بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(395, 0, 'ar', 'admin', 'account_manager_msgs.account_delete', 'تم حذف مدير الحساب بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(396, 0, 'ar', 'admin', 'dispatcher_msgs.dispatcher_saved', 'تفاصيل مرسل المحفوظة بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(397, 0, 'ar', 'admin', 'dispatcher_msgs.dispatcher_not_found', 'مرسل غير موجود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(398, 0, 'ar', 'admin', 'dispatcher_msgs.dispatcher_update', 'المرسل تحديث بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(399, 0, 'ar', 'admin', 'dispatcher_msgs.dispatcher_delete', 'المرسل المحذوف بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(400, 0, 'ar', 'admin', 'dispatcher_msgs.request_assigned', 'طلب معين للموفر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(401, 0, 'ar', 'admin', 'fleet_msgs.fleet_saved', 'تفاصيل الأسطول المحفوظة بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(402, 0, 'ar', 'admin', 'fleet_msgs.fleet_not_found', 'الأسطول غير موجود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(403, 0, 'ar', 'admin', 'fleet_msgs.fleet_update', 'تحديث الأسطول بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(404, 0, 'ar', 'admin', 'fleet_msgs.fleet_delete', 'الأسطول المحذوف بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(405, 0, 'ar', 'admin', 'provider_msgs.provider_saved', 'تفاصيل موفر المحفوظة بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(406, 0, 'ar', 'admin', 'provider_msgs.provider_not_found', 'موفر غير موجود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(407, 0, 'ar', 'admin', 'provider_msgs.provider_update', 'موفر تم تحديثه بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(408, 0, 'ar', 'admin', 'provider_msgs.provider_delete', 'تم حذف مقدم بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(409, 0, 'ar', 'admin', 'provider_msgs.provider_approve', 'وافق مزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(410, 0, 'ar', 'admin', 'provider_msgs.provider_disapprove', 'موفر الرفض', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(411, 0, 'ar', 'admin', 'provider_msgs.document_pending', 'المستندات verfication المعلقةg', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(412, 0, 'ar', 'admin', 'provider_msgs.document_approved', '\nتمت الموافقة على وثيقة مقدم الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(413, 0, 'ar', 'admin', 'provider_msgs.document_delete', 'تم حذف مستند الموفر', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(414, 0, 'ar', 'admin', 'provider_msgs.document_not_found', 'لم يتم العثور على وثيقة مقدم الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(415, 0, 'ar', 'admin', 'provider_msgs.service_type_pending', 'لم يتم تعيين نوع الخدمة لمزود الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(416, 0, 'ar', 'admin', 'provider_msgs.provider_pending', 'لم يتم تعيين نوع الخدمة أو مستندات التحقق المعلقة لموفر الخدمة', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(417, 0, 'ar', 'admin', 'provider_msgs.provider_service_update', 'تم تحديث نوع خدمة الموفر بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(418, 0, 'ar', 'admin', 'provider_msgs.provider_service_delete', 'تم حذف خدمة المزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(419, 0, 'ar', 'admin', 'provider_msgs.provider_service_not_found', 'لم يتم العثور على خدمة المزود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(420, 0, 'ar', 'admin', 'provider_msgs.trip_cancelled', 'رحلة ملغاة بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(421, 0, 'ar', 'admin', 'user_msgs.user_saved', 'المستخدم المحفوظة بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(422, 0, 'ar', 'admin', 'user_msgs.user_not_found', 'المستخدم ليس موجود', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(423, 0, 'ar', 'admin', 'user_msgs.user_update', 'تم تحديث المستخدم بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(424, 0, 'ar', 'admin', 'user_msgs.user_delete', 'تم حذف المستخدم بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(425, 0, 'ar', 'admin', 'document_msgs.document_saved', 'تم حفظ المستند بنجاح', '2019-06-11 20:40:47', '2019-06-11 20:41:26'),
(426, 0, 'ar', 'admin', 'document_msgs.document_not_found', 'المستند غير موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(427, 0, 'ar', 'admin', 'document_msgs.document_update', 'تم تحديث المستند بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(428, 0, 'ar', 'admin', 'document_msgs.document_delete', 'تم حذف المستند بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(429, 0, 'ar', 'admin', 'favourite_location_msgs.favourite_saved', 'المكان المفضل تم الحفظ بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(430, 0, 'ar', 'admin', 'favourite_location_msgs.favourite_not_found', 'المكان المفضل غير موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(431, 0, 'ar', 'admin', 'favourite_location_msgs.favourite_exists', 'المكان المفضل بالفعل موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(432, 0, 'ar', 'admin', 'favourite_location_msgs.favourite_update', 'تم تحديث الموقع المفضل بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(433, 0, 'ar', 'admin', 'favourite_location_msgs.favourite_delete', 'المكان المفضل المحذوفة بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(434, 0, 'ar', 'admin', 'promocode_msgs.promocode_saved', 'تم حفظ الرمز الترويجي بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(435, 0, 'ar', 'admin', 'promocode_msgs.promocode_not_found', 'الرمز الترويجي غير موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(436, 0, 'ar', 'admin', 'promocode_msgs.promocode_exists', 'الرمز الترويجي موجود بالفعل', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(437, 0, 'ar', 'admin', 'promocode_msgs.promocode_update', 'الرمز الترويجي تم تحديثه بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(438, 0, 'ar', 'admin', 'promocode_msgs.promocode_delete', 'تم حذف الرمز الترويجي بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(439, 0, 'ar', 'admin', 'peakhour_msgs.peakhour_saved', 'Peak Hour Saved Successfully', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(440, 0, 'ar', 'admin', 'peakhour_msgs.peakhour_not_found', 'Peak Hour Not Found', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(441, 0, 'ar', 'admin', 'peakhour_msgs.peakhour_exists', 'Peak Hour Already Exists', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(442, 0, 'ar', 'admin', 'peakhour_msgs.peakhour_update', 'Peak Hour Updated Successfully', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(443, 0, 'ar', 'admin', 'peakhour_msgs.peakhour_delete', 'Peak Hour Deleted Successfully', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(444, 0, 'ar', 'admin', 'reason_msgs.reason_saved', 'Reason Saved Successfully', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(445, 0, 'ar', 'admin', 'reason_msgs.reason_not_found', 'Reason Not Found', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(446, 0, 'ar', 'admin', 'reason_msgs.reason_exists', 'Reason Already Exists', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(447, 0, 'ar', 'admin', 'reason_msgs.reason_update', 'Reason Updated Successfully', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(448, 0, 'ar', 'admin', 'reason_msgs.reason_delete', 'Reason Deleted Successfully', '2019-06-11 20:40:48', '2019-06-11 20:41:26');
INSERT INTO `ltm_translations` (`id`, `status`, `locale`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(449, 0, 'ar', 'admin', 'service_type_msgs.service_type_saved', 'تم حفظ نوع الخدمة بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(450, 0, 'ar', 'admin', 'service_type_msgs.service_type_not_found', 'نوع الخدمة غير موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(451, 0, 'ar', 'admin', 'service_type_msgs.service_type_exists', 'نوع الخدمة بالفعل موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(452, 0, 'ar', 'admin', 'service_type_msgs.service_type_update', 'تم تحديث نوع الخدمة بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(453, 0, 'ar', 'admin', 'service_type_msgs.service_type_delete', 'تم حذف نوع الخدمة بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(454, 0, 'ar', 'admin', 'service_type_msgs.service_type_using', 'موفر استخدام هذه الخدمة ، لا يمكنك حذفها', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(455, 0, 'ar', 'admin', 'payment_msgs.amount_send', 'المبلغ ترسل بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(456, 0, 'ar', 'admin', 'payment_msgs.account_not_found', 'حساب الشريط غير موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(457, 0, 'ar', 'admin', 'payment_msgs.amount_added', ' وأضاف إلى محفظتك', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(458, 0, 'ar', 'api', 'user.incorrect_password', 'كلمة سر خاطئة', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(459, 0, 'ar', 'api', 'user.incorrect_old_password', 'كلمة السر القديمة غير صحيحة', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(460, 0, 'ar', 'api', 'user.change_password', 'المطلوب هو كلمة المرور الجديدة يجب\nلا تكون نفس كلمة المرور القديمة', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(461, 0, 'ar', 'api', 'user.password_updated', 'تم تحديث كلمة السر', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(462, 0, 'ar', 'api', 'user.location_updated', 'تحديث الموقع', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(463, 0, 'ar', 'api', 'user.language_updated', 'تحديث اللغة', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(464, 0, 'ar', 'api', 'user.profile_updated', 'تحديث الملف الشخصي', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(465, 0, 'ar', 'api', 'user.user_not_found', 'المستخدم ليس موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(466, 0, 'ar', 'api', 'user.not_paid', 'المستخدم غير مدفوع', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(467, 0, 'ar', 'api', 'user.referral_amount', 'مبلغ الإحالة', '2019-06-11 20:40:48', '2019-06-11 20:41:26'),
(468, 0, 'ar', 'api', 'user.referral_count', 'عدد الإحالات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(469, 0, 'ar', 'api', 'user.invite_friends', '<p style=\'color:#FDFEFE;\'>أحضر 4 صديقًا<br>واكسب <span color=\'#00E4C5\'>€6</span> لكل رئيس</p>', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(470, 0, 'ar', 'api', 'provider.incorrect_password', 'كلمة سر خاطئة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(471, 0, 'ar', 'api', 'provider.incorrect_old_password', 'كلمة السر القديمة غير صحيحة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(472, 0, 'ar', 'api', 'provider.change_password', 'المطلوب هو كلمة المرور الجديدة يجب لا تكون نفس كلمة المرور القديمة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(473, 0, 'ar', 'api', 'provider.password_updated', 'تم تحديث كلمة السر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(474, 0, 'ar', 'api', 'provider.location_updated', 'تحديث الموقع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(475, 0, 'ar', 'api', 'provider.language_updated', 'تحديث اللغة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(476, 0, 'ar', 'api', 'provider.profile_updated', 'تحديث الملف الشخصي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(477, 0, 'ar', 'api', 'provider.provider_not_found', 'موفر غير موجود', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(478, 0, 'ar', 'api', 'provider.not_approved', 'لم تتم الموافقة على حسابك للقيادة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(479, 0, 'ar', 'api', 'provider.incorrect_email', 'عنوان البريد الإلكتروني أو كلمة المرور التي أدخلتها غير صحيح', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(480, 0, 'ar', 'api', 'provider.referral_amount', 'مبلغ الإحالة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(481, 0, 'ar', 'api', 'provider.referral_count', 'عدد الإحالات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(482, 0, 'ar', 'api', 'provider.invite_friends', '<p style=\'color:#FDFEFE;\'>أحضر 4 صديقًا<br>واكسب <span color=\'#00E4C5\'>€6</span> لكل رئيس</p>', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(483, 0, 'ar', 'api', 'ride.request_inprogress', 'طلب بالفعل في التقدم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(484, 0, 'ar', 'api', 'ride.no_providers_found', 'لا يوجد سائقين', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(485, 0, 'ar', 'api', 'ride.request_cancelled', 'Your Ride Cancelled', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(486, 0, 'ar', 'api', 'ride.already_cancelled', 'بالفعل ركوب ملغاة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(487, 0, 'ar', 'api', 'ride.ride_cancelled', 'ركوب ملغى', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(488, 0, 'ar', 'api', 'ride.already_onride', 'أنت بالفعل غير متواجد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(489, 0, 'ar', 'api', 'ride.provider_rated', 'سائق تقييمه', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(490, 0, 'ar', 'api', 'ride.request_scheduled', 'الركوب المقرر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(491, 0, 'ar', 'api', 'ride.request_already_scheduled', 'ركوب المقرر بالفعل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(492, 0, 'ar', 'api', 'ride.request_modify_location', 'المستخدم تغيير عنوان الوجهة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(493, 0, 'ar', 'api', 'ride.request_completed', 'اكتمل الطلب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(494, 0, 'ar', 'api', 'ride.request_not_completed', 'طلب لم يكتمل بعد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(495, 0, 'ar', 'api', 'ride.request_rejected', 'تم رفض الطلب بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(496, 0, 'ar', 'api', 'invalid', 'بيانات الاعتماد غير صالحة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(497, 0, 'ar', 'api', 'unauthenticated', 'غير مصدق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(498, 0, 'ar', 'api', 'destination_changed', 'تم تغيير موقع الوجهة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(499, 0, 'ar', 'api', 'unable_accept', 'غير قادر على القبول ، يرجى المحاولة مرة أخرى في وقت لاحق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(500, 0, 'ar', 'api', 'connection_err', 'خطأ في الإتصال', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(501, 0, 'ar', 'api', 'logout_success', 'تم تسجيل الخروج بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(502, 0, 'ar', 'api', 'email_available', 'البريد الإلكتروني المتاحة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(503, 0, 'ar', 'api', 'email_not_available', 'البريد الإلكتروني غير متوفر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(504, 0, 'ar', 'api', 'services_not_found', 'الخدمات غير موجودة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(505, 0, 'ar', 'api', 'promocode_applied', 'الرمز الترويجي المطبق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(506, 0, 'ar', 'api', 'promocode_expired', 'انتهاء مدة العرضd', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(507, 0, 'ar', 'api', 'promocode_already_in_use', '\nالرمز الترويجي موجود بالفعل في الاستخدام', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(508, 0, 'ar', 'api', 'paid', 'دفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(509, 0, 'ar', 'api', 'added_to_your_wallet', 'تمت إضافته إلى محفظتك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(510, 0, 'ar', 'api', 'amount_success', 'طلب المبلغ المضافة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(511, 0, 'ar', 'api', 'amount_cancel', 'تم إلغاء الطلب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(512, 0, 'ar', 'api', 'amount_max', 'قد لا يكون المبلغ أكبر من ', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(513, 0, 'ar', 'api', 'card_already', 'البطاقة مضافة بالفعل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(514, 0, 'ar', 'api', 'card_added', 'تمت إضافة البطاقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(515, 0, 'ar', 'api', 'card_deleted', 'بطاقة المحذوفة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(516, 0, 'ar', 'api', 'push.request_accepted', 'ركوبك مقبول من قبل سائق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(517, 0, 'ar', 'api', 'push.arrived', 'وصل السائق في موقعك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(518, 0, 'ar', 'api', 'push.pickedup', 'ركوب بدأ', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(519, 0, 'ar', 'api', 'push.complete', 'اكتمل الركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(520, 0, 'ar', 'api', 'push.rate', 'تم تقييمه بنجاح', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(521, 0, 'ar', 'api', 'push.dropped', 'اكتمال رحلتك بنجاح. عليك أن تدفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(522, 0, 'ar', 'api', 'push.incoming_request', 'جولة جديدة واردة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(523, 0, 'ar', 'api', 'push.added_money_to_wallet', ' تمت إضافته إلى محفظتك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(524, 0, 'ar', 'api', 'push.charged_from_wallet', ' مشحونة من محفظتك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(525, 0, 'ar', 'api', 'push.document_verfied', 'يتم التحقق من المستندات الخاصة بك ، أنت الآن على استعداد لبدء عملك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(526, 0, 'ar', 'api', 'push.user_cancelled', 'مستخدم ألغى ركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(527, 0, 'ar', 'api', 'push.provider_cancelled', 'سائق ألغى ركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(528, 0, 'ar', 'api', 'push.schedule_start', 'لقد بدأت رحلة الجدول الزمني الخاص بك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(529, 0, 'ar', 'api', 'transaction.admin_commission', 'عمولة المشرف', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(530, 0, 'ar', 'api', 'transaction.fleet_debit', 'دفعت لجنة الاسطول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(531, 0, 'ar', 'api', 'transaction.fleet_add', 'تمت إضافة عمولة الأسطول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(532, 0, 'ar', 'api', 'transaction.fleet_recharge', 'اعادة تكليف الاسطول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(533, 0, 'ar', 'api', 'transaction.discount_apply', 'الخصم قد تم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(534, 0, 'ar', 'api', 'transaction.discount_refund', 'خصم مبلغ الاسترداد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(535, 0, 'ar', 'api', 'transaction.discount_recharge', 'موفر خصم كمية الشحن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(536, 0, 'ar', 'api', 'transaction.tax_credit', 'مبلغ الضريبة المدين', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(537, 0, 'ar', 'api', 'transaction.tax_debit', 'مبلغ الضريبة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(538, 0, 'ar', 'api', 'transaction.provider_credit', 'إضافة كمية الركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(539, 0, 'ar', 'api', 'transaction.provider_recharge', 'مزود ركوب كمية التغذية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(540, 0, 'ar', 'api', 'transaction.user_recharge', 'تعبئة رصيد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(541, 0, 'ar', 'api', 'transaction.user_trip', 'رحلة قصيرة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(542, 0, 'ar', 'auth', 'failed', 'لا تتطابق بيانات الاعتماد هذه مع سجلاتنا.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(543, 0, 'ar', 'auth', 'throttle', 'عدد محاولات تسجيل الدخول أكثر من اللازم. يرجى المحاولة مرة أخرى: ثانية ثانية.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(544, 0, 'ar', 'pagination', 'previous', 'وقوو]؛ سابق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(545, 0, 'ar', 'pagination', 'next', 'التالي & raquo;', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(546, 0, 'ar', 'passwords', 'password', 'يجب أن تتكون كلمات المرور من ستة أحرف على الأقل وتتطابق مع التأكيد.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(547, 0, 'ar', 'passwords', 'reset', 'تم إعادة تعيين كلمة المرور الخاصة بك!', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(548, 0, 'ar', 'passwords', 'sent', 'لقد أرسلنا عبر البريد الإلكتروني رابط إعادة تعيين كلمة المرور الخاص بك!', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(549, 0, 'ar', 'passwords', 'token', 'رمز إعادة تعيين كلمة المرور هذا غير صالح.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(550, 0, 'ar', 'passwords', 'user', 'لا يمكننا العثور على مستخدم لديه عنوان البريد الإلكتروني هذا.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(551, 0, 'ar', 'provider', 'profile.help', 'مساعدة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(552, 0, 'ar', 'provider', 'profile.my_profile', 'ملفي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(553, 0, 'ar', 'provider', 'profile.change_password', 'غير كلمة السر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(554, 0, 'ar', 'provider', 'profile.logout', 'الخروج', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(555, 0, 'ar', 'provider', 'profile.profile', 'الملف الشخصي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(556, 0, 'ar', 'provider', 'profile.manage_documents', 'إدارة المستندات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(557, 0, 'ar', 'provider', 'profile.update_location', 'تحديث الموقع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(558, 0, 'ar', 'provider', 'profile.first_name', 'الاسم الاول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(559, 0, 'ar', 'provider', 'profile.last_name', 'الكنية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(560, 0, 'ar', 'provider', 'profile.avatar', 'الصورة الرمزية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(561, 0, 'ar', 'provider', 'profile.phone', 'هاتف', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(562, 0, 'ar', 'provider', 'profile.language', 'لغة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(563, 0, 'ar', 'provider', 'profile.address', 'عنوان', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(564, 0, 'ar', 'provider', 'profile.full_address', 'ادخل الجناح ، الطابق ، الشقة (اختياري)', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(565, 0, 'ar', 'provider', 'profile.city', 'مدينة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(566, 0, 'ar', 'provider', 'profile.country', 'بلد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(567, 0, 'ar', 'provider', 'profile.pin', 'الرمز البريدي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(568, 0, 'ar', 'provider', 'profile.service_type', 'نوع الخدمة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(569, 0, 'ar', 'provider', 'profile.car_number', 'رقم السياره', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(570, 0, 'ar', 'provider', 'profile.car_model', 'طراز السيارة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(571, 0, 'ar', 'provider', 'profile.driver_document', 'وثائق السائق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(572, 0, 'ar', 'provider', 'profile.vehicle_document', 'وثائق السيارة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(573, 0, 'ar', 'provider', 'profile.enter_location', 'أدخل الموقع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(574, 0, 'ar', 'provider', 'profile.update', 'تحديث', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(575, 0, 'ar', 'provider', 'profile.change_mobile', 'تغيير رقم الجوال', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(576, 0, 'ar', 'provider', 'profile.verify', 'التحقق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(577, 0, 'ar', 'provider', 'profile.verified', 'التحقق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(578, 0, 'ar', 'provider', 'profile.ride', 'اركب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(579, 0, 'ar', 'provider', 'profile.drive', 'قيادة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(580, 0, 'ar', 'provider', 'profile.cities', 'مدن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(581, 0, 'ar', 'provider', 'profile.fare_estimate', 'تقدير الأجرة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(582, 0, 'ar', 'provider', 'profile.signup_to_ride', 'اشترك في ركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(583, 0, 'ar', 'provider', 'profile.become_a_driver', 'كن سائق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(584, 0, 'ar', 'provider', 'profile.ride_now', 'اركب الآن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(585, 0, 'ar', 'provider', 'profile.get_app_on', 'الحصول على التطبيقات على', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(586, 0, 'ar', 'provider', 'profile.connect_us', 'تواصل معنا', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(587, 0, 'ar', 'provider', 'profile.home', 'الصفحة الرئيسية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(588, 0, 'ar', 'provider', 'profile.my_trips', 'رحلاتي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(589, 0, 'ar', 'provider', 'profile.partner_earnings', 'أرباح الشريك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(590, 0, 'ar', 'provider', 'profile.incoming_request', 'طلب وارد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(591, 0, 'ar', 'provider', 'profile.paul_walker', 'Paul Walker', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(592, 0, 'ar', 'provider', 'profile.accept', 'قبول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(593, 0, 'ar', 'provider', 'profile.cancel', 'إلغاء', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(594, 0, 'ar', 'provider', 'profile.wallet_transaction', 'معاملة المحفظة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(595, 0, 'ar', 'provider', 'profile.transfer', 'نقل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(596, 0, 'ar', 'provider', 'profile.upload', 'رفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(597, 0, 'ar', 'provider', 'profile.error_msg', 'يمكن أن تحتوي فقط على أحرف أبجدية رقمية و. - المساحات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(598, 0, 'ar', 'provider', 'profile.error_phone', 'رقم هاتف غير صحيح', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(599, 0, 'ar', 'provider', 'partner.payment', 'بيانات الدفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(600, 0, 'ar', 'provider', 'partner.upcoming', 'القادمة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(601, 0, 'ar', 'provider', 'partner.total_earnings', 'الأرباح الكلية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(602, 0, 'ar', 'provider', 'partner.trips_completed', 'تريبس استكمل اليوم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(603, 0, 'ar', 'provider', 'partner.daily_trip', 'هدف الرحلة اليومي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(604, 0, 'ar', 'provider', 'partner.fully_completed', 'رحلات التاجر كاملة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(605, 0, 'ar', 'provider', 'partner.acceptance', 'معدل القبول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(606, 0, 'ar', 'provider', 'partner.driver_cancel', 'إلغاء السائقين', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(607, 0, 'ar', 'provider', 'partner.weekly_earning', 'الأرباح الأسبوعية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(608, 0, 'ar', 'provider', 'partner.trip_earning', 'أرباح الرحلة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(609, 0, 'ar', 'provider', 'partner.estimate_payout', 'العائد التقديري', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(610, 0, 'ar', 'provider', 'partner.daily_earnings', 'الأرباح اليومية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(611, 0, 'ar', 'provider', 'partner.status', 'الحالة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(612, 0, 'ar', 'provider', 'partner.all_trip', 'جميع الرحلات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(613, 0, 'ar', 'provider', 'partner.completed', 'منجز', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(614, 0, 'ar', 'provider', 'partner.pending', 'قيد الانتظار', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(615, 0, 'ar', 'provider', 'partner.pickup', 'اختار المعاد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(616, 0, 'ar', 'provider', 'partner.booking_id', 'رقم الحجز', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(617, 0, 'ar', 'provider', 'partner.vehicle', 'مركبة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(618, 0, 'ar', 'provider', 'partner.duration', 'المدة الزمنية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(619, 0, 'ar', 'provider', 'partner.distance(km)', 'مسافه: بعد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(620, 0, 'ar', 'provider', 'partner.invoice_amount', 'قيمة الفاتورة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(621, 0, 'ar', 'provider', 'partner.cash_collected', 'النقدية المجمعة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(622, 0, 'ar', 'provider', 'partner.upcoming_tips', 'الرحلات القادمة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(623, 0, 'ar', 'provider', 'partner.pickup_time', 'اختار المعاد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(624, 0, 'ar', 'provider', 'partner.pickup_address', 'عنوان لاقط', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(625, 0, 'ar', 'provider', 'partner.action', 'عمل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(626, 0, 'ar', 'provider', 'signup.already_register', 'هل أنت مسجل بالفعل؟', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(627, 0, 'ar', 'provider', 'signup.sign_up', 'سجل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(628, 0, 'ar', 'provider', 'signup.enter_phone', 'أدخل رقم الهاتف', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(629, 0, 'ar', 'provider', 'signup.email_address', 'عنوان بريد الكتروني', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(630, 0, 'ar', 'provider', 'signup.male', 'الذكر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(631, 0, 'ar', 'provider', 'signup.female', 'إناثا', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(632, 0, 'ar', 'provider', 'signup.password', 'كلمه السر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(633, 0, 'ar', 'provider', 'signup.confirm_password', 'تأكيد كلمة المرور', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(634, 0, 'ar', 'provider', 'signup.register', 'تسجيل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(635, 0, 'ar', 'provider', 'signup.create_new_acc', 'انشاء حساب جديد', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(636, 0, 'ar', 'provider', 'signup.sign_in', 'تسجيل الدخول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(637, 0, 'ar', 'provider', 'signup.remember_me', 'تذكرنى', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(638, 0, 'ar', 'provider', 'signup.login', 'تسجيل الدخول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(639, 0, 'ar', 'provider', 'signup.forgot_password', 'نسيت رقمك السري?', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(640, 0, 'ar', 'provider', 'signup.login_facebook', 'تسجيل الدخول باستخدام الفيسبوك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(641, 0, 'ar', 'provider', 'signup.login_google', 'تسجيل الدخول باستخدام GOOGLE +', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(642, 0, 'ar', 'provider', 'signup.reset_password', 'إعادة ضبط كلمة المرور', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(643, 0, 'ar', 'provider', 'signup.already_have_acc', 'هل لديك حساب?', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(644, 0, 'ar', 'provider', 'signup.send_password_reset_link', 'إرسال كلمة المرور رابط إعادة تعيين', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(645, 0, 'ar', 'provider', 'card.fullname', 'الاسم الكامل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(646, 0, 'ar', 'provider', 'card.card_no', 'رقم البطاقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(647, 0, 'ar', 'provider', 'card.cvv', 'CVV', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(648, 0, 'ar', 'provider', 'card.add_card', 'إضافة بطاقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(649, 0, 'ar', 'provider', 'card.add_debit_card', 'إضافة بطاقة الخصم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(650, 0, 'ar', 'provider', 'card.delete', 'حذف', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(651, 0, 'ar', 'provider', 'card.month', 'شهر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(652, 0, 'ar', 'provider', 'card.year', 'عام', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(653, 0, 'ar', 'provider', 'card.default', 'افتراضي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(654, 0, 'ar', 'provider', 'card.list', 'بطاقات الخصم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(655, 0, 'ar', 'provider', 'card.type', 'نوع البطاقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(656, 0, 'ar', 'provider', 'card.four', 'آخر أربعة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(657, 0, 'ar', 'provider', 'card.set', 'الوضع الإفتراضي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(658, 0, 'ar', 'provider', 'card.notfound', 'لم يتم إضافة بطاقة خصم حتى الآن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(659, 0, 'ar', 'provider', 'transaction_ref', 'معرف المعاملة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(660, 0, 'ar', 'provider', 'transaction_desc', 'وصف', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(661, 0, 'ar', 'provider', 'sno', 'سنو', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(662, 0, 'ar', 'provider', 'amount', 'كمية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(663, 0, 'ar', 'provider', 'status', 'الحالة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(664, 0, 'ar', 'provider', 'current_balance', 'الرصيد الحالي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(665, 0, 'ar', 'provider', 'transfer', 'نقل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(666, 0, 'ar', 'provider', 'datetime', 'التاريخ & amp؛ زمن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(667, 0, 'ar', 'provider', 'cancel', 'إلغاء', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(668, 0, 'ar', 'provider', 'document_pending', 'التحقق من المستندات في انتظار المراجعة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(669, 0, 'ar', 'provider', 'document_upload', 'رفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(670, 0, 'ar', 'provider', 'card_pending', 'قسم بطاقة الخصم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(671, 0, 'ar', 'provider', 'drive_now', 'قد الآن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(672, 0, 'ar', 'provider', 'offline', 'الذهاب دون اتصال', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(673, 0, 'ar', 'provider', 'online', 'اتصل بالانترنت', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(674, 0, 'ar', 'provider', 'hours', 'ساعات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(675, 0, 'ar', 'provider', 'minutes', 'الدقائق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(676, 0, 'ar', 'provider', 'credit', 'ائتمان', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(677, 0, 'ar', 'provider', 'debit', 'مدين', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(678, 0, 'ar', 'provider', 'lang', 'ar', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(679, 0, 'ar', 'provider', 'enter_location', 'أدخل الموقع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(680, 0, 'ar', 'provider', 'your_location', 'موقعك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(681, 0, 'ar', 'provider', 'expires', 'تنتهي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(682, 0, 'ar', 'servicetypes', 'MIN', 'في التسعير الدقيقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(683, 0, 'ar', 'servicetypes', 'HOUR', 'سعر لكل ساعة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(684, 0, 'ar', 'servicetypes', 'DISTANCE', 'التسعير المسافة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(685, 0, 'ar', 'servicetypes', 'DISTANCEMIN', 'المسافة والسعر في الدقيقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(686, 0, 'ar', 'servicetypes', 'DISTANCEHOUR', 'المسافة والسعر لكل ساعة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(687, 0, 'ar', 'user', 'profile.old_password', 'كلمة المرور القديمة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(688, 0, 'ar', 'user', 'profile.password', 'كلمه السر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(689, 0, 'ar', 'user', 'profile.confirm_password', 'تأكيد كلمة المرور', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(690, 0, 'ar', 'user', 'profile.first_name', 'الاسم الاول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(691, 0, 'ar', 'user', 'profile.last_name', 'الكنية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(692, 0, 'ar', 'user', 'profile.email', 'البريد الإلكتروني', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(693, 0, 'ar', 'user', 'profile.mobile', 'التليفون المحمول', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(694, 0, 'ar', 'user', 'profile.general_information', 'معلومات عامة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(695, 0, 'ar', 'user', 'profile.profile_picture', 'الصوره الشخصيه', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(696, 0, 'ar', 'user', 'profile.wallet_balance', 'رصيد المحفظة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(697, 0, 'ar', 'user', 'profile.edit', 'تصحيح', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(698, 0, 'ar', 'user', 'profile.save', 'حفظ', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(699, 0, 'ar', 'user', 'profile.edit_information', 'تعديل المعلومات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(700, 0, 'ar', 'user', 'profile.change_password', 'غير كلمة السر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(701, 0, 'ar', 'user', 'profile.profile', 'الملف الشخصي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(702, 0, 'ar', 'user', 'profile.change_mobile', 'تغيير رقم الجوال', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(703, 0, 'ar', 'user', 'profile.verify', 'التحقق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(704, 0, 'ar', 'user', 'profile.verified', 'التحقق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(705, 0, 'ar', 'user', 'profile.settings', 'الإعدادات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(706, 0, 'ar', 'user', 'profile.logout', 'الخروج', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(707, 0, 'ar', 'user', 'profile.name', 'اسم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(708, 0, 'ar', 'user', 'profile.language', 'لغة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(709, 0, 'ar', 'user', 'cash', 'السيولة النقدية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(710, 0, 'ar', 'user', 'booking_id', 'رقم الحجز', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(711, 0, 'ar', 'user', 'service_number', 'رقم السياره', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(712, 0, 'ar', 'user', 'service_model', 'طراز السيارة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(713, 0, 'ar', 'user', 'service_type', 'نوع الخدمة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(714, 0, 'ar', 'user', 'card.fullname', 'الاسم الكامل', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(715, 0, 'ar', 'user', 'card.card_no', 'رقم البطاقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(716, 0, 'ar', 'user', 'card.cvv', 'CVV', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(717, 0, 'ar', 'user', 'card.add_card', 'إضافة بطاقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(718, 0, 'ar', 'user', 'card.delete', 'حذف', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(719, 0, 'ar', 'user', 'card.month', 'شهر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(720, 0, 'ar', 'user', 'card.year', 'عام', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(721, 0, 'ar', 'user', 'card.default', 'افتراضي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(722, 0, 'ar', 'user', 'card.delete_msg', 'هل أنت متأكد من حذف هذه البطاقة?', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(723, 0, 'ar', 'user', 'fare_breakdown', 'انفلات الأجرة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(724, 0, 'ar', 'user', 'ride.finding_driver', 'العثور على سائق الخاص بك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(725, 0, 'ar', 'user', 'ride.accepted_ride', 'قبلت رحلتك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(726, 0, 'ar', 'user', 'ride.arrived_ride', 'وصلت في موقعك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(727, 0, 'ar', 'user', 'ride.onride', 'استمتع بالركوب الخاص بك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(728, 0, 'ar', 'user', 'ride.waiting_payment', 'في انتظار الدفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(729, 0, 'ar', 'user', 'ride.rate_and_review', 'معدل ومراجعة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(730, 0, 'ar', 'user', 'ride.ride_now', 'اركب الآن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(731, 0, 'ar', 'user', 'ride.cancel_request', 'إلغاء الطلب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(732, 0, 'ar', 'user', 'ride.ride_status', 'وضع الركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(733, 0, 'ar', 'user', 'ride.dropped_ride', 'اكتمال ركوب الخاص بك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(734, 0, 'ar', 'user', 'ride.ride_details', 'تفاصيل ركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(735, 0, 'ar', 'user', 'ride.invoice', 'فاتورة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(736, 0, 'ar', 'user', 'ride.base_price', 'الاجرة الاساسية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(737, 0, 'ar', 'user', 'ride.tax_price', 'تسعيرة التاكسي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(738, 0, 'ar', 'user', 'ride.distance_price', 'المسافة أجرة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(739, 0, 'ar', 'user', 'ride.minutes_price', 'دقائق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(740, 0, 'ar', 'user', 'ride.hours_price', 'ساعات الأجرة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(741, 0, 'ar', 'user', 'ride.distance_travelled', 'المسافة المقطوعة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(742, 0, 'ar', 'user', 'ride.tips', 'نصائح', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(743, 0, 'ar', 'user', 'ride.comment', 'تعليق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(744, 0, 'ar', 'user', 'ride.detection_wallet', 'كشف المحفظة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(745, 0, 'ar', 'user', 'ride.rating', 'تقييم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(746, 0, 'ar', 'user', 'ride.km', 'كيلومتر', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(747, 0, 'ar', 'user', 'ride.total', 'مجموع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(748, 0, 'ar', 'user', 'ride.amount_paid', 'المبلغ المستحق للدفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(749, 0, 'ar', 'user', 'ride.promotion_applied', 'العرض المقدم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(750, 0, 'ar', 'user', 'ride.request_inprogress', 'الركوب بالفعل في التقدم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(751, 0, 'ar', 'user', 'ride.request_scheduled', 'ركوب المقرر بالفعل في هذا الوقت', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(752, 0, 'ar', 'user', 'ride.cancel_reason', 'الغاء السبب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(753, 0, 'ar', 'user', 'ride.wallet_deduction', 'خصم المحفظة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(754, 0, 'ar', 'user', 'dashboard', 'لوحة القيادة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(755, 0, 'ar', 'user', 'payment', 'دفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(756, 0, 'ar', 'user', 'wallet', 'محفظة نقود', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(757, 0, 'ar', 'user', 'my_wallet', 'محفظتى', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(758, 0, 'ar', 'user', 'my_trips', 'رحلاتي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(759, 0, 'ar', 'user', 'in_your_wallet', 'في محفظتك', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(760, 0, 'ar', 'user', 'status', 'الحالة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(761, 0, 'ar', 'user', 'driver_name', 'اسم السائق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(762, 0, 'ar', 'user', 'driver_rating', 'تقييم السائق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(763, 0, 'ar', 'user', 'payment_mode', 'طريقة الدفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(764, 0, 'ar', 'user', 'otp', 'مكتب المدعي العام', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(765, 0, 'ar', 'user', 'add_money', 'إضافة المال', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(766, 0, 'ar', 'user', 'date', 'تاريخ', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(767, 0, 'ar', 'user', 'schedule_date', 'تاريخ', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(768, 0, 'ar', 'user', 'amount', 'المبلغ الإجمالي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(769, 0, 'ar', 'user', 'type', 'نوع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(770, 0, 'ar', 'user', 'time', 'زمن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(771, 0, 'ar', 'user', 'request_id', 'طلب معرف', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(772, 0, 'ar', 'user', 'paid_via', 'دفع عن طريق', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(773, 0, 'ar', 'user', 'from', 'من عند', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(774, 0, 'ar', 'user', 'total_distance', 'المسافة الكلية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(775, 0, 'ar', 'user', 'eta', 'ETA', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(776, 0, 'ar', 'user', 'to', 'إلى', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(777, 0, 'ar', 'user', 'use_wallet_balance', 'استخدم رصيد المحفظة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(778, 0, 'ar', 'user', 'available_wallet_balance', 'رصيد المحفظة المتاح', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(779, 0, 'ar', 'user', 'estimated_fare', 'الأجرة المقدرة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(780, 0, 'ar', 'user', 'charged', 'متهم', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(781, 0, 'ar', 'user', 'payment_method', 'طرق الدفع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(782, 0, 'ar', 'user', 'promotion', 'الترقيات', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(783, 0, 'ar', 'user', 'promocode', 'الرموز الترويجية', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(784, 0, 'ar', 'user', 'add_promocode', 'أضف الرمز الترويجي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(785, 0, 'ar', 'user', 'upcoming_trips', 'الرحلات القادمة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(786, 0, 'ar', 'user', 'total', 'مجموع', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(787, 0, 'ar', 'user', 'promocode_select', 'حدد الرمز الترويجي', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(788, 0, 'ar', 'user', 'schedule_title', 'جدولة ركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(789, 0, 'ar', 'user', 'schedule', 'الجدول الزمني لاحقا', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(790, 0, 'ar', 'user', 'schedule_time', 'زمن', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(791, 0, 'ar', 'user', 'schedule_ride', 'جدول الركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(792, 0, 'ar', 'user', 'demand_node', 'ملاحظة: نظرًا لارتفاع الطلب ، قد تختلف الأجرة!', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(793, 0, 'ar', 'user', 'no_trips', 'لا رحلات المتاحة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(794, 0, 'ar', 'user', 'provider_details', 'تفاصيل مقدم الخدمة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(795, 0, 'ar', 'user', 'ride_cancel', 'إلغاء ركوب', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(796, 0, 'ar', 'user', 'enter_amount', 'أدخل المبلغ', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(797, 0, 'ar', 'user', 'please', 'رجاء', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(798, 0, 'ar', 'user', 'add_card', 'إضافة بطاقة', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(799, 0, 'ar', 'user', 'to_continue', 'لاستكمال', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(800, 0, 'ar', 'user', 'credit', 'ائتمان', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(801, 0, 'ar', 'user', 'debit', 'مدين', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(802, 0, 'ar', 'user', 'maperror', 'Invalid Map Key', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(803, 0, 'ar', 'user', 'referral', 'Refer a Friend', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(804, 0, 'ar', 'validation', 'accepted', 'يجب قبول السمة.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(805, 0, 'ar', 'validation', 'active_url', 'السمة: ليست عنوان URL صالحًا.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(806, 0, 'ar', 'validation', 'after', 'يجب أن تكون السمة: تاريخًا بعد: التاريخ.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(807, 0, 'ar', 'validation', 'after_or_equal', 'يجب أن تكون السمة: تاريخًا بعد أو يساوي: التاريخ.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(808, 0, 'ar', 'validation', 'alpha', 'قد تحتوي السمة: على أحرف فقط.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(809, 0, 'ar', 'validation', 'alpha_dash', 'قد تحتوي السمة: على أحرف وأرقام وشرطات فقط.', '2019-06-11 20:40:48', '2019-06-11 20:41:27'),
(810, 0, 'ar', 'validation', 'alpha_num', 'قد تحتوي السمة: على أحرف وأرقام فقط.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(811, 0, 'ar', 'validation', 'array', 'يجب أن تكون السمة: مصفوفة.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(812, 0, 'ar', 'validation', 'before', 'ال :attribute يجب أن يكون تاريخ من قبل :date.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(813, 0, 'ar', 'validation', 'before_or_equal', 'ال :attribute يجب أن يكون تاريخًا قبل أو يساوي :date.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(814, 0, 'ar', 'validation', 'between.numeric', 'ال :attribute يجب ان يكون بين :min و :max.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(815, 0, 'ar', 'validation', 'between.file', 'ال :attribute يجب ان يكون بين :min و :max kilobytes.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(816, 0, 'ar', 'validation', 'between.string', 'ال :attribute يجب ان يكون بين :min و :max characters.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(817, 0, 'ar', 'validation', 'between.array', 'ال :attribute يجب أن يكون بين :min و :max items.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(818, 0, 'ar', 'validation', 'boolean', 'يجب أن يكون حقل السمة: true أو false.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(819, 0, 'ar', 'validation', 'confirmed', 'لا يتطابق تأكيد السمة.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(820, 0, 'ar', 'validation', 'date', 'السمة: ليست تاريخًا صالحًا.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(821, 0, 'ar', 'validation', 'date_format', 'السمة: لا تتطابق مع التنسيق: format.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(822, 0, 'ar', 'validation', 'different', 'يجب أن تكون السمة و: أخرى مختلفة.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(823, 0, 'ar', 'validation', 'digits', 'يجب أن تكون السمة: أرقام أرقام.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(824, 0, 'ar', 'validation', 'digits_between', 'يجب أن تتراوح السمة: بين: min و: max numbers.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(825, 0, 'ar', 'validation', 'dimensions', 'تحتوي السمة: على أبعاد صور غير صالحة.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(826, 0, 'ar', 'validation', 'distinct', 'يحتوي حقل السمة على قيمة مكررة.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(827, 0, 'ar', 'validation', 'email', 'يجب أن تكون السمة: عنوان بريد إلكتروني صالحًا.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(828, 0, 'ar', 'validation', 'exists', 'السمة المحددة: غير صالحة.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(829, 0, 'ar', 'validation', 'file', 'السمة المحددة: غير صالحة', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(830, 0, 'ar', 'validation', 'filled', 'حقل السمة مطلوب.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(831, 0, 'ar', 'validation', 'image', 'يجب أن تكون السمة: صورة.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(832, 0, 'ar', 'validation', 'in', 'السمة المحددة: غير صالحة.', '2019-06-11 20:40:48', '2019-06-11 20:41:28'),
(833, 0, 'ar', 'validation', 'in_array', 'حقل السمة: غير موجود في: other.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(834, 0, 'ar', 'validation', 'integer', 'يجب أن تكون الخاصية المميزة: عدد صحيح.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(835, 0, 'ar', 'validation', 'ip', 'يجب أن تكون السمة: عنوان IP صالحًا.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(836, 0, 'ar', 'validation', 'json', 'يجب أن تكون السمة: عبارة عن سلسلة JSON صالحة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(837, 0, 'ar', 'validation', 'max.numeric', 'يجب أن تكون السمة: عبارة عن سلسلة JSON صالحة', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(838, 0, 'ar', 'validation', 'max.file', 'قد لا تكون السمة: أكبر من: max kilobytes.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(839, 0, 'ar', 'validation', 'max.string', 'قد لا تكون السمة: أكبر من: max characters.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(840, 0, 'ar', 'validation', 'max.array', 'قد لا تحتوي السمة: على أكثر من: الحد الأقصى للعناصر.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(841, 0, 'ar', 'validation', 'mimes', 'يجب أن تكون السمة: ملف من النوع:: القيم.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(842, 0, 'ar', 'validation', 'mimetypes', 'يجب أن تكون السمة: ملف من النوع:: القيم.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(843, 0, 'ar', 'validation', 'min.numeric', 'لا :attribute لا بد أن يكون على الأقل :min.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(844, 0, 'ar', 'validation', 'min.file', 'لا :attribute لا بد أن يكون على الأقل :min kilobytes.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(845, 0, 'ar', 'validation', 'min.string', 'لا :attribute لا بد أن يكون على الأقل :min characters.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(846, 0, 'ar', 'validation', 'min.array', 'لا :attribute لا بد أن يكون على الأقل :min items.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(847, 0, 'ar', 'validation', 'not_in', 'السمة المحددة: غير صالحة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(848, 0, 'ar', 'validation', 'numeric', 'يجب أن تكون السمة: رقمًا.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(849, 0, 'ar', 'validation', 'present', 'يجب أن يكون حقل السمة موجودًا.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(850, 0, 'ar', 'validation', 'regex', 'شكل السمة: غير صالح.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(851, 0, 'ar', 'validation', 'required', 'حقل السمة مطلوب.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(852, 0, 'ar', 'validation', 'required_if', 'حقل السمة مطلوب عندما: الآخر هو: القيمة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(853, 0, 'ar', 'validation', 'required_unless', 'حقل السمة مطلوب ما لم: الآخر في: القيم.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(854, 0, 'ar', 'validation', 'required_with', 'حقل السمة مطلوب عندما: تكون القيم موجودة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(855, 0, 'ar', 'validation', 'required_with_all', 'حقل السمة مطلوب عندما: تكون القيم موجودة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(856, 0, 'ar', 'validation', 'required_without', 'حقل السمة مطلوب عندما: تكون القيم prThe: حقل السمة مطلوب عندما: تكون القيم غير موجودة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(857, 0, 'ar', 'validation', 'required_without_all', 'حقل السمة مطلوب عند عدم وجود أي من: القيم.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(858, 0, 'ar', 'validation', 'same', 'يجب أن تتطابق السمة و: other.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(859, 0, 'ar', 'validation', 'size.numeric', 'يجب أن تكون السمة: الحجم.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(860, 0, 'ar', 'validation', 'size.file', 'يجب أن تكون السمة: حجم الكيلوبايت.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(861, 0, 'ar', 'validation', 'size.string', 'السمة يجب أن تكون: حجم الحروف.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(862, 0, 'ar', 'validation', 'size.array', 'يجب أن تحتوي السمة: على عناصر الحجم.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(863, 0, 'ar', 'validation', 'string', 'يجب أن تكون السمة: سلسلة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(864, 0, 'ar', 'validation', 'timezone', 'يجب أن تكون السمة: منطقة صالحة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(865, 0, 'ar', 'validation', 'unique', 'لقد تم بالفعل اتخاذ الخاصية المميزة:.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(866, 0, 'ar', 'validation', 'uploaded', 'أخفق تحميل السمة.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(867, 0, 'ar', 'validation', 'url', 'لا :attribute التنسيق غير صالح.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(868, 0, 'ar', 'validation', 'custom.s_latitude.required', 'عنوان المصدر مطلوب', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(869, 0, 'ar', 'validation', 'custom.d_latitude.required', 'عنوان الوجهة مطلوب', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(870, 0, 'en', 'admin', 'back', 'Back', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(871, 0, 'en', 'admin', 'db_backup', 'DB Backup', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(872, 0, 'en', 'admin', 'db_backup_btn', 'DB Backup Download', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(873, 0, 'en', 'admin', 'demomode', '\"CRUD Feature\" has been disabled on the Demo Admin Panel. This feature will be enabled on your product which you will be purchasing, meahwhile if you have any queries feel free to contact our 24/7 support at info@appdupe.com.', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(874, 0, 'en', 'admin', 'fleet.fleet_owners', 'Fleet Owners', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(875, 0, 'en', 'admin', 'fleet.add_new_fleet_owner', 'Add New Fleet Owner', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(876, 0, 'en', 'admin', 'fleet.show_provider', 'Show Provider', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(877, 0, 'en', 'admin', 'fleet.add_fleet_owner', 'Add Fleet Owner', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(878, 0, 'en', 'admin', 'fleet.company_name', 'Company Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(879, 0, 'en', 'admin', 'fleet.company_logo', 'Company Logo', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(880, 0, 'en', 'admin', 'fleet.fleet_commission', 'Commission', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(881, 0, 'en', 'admin', 'fleet.update_fleet_owner', 'Update Fleet Owner', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(882, 0, 'en', 'admin', 'fleet.update_fleet', 'Update Fleet', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(883, 0, 'en', 'admin', 'fleet.fleet_name', 'Fleet Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(884, 0, 'en', 'admin', 'edit', 'Edit', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(885, 0, 'en', 'admin', 'delete', 'Delete', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(886, 0, 'en', 'admin', 'something_wrong', 'Something Went Wrong!', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(887, 0, 'en', 'admin', 'something_wrong_dashboard', 'Something Went Wrong with Dashboard!', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(888, 0, 'en', 'admin', 'request_delete', 'Request Deleted', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(889, 0, 'en', 'admin', 'profile_update', 'Profile Updated', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(890, 0, 'en', 'admin', 'password', 'Password ', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(891, 0, 'en', 'admin', 'password_confirmation', 'Confirm Password', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(892, 0, 'en', 'admin', 'password_update', 'Password Updated', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(893, 0, 'en', 'admin', 'password_not_match', 'Password entered doesn\'t match', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(894, 0, 'en', 'admin', 'password_error', 'Please enter correct password', '2019-06-11 20:40:49', '2019-06-11 20:41:28');
INSERT INTO `ltm_translations` (`id`, `status`, `locale`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(895, 0, 'en', 'admin', 'role', 'Roles', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(896, 0, 'en', 'admin', 'location_updated', 'Location Updated successfully', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(897, 0, 'en', 'admin', 'service.per_hour', 'Per Hour', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(898, 0, 'en', 'admin', 'service.total_hour', 'Total Hours', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(899, 0, 'en', 'admin', 'service.Base_Price', 'Base Price', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(900, 0, 'en', 'admin', 'service.Base_Distance', 'Base Distance', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(901, 0, 'en', 'admin', 'service.per_minute', 'Per Minute', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(902, 0, 'en', 'admin', 'service.total_minute', 'Total Minutes', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(903, 0, 'en', 'admin', 'service.per', 'Per', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(904, 0, 'en', 'admin', 'service.total', 'Total', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(905, 0, 'en', 'admin', 'service.Service_Image', 'Service Image', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(906, 0, 'en', 'admin', 'service.Service_marker_Image', 'Service Marker Image', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(907, 0, 'en', 'admin', 'service.Add_Service_Type', 'Add Service Type', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(908, 0, 'en', 'admin', 'service.Service_Name', 'Service Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(909, 0, 'en', 'admin', 'service.Provider_Name', 'Provider Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(910, 0, 'en', 'admin', 'service.hourly_Price', 'Hour Price', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(911, 0, 'en', 'admin', 'service.unit_time', 'Unit Time Pricing (For Rental amount per hour / 60) ', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(912, 0, 'en', 'admin', 'service.unit', 'Unit Distance Price', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(913, 0, 'en', 'admin', 'service.Seat_Capacity', 'Seat Capacity', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(914, 0, 'en', 'admin', 'service.Pricing_Logic', 'Pricing Logic', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(915, 0, 'en', 'admin', 'service.Description', 'Description', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(916, 0, 'en', 'admin', 'service.Update_User', 'Update User', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(917, 0, 'en', 'admin', 'service.Update_Service_Type', 'Update Service Type', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(918, 0, 'en', 'admin', 'service.peak_title', 'Peak Time', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(919, 0, 'en', 'admin', 'service.peak_id', 'ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(920, 0, 'en', 'admin', 'service.peak_time', 'Time', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(921, 0, 'en', 'admin', 'service.peak_price', 'Peak Price(%) - Ride fare x Peak price(%)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(922, 0, 'en', 'admin', 'service.waiting_title', 'Waiting Charges', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(923, 0, 'en', 'admin', 'service.waiting_wave', 'Waive off minutes', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(924, 0, 'en', 'admin', 'service.waiting_charge', 'Per Minute Fare', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(925, 0, 'en', 'admin', 'setting.map_key', 'Google Map Key', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(926, 0, 'en', 'admin', 'setting.fb_app_version', 'FB App Version', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(927, 0, 'en', 'admin', 'setting.fb_app_id', 'FB App ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(928, 0, 'en', 'admin', 'setting.fb_app_secret', 'FB App Secret', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(929, 0, 'en', 'admin', 'setting.facebook_client_id', 'Facebook Client ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(930, 0, 'en', 'admin', 'setting.facebook_client_secret', 'Facebook Client Secret', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(931, 0, 'en', 'admin', 'setting.facebook_redirect', 'Facebook Redirect URL', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(932, 0, 'en', 'admin', 'setting.google_client_id', 'Google Client ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(933, 0, 'en', 'admin', 'setting.google_client_secret', 'Google Client Secret', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(934, 0, 'en', 'admin', 'setting.google_redirect', 'Google Redirect URL', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(935, 0, 'en', 'admin', 'setting.Android_user_link', 'Playstore User link', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(936, 0, 'en', 'admin', 'setting.Android_provider_link', 'Playstore Provider link', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(937, 0, 'en', 'admin', 'setting.Ios_user_Link', 'Appstore User Link', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(938, 0, 'en', 'admin', 'setting.Ios_provider_Link', 'Appstore Provider Link', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(939, 0, 'en', 'admin', 'setting.Facebook_Link', 'Facebook Link', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(940, 0, 'en', 'admin', 'setting.Twitter_Link', 'Twitter Link', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(941, 0, 'en', 'admin', 'setting.Site_Settings', 'Site Settings', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(942, 0, 'en', 'admin', 'setting.Site_Name', 'Site Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(943, 0, 'en', 'admin', 'setting.Site_Logo', 'Site Logo', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(944, 0, 'en', 'admin', 'setting.Site_Icon', 'Site Icon', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(945, 0, 'en', 'admin', 'setting.Copyright_Content', 'Copyright Content', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(946, 0, 'en', 'admin', 'setting.Provider_Accept_Timeout', 'Provider Accept Timeout', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(947, 0, 'en', 'admin', 'setting.Provider_Search_Radius', 'Provider Search Radius', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(948, 0, 'en', 'admin', 'setting.SOS_Number', 'SOS Number', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(949, 0, 'en', 'admin', 'setting.Contact_Number', 'Contact Number', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(950, 0, 'en', 'admin', 'setting.Contact_Email', 'Contact Email', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(951, 0, 'en', 'admin', 'setting.Social_Login', 'Social Login', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(952, 0, 'en', 'admin', 'setting.Update_Site_Settings', 'Update Site Settings', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(953, 0, 'en', 'admin', 'setting.distance', 'Distance', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(954, 0, 'en', 'admin', 'setting.referral', 'Referral', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(955, 0, 'en', 'admin', 'setting.referral_count', 'Referral count', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(956, 0, 'en', 'admin', 'setting.referral_amount', 'Referral amount', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(957, 0, 'en', 'admin', 'setting.send_mail', 'Send Mail', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(958, 0, 'en', 'admin', 'setting.mail_host', 'Host', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(959, 0, 'en', 'admin', 'setting.mail_username', 'Username', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(960, 0, 'en', 'admin', 'setting.mail_password', 'Password', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(961, 0, 'en', 'admin', 'setting.mail_from_address', 'From Address', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(962, 0, 'en', 'admin', 'setting.mail_from_name', 'From Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(963, 0, 'en', 'admin', 'setting.mail_port', 'Port', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(964, 0, 'en', 'admin', 'setting.mail_encryption', 'Encryption', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(965, 0, 'en', 'admin', 'setting.mail_domain', 'Domain', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(966, 0, 'en', 'admin', 'setting.mail_secret', 'Secret', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(967, 0, 'en', 'admin', 'setting.mail_driver', 'Driver', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(968, 0, 'en', 'admin', 'setting.environment', 'IOS Push Environment', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(969, 0, 'en', 'admin', 'setting.ios_push_password', 'IOS Push Passwords', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(970, 0, 'en', 'admin', 'setting.ios_push_user_pem', 'IOS Push User Pem', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(971, 0, 'en', 'admin', 'setting.ios_push_provider_pem', 'IOS Push Provider Pem', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(972, 0, 'en', 'admin', 'setting.android_push_key', 'Android Push Key', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(973, 0, 'en', 'admin', 'setting.timezone', 'Time Zone', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(974, 0, 'en', 'admin', 'setting.smtp', 'SMTP', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(975, 0, 'en', 'admin', 'setting.mailgun', 'Mail Gun', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(976, 0, 'en', 'admin', 'payment.card_payments', 'Stripe (Card Payments)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(977, 0, 'en', 'admin', 'payment.cash_payments', 'Cash Payments', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(978, 0, 'en', 'admin', 'payment.stripe_secret_key', 'Stripe Secret key', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(979, 0, 'en', 'admin', 'payment.stripe_publishable_key', 'Stripe Publishable key', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(980, 0, 'en', 'admin', 'payment.payumoney', 'Payumoney', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(981, 0, 'en', 'admin', 'payment.payumoney_environment', 'Environment', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(982, 0, 'en', 'admin', 'payment.payumoney_key', 'Key', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(983, 0, 'en', 'admin', 'payment.payumoney_salt', 'Salt', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(984, 0, 'en', 'admin', 'payment.payumoney_auth', 'Auth', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(985, 0, 'en', 'admin', 'payment.paypal', 'Paypal', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(986, 0, 'en', 'admin', 'payment.paypal_environment', 'Environment', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(987, 0, 'en', 'admin', 'payment.paypal_client_id', 'Client ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(988, 0, 'en', 'admin', 'payment.paypal_client_secret', 'Client Secret', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(989, 0, 'en', 'admin', 'payment.paypal_adaptive', 'Paypal Adaptive', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(990, 0, 'en', 'admin', 'payment.paypal_adaptive_environment', 'Environment', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(991, 0, 'en', 'admin', 'payment.paypal_username', 'Username', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(992, 0, 'en', 'admin', 'payment.paypal_password', 'Password', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(993, 0, 'en', 'admin', 'payment.paypal_secret', 'Secret', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(994, 0, 'en', 'admin', 'payment.paypal_certificate', 'Certificate', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(995, 0, 'en', 'admin', 'payment.paypal_app_id', 'APP Id', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(996, 0, 'en', 'admin', 'payment.paypal_adaptive_currency', 'Currency', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(997, 0, 'en', 'admin', 'payment.paypal_email', 'johndoe@example.com', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(998, 0, 'en', 'admin', 'payment.braintree', 'Braintree', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(999, 0, 'en', 'admin', 'payment.braintree_environment', 'Environment', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1000, 0, 'en', 'admin', 'payment.braintree_merchant_id', 'Merchant ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1001, 0, 'en', 'admin', 'payment.braintree_public_key', 'Public Key', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1002, 0, 'en', 'admin', 'payment.braintree_private_key', 'Private Key', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1003, 0, 'en', 'admin', 'payment.paytm', 'Paytm', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1004, 0, 'en', 'admin', 'payment.paytm_environment', 'Environment', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1005, 0, 'en', 'admin', 'payment.paytm_merchant_id', 'Merchant ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1006, 0, 'en', 'admin', 'payment.paytm_merchant_key', 'Merchant Key', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1007, 0, 'en', 'admin', 'payment.paytm_website', 'Website', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1008, 0, 'en', 'admin', 'payment.payment_history', 'Payment History', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1009, 0, 'en', 'admin', 'payment.request_id', 'Request ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1010, 0, 'en', 'admin', 'payment.transaction_id', 'Transaction ID', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1011, 0, 'en', 'admin', 'payment.from', 'From', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1012, 0, 'en', 'admin', 'payment.to', 'To', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1013, 0, 'en', 'admin', 'payment.total_amount', 'Total Amount', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1014, 0, 'en', 'admin', 'payment.provider_amount', 'Provider Amount', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1015, 0, 'en', 'admin', 'payment.payment_mode', 'Payment Mode', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1016, 0, 'en', 'admin', 'payment.payment_status', 'Payment Status', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1017, 0, 'en', 'admin', 'payment.payment_modes', 'Payment Modes', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1018, 0, 'en', 'admin', 'payment.payment_settings', 'Payment Settings', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1019, 0, 'en', 'admin', 'payment.daily_target', 'Daily Target', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1020, 0, 'en', 'admin', 'payment.tax_percentage', 'Tax percentage(%)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1021, 0, 'en', 'admin', 'payment.surge_trigger_point', 'Surge Trigger Point', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1022, 0, 'en', 'admin', 'payment.surge_percentage', 'Surge Percentage(%)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1023, 0, 'en', 'admin', 'payment.commission_percentage', 'Commission (%)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1024, 0, 'en', 'admin', 'payment.provider_commission_percentage', 'Provider Commission (%)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1025, 0, 'en', 'admin', 'payment.peak_percentage', 'Peak Hours Commission (%)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1026, 0, 'en', 'admin', 'payment.waiting_percentage', 'Waiting Charges Commission (%)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1027, 0, 'en', 'admin', 'payment.fleet_commission_percentage', 'Fleet Commission (%)', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1028, 0, 'en', 'admin', 'payment.booking_id_prefix', 'Booking ID Prefix', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1029, 0, 'en', 'admin', 'payment.currency', 'Currency', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1030, 0, 'en', 'admin', 'payment.update_site_settings', 'Update Site Settings', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1031, 0, 'en', 'admin', 'payment.minimum_negative_balance', 'Minimum Negative Balance', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1032, 0, 'en', 'admin', 'addsettle', 'Settlement', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1033, 0, 'en', 'admin', 'prd_settle', 'Provider Settlement', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1034, 0, 'en', 'admin', 'flt_settle', 'Fleet Settlement', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1035, 0, 'en', 'admin', 'document.add_Document', 'Add Document', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1036, 0, 'en', 'admin', 'document.document_name', 'Document Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1037, 0, 'en', 'admin', 'document.document_type', 'Document Type', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1038, 0, 'en', 'admin', 'document.driver_review', 'Driver Review', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1039, 0, 'en', 'admin', 'document.vehicle_review', 'Vehicle Review', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1040, 0, 'en', 'admin', 'document.update_document', 'Update Document', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1041, 0, 'en', 'admin', 'document.document', 'Document', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1042, 0, 'en', 'admin', 'account-manager.account_manager', 'Account Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1043, 0, 'en', 'admin', 'account-manager.add_new_account_manager', 'Add New Account Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1044, 0, 'en', 'admin', 'account-manager.add_account_manager', 'Add Account Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1045, 0, 'en', 'admin', 'account-manager.full_name', 'Full Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1046, 0, 'en', 'admin', 'account-manager.password_confirmation', 'Password Confirmation', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1047, 0, 'en', 'admin', 'account-manager.update_account_manager', 'Update Account Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1048, 0, 'en', 'admin', 'dispute-manager.dispute_manager', 'Dispute Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1049, 0, 'en', 'admin', 'dispute-manager.add_new_dispute_manager', 'Add New Dispute Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1050, 0, 'en', 'admin', 'dispute-manager.add_dispute_manager', 'Add Dispute Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1051, 0, 'en', 'admin', 'dispute-manager.full_name', 'Full Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1052, 0, 'en', 'admin', 'dispute-manager.password_confirmation', 'Password Confirmation', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1053, 0, 'en', 'admin', 'dispute-manager.update_dispute_manager', 'Update Dispute Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1054, 0, 'en', 'admin', 'dispatcher.dispatcher', 'Dispatcher', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1055, 0, 'en', 'admin', 'dispatcher.add_new_dispatcher', 'Add New Dispatcher', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1056, 0, 'en', 'admin', 'dispatcher.add_dispatcher', 'Add Dispatcher', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1057, 0, 'en', 'admin', 'dispatcher.update_dispatcher', 'Update Dispatcher', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1058, 0, 'en', 'admin', 'provides.download', 'Download', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1059, 0, 'en', 'admin', 'provides.providers', 'Providers', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1060, 0, 'en', 'admin', 'provides.provider_name', 'Provider Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1061, 0, 'en', 'admin', 'provides.approve', 'Approve', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1062, 0, 'en', 'admin', 'provides.delete', 'Delete', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1063, 0, 'en', 'admin', 'provides.add_provider', 'Add Provider', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1064, 0, 'en', 'admin', 'provides.password_confirmation', 'Password Confirmation', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1065, 0, 'en', 'admin', 'provides.update_provider', 'Update Provider', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1066, 0, 'en', 'admin', 'provides.type_allocation', 'Provider Service Type Allocation', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1067, 0, 'en', 'admin', 'provides.service_name', 'Service Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1068, 0, 'en', 'admin', 'provides.service_number', 'Service Number', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1069, 0, 'en', 'admin', 'provides.service_model', 'Service Model', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1070, 0, 'en', 'admin', 'provides.provider_documents', 'Provider Documents', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1071, 0, 'en', 'admin', 'provides.document_type', 'Document Type', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1072, 0, 'en', 'admin', 'provides.add_new_provider', 'Add New Provider', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1073, 0, 'en', 'admin', 'provides.total_requests', 'Total Requests', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1074, 0, 'en', 'admin', 'provides.full_name', 'Full Name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1075, 0, 'en', 'admin', 'provides.accepted_requests', 'Accepted Requests', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1076, 0, 'en', 'admin', 'provides.cancelled_requests', 'Cancelled Requests', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1077, 0, 'en', 'admin', 'provides.service_type', 'Documents / Service Type', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1078, 0, 'en', 'admin', 'provides.online', 'Online', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1079, 0, 'en', 'admin', 'provides.Provider_Details', 'Provider Details', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1080, 0, 'en', 'admin', 'provides.Approved', 'Approved', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1081, 0, 'en', 'admin', 'provides.Not_Approved', 'Not Approved', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1082, 0, 'en', 'admin', 'provides.Total_Rides', 'Total Rides', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1083, 0, 'en', 'admin', 'provides.Total_Earning', 'Total Earning', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1084, 0, 'en', 'admin', 'provides.Commission', 'Commission', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1085, 0, 'en', 'admin', 'provides.Joined_at', 'Joined at', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1086, 0, 'en', 'admin', 'provides.Details', 'Details', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1087, 0, 'en', 'admin', 'History', 'History', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1088, 0, 'en', 'admin', 'Statements', 'Statements', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1089, 0, 'en', 'admin', 'user-pro.name', 'Company name', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1090, 0, 'en', 'admin', 'user-pro.address', 'Address', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1091, 0, 'en', 'admin', 'user-pro.phone_number', 'Phone number', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1092, 0, 'en', 'admin', 'user-pro.reg_number', 'Registration number', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1093, 0, 'en', 'admin', 'user-pro.email', 'Email', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1094, 0, 'en', 'admin', 'user-pro.allow_negative', 'Allow the negative payment', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1095, 0, 'en', 'admin', 'user-pro.zipcode', 'Zip', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1096, 0, 'en', 'admin', 'user-pro.city', 'City', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1097, 0, 'en', 'admin', 'include.profile', 'Profile', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1098, 0, 'en', 'admin', 'include.sign_out', 'Sign out', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1099, 0, 'en', 'admin', 'include.reviews', 'Reviews', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1100, 0, 'en', 'admin', 'include.add_new_promocode', 'Add New Promocode', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1101, 0, 'en', 'admin', 'include.admin_dashboard', 'Admin Dashboard', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1102, 0, 'en', 'admin', 'include.dashboard', 'Dashboard', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1103, 0, 'en', 'admin', 'include.fleet_dashboard', 'Fleet Dashboard', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1104, 0, 'en', 'admin', 'include.dispatcher_dashboard', 'Dispatcher Dashboard', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1105, 0, 'en', 'admin', 'include.account_dashboard', 'Account Dashboard', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1106, 0, 'en', 'admin', 'include.account_statements', 'Accounts Statements', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1107, 0, 'en', 'admin', 'include.dispatcher_panel', 'Dispatcher Panel', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1108, 0, 'en', 'admin', 'include.heat_map', 'Heat Map', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1109, 0, 'en', 'admin', 'include.members', 'Members', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1110, 0, 'en', 'admin', 'include.users', 'Users', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1111, 0, 'en', 'admin', 'include.user_pro', 'User Pro', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1112, 0, 'en', 'admin', 'include.list_users', 'List Users', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1113, 0, 'en', 'admin', 'include.add_new_user', 'Add New User', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1114, 0, 'en', 'admin', 'include.providers', 'Providers', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1115, 0, 'en', 'admin', 'include.list_providers', 'List Providers', '2019-06-11 20:40:49', '2019-06-11 20:41:28'),
(1116, 0, 'en', 'admin', 'include.add_new_provider', 'Add New Provider', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1117, 0, 'en', 'admin', 'include.dispatcher', 'Dispatcher', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1118, 0, 'en', 'admin', 'include.list_dispatcher', 'List Dispatcher', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1119, 0, 'en', 'admin', 'include.add_new_dispatcher', 'Add New Dispatcher', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1120, 0, 'en', 'admin', 'include.fleet_owner', 'Fleet Owner', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1121, 0, 'en', 'admin', 'include.list_fleets', 'List Fleets', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1122, 0, 'en', 'admin', 'include.add_new_fleet_owner', 'Add New Fleet Owner', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1123, 0, 'en', 'admin', 'include.account_manager', 'Account Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1124, 0, 'en', 'admin', 'include.list_account_managers', 'List Account Managers', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1125, 0, 'en', 'admin', 'include.add_new_account_manager', 'Add New Account Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1126, 0, 'en', 'admin', 'include.accounts', 'Accounts', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1127, 0, 'en', 'admin', 'include.dispute_manager', 'Dispute Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1128, 0, 'en', 'admin', 'include.list_dispute_managers', 'List Dispute Managers', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1129, 0, 'en', 'admin', 'include.add_new_dispute_manager', 'Add New Dispute Manager', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1130, 0, 'en', 'admin', 'include.statements', 'Statements', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1131, 0, 'en', 'admin', 'include.overall_ride_statments', 'Overall Ride Statements', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1132, 0, 'en', 'admin', 'include.provider_statement', 'Provider Statement', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1133, 0, 'en', 'admin', 'include.user_statement', 'User Statement', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1134, 0, 'en', 'admin', 'include.fleet_statement', 'Fleet Statement', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1135, 0, 'en', 'admin', 'include.daily_statement', 'Daily Statement', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1136, 0, 'en', 'admin', 'include.today_statement', 'Today Statement', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1137, 0, 'en', 'admin', 'include.monthly_statement', 'Monthly Statement', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1138, 0, 'en', 'admin', 'include.yearly_statement', 'Yearly Statement', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1139, 0, 'en', 'admin', 'include.overall_ride_earnings', 'Overall Ride Earnings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1140, 0, 'en', 'admin', 'include.provider_earnings', 'Provider Earnings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1141, 0, 'en', 'admin', 'include.user_ride_histroy', 'User Ride Histroy', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1142, 0, 'en', 'admin', 'include.fleet_ride_histroy', 'Fleet Ride Histroy', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1143, 0, 'en', 'admin', 'include.daily_earnings', 'Daily Earnings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1144, 0, 'en', 'admin', 'include.today_earnings', 'Today Earnings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1145, 0, 'en', 'admin', 'include.monthly_earnings', 'Monthly Earnings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1146, 0, 'en', 'admin', 'include.yearly_earnings', 'Yearly Earnings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1147, 0, 'en', 'admin', 'include.statement_from', 'Ride Statement from', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1148, 0, 'en', 'admin', 'include.statement_to', 'to', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1149, 0, 'en', 'admin', 'include.details', 'Details', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1150, 0, 'en', 'admin', 'include.map', 'Map', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1151, 0, 'en', 'admin', 'include.ratings', 'Ratings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1152, 0, 'en', 'admin', 'include.user_ratings', 'User Ratings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1153, 0, 'en', 'admin', 'include.provider_ratings', 'Provider Ratings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1154, 0, 'en', 'admin', 'include.requests', 'Requests', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1155, 0, 'en', 'admin', 'include.request_history', 'Request History', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1156, 0, 'en', 'admin', 'include.scheduled_rides', 'Scheduled Rides', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1157, 0, 'en', 'admin', 'include.general', 'General', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1158, 0, 'en', 'admin', 'include.service_types', 'Service Types', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1159, 0, 'en', 'admin', 'include.list_service_types', 'List Service Types', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1160, 0, 'en', 'admin', 'include.add_new_service_type', 'Add New Service Type', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1161, 0, 'en', 'admin', 'include.documents', 'Documents', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1162, 0, 'en', 'admin', 'include.list_documents', 'List Documents', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1163, 0, 'en', 'admin', 'include.add_new_document', 'Add New Document', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1164, 0, 'en', 'admin', 'include.promocodes', 'Promocodes', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1165, 0, 'en', 'admin', 'include.list_promocodes', 'List Promocodes', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1166, 0, 'en', 'admin', 'include.payment_details', 'Payment Details', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1167, 0, 'en', 'admin', 'include.payment_history', 'Payment History', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1168, 0, 'en', 'admin', 'include.payment_settings', 'Payment Settings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1169, 0, 'en', 'admin', 'include.settings', 'Settings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1170, 0, 'en', 'admin', 'include.site_settings', 'Site Settings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1171, 0, 'en', 'admin', 'include.others', 'Others', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1172, 0, 'en', 'admin', 'include.cms_pages', 'Cms Pages', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1173, 0, 'en', 'admin', 'include.help', 'Help', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1174, 0, 'en', 'admin', 'include.custom_push', 'Custom Push', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1175, 0, 'en', 'admin', 'include.translations', 'Translations', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1176, 0, 'en', 'admin', 'include.account', 'Account', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1177, 0, 'en', 'admin', 'include.account_settings', 'Account Settings', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1178, 0, 'en', 'admin', 'include.change_password', 'Change Password', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1179, 0, 'en', 'admin', 'include.transaction', 'Settlements', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1180, 0, 'en', 'admin', 'include.payment_request', 'Payment Request', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1181, 0, 'en', 'admin', 'include.provider_request', 'Provider Settlements', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1182, 0, 'en', 'admin', 'include.fleet_request', 'Fleet Settlements', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1183, 0, 'en', 'admin', 'include.all_transaction', 'All Transactions', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1184, 0, 'en', 'admin', 'include.wallet', 'Wallet', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1185, 0, 'en', 'admin', 'include.debit_card', 'Debit Cards', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1186, 0, 'en', 'admin', 'include.transfer', 'Transfer', '2019-06-11 20:40:49', '2019-06-11 20:41:29'),
(1187, 0, 'en', 'admin', 'include.logout', 'Logout', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1188, 0, 'en', 'admin', 'include.reason', 'Cancel Reasons', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1189, 0, 'en', 'admin', 'include.list_reasons', 'List Reasons', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1190, 0, 'en', 'admin', 'include.add_new_reason', 'Add New Reason', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1191, 0, 'en', 'admin', 'include.peakhour', 'Peak Hours', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1192, 0, 'en', 'admin', 'include.dispute', 'Disputes', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1193, 0, 'en', 'admin', 'include.dispute_panel', 'Dispute Panel', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1194, 0, 'en', 'admin', 'include.dispute_type', 'Dispute Types', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1195, 0, 'en', 'admin', 'include.dispute_request', 'Dispute Requests', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1196, 0, 'en', 'admin', 'include.userdispute', 'User Disputes', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1197, 0, 'en', 'admin', 'include.lostitem', 'Lost Items', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1198, 0, 'en', 'admin', 'include.notify', 'Notifications', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1199, 0, 'en', 'admin', 'include.list_notifications', 'List Notifications', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1200, 0, 'en', 'admin', 'include.add_new_notification', 'Add New Notification', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1201, 0, 'en', 'admin', 'include.offer', 'Offer', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1202, 0, 'en', 'admin', 'include.rides', 'Rides', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1203, 0, 'en', 'admin', 'include.ride_history', 'Ride History', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1204, 0, 'en', 'admin', 'include.roles', 'Roles', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1205, 0, 'en', 'admin', 'include.role_types', 'Roles Types', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1206, 0, 'en', 'admin', 'include.sub_admins', 'Adminstrators', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1207, 0, 'en', 'admin', 'account.change_password', 'Change Password', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1208, 0, 'en', 'admin', 'account.old_password', 'Old Password', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1209, 0, 'en', 'admin', 'account.password', 'Password ', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1210, 0, 'en', 'admin', 'account.password_confirmation', 'Password Confirmation', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1211, 0, 'en', 'admin', 'account.update_profile', 'Update Profile', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1212, 0, 'en', 'admin', 'account.new_password', 'New Password', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1213, 0, 'en', 'admin', 'account.retype_password', 'Re-type New Password', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1214, 0, 'en', 'admin', 'help', 'Help', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1215, 0, 'en', 'admin', 'email', 'Email', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1216, 0, 'en', 'admin', 'auth.remember_me', 'Remember Me', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1217, 0, 'en', 'admin', 'auth.reset_password', 'Reset Password', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1218, 0, 'en', 'admin', 'auth.admin_login', 'Admin Login', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1219, 0, 'en', 'admin', 'auth.login_here', 'Login Here', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1220, 0, 'en', 'admin', 'auth.sign_in', 'Sign In', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1221, 0, 'en', 'admin', 'auth.forgot_your_password', 'Forgot Your Password', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1222, 0, 'en', 'admin', 'auth.request_scheduled', 'Ride Scheduled', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1223, 0, 'en', 'admin', 'auth.request_already_scheduled', 'Ride Already Scheduled', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1224, 0, 'en', 'admin', 'promocode.add_promocode', 'Add Promocode', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1225, 0, 'en', 'admin', 'promocode.discount', 'Discount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1226, 0, 'en', 'admin', 'promocode.expiration', 'Expiration', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1227, 0, 'en', 'admin', 'promocode.promocode', 'Promocode', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1228, 0, 'en', 'admin', 'promocode.update_promocode', 'Update Promocode', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1229, 0, 'en', 'admin', 'promocode.used_count', 'Used Count', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1230, 0, 'en', 'admin', 'promocode.promocodes', 'Promocodes', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1231, 0, 'en', 'admin', 'promocode.discount_type', 'Promocode Use ', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1232, 0, 'en', 'admin', 'promocode.percentage', 'Percentage', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1233, 0, 'en', 'admin', 'promocode.max_amount', 'Max Amount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1234, 0, 'en', 'admin', 'promocode.promo_description', 'Description', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1235, 0, 'en', 'admin', 'reason.title', 'Cancel Reasons', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1236, 0, 'en', 'admin', 'reason.add_reason', 'Add Reason', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1237, 0, 'en', 'admin', 'reason.update_reason', 'Update Reason', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1238, 0, 'en', 'admin', 'reason.reason', 'Reason', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1239, 0, 'en', 'admin', 'reason.type', 'Type', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1240, 0, 'en', 'admin', 'reason.status', 'Status', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1241, 0, 'en', 'admin', 'peakhour.title', 'Peak Hours', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1242, 0, 'en', 'admin', 'peakhour.add_time', 'Add Peak Hour', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1243, 0, 'en', 'admin', 'peakhour.update_time', 'Update Peak Hour', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1244, 0, 'en', 'admin', 'peakhour.start_time', 'Start Time', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1245, 0, 'en', 'admin', 'peakhour.end_time', 'End Time', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1246, 0, 'en', 'admin', 'notification.title', 'Notifications', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1247, 0, 'en', 'admin', 'notification.add', 'Add Notification', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1248, 0, 'en', 'admin', 'notification.update', 'Update Notification', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1249, 0, 'en', 'admin', 'notification.notify_type', 'Type', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1250, 0, 'en', 'admin', 'notification.notify_image', 'Image', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1251, 0, 'en', 'admin', 'notification.notify_desc', 'Description', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1252, 0, 'en', 'admin', 'notification.notify_expiry', 'Expiry Date', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1253, 0, 'en', 'admin', 'notification.notify_status', 'Status', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1254, 0, 'en', 'admin', 'lostitem.title', 'Lost Items', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1255, 0, 'en', 'admin', 'lostitem.add', 'Add Lost Item', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1256, 0, 'en', 'admin', 'lostitem.update', 'Update Lost Item', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1257, 0, 'en', 'admin', 'lostitem.lost_id', 'Request Id', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1258, 0, 'en', 'admin', 'lostitem.request', 'Request Details', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1259, 0, 'en', 'admin', 'lostitem.lost_user', 'User', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1260, 0, 'en', 'admin', 'lostitem.lost_item', 'Lost Item Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1261, 0, 'en', 'admin', 'lostitem.lost_comments', 'Comments', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1262, 0, 'en', 'admin', 'lostitem.lost_status', 'Status', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1263, 0, 'en', 'admin', 'dispute.title', 'Disputes', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1264, 0, 'en', 'admin', 'dispute.title1', 'Request Disputes', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1265, 0, 'en', 'admin', 'dispute.add_dispute', 'Add Dispute', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1266, 0, 'en', 'admin', 'dispute.update_dispute', 'Update Dispute', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1267, 0, 'en', 'admin', 'dispute.update_dispute1', 'Update Request Dispute', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1268, 0, 'en', 'admin', 'dispute.dispute_type', 'Dispute Type', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1269, 0, 'en', 'admin', 'dispute.dispute_id', 'Id', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1270, 0, 'en', 'admin', 'dispute.dispute_request_id', 'Request Id', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1271, 0, 'en', 'admin', 'dispute.dispute_request', 'Request By', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1272, 0, 'en', 'admin', 'dispute.dispute_user', 'User', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1273, 0, 'en', 'admin', 'dispute.dispute_provider', 'Provider', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1274, 0, 'en', 'admin', 'dispute.dispute_name', 'Dispute Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1275, 0, 'en', 'admin', 'dispute.dispute_refund', 'Refund Amount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1276, 0, 'en', 'admin', 'dispute.dispute_comments', 'Comments', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1277, 0, 'en', 'admin', 'dispute.dispute_status', 'Status', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1278, 0, 'en', 'admin', 'dispute.new_dispute', 'New dispute created!', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1279, 0, 'en', 'admin', 'users.Users', 'Users', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1280, 0, 'en', 'admin', 'users.Add_User', 'Add User', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1281, 0, 'en', 'admin', 'users.Update_User', 'Update User', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1282, 0, 'en', 'admin', 'users.Rating', 'Rating', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1283, 0, 'en', 'admin', 'users.Wallet_Amount', 'Wallet Amount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1284, 0, 'en', 'admin', 'users.User_Details', 'User Details', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1285, 0, 'en', 'admin', 'users.name', 'User Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1286, 0, 'en', 'admin', 'users.Total_Rides', 'Total Rides', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1287, 0, 'en', 'admin', 'users.Total_Spending', 'Total Spending', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1288, 0, 'en', 'admin', 'users.Joined_at', 'Joined at', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1289, 0, 'en', 'admin', 'users.Details', 'Details', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1290, 0, 'en', 'admin', 'fleets.name', 'Fleet Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1291, 0, 'en', 'admin', 'fleets.Total_Rides', 'Total Rides', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1292, 0, 'en', 'admin', 'fleets.Total_Earnings', 'Total Earnings', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1293, 0, 'en', 'admin', 'fleets.Joined_at', 'Joined at', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1294, 0, 'en', 'admin', 'fleets.Details', 'Details', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1295, 0, 'en', 'admin', 'name', 'Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1296, 0, 'en', 'admin', 'first_name', 'First Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1297, 0, 'en', 'admin', 'last_name', 'Last Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1298, 0, 'en', 'admin', 'picture', 'Picture', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1299, 0, 'en', 'admin', 'mobile', 'Mobile', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1300, 0, 'en', 'admin', 'cancel', 'Cancel', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1301, 0, 'en', 'admin', 'view', 'View', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1302, 0, 'en', 'admin', 'update', 'Update', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1303, 0, 'en', 'admin', 'id', 'ID', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1304, 0, 'en', 'admin', 'gender', 'Gender', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1305, 0, 'en', 'admin', 'address', 'Address', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1306, 0, 'en', 'admin', 'action', 'Action', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1307, 0, 'en', 'admin', 'Enable', 'Enable', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1308, 0, 'en', 'admin', 'Disable', 'Disable', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1309, 0, 'en', 'admin', 'type', 'Type', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1310, 0, 'en', 'admin', 'status', 'Status', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1311, 0, 'en', 'admin', 'message', 'Message', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1312, 0, 'en', 'admin', 'amount', 'Amount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1313, 0, 'en', 'admin', 'company', 'Company', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1314, 0, 'en', 'admin', 'logo', 'Logo', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1315, 0, 'en', 'admin', 'service_select', 'Please Create a Service Type', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1316, 0, 'en', 'admin', 'pages.pages', 'Pages', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1317, 0, 'en', 'admin', 'request.Booking_ID', 'Booking ID', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1318, 0, 'en', 'admin', 'request.User_Name', 'User Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1319, 0, 'en', 'admin', 'request.Date_Time', 'Date &amp; Time', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1320, 0, 'en', 'admin', 'request.Provider_Name', 'Provider Name', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1321, 0, 'en', 'admin', 'request.Payment_Mode', 'Payment Mode', '2019-06-11 20:40:50', '2019-06-11 20:40:50'),
(1322, 0, 'en', 'admin', 'request.Payment_Status', 'Payment Status', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1323, 0, 'en', 'admin', 'request.Request_Id', 'Request Id', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1324, 0, 'en', 'admin', 'request.Scheduled_Date_Time', 'Scheduled Date & Time', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1325, 0, 'en', 'admin', 'request.picked_up', 'Picked up', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1326, 0, 'en', 'admin', 'request.dropped', 'Dropped', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1327, 0, 'en', 'admin', 'request.request_details', 'Request Details', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1328, 0, 'en', 'admin', 'request.commission', 'Commission', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1329, 0, 'en', 'admin', 'request.date', 'Dated on', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1330, 0, 'en', 'admin', 'request.status', 'Status', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1331, 0, 'en', 'admin', 'request.earned', 'Earned', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1332, 0, 'en', 'admin', 'request.provider_not_assigned', 'Provider not yet assigned!', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1333, 0, 'en', 'admin', 'request.total_distance', 'Total Distance', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1334, 0, 'en', 'admin', 'request.ride_scheduled_time', 'Ride Scheduled Time', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1335, 0, 'en', 'admin', 'request.ride_start_time', 'Ride Start Time', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1336, 0, 'en', 'admin', 'request.ride_end_time', 'Ride End Time', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1337, 0, 'en', 'admin', 'request.pickup_address', 'Pickup Address', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1338, 0, 'en', 'admin', 'request.drop_address', 'Drop Address', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1339, 0, 'en', 'admin', 'request.base_price', 'Base Price', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1340, 0, 'en', 'admin', 'request.minutes_price', 'Minutes Price', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1341, 0, 'en', 'admin', 'request.hours_price', 'Hours Price', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1342, 0, 'en', 'admin', 'request.distance_price', 'Distance Price', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1343, 0, 'en', 'admin', 'request.fleet_commission', 'Fleet Commission', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1344, 0, 'en', 'admin', 'request.discount_price', 'Discount Price', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1345, 0, 'en', 'admin', 'request.tax_price', 'Tax Price', '2019-06-11 20:40:50', '2019-06-11 20:41:29');
INSERT INTO `ltm_translations` (`id`, `status`, `locale`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1346, 0, 'en', 'admin', 'request.surge_price', 'Surge Price', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1347, 0, 'en', 'admin', 'request.tips', 'Tips', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1348, 0, 'en', 'admin', 'request.total_amount', 'Total Amount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1349, 0, 'en', 'admin', 'request.wallet_deduction', 'Wallet Deduction', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1350, 0, 'en', 'admin', 'request.paid_amount', 'Paid Amount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1351, 0, 'en', 'admin', 'request.provider_earnings', 'Provider Earnings', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1352, 0, 'en', 'admin', 'request.ride_status', 'Ride Status', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1353, 0, 'en', 'admin', 'request.cash_amount', 'Cash Amount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1354, 0, 'en', 'admin', 'request.card_amount', 'Card Amount', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1355, 0, 'en', 'admin', 'request.waiting_charge', 'Waiting Charge', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1356, 0, 'en', 'admin', 'request.peak_amount', 'Peak Hours Charge', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1357, 0, 'en', 'admin', 'request.peak_commission', 'Peak Hours Commission', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1358, 0, 'en', 'admin', 'request.waiting_commission', 'Waiting Charge Commission', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1359, 0, 'en', 'admin', 'request.transaction_id', 'Transaction ID', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1360, 0, 'en', 'admin', 'request.user_rating', 'User Rating', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1361, 0, 'en', 'admin', 'request.provider_rating', 'Provider Rating', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1362, 0, 'en', 'admin', 'request.user_comment', 'User Comment', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1363, 0, 'en', 'admin', 'request.provider_comment', 'Provider Comment', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1364, 0, 'en', 'admin', 'review.Request_ID', 'Request ID', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1365, 0, 'en', 'admin', 'review.Rating', 'Rating', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1366, 0, 'en', 'admin', 'review.Comments', 'Comments', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1367, 0, 'en', 'admin', 'review.Provider_Reviews', 'Provider Reviews', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1368, 0, 'en', 'admin', 'review.User_Reviews', 'User Reviews', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1369, 0, 'en', 'admin', 'review.transaction_id', 'Transaction ID', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1370, 0, 'en', 'admin', 'dashboard.Rides', 'Total No. of Rides', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1371, 0, 'en', 'admin', 'dashboard.Revenue', 'Revenue', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1372, 0, 'en', 'admin', 'dashboard.service', 'No. of Service Types', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1373, 0, 'en', 'admin', 'dashboard.cancel_count', 'User Cancelled Count', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1374, 0, 'en', 'admin', 'dashboard.provider_cancel_count', 'Provider Cancelled Count', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1375, 0, 'en', 'admin', 'dashboard.fleets', 'No. of Fleets', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1376, 0, 'en', 'admin', 'dashboard.providers', 'No. of Providers', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1377, 0, 'en', 'admin', 'dashboard.scheduled', 'No. of Scheduled Rides', '2019-06-11 20:40:50', '2019-06-11 20:41:29'),
(1378, 0, 'en', 'admin', 'dashboard.Recent_Rides', 'Recent Rides', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1379, 0, 'en', 'admin', 'dashboard.View_Ride_Details', 'View Ride Details', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1380, 0, 'en', 'admin', 'dashboard.No_Details_Found', 'No Details Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1381, 0, 'en', 'admin', 'dashboard.cancel_rides', 'Cancelled Rides', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1382, 0, 'en', 'admin', 'dashboard.over_earning', 'Over All Earning', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1383, 0, 'en', 'admin', 'dashboard.over_commission', 'Over All Commission', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1384, 0, 'en', 'admin', 'dashboard.total', 'Total', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1385, 0, 'en', 'admin', 'dashboard.completed_ride', 'Completed rides', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1386, 0, 'en', 'admin', 'dashboard.cancelled_ride', 'Canceled rides', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1387, 0, 'en', 'admin', 'dashboard.total_clients', 'Total Partenaires', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1388, 0, 'en', 'admin', 'dashboard.users', 'Total No. of Users', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1389, 0, 'en', 'admin', 'heatmap.Ride_Heatmap', 'Heatmap', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1390, 0, 'en', 'admin', 'heatmap.godseye', 'Godseye', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1391, 0, 'en', 'admin', 'push.Push_Notification', 'Push Notification', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1392, 0, 'en', 'admin', 'push.Sent_to', 'Sent to', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1393, 0, 'en', 'admin', 'push.message', 'Sent Message', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1394, 0, 'en', 'admin', 'push.Push_Now', 'Push Now', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1395, 0, 'en', 'admin', 'push.Schedule_Push', 'Schedule Push', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1396, 0, 'en', 'admin', 'push.Condition', 'Condition', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1397, 0, 'en', 'admin', 'push.Notification_History', 'Notification History', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1398, 0, 'en', 'admin', 'push.Sent_on', 'Sent on', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1399, 0, 'en', 'admin', 'transaction_ref', 'Transaction Id', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1400, 0, 'en', 'admin', 'transaction_desc', 'Description', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1401, 0, 'en', 'admin', 'sno', 'Sno', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1402, 0, 'en', 'admin', 'by', 'Send / Receive By', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1403, 0, 'en', 'admin', 'current_balance', 'Current Balance', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1404, 0, 'en', 'admin', 'transfer', 'Transfer', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1405, 0, 'en', 'admin', 'send', 'Send', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1406, 0, 'en', 'admin', 'datetime', 'Date &amp; Time', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1407, 0, 'en', 'admin', 'approve', 'Send', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1408, 0, 'en', 'admin', 'settle', 'Settle', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1409, 0, 'en', 'admin', 'account_manager_msgs.account_saved', 'Account Manager Details Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1410, 0, 'en', 'admin', 'account_manager_msgs.account_not_found', 'Account Manager Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1411, 0, 'en', 'admin', 'account_manager_msgs.account_update', 'Account Manager Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1412, 0, 'en', 'admin', 'account_manager_msgs.account_delete', 'Account Manager Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1413, 0, 'en', 'admin', 'dispute_manager_msgs.dispute_saved', 'Dispute Manager Details Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1414, 0, 'en', 'admin', 'dispute_manager_msgs.dispute_not_found', 'Dispute Manager Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1415, 0, 'en', 'admin', 'dispute_manager_msgs.dispute_update', 'Dispute Manager Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1416, 0, 'en', 'admin', 'dispute_manager_msgs.dispute_delete', 'Dispute Manager Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1417, 0, 'en', 'admin', 'dispatcher_msgs.dispatcher_saved', 'Dispatcher Details Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1418, 0, 'en', 'admin', 'dispatcher_msgs.dispatcher_not_found', 'Dispatcher Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1419, 0, 'en', 'admin', 'dispatcher_msgs.dispatcher_update', 'Dispatcher Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1420, 0, 'en', 'admin', 'dispatcher_msgs.dispatcher_delete', 'Dispatcher Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1421, 0, 'en', 'admin', 'dispatcher_msgs.request_assigned', 'Request Assigned to Provider', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1422, 0, 'en', 'admin', 'fleet_msgs.fleet_saved', 'Fleet Details Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1423, 0, 'en', 'admin', 'fleet_msgs.fleet_not_found', 'Fleet Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1424, 0, 'en', 'admin', 'fleet_msgs.fleet_update', 'Fleet Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1425, 0, 'en', 'admin', 'fleet_msgs.fleet_delete', 'Fleet Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1426, 0, 'en', 'admin', 'fleet_msgs.fleet_settlement', 'Fleet settlement pending, you could not able to delete', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1427, 0, 'en', 'admin', 'provider_msgs.provider_saved', 'Provider Details Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1428, 0, 'en', 'admin', 'provider_msgs.provider_not_found', 'Provider Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1429, 0, 'en', 'admin', 'provider_msgs.provider_update', 'Provider Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1430, 0, 'en', 'admin', 'provider_msgs.provider_delete', 'Provider Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1431, 0, 'en', 'admin', 'provider_msgs.provider_approve', 'Provider approved', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1432, 0, 'en', 'admin', 'provider_msgs.provider_disapprove', 'Provider disapproved', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1433, 0, 'en', 'admin', 'provider_msgs.document_pending', 'Documents verfication pending', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1434, 0, 'en', 'admin', 'provider_msgs.document_approved', 'Provider document has been approved', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1435, 0, 'en', 'admin', 'provider_msgs.document_delete', 'Provider document has been deleted', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1436, 0, 'en', 'admin', 'provider_msgs.document_not_found', 'Provider document not found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1437, 0, 'en', 'admin', 'provider_msgs.provider_settlement', 'Provider settlement pending, you could not able to delete', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1438, 0, 'en', 'admin', 'provider_msgs.service_type_pending', 'Provider has not been assigned a service type', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1439, 0, 'en', 'admin', 'provider_msgs.provider_pending', 'Provider has not been assigned a service type or documents verfication pending', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1440, 0, 'en', 'admin', 'provider_msgs.provider_service_update', 'Provider service type updated successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1441, 0, 'en', 'admin', 'provider_msgs.provider_service_delete', 'Provider service has been deleted', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1442, 0, 'en', 'admin', 'provider_msgs.provider_service_not_found', 'Provider service not found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1443, 0, 'en', 'admin', 'provider_msgs.trip_cancelled', 'Trip Cancelled Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1444, 0, 'en', 'admin', 'admins.user_saved', 'Sub Admin Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1445, 0, 'en', 'admin', 'admins.user_not_found', 'Sub Admin Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1446, 0, 'en', 'admin', 'admins.Add_User', 'Add Admin', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1447, 0, 'en', 'admin', 'admins.update_User', 'Update Admin', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1448, 0, 'en', 'admin', 'admins.user_delete', 'Sub Admin Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1449, 0, 'en', 'admin', 'admins.role_not_found', 'Role Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1450, 0, 'en', 'admin', 'user_msgs.user_saved', 'User Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1451, 0, 'en', 'admin', 'user_msgs.user_not_found', 'User Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1452, 0, 'en', 'admin', 'user_msgs.user_update', 'User Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1453, 0, 'en', 'admin', 'user_msgs.user_delete', 'User Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1454, 0, 'en', 'admin', 'document_msgs.document_saved', 'Document Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1455, 0, 'en', 'admin', 'document_msgs.document_not_found', 'Document Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1456, 0, 'en', 'admin', 'document_msgs.document_update', 'Document Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1457, 0, 'en', 'admin', 'document_msgs.document_delete', 'Document Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1458, 0, 'en', 'admin', 'favourite_location_msgs.favourite_saved', 'Favourite Location Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1459, 0, 'en', 'admin', 'favourite_location_msgs.favourite_not_found', 'Favourite Location Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1460, 0, 'en', 'admin', 'favourite_location_msgs.favourite_exists', 'Favourite Location Already Exists', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1461, 0, 'en', 'admin', 'favourite_location_msgs.favourite_update', 'Favourite Location Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1462, 0, 'en', 'admin', 'favourite_location_msgs.favourite_delete', 'Favourite Location Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1463, 0, 'en', 'admin', 'promocode_msgs.promocode_saved', 'Promocode Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1464, 0, 'en', 'admin', 'promocode_msgs.promocode_not_found', 'Promocode Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1465, 0, 'en', 'admin', 'promocode_msgs.promocode_exists', 'Promocode Already Exists', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1466, 0, 'en', 'admin', 'promocode_msgs.promocode_update', 'Promocode Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1467, 0, 'en', 'admin', 'promocode_msgs.promocode_delete', 'Promocode Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1468, 0, 'en', 'admin', 'peakhour_msgs.peakhour_saved', 'Peak Hour Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1469, 0, 'en', 'admin', 'peakhour_msgs.peakhour_not_found', 'Peak Hour Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1470, 0, 'en', 'admin', 'peakhour_msgs.peakhour_exists', 'Peak Hour Already Exists', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1471, 0, 'en', 'admin', 'peakhour_msgs.peakhour_update', 'Peak Hour Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1472, 0, 'en', 'admin', 'peakhour_msgs.peakhour_delete', 'Peak Hour Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1473, 0, 'en', 'admin', 'dispute_msgs.saved', 'Dispute Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1474, 0, 'en', 'admin', 'dispute_msgs.not_found', 'Dispute Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1475, 0, 'en', 'admin', 'dispute_msgs.exists', 'Dispute Already Exists', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1476, 0, 'en', 'admin', 'dispute_msgs.update', 'Dispute Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1477, 0, 'en', 'admin', 'dispute_msgs.delete', 'Dispute Deleted Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1478, 0, 'en', 'admin', 'notification_msgs.saved', 'Notification Saved Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1479, 0, 'en', 'admin', 'notification_msgs.not_found', 'Notification Not Found', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1480, 0, 'en', 'admin', 'notification_msgs.exists', 'Notification Already Exists', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1481, 0, 'en', 'admin', 'notification_msgs.update', 'Notification Updated Successfully', '2019-06-11 20:40:50', '2019-06-11 20:41:30'),
(1482, 0, 'en', 'admin', 'notification_msgs.delete', 'Notification Deleted Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1483, 0, 'en', 'admin', 'lostitem_msgs.saved', 'Lost Item Request Saved Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1484, 0, 'en', 'admin', 'lostitem_msgs.not_found', 'Lost Item Request Not Found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1485, 0, 'en', 'admin', 'lostitem_msgs.exists', 'Lost Item Request Already Exists', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1486, 0, 'en', 'admin', 'lostitem_msgs.update', 'Lost Item Request Updated Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1487, 0, 'en', 'admin', 'lostitem_msgs.delete', 'Lost Item Request Deleted Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1488, 0, 'en', 'admin', 'reason_msgs.reason_saved', 'Reason Saved Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1489, 0, 'en', 'admin', 'reason_msgs.reason_not_found', 'Reason Not Found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1490, 0, 'en', 'admin', 'reason_msgs.reason_exists', 'Reason Already Exists', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1491, 0, 'en', 'admin', 'reason_msgs.reason_update', 'Reason Updated Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1492, 0, 'en', 'admin', 'reason_msgs.reason_delete', 'Reason Deleted Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1493, 0, 'en', 'admin', 'service_type_msgs.service_type_saved', 'Service Type Saved Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1494, 0, 'en', 'admin', 'service_type_msgs.service_type_not_found', 'Service Type Not Found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1495, 0, 'en', 'admin', 'service_type_msgs.service_type_exists', 'Service Type Already Exists', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1496, 0, 'en', 'admin', 'service_type_msgs.service_type_update', 'Service Type Updated Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1497, 0, 'en', 'admin', 'service_type_msgs.service_type_delete', 'Service Type Deleted Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1498, 0, 'en', 'admin', 'service_type_msgs.service_type_using', 'Provider using this service, you cannot able to delete', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1499, 0, 'en', 'admin', 'payment_msgs.amount_send', 'Amount successfully send', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1500, 0, 'en', 'admin', 'payment_msgs.account_not_found', 'Strip Account not found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1501, 0, 'en', 'admin', 'payment_msgs.amount_added', ' added to your wallet', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1502, 0, 'en', 'admin', 'permissions', 'Permissions', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1503, 0, 'en', 'admin', 'roles.role_saved', 'Role Saved Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1504, 0, 'en', 'admin', 'roles.role_not_found', 'Role Not Found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1505, 0, 'en', 'admin', 'roles.role_update', 'Role Updated Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1506, 0, 'en', 'admin', 'roles.role_delete', 'Role Deleted Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1507, 0, 'en', 'admin', 'roles.role_name', 'Role', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1508, 0, 'en', 'admin', 'roles.add_role', 'Add Role', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1509, 0, 'en', 'admin', 'roles.update_role', 'Update Role', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1510, 0, 'en', 'api', 'user.incorrect_password', 'Incorrect Password', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1511, 0, 'en', 'api', 'user.incorrect_old_password', 'Incorrect old Password', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1512, 0, 'en', 'api', 'user.change_password', 'Required is new password should \nnot be same as old password', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1513, 0, 'en', 'api', 'user.password_updated', 'Password Updated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1514, 0, 'en', 'api', 'user.location_updated', 'Location Updated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1515, 0, 'en', 'api', 'user.language_updated', 'Language Updated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1516, 0, 'en', 'api', 'user.profile_updated', 'Profile Updated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1517, 0, 'en', 'api', 'user.user_not_found', 'User Not Found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1518, 0, 'en', 'api', 'user.not_paid', 'User Not Paid', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1519, 0, 'en', 'api', 'user.referral_amount', 'Referral Amount', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1520, 0, 'en', 'api', 'user.referral_count', 'Referral Count', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1521, 0, 'en', 'api', 'user.invite_friends', '<p style=\'color:##FDFEFE;\'>Refer your 4 friends<br>and earn <span style=\'color:#f06292\'>€6</span> per head</p>', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1522, 0, 'en', 'api', 'provider.incorrect_password', 'Incorrect Password', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1523, 0, 'en', 'api', 'provider.incorrect_old_password', 'Incorrect old Password', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1524, 0, 'en', 'api', 'provider.change_password', 'Required is new password should \nnot be same as old password', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1525, 0, 'en', 'api', 'provider.password_updated', 'Password Updated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1526, 0, 'en', 'api', 'provider.location_updated', 'Location Updated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1527, 0, 'en', 'api', 'provider.language_updated', 'Language Updated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1528, 0, 'en', 'api', 'provider.profile_updated', 'Profile Updated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1529, 0, 'en', 'api', 'provider.provider_not_found', 'Provider Not Found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1530, 0, 'en', 'api', 'provider.not_approved', 'You account has not been approved for driving', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1531, 0, 'en', 'api', 'provider.incorrect_email', 'The email address or password you entered is incorrect', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1532, 0, 'en', 'api', 'provider.referral_amount', 'Referral Amount', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1533, 0, 'en', 'api', 'provider.referral_count', 'Referral Count', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1534, 0, 'en', 'api', 'provider.invite_friends', '<p style=\'color:##FDFEFE;\'>Refer your 4 friends<br>and earn <span style=\'color:#f06292\'>€6</span> per head</p>', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1535, 0, 'en', 'api', 'ride.request_inprogress', 'Already Request in Progress', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1536, 0, 'en', 'api', 'ride.no_providers_found', 'No Drivers Found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1537, 0, 'en', 'api', 'ride.request_cancelled', 'Your Ride Cancelled', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1538, 0, 'en', 'api', 'ride.already_cancelled', 'Already Ride Cancelled', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1539, 0, 'en', 'api', 'ride.ride_cancelled', 'Ride Cancelled', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1540, 0, 'en', 'api', 'ride.already_onride', 'Already You are Onride', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1541, 0, 'en', 'api', 'ride.provider_rated', 'Driver Rated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1542, 0, 'en', 'api', 'ride.request_scheduled', 'Ride Scheduled', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1543, 0, 'en', 'api', 'ride.request_already_scheduled', 'Ride Already Scheduled', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1544, 0, 'en', 'api', 'ride.request_modify_location', 'User Changed Destination Address', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1545, 0, 'en', 'api', 'ride.request_completed', 'Request Completed', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1546, 0, 'en', 'api', 'ride.request_not_completed', 'Request not yet completed', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1547, 0, 'en', 'api', 'ride.request_rejected', 'Request Rejected Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1548, 0, 'en', 'api', 'payment_success', 'Payment Success', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1549, 0, 'en', 'api', 'invalid', 'Invalid credentials', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1550, 0, 'en', 'api', 'unauthenticated', 'Unauthenticated', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1551, 0, 'en', 'api', 'something_went_wrong', 'Something Went Wrong', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1552, 0, 'en', 'api', 'destination_changed', 'Destination location changed', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1553, 0, 'en', 'api', 'unable_accept', 'Unable to accept, Please try again later', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1554, 0, 'en', 'api', 'connection_err', 'Connection Error', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1555, 0, 'en', 'api', 'logout_success', 'Logged out Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1556, 0, 'en', 'api', 'email_available', 'Email Available', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1557, 0, 'en', 'api', 'email_not_available', 'Email Not Available', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1558, 0, 'en', 'api', 'mobile_exist', 'Mobile Number Already Exists', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1559, 0, 'en', 'api', 'country_code', 'Country code is required.', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1560, 0, 'en', 'api', 'email_exist', 'Email Already Exists', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1561, 0, 'en', 'api', 'available', 'Data Available', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1562, 0, 'en', 'api', 'services_not_found', 'Services Not Found', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1563, 0, 'en', 'api', 'promocode_applied', 'Promocode Applied', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1564, 0, 'en', 'api', 'promocode_expired', 'Promocode Expired', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1565, 0, 'en', 'api', 'promocode_already_in_use', 'Promocode Already in Use', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1566, 0, 'en', 'api', 'paid', 'Paid', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1567, 0, 'en', 'api', 'added_to_your_wallet', 'Added to your Wallet', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1568, 0, 'en', 'api', 'amount_success', 'Request amount added', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1569, 0, 'en', 'api', 'amount_cancel', 'Request has been cancelled', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1570, 0, 'en', 'api', 'amount_max', 'The amount may not be greater than ', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1571, 0, 'en', 'api', 'card_already', 'Card Already Added', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1572, 0, 'en', 'api', 'card_added', 'Card Added', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1573, 0, 'en', 'api', 'card_deleted', 'Card Deleted', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1574, 0, 'en', 'api', 'otp', 'Otp Is Wrong', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1575, 0, 'en', 'api', 'push.request_accepted', 'Your Ride Accepted by a Driver', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1576, 0, 'en', 'api', 'push.arrived', 'Driver Arrived at your Location', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1577, 0, 'en', 'api', 'push.pickedup', 'Ride Started', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1578, 0, 'en', 'api', 'push.complete', 'Ride Completed', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1579, 0, 'en', 'api', 'push.rate', 'Rated Successfully', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1580, 0, 'en', 'api', 'push.dropped', 'Your ride is completed successfully. you have to pay', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1581, 0, 'en', 'api', 'push.incoming_request', 'New Incoming Ride', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1582, 0, 'en', 'api', 'push.added_money_to_wallet', ' Added to your Wallet', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1583, 0, 'en', 'api', 'push.charged_from_wallet', ' Charged from your Wallet', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1584, 0, 'en', 'api', 'push.document_verfied', 'Your Documents are verified, Now you are ready to Start your Business', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1585, 0, 'en', 'api', 'push.provider_not_available', 'Sorry for inconvience time, Our partner or busy. Please try after some time', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1586, 0, 'en', 'api', 'push.user_cancelled', 'User Cancelled the Ride', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1587, 0, 'en', 'api', 'push.provider_cancelled', 'Driver Cancelled the Ride', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1588, 0, 'en', 'api', 'push.schedule_start', 'Your schedule ride has been started', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1589, 0, 'en', 'api', 'push.provider_waiting_start', 'Driver Started the Waiting Time', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1590, 0, 'en', 'api', 'push.provider_waiting_end', 'Driver Stopped the Waiting Time', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1591, 0, 'en', 'api', 'push.provider_status_hold', 'Go Offline if you want to have a rest', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1592, 0, 'en', 'api', 'transaction.admin_commission', 'admin commission', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1593, 0, 'en', 'api', 'transaction.fleet_debit', 'fleet commission debited', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1594, 0, 'en', 'api', 'transaction.fleet_add', 'fleet commission added', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1595, 0, 'en', 'api', 'transaction.fleet_recharge', 'fleet commission recharge', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1596, 0, 'en', 'api', 'transaction.discount_apply', 'discount applied', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1597, 0, 'en', 'api', 'transaction.discount_refund', 'discount amount refund', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1598, 0, 'en', 'api', 'transaction.discount_recharge', 'provider discount amount recharge', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1599, 0, 'en', 'api', 'transaction.tax_credit', 'tax amount debited', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1600, 0, 'en', 'api', 'transaction.tax_debit', 'tax amount credited', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1601, 0, 'en', 'api', 'transaction.provider_credit', 'ride amount added', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1602, 0, 'en', 'api', 'transaction.provider_recharge', 'provider ride amount recharge', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1603, 0, 'en', 'api', 'transaction.user_recharge', 'recharge', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1604, 0, 'en', 'api', 'transaction.user_trip', 'trip', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1605, 0, 'en', 'api', 'transaction.referal_recharge', 'Referal recharge', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1606, 0, 'en', 'api', 'transaction.dispute_refund', 'Dispute refund', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1607, 0, 'en', 'api', 'transaction.peak_commission', 'Peak hours commission', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1608, 0, 'en', 'api', 'transaction.waiting_commission', 'Waiting charges commission', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1609, 0, 'en', 'auth', 'failed', 'These credentials do not match our records.', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1610, 0, 'en', 'auth', 'throttle', 'Too many login attempts. Please try again in :seconds seconds.', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1611, 0, 'en', 'pagination', 'previous', '&laquo; Previous', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1612, 0, 'en', 'pagination', 'next', 'Next &raquo;', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1613, 0, 'en', 'passwords', 'password', 'Passwords must be at least six characters and match the confirmation.', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1614, 0, 'en', 'passwords', 'reset', 'Your password has been reset!', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1615, 0, 'en', 'passwords', 'sent', 'We have e-mailed your password reset link!', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1616, 0, 'en', 'passwords', 'token', 'This password reset token is invalid.', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1617, 0, 'en', 'passwords', 'user', 'We can\'t find a user with that e-mail address.', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1618, 0, 'en', 'provider', 'profile.help', 'Help', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1619, 0, 'en', 'provider', 'profile.my_profile', 'My Profile', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1620, 0, 'en', 'provider', 'profile.change_password', 'Change Password', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1621, 0, 'en', 'provider', 'profile.logout', 'Logout', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1622, 0, 'en', 'provider', 'profile.profile', 'Profile', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1623, 0, 'en', 'provider', 'profile.manage_documents', 'Manage Documents', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1624, 0, 'en', 'provider', 'profile.update_location', 'Update Location', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1625, 0, 'en', 'provider', 'profile.first_name', 'First Name', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1626, 0, 'en', 'provider', 'profile.last_name', 'Last Name', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1627, 0, 'en', 'provider', 'profile.avatar', 'Avatar', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1628, 0, 'en', 'provider', 'profile.phone', 'Phone', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1629, 0, 'en', 'provider', 'profile.language', 'Language', '2019-06-11 20:40:51', '2019-06-11 20:41:30'),
(1630, 0, 'en', 'provider', 'profile.address', 'Address', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1631, 0, 'en', 'provider', 'profile.full_address', 'Enter Suite, Floor, Apt (optional)', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1632, 0, 'en', 'provider', 'profile.city', 'City', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1633, 0, 'en', 'provider', 'profile.country', 'Country', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1634, 0, 'en', 'provider', 'profile.pin', 'Postal Code', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1635, 0, 'en', 'provider', 'profile.service_type', 'Service Type', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1636, 0, 'en', 'provider', 'profile.car_number', 'Car Number', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1637, 0, 'en', 'provider', 'profile.car_model', 'Car Model', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1638, 0, 'en', 'provider', 'profile.driver_document', 'Driver Documents', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1639, 0, 'en', 'provider', 'profile.vehicle_document', 'Vehicle Documents', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1640, 0, 'en', 'provider', 'profile.enter_location', 'Enter a location', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1641, 0, 'en', 'provider', 'profile.update', 'Update', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1642, 0, 'en', 'provider', 'profile.change_mobile', 'Change Mobile Number', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1643, 0, 'en', 'provider', 'profile.verify', 'Verify', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1644, 0, 'en', 'provider', 'profile.verified', 'Verified', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1645, 0, 'en', 'provider', 'profile.ride', 'Ride', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1646, 0, 'en', 'provider', 'profile.drive', 'Drive', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1647, 0, 'en', 'provider', 'profile.cities', 'Cities', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1648, 0, 'en', 'provider', 'profile.fare_estimate', 'Fare Estimate', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1649, 0, 'en', 'provider', 'profile.signup_to_ride', 'Signup to Ride', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1650, 0, 'en', 'provider', 'profile.become_a_driver', 'Become a Driver', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1651, 0, 'en', 'provider', 'profile.ride_now', 'Ride Now', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1652, 0, 'en', 'provider', 'profile.get_app_on', 'Get App on', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1653, 0, 'en', 'provider', 'profile.connect_us', 'Connect us', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1654, 0, 'en', 'provider', 'profile.home', 'Home', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1655, 0, 'en', 'provider', 'profile.my_trips', 'My Trips', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1656, 0, 'en', 'provider', 'profile.notifications', 'Notifications', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1657, 0, 'en', 'provider', 'profile.partner_earnings', 'Partner Earnings', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1658, 0, 'en', 'provider', 'profile.incoming_request', 'Incoming Request', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1659, 0, 'en', 'provider', 'profile.paul_walker', 'Paul Walker', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1660, 0, 'en', 'provider', 'profile.accept', 'Accept', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1661, 0, 'en', 'provider', 'profile.cancel', 'Cancel', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1662, 0, 'en', 'provider', 'profile.wallet_transaction', 'Wallet Transaction', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1663, 0, 'en', 'provider', 'profile.transfer', 'Transfer', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1664, 0, 'en', 'provider', 'profile.upload', 'Upload', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1665, 0, 'en', 'provider', 'profile.error_msg', 'can only contain alphanumeric characters and . - spaces', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1666, 0, 'en', 'provider', 'profile.error_phone', 'Incorrect phone number', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1667, 0, 'en', 'provider', 'profile.refer_friend', 'Refer a Friend', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1668, 0, 'en', 'provider', 'profile.notify', 'Notifications', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1669, 0, 'en', 'provider', 'profile.qr_code', 'QR Code', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1670, 0, 'en', 'provider', 'profile.paypal_email', 'Paypal Email', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1671, 0, 'en', 'provider', 'partner.payment', 'Payment Statements', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1672, 0, 'en', 'provider', 'partner.upcoming', 'Upcoming', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1673, 0, 'en', 'provider', 'partner.total_earnings', 'Total Earnings', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1674, 0, 'en', 'provider', 'partner.trips_completed', 'TRIPS COMPLETED TODAY', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1675, 0, 'en', 'provider', 'partner.daily_trip', 'DAILY TRIP TARGET', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1676, 0, 'en', 'provider', 'partner.fully_completed', 'FULLY COMPLETED TRIPS', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1677, 0, 'en', 'provider', 'partner.acceptance', 'ACCEPTANCE RATE', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1678, 0, 'en', 'provider', 'partner.driver_cancel', 'DRIVER CANCELLATIONS', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1679, 0, 'en', 'provider', 'partner.weekly_earning', 'Weekly Earnings', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1680, 0, 'en', 'provider', 'partner.trip_earning', 'Trip Earnings', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1681, 0, 'en', 'provider', 'partner.estimate_payout', 'Estimated Payout', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1682, 0, 'en', 'provider', 'partner.daily_earnings', 'Daily Earnings', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1683, 0, 'en', 'provider', 'partner.status', 'Status', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1684, 0, 'en', 'provider', 'partner.all_trip', 'All Trips', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1685, 0, 'en', 'provider', 'partner.completed', 'Completed', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1686, 0, 'en', 'provider', 'partner.pending', 'Pending', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1687, 0, 'en', 'provider', 'partner.pickup', 'Pickup Time', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1688, 0, 'en', 'provider', 'partner.booking_id', 'Booking Id', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1689, 0, 'en', 'provider', 'partner.vehicle', 'Vehicle', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1690, 0, 'en', 'provider', 'partner.duration', 'Duration', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1691, 0, 'en', 'provider', 'partner.distance(km)', 'Distance', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1692, 0, 'en', 'provider', 'partner.invoice_amount', 'Invoice Amount', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1693, 0, 'en', 'provider', 'partner.cash_collected', 'Cash Collected', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1694, 0, 'en', 'provider', 'partner.upcoming_tips', 'Upcoming Trips', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1695, 0, 'en', 'provider', 'partner.pickup_time', 'Pickup Time', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1696, 0, 'en', 'provider', 'partner.pickup_address', 'Pickup Address', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1697, 0, 'en', 'provider', 'partner.action', 'Action', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1698, 0, 'en', 'provider', 'signup.already_register', 'ALREADY REGISTERED?', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1699, 0, 'en', 'provider', 'signup.sign_up', 'Sign Up', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1700, 0, 'en', 'provider', 'signup.enter_phone', 'Enter Phone Number', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1701, 0, 'en', 'provider', 'signup.email_address', 'E-Mail Address', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1702, 0, 'en', 'provider', 'signup.male', 'Male', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1703, 0, 'en', 'provider', 'signup.female', 'Female', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1704, 0, 'en', 'provider', 'signup.password', 'Password', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1705, 0, 'en', 'provider', 'signup.confirm_password', 'Confirm Password', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1706, 0, 'en', 'provider', 'signup.register', 'Register', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1707, 0, 'en', 'provider', 'signup.create_new_acc', 'CREATE NEW ACCOUNT', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1708, 0, 'en', 'provider', 'signup.sign_in', 'Sign In', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1709, 0, 'en', 'provider', 'signup.remember_me', 'Remember Me', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1710, 0, 'en', 'provider', 'signup.login', 'Login', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1711, 0, 'en', 'provider', 'signup.forgot_password', 'Forgot Your Password?', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1712, 0, 'en', 'provider', 'signup.login_facebook', 'LOGIN WITH FACEBOOK', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1713, 0, 'en', 'provider', 'signup.login_google', 'LOGIN WITH GOOGLE+', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1714, 0, 'en', 'provider', 'signup.reset_password', 'Reset Password', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1715, 0, 'en', 'provider', 'signup.already_have_acc', 'ALREADY HAVE AN ACCOUNT?', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1716, 0, 'en', 'provider', 'signup.send_password_reset_link', 'SEND PASSWORD RESET LINK', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1717, 0, 'en', 'provider', 'card.fullname', 'Full Name', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1718, 0, 'en', 'provider', 'card.card_no', 'Card Number', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1719, 0, 'en', 'provider', 'card.cvv', 'CVV', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1720, 0, 'en', 'provider', 'card.add_card', 'Add Card', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1721, 0, 'en', 'provider', 'card.add_debit_card', 'Add Debit Card', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1722, 0, 'en', 'provider', 'card.delete', 'Delete', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1723, 0, 'en', 'provider', 'card.month', 'Month', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1724, 0, 'en', 'provider', 'card.year', 'Year', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1725, 0, 'en', 'provider', 'card.default', 'Default', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1726, 0, 'en', 'provider', 'card.list', 'Debit Cards', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1727, 0, 'en', 'provider', 'card.type', 'Card Type', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1728, 0, 'en', 'provider', 'card.four', 'Last Four', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1729, 0, 'en', 'provider', 'card.set', 'Set Default', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1730, 0, 'en', 'provider', 'card.notfound', 'No Debit Card Added Yet', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1731, 0, 'en', 'provider', 'transaction_ref', 'Transaction Id', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1732, 0, 'en', 'provider', 'transaction_desc', 'Description', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1733, 0, 'en', 'provider', 'sno', 'Sno', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1734, 0, 'en', 'provider', 'amount', 'Amount', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1735, 0, 'en', 'provider', 'status', 'Status', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1736, 0, 'en', 'provider', 'current_balance', 'Current Balance', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1737, 0, 'en', 'provider', 'transfer', 'Transfer', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1738, 0, 'en', 'provider', 'datetime', 'Date &amp; Time', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1739, 0, 'en', 'provider', 'cancel', 'Cancel', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1740, 0, 'en', 'provider', 'document_pending', 'Document Verification Pending', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1741, 0, 'en', 'provider', 'document_upload', 'UPLOAD', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1742, 0, 'en', 'provider', 'card_pending', 'Debit Card Section', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1743, 0, 'en', 'provider', 'negative_balance', 'Wallet balance is below minimum level', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1744, 0, 'en', 'provider', 'drive_now', 'Drive Now', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1745, 0, 'en', 'provider', 'offline', 'GO OFFLINE', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1746, 0, 'en', 'provider', 'online', 'GO ONLINE', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1747, 0, 'en', 'provider', 'hours', 'Hours', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1748, 0, 'en', 'provider', 'minutes', 'Minutes', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1749, 0, 'en', 'provider', 'credit', 'Credit', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1750, 0, 'en', 'provider', 'debit', 'Debit', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1751, 0, 'en', 'provider', 'lang', 'en', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1752, 0, 'en', 'provider', 'enter_location', 'Enter a location', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1753, 0, 'en', 'provider', 'your_location', 'Your Location', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1754, 0, 'en', 'provider', 'expires', 'Expires', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1755, 0, 'en', 'provider', 'type', 'Type', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1756, 0, 'en', 'servicetypes', 'MIN', 'Per Minute Pricing', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1757, 0, 'en', 'servicetypes', 'HOUR', 'Per Hour Pricing', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1758, 0, 'en', 'servicetypes', 'DISTANCE', 'Distance Pricing', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1759, 0, 'en', 'servicetypes', 'DISTANCEMIN', 'Distance and Per Minute Pricing', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1760, 0, 'en', 'servicetypes', 'DISTANCEHOUR', 'Distance and Per Hour Pricing', '2019-06-11 20:40:51', '2019-06-11 20:41:31'),
(1761, 0, 'en', 'user', 'profile.old_password', 'Old Password', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1762, 0, 'en', 'user', 'profile.password', 'Password', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1763, 0, 'en', 'user', 'profile.confirm_password', 'Confirm Password', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1764, 0, 'en', 'user', 'profile.first_name', 'First Name', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1765, 0, 'en', 'user', 'profile.last_name', 'Last Name', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1766, 0, 'en', 'user', 'profile.email', 'Email', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1767, 0, 'en', 'user', 'profile.mobile', 'Mobile', '2019-06-11 20:40:52', '2019-06-11 20:41:31');
INSERT INTO `ltm_translations` (`id`, `status`, `locale`, `group`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1768, 0, 'en', 'user', 'profile.general_information', 'General Information', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1769, 0, 'en', 'user', 'profile.profile_picture', 'Profile Picture', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1770, 0, 'en', 'user', 'profile.wallet_balance', 'Wallet Balance', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1771, 0, 'en', 'user', 'profile.edit', 'Edit', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1772, 0, 'en', 'user', 'profile.save', 'Save', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1773, 0, 'en', 'user', 'profile.edit_information', 'Edit Information', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1774, 0, 'en', 'user', 'profile.change_password', 'Change Password', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1775, 0, 'en', 'user', 'profile.profile', 'Profile', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1776, 0, 'en', 'user', 'profile.change_mobile', 'Change Mobile Number', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1777, 0, 'en', 'user', 'profile.verify', 'Verify', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1778, 0, 'en', 'user', 'profile.verified', 'Verified', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1779, 0, 'en', 'user', 'profile.settings', 'Settings', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1780, 0, 'en', 'user', 'profile.logout', 'Logout', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1781, 0, 'en', 'user', 'profile.name', 'Name', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1782, 0, 'en', 'user', 'profile.language', 'Language', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1783, 0, 'en', 'user', 'profile.notify', 'Notifications', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1784, 0, 'en', 'user', 'profile.qr_code', 'QR Code', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1785, 0, 'en', 'user', 'profile.country_code', 'Country Code', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1786, 0, 'en', 'user', 'cash', 'CASH', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1787, 0, 'en', 'user', 'booking_id', 'Booking Id', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1788, 0, 'en', 'user', 'service_number', 'Car Number', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1789, 0, 'en', 'user', 'service_model', 'Car Model', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1790, 0, 'en', 'user', 'service_type', 'Service Type', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1791, 0, 'en', 'user', 'card.fullname', 'Full Name', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1792, 0, 'en', 'user', 'card.card_no', 'Card Number', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1793, 0, 'en', 'user', 'card.cvv', 'CVV', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1794, 0, 'en', 'user', 'card.add_card', 'Add Card', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1795, 0, 'en', 'user', 'card.delete', 'Delete', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1796, 0, 'en', 'user', 'card.month', 'Month', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1797, 0, 'en', 'user', 'card.year', 'Year', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1798, 0, 'en', 'user', 'card.default', 'Default', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1799, 0, 'en', 'user', 'card.delete_msg', 'Are you sure want to delete this card?', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1800, 0, 'en', 'user', 'fare_breakdown', 'FARE BREAKDOWN', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1801, 0, 'en', 'user', 'ride.finding_driver', 'Finding your Driver', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1802, 0, 'en', 'user', 'ride.accepted_ride', 'Accepted Your Ride', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1803, 0, 'en', 'user', 'ride.arrived_ride', 'Arrived At your Location', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1804, 0, 'en', 'user', 'ride.onride', 'Enjoy your Ride', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1805, 0, 'en', 'user', 'ride.waiting_payment', 'Waiting for Payment', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1806, 0, 'en', 'user', 'ride.rate_and_review', 'Rate and Review', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1807, 0, 'en', 'user', 'ride.ride_now', 'Ride Now', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1808, 0, 'en', 'user', 'ride.make_a_ride', 'Make a ride', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1809, 0, 'en', 'user', 'ride.change_drop_location', 'Change Drop Location', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1810, 0, 'en', 'user', 'ride.cancel_request', 'Cancel Request', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1811, 0, 'en', 'user', 'ride.ride_status', 'Ride Status', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1812, 0, 'en', 'user', 'ride.dropped_ride', 'Your Ride is Completed', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1813, 0, 'en', 'user', 'ride.ride_details', 'Ride Details', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1814, 0, 'en', 'user', 'ride.invoice', 'Invoice', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1815, 0, 'en', 'user', 'ride.base_price', 'Base Fare', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1816, 0, 'en', 'user', 'ride.tax_price', 'Tax Fare', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1817, 0, 'en', 'user', 'ride.toll_charge', 'Toll Charge', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1818, 0, 'en', 'user', 'ride.waiting_price', 'Waiting Charge', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1819, 0, 'en', 'user', 'ride.distance_price', 'Distance Fare', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1820, 0, 'en', 'user', 'ride.minutes_price', 'Minutes Fare', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1821, 0, 'en', 'user', 'ride.hours_price', 'Hours Fare', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1822, 0, 'en', 'user', 'ride.distance_travelled', 'Distance Travelled', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1823, 0, 'en', 'user', 'ride.tips', 'Tips', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1824, 0, 'en', 'user', 'ride.comment', 'Comment', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1825, 0, 'en', 'user', 'ride.detection_wallet', 'Wallet Detection', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1826, 0, 'en', 'user', 'ride.rating', 'Rating', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1827, 0, 'en', 'user', 'ride.km', 'Kilometer', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1828, 0, 'en', 'user', 'ride.total', 'Total', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1829, 0, 'en', 'user', 'ride.amount_paid', 'Amount to be Paid', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1830, 0, 'en', 'user', 'ride.round_off', 'Round off amount', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1831, 0, 'en', 'user', 'ride.promotion_applied', 'Promotion Applied', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1832, 0, 'en', 'user', 'ride.request_inprogress', 'Ride Already in Progress', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1833, 0, 'en', 'user', 'ride.request_scheduled', 'Ride Already Scheduled on this time', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1834, 0, 'en', 'user', 'ride.cancel_reason', 'Cancel Reason', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1835, 0, 'en', 'user', 'ride.wallet_deduction', 'Wallet Deduction', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1836, 0, 'en', 'user', 'ride.im_the_traveller', 'Im the traveller', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1837, 0, 'en', 'user', 'ride.i_have_a_passenger', 'I have a passenger', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1838, 0, 'en', 'user', 'dashboard', 'Dashboard', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1839, 0, 'en', 'user', 'payment', 'Payment', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1840, 0, 'en', 'user', 'wallet', 'Wallet', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1841, 0, 'en', 'user', 'my_wallet', 'My Wallet', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1842, 0, 'en', 'user', 'my_trips', 'My Trips', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1843, 0, 'en', 'user', 'notifications', 'Notifications', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1844, 0, 'en', 'user', 'user', 'User', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1845, 0, 'en', 'user', 'title', 'Title', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1846, 0, 'en', 'user', 'description', 'Description', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1847, 0, 'en', 'user', 'updated', 'Updated', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1848, 0, 'en', 'user', 'in_your_wallet', 'in your wallet', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1849, 0, 'en', 'user', 'status', 'Status', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1850, 0, 'en', 'user', 'driver_name', 'Driver Name', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1851, 0, 'en', 'user', 'driver_rating', 'Driver Rating', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1852, 0, 'en', 'user', 'payment_mode', 'Payment Mode', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1853, 0, 'en', 'user', 'otp', 'Otp', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1854, 0, 'en', 'user', 'add_money', 'Add Money', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1855, 0, 'en', 'user', 'date', 'Date', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1856, 0, 'en', 'user', 'schedule_date', 'Date', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1857, 0, 'en', 'user', 'amount', 'Total Amount', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1858, 0, 'en', 'user', 'dispute', 'Dispute', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1859, 0, 'en', 'user', 'type', 'Type', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1860, 0, 'en', 'user', 'time', 'Time', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1861, 0, 'en', 'user', 'request_id', 'Request ID', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1862, 0, 'en', 'user', 'paid_via', 'PAID VIA', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1863, 0, 'en', 'user', 'from', 'From', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1864, 0, 'en', 'user', 'total_distance', 'Total Distance', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1865, 0, 'en', 'user', 'eta', 'ETA', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1866, 0, 'en', 'user', 'to', 'To', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1867, 0, 'en', 'user', 'use_wallet_balance', 'Use Wallet Balance', '2019-06-11 20:40:52', '2019-06-11 20:41:31'),
(1868, 0, 'en', 'user', 'available_wallet_balance', 'Available Wallet Balance', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1869, 0, 'en', 'user', 'estimated_fare', 'Estimated Fare', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1870, 0, 'en', 'user', 'charged', 'CHARGED', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1871, 0, 'en', 'user', 'payment_method', 'Payment Methods', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1872, 0, 'en', 'user', 'promotion', 'Promotions', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1873, 0, 'en', 'user', 'promocode', 'Promocodes', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1874, 0, 'en', 'user', 'add_promocode', 'Add Promocode', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1875, 0, 'en', 'user', 'upcoming_trips', 'Upcoming trips', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1876, 0, 'en', 'user', 'total', 'Total', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1877, 0, 'en', 'user', 'promocode_select', 'Select Promocode', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1878, 0, 'en', 'user', 'schedule_title', 'Schedule a Ride', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1879, 0, 'en', 'user', 'schedule', 'Schedule Later', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1880, 0, 'en', 'user', 'schedule_time', 'Time', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1881, 0, 'en', 'user', 'schedule_ride', 'Schedule Ride', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1882, 0, 'en', 'user', 'demand_node', 'Note : Due to High Demand the fare may vary!', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1883, 0, 'en', 'user', 'no_trips', 'No trips Available', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1884, 0, 'en', 'user', 'provider_details', 'Provider Details', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1885, 0, 'en', 'user', 'ride_cancel', 'Cancel Ride', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1886, 0, 'en', 'user', 'enter_amount', 'Enter Amount', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1887, 0, 'en', 'user', 'please', 'Please', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1888, 0, 'en', 'user', 'add_card', 'add card', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1889, 0, 'en', 'user', 'to_continue', 'to continue', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1890, 0, 'en', 'user', 'credit', 'Credit', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1891, 0, 'en', 'user', 'debit', 'Debit', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1892, 0, 'en', 'user', 'maperror', 'Invalid Map Key', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1893, 0, 'en', 'user', 'referral', 'Refer a Friend', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1894, 0, 'en', 'validation', 'accepted', 'The :attribute must be accepted.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1895, 0, 'en', 'validation', 'active_url', 'The :attribute is not a valid URL.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1896, 0, 'en', 'validation', 'after', 'The :attribute must be a date after :date.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1897, 0, 'en', 'validation', 'after_or_equal', 'The :attribute must be a date after or equal to :date.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1898, 0, 'en', 'validation', 'alpha', 'The :attribute may only contain letters.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1899, 0, 'en', 'validation', 'alpha_dash', 'The :attribute may only contain letters, numbers, and dashes.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1900, 0, 'en', 'validation', 'alpha_num', 'The :attribute may only contain letters and numbers.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1901, 0, 'en', 'validation', 'array', 'The :attribute must be an array.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1902, 0, 'en', 'validation', 'before', 'The :attribute must be a date before :date.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1903, 0, 'en', 'validation', 'before_or_equal', 'The :attribute must be a date before or equal to :date.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1904, 0, 'en', 'validation', 'between.numeric', 'The :attribute must be between :min and :max.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1905, 0, 'en', 'validation', 'between.file', 'The :attribute must be between :min and :max kilobytes.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1906, 0, 'en', 'validation', 'between.string', 'The :attribute must be between :min and :max characters.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1907, 0, 'en', 'validation', 'between.array', 'The :attribute must have between :min and :max items.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1908, 0, 'en', 'validation', 'boolean', 'The :attribute field must be true or false.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1909, 0, 'en', 'validation', 'confirmed', 'The :attribute confirmation does not match.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1910, 0, 'en', 'validation', 'date', 'The :attribute is not a valid date.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1911, 0, 'en', 'validation', 'date_format', 'The :attribute does not match the format :format.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1912, 0, 'en', 'validation', 'different', 'The :attribute and :other must be different.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1913, 0, 'en', 'validation', 'digits', 'The :attribute must be :digits digits.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1914, 0, 'en', 'validation', 'digits_between', 'The :attribute must be between :min and :max digits.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1915, 0, 'en', 'validation', 'dimensions', 'The :attribute has invalid image dimensions.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1916, 0, 'en', 'validation', 'distinct', 'The :attribute field has a duplicate value.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1917, 0, 'en', 'validation', 'email', 'The :attribute must be a valid email address.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1918, 0, 'en', 'validation', 'exists', 'The selected :attribute is invalid.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1919, 0, 'en', 'validation', 'file', 'The :attribute must be a file.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1920, 0, 'en', 'validation', 'filled', 'The :attribute field is required.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1921, 0, 'en', 'validation', 'image', 'The :attribute must be an image.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1922, 0, 'en', 'validation', 'in', 'The selected :attribute is invalid.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1923, 0, 'en', 'validation', 'in_array', 'The :attribute field does not exist in :other.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1924, 0, 'en', 'validation', 'integer', 'The :attribute must be an integer.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1925, 0, 'en', 'validation', 'ip', 'The :attribute must be a valid IP address.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1926, 0, 'en', 'validation', 'json', 'The :attribute must be a valid JSON string.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1927, 0, 'en', 'validation', 'max.numeric', 'The :attribute may not be greater than :max.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1928, 0, 'en', 'validation', 'max.file', 'The :attribute may not be greater than :max kilobytes.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1929, 0, 'en', 'validation', 'max.string', 'The :attribute may not be greater than :max characters.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1930, 0, 'en', 'validation', 'max.array', 'The :attribute may not have more than :max items.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1931, 0, 'en', 'validation', 'mimes', 'The :attribute must be a file of type: :values.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1932, 0, 'en', 'validation', 'mimetypes', 'The :attribute must be a file of type: :values.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1933, 0, 'en', 'validation', 'min.numeric', 'The :attribute must be at least :min.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1934, 0, 'en', 'validation', 'min.file', 'The :attribute must be at least :min kilobytes.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1935, 0, 'en', 'validation', 'min.string', 'The :attribute must be at least :min characters.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1936, 0, 'en', 'validation', 'min.array', 'The :attribute must have at least :min items.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1937, 0, 'en', 'validation', 'not_in', 'The selected :attribute is invalid.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1938, 0, 'en', 'validation', 'numeric', 'The :attribute must be a number.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1939, 0, 'en', 'validation', 'present', 'The :attribute field must be present.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1940, 0, 'en', 'validation', 'regex', 'The :attribute format is invalid.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1941, 0, 'en', 'validation', 'required', 'The :attribute field is required.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1942, 0, 'en', 'validation', 'required_if', 'The :attribute field is required when :other is :value.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1943, 0, 'en', 'validation', 'required_unless', 'The :attribute field is required unless :other is in :values.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1944, 0, 'en', 'validation', 'required_with', 'The :attribute field is required when :values is present.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1945, 0, 'en', 'validation', 'required_with_all', 'The :attribute field is required when :values is present.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1946, 0, 'en', 'validation', 'required_without', 'The :attribute field is required when :values is not present.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1947, 0, 'en', 'validation', 'required_without_all', 'The :attribute field is required when none of :values are present.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1948, 0, 'en', 'validation', 'same', 'The :attribute and :other must match.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1949, 0, 'en', 'validation', 'size.numeric', 'The :attribute must be :size.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1950, 0, 'en', 'validation', 'size.file', 'The :attribute must be :size kilobytes.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1951, 0, 'en', 'validation', 'size.string', 'The :attribute must be :size characters.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1952, 0, 'en', 'validation', 'size.array', 'The :attribute must contain :size items.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1953, 0, 'en', 'validation', 'string', 'The :attribute must be a string.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1954, 0, 'en', 'validation', 'timezone', 'The :attribute must be a valid zone.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1955, 0, 'en', 'validation', 'unique', 'The :attribute has already been taken.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1956, 0, 'en', 'validation', 'uploaded', 'The :attribute failed to upload.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1957, 0, 'en', 'validation', 'url', 'The :attribute format is invalid.', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1958, 0, 'en', 'validation', 'custom.s_latitude.required', 'Source address required', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1959, 0, 'en', 'validation', 'custom.d_latitude.required', 'Destination address required', '2019-06-11 20:40:52', '2019-06-11 20:41:32'),
(1960, 0, 'en', 'admin', 'payment.payumoney_merchant_id', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1961, 0, 'en', 'admin', 'admins.user_update', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1962, 0, 'en', 'user', 'ride.trips.saved', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1963, 0, 'en', 'user', 'ride.trips.not_found', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1964, 0, 'en', '_json', 'provider.partner.distance(km)', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1965, 0, 'en', '_json', 'No Records', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1966, 0, 'en', '_json', 'Disable', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1967, 0, 'en', '_json', 'Enable', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1968, 0, 'en', '_json', 'Page Expired', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1969, 0, 'en', '_json', 'Sorry, your session has expired. Please refresh and try again.', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1970, 0, 'en', '_json', 'Unauthorized', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1971, 0, 'en', '_json', 'Sorry, you are not authorized to access this page.', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1972, 0, 'en', '_json', 'Oh no', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1973, 0, 'en', '_json', 'Go Home', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1974, 0, 'en', '_json', 'Error', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1975, 0, 'en', '_json', 'Whoops, something went wrong on our servers.', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1976, 0, 'en', '_json', 'Forbidden', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1977, 0, 'en', '_json', 'Too Many Requests', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08'),
(1978, 0, 'en', '_json', 'Sorry, you are making too many requests to our servers.', NULL, '2019-06-11 20:41:08', '2019-06-11 20:41:08');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_04_02_193005_create_translations_table', 1),
(2, '2014_10_12_000000_create_users_table', 1),
(3, '2014_10_12_100000_create_password_resets_table', 1),
(4, '2015_08_25_172600_create_settings_table', 1),
(5, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(6, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(7, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(8, '2016_06_01_000004_create_oauth_clients_table', 1),
(9, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(10, '2016_12_03_000000_create_payu_payments_table', 1),
(11, '2016_12_03_000000_create_permission_tables', 1),
(12, '2017_01_11_180503_create_admins_table', 1),
(13, '2017_01_11_180511_create_providers_table', 1),
(14, '2017_01_11_181312_create_cards_table', 1),
(15, '2017_01_11_181357_create_chats_table', 1),
(16, '2017_01_11_181558_create_promocodes_table', 1),
(17, '2017_01_11_182454_create_provider_documents_table', 1),
(18, '2017_01_11_182536_create_provider_services_table', 1),
(19, '2017_01_11_182649_create_user_requests_table', 1),
(20, '2017_01_11_182717_create_request_filters_table', 1),
(21, '2017_01_11_182738_create_service_types_table', 1),
(22, '2017_01_25_172422_create_documents_table', 1),
(23, '2017_01_31_122021_create_provider_devices_table', 1),
(24, '2017_02_02_192703_create_user_request_ratings_table', 1),
(25, '2017_02_06_080124_create_user_request_payments_table', 1),
(26, '2017_02_14_135859_create_provider_profiles_table', 1),
(27, '2017_02_21_131429_create_promocode_usages_table', 1),
(28, '2017_06_17_151030_create_dispatchers_table', 1),
(29, '2017_06_17_151031_create_dispatcher_password_resets_table', 1),
(30, '2017_06_17_151145_create_fleets_table', 1),
(31, '2017_06_17_151146_create_fleet_password_resets_table', 1),
(32, '2017_06_20_154148_create_accounts_table', 1),
(33, '2017_06_20_154149_create_account_password_resets_table', 1),
(34, '2017_08_03_194354_create_custom_pushes_table', 1),
(35, '2017_09_01_190333_create_wallet_passbooks_table', 1),
(36, '2017_09_01_190355_create_promocode_passbooks_table', 1),
(37, '2017_09_26_160101_create_favourite_locations_table', 1),
(38, '2018_06_29_174517_create_works_table', 1),
(39, '2018_09_07_151624_create_admin_wallet_table', 1),
(40, '2018_09_07_151631_create_user_wallet_table', 1),
(41, '2018_09_07_151636_create_provider_wallet_table', 1),
(42, '2018_09_07_151645_create_fleet_wallet_table', 1),
(43, '2018_09_14_160535_create_wallet_requests_table', 1),
(44, '2018_09_24_164552_create_provider_cards_table', 1),
(45, '2018_09_26_143905_create_fleet_cards_table', 1),
(46, '2018_09_27_195450_create_eventcontacts_table', 1),
(47, '2018_12_07_132532_create_referral_histroy_table', 1),
(48, '2018_12_07_132536_create_referral_earnings_table', 1),
(49, '2018_12_18_171537_create_reasons_table', 1),
(50, '2018_12_27_125550_create_request_waiting_time_table', 1),
(51, '2018_12_27_125553_create_service_peak_hours_table', 1),
(52, '2018_12_27_125556_create_peak_hours_table', 1),
(53, '2019_01_07_135142_create_disputes_table', 1),
(54, '2019_01_07_135145_create_user_request_disputes_table', 1),
(55, '2019_01_07_135146_create_user_request_lost_items_table', 1),
(56, '2019_01_07_135148_create_notifications_table', 1),
(57, '2019_01_28_145133_create_push_subscriptions_table', 1),
(58, '2019_01_31_104045_create_payment_logs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Admin', 1),
(2, 'App\\Admin', 2),
(2, 'App\\Admin', 5),
(3, 'App\\Admin', 4),
(3, 'App\\Admin', 7),
(4, 'App\\Admin', 3),
(5, 'App\\Fleet', 1),
(6, 'App\\Admin', 8),
(6, 'App\\Admin', 9);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(10) UNSIGNED NOT NULL,
  `notify_type` enum('all','user','provider') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'all',
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiry_date` timestamp NULL DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('1732cce01db571203acd9d9ca7bb58dd06a4b49b6cdc72d90b1fb08ec28b45b3d984ba54c21e4a5d', 906, 2, NULL, '[]', 0, '2019-09-12 15:50:16', '2019-09-12 15:50:16', '2019-09-27 17:50:16'),
('17dba116dbcb59c4a3b2589d68d89b1a3f7628b6d5ba3c2b4157ebc270a087e6c2ff26cdb0c13c26', 1120, 2, NULL, '[]', 0, '2019-09-14 08:42:11', '2019-09-14 08:42:11', '2019-09-29 10:42:11'),
('1ef852b892b38c012c7e90049a143194e952c07acabf30a7fcbef6ca84fb101247943d1b8ce200c7', 1112, 2, NULL, '[]', 0, '2019-08-19 18:06:24', '2019-08-19 18:06:24', '2019-09-03 20:06:24'),
('420d932f2a226aa770afb4175bea47efaad62fbe67e02d1971830d2755820813b8737d3a25613e4c', 1119, 2, NULL, '[]', 0, '2019-09-14 10:51:07', '2019-09-14 10:51:07', '2019-09-29 12:51:07'),
('42143e2e8cf4314d3eb451fc6e53f9878e3dc8323342e4aa1163057612734f2cf417d9da422a03f6', 1097, 1, 'AutoLogin', '[]', 0, '2019-08-09 17:40:40', '2019-08-09 17:40:40', '2020-08-09 19:40:40'),
('4e9d44122b7aff2f30fe31985e08cc68737db1196b29f3ed8e3bdc8435ae21e097fddb9dc2974eae', 1084, 2, NULL, '[]', 0, '2019-07-31 16:01:51', '2019-07-31 16:01:51', '2019-08-15 18:01:51'),
('5313844ac2b481b64aee0447c10d713d61b98bf8fae8e69a1218908a5f290014d5d1e414a0edf71c', 779, 1, 'AutoLogin', '[]', 0, '2019-04-12 08:29:28', '2019-04-12 08:29:28', '2020-04-12 08:29:28'),
('569edcf4d7cec4fed56b1c1445aa751f1c665b20de91fe74568c13c16ac77ddd6be3daa43bf72820', 1099, 1, 'AutoLogin', '[]', 0, '2019-08-12 12:18:12', '2019-08-12 12:18:12', '2020-08-12 14:18:12'),
('5bc81cecf3331c9752bdc14da501565b5d04ed07a2498304e85fe9de81b25b9ee948eb5ae4822d83', 1096, 1, 'AutoLogin', '[]', 0, '2019-08-09 15:46:11', '2019-08-09 15:46:11', '2020-08-09 17:46:11'),
('6385f3b2df09635f04574c47da737ad8913a0430807c46fc3646029b35f5344795eeb0a13369cbb5', 102, 2, NULL, '[]', 0, '2019-07-30 11:04:18', '2019-07-30 11:04:18', '2019-08-14 13:04:18'),
('751578664cd111e7789ab00ef6fa22d759c65b97147d3ab731b19a2572bb87b6a6c3f00eecbd2fdc', 1093, 1, 'AutoLogin', '[]', 0, '2019-08-09 13:15:31', '2019-08-09 13:15:31', '2020-08-09 15:15:31'),
('7ecd6069750b4f9bbc81fa2cfbd5b2a72a2a642f799d40d4874bf478f0bb0622baaf57e8e2f44c0e', 1103, 2, NULL, '[]', 0, '2019-08-19 16:48:58', '2019-08-19 16:48:58', '2019-09-03 18:48:58'),
('9e7d7e3661c53c9f1268e007ce89a7cd4b9f83e1fe186b7e8789b579de3c156e9431dbf765d87b7d', 1095, 1, 'AutoLogin', '[]', 0, '2019-08-09 15:39:36', '2019-08-09 15:39:36', '2020-08-09 17:39:36'),
('a5e7da40ac9175e45bc2bdee09df2b8188e572f383ed5b46898681c1d71f0880dfd8d4adb065dee3', 1167, 2, NULL, '[]', 0, '2020-02-05 19:54:03', '2020-02-05 19:54:03', '2020-02-20 20:54:03'),
('a696163dfe206435c346ce76379603e5a9f4f89b1a35fcb273da84c4816835a8732958c2967cdd16', 1139, 2, NULL, '[]', 0, '2020-01-04 06:24:09', '2020-01-04 06:24:09', '2020-01-19 07:24:09'),
('a76ae4d5deca34ba00973d606b509e870bfedf7d7d3cc6ec1055d1c1fb88dc9075428bd9fc6af66a', 1113, 2, NULL, '[]', 0, '2019-08-20 09:07:03', '2019-08-20 09:07:03', '2019-09-04 11:07:03'),
('abf5f64acf3333153d8431219548df5e5f22f3e612af6e9b088cbe30430e544c5f0f980dfdf4426c', 989, 1, 'AutoLogin', '[]', 0, '2019-06-22 16:18:13', '2019-06-22 16:18:13', '2020-06-22 16:18:13'),
('b0ad519ba3111a213c40b48eef3607470e844bd4681ef8b21bb923b52738b1b2769a0cd51bb036ec', 1098, 1, 'AutoLogin', '[]', 0, '2019-08-09 18:21:42', '2019-08-09 18:21:42', '2020-08-09 20:21:42'),
('bbffe9f7901e414f3c98ecc048255434f6ceeed158091b1a60dbd9491fb4c773ec70b7a45836ad40', 910, 2, NULL, '[]', 0, '2020-01-07 02:32:06', '2020-01-07 02:32:06', '2020-01-22 03:32:06'),
('beae0aff74067cd917b2497f38748b1e5981ee0ebf07bec16af2e9aa1f68804de98032eeed405e19', 904, 2, NULL, '[]', 0, '2019-06-29 16:47:59', '2019-06-29 16:47:59', '2019-07-14 16:47:59'),
('c2deb08c09f2137028872d603c863e682e163dae498606fc4656343d25c4ac48a609faad07acfdf2', 1176, 1, 'AutoLogin', '[]', 0, '2020-02-03 23:14:14', '2020-02-03 23:14:14', '2021-02-04 00:14:14'),
('c3b6370912d03cd42398defc9bd908762530d2a3fa4e64ac9a1980d8cc24b08d148b4eb322a0a48e', 1123, 2, NULL, '[]', 0, '2019-09-18 20:10:12', '2019-09-18 20:10:12', '2019-10-03 22:10:12'),
('dbc0a2812af8a25052bf6bf2e116fbd571e36412a00d89ce78f54ce4f146c70f3da19337184854b8', 1124, 2, NULL, '[]', 0, '2020-02-07 16:48:42', '2020-02-07 16:48:42', '2020-02-22 17:48:42'),
('ea26d6c91b6c79aa6692c64a83c4f7dc3e8bc2f478cc8ccaa61fccbec607b5d1cf443960ce480729', 1177, 2, NULL, '[]', 0, '2020-02-24 08:34:29', '2020-02-24 08:34:29', '2020-03-10 09:34:29'),
('ecb6183fc1f6012e69f3f809142d985d705b9c3ef94186f5fcfef33b933c985713dbaf76071cd1d4', 1, 2, NULL, '[]', 0, '2020-02-27 15:08:57', '2020-02-27 15:08:57', '2020-03-13 23:08:56'),
('f0264fff0ca2b76794746acd3234761ce5afc62ca67810a810b22ff74e42bb61d0293192fe60a598', 1121, 2, NULL, '[]', 0, '2019-09-20 14:36:27', '2019-09-20 14:36:27', '2019-10-05 16:36:27'),
('f08442216b8a4781b9676f1713222aea291d5636ed90f5160083d552505cf9995c839e5c7ed038d0', 1110, 2, NULL, '[]', 0, '2019-11-01 18:43:17', '2019-11-01 18:43:17', '2019-11-16 19:43:17'),
('f3fea926e978b5878500c49565e680edf28abbacf62e92085b543d4895239d7336ba932c358ef300', 117, 1, 'AutoLogin', '[]', 0, '2019-02-28 13:18:34', '2019-02-28 13:18:34', '2020-02-28 12:18:34');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'VTCPro Personal Access Client', 'WQSwgKCNd0sPrXGIzogQd4XhjjbMsDUPeANiXMOy', 'http://localhost', 1, 0, 0, '2019-02-27 06:10:27', '2019-02-27 06:10:27'),
(2, NULL, 'VTCPro Password Grant Client', 'OMV3biaXeE78bOW5TIOJABYLkLOnz2YTx5kadSK3', 'http://localhost', 0, 1, 0, '2019-02-27 06:10:27', '2019-02-27 06:10:27');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-02-27 06:10:27', '2019-02-27 06:10:27');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
('0a718038fbc0bbe85aefe3ad2728aac8b702577f8e55d74255ee73071146fe335d1f010de242ac12', 'c3b6370912d03cd42398defc9bd908762530d2a3fa4e64ac9a1980d8cc24b08d148b4eb322a0a48e', 0, '2019-12-17 22:10:12'),
('10ffd419c8f6904663013fb63004185dd5392d0ee178e2602fd280c1fec5abe55698931f9b38c22d', '17dba116dbcb59c4a3b2589d68d89b1a3f7628b6d5ba3c2b4157ebc270a087e6c2ff26cdb0c13c26', 0, '2019-12-13 10:42:11'),
('1bdd929fe0516ed4be36a832ab3dee41c86c7e7051a4494227084eaefc0adc06a574741a044f7e97', 'f0264fff0ca2b76794746acd3234761ce5afc62ca67810a810b22ff74e42bb61d0293192fe60a598', 0, '2019-12-19 16:36:27'),
('2ffc2435fefd12d408dd1662a13f2fb10467a04dc157808c70bbd8365697fdea6bf53be01df5c022', 'a696163dfe206435c346ce76379603e5a9f4f89b1a35fcb273da84c4816835a8732958c2967cdd16', 0, '2020-04-03 07:24:09'),
('354dad01f3c86dfa772434003e6a3474d95189c6d72ab473b12429b8f6fa914abe405ef050f411c8', '4e9d44122b7aff2f30fe31985e08cc68737db1196b29f3ed8e3bdc8435ae21e097fddb9dc2974eae', 0, '2019-10-29 18:01:51'),
('4e769d8b044fb8d84ccaf4b98a18ffbfb3c43d573bd0a1d332a38bcf70155be68c780181d3028870', '1732cce01db571203acd9d9ca7bb58dd06a4b49b6cdc72d90b1fb08ec28b45b3d984ba54c21e4a5d', 0, '2019-12-11 17:50:16'),
('7a5359b4417c70bd1bb41d5b14bda2ad39d1873d264a1c006d800b76afacddde54e41abab9e9f3ee', '1ef852b892b38c012c7e90049a143194e952c07acabf30a7fcbef6ca84fb101247943d1b8ce200c7', 0, '2019-11-17 20:06:24'),
('7bb63bd9e4fae120fe68525fd9d644624cbec9723edfed5fac77bb361e6090fa20584f0f567d671d', 'a76ae4d5deca34ba00973d606b509e870bfedf7d7d3cc6ec1055d1c1fb88dc9075428bd9fc6af66a', 0, '2019-11-18 11:07:03'),
('829d79a75ec7bcbf5c52bb9bdd711dfa7bf0895a5fdfb43ba33e5dbf8c90cf996d534c9418041ef6', 'ecb6183fc1f6012e69f3f809142d985d705b9c3ef94186f5fcfef33b933c985713dbaf76071cd1d4', 0, '2020-05-27 23:08:56'),
('8ad3ccb85089d256d06f6c8111bd1fa057a987b00a01a3b040fcb732014c4d1c3e1726fc7a0c7656', 'beae0aff74067cd917b2497f38748b1e5981ee0ebf07bec16af2e9aa1f68804de98032eeed405e19', 0, '2019-09-27 16:47:59'),
('9069b48ae070d0a5942494db83114b875f4dd5bbd3636ebaeffcf8238389a2ffabf7f5aecf93cece', 'bbffe9f7901e414f3c98ecc048255434f6ceeed158091b1a60dbd9491fb4c773ec70b7a45836ad40', 0, '2020-04-06 03:32:06'),
('994b3f7ed24645a7444d247506d4ea906c96d2961fdd2427095bb2f0dc627a3810be2d2d2e917bda', '6385f3b2df09635f04574c47da737ad8913a0430807c46fc3646029b35f5344795eeb0a13369cbb5', 0, '2019-10-28 13:04:18'),
('b4fa3d798ce5fbcc8b3d37a279b08b0ac63111e06db79fd6b93f270700adc535a67f82447b89d778', 'dbc0a2812af8a25052bf6bf2e116fbd571e36412a00d89ce78f54ce4f146c70f3da19337184854b8', 0, '2020-05-07 17:48:42'),
('b92b51ec1db3f50f029bcd273ca0a83d7057e3a828b9ebdb40f529f2f74a10d29ae2d480c3fff913', '7ecd6069750b4f9bbc81fa2cfbd5b2a72a2a642f799d40d4874bf478f0bb0622baaf57e8e2f44c0e', 0, '2019-11-17 18:48:58'),
('cb31c5946d0430b1ffc7b07d9adc4810edd55b13db85bcc8bcf9bc3024c912a5e2bf208c3830b503', '420d932f2a226aa770afb4175bea47efaad62fbe67e02d1971830d2755820813b8737d3a25613e4c', 0, '2019-12-13 12:51:07'),
('cbeba7f407599fad9e0fd7592c282c03cf462d03f75bee07138fdd72f266358c55a17b394ab8e696', 'f08442216b8a4781b9676f1713222aea291d5636ed90f5160083d552505cf9995c839e5c7ed038d0', 0, '2020-01-30 19:43:17'),
('d2f45e8d9768322b7ab22506ef6381cad9cfd0d4acd12ae0c8f4a915056ddbf687719a9734f126d9', 'a5e7da40ac9175e45bc2bdee09df2b8188e572f383ed5b46898681c1d71f0880dfd8d4adb065dee3', 0, '2020-05-05 20:54:03'),
('f36ad6cfb83dab1c59d4542f387a10b7c6062280ba1fd60dd8bd01195a06f40a5dcaea1244952016', 'ea26d6c91b6c79aa6692c64a83c4f7dc3e8bc2f478cc8ccaa61fccbec607b5d1cf443960ce480729', 0, '2020-05-24 09:34:29');

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `time` varchar(75) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_logs`
--

CREATE TABLE `payment_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `is_wallet` int(11) NOT NULL DEFAULT 0,
  `user_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'user or provider',
  `payment_mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL COMMENT 'user id or provider id',
  `amount` double(8,2) NOT NULL DEFAULT 0.00,
  `transaction_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Random code generated during payment',
  `transaction_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Foreign key of the user request or wallet table',
  `response` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payu_payments`
--

CREATE TABLE `payu_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `account` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payable_id` int(10) UNSIGNED DEFAULT NULL,
  `payable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `txnid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mihpayid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `discount` double NOT NULL DEFAULT 0,
  `net_amount_debit` double NOT NULL DEFAULT 0,
  `data` text COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `unmappedstatus` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bank_ref_num` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bankcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cardnum` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name_on_card` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `issuing_bank` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `peak_hours`
--

CREATE TABLE `peak_hours` (
  `id` int(10) UNSIGNED NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `peak_hours`
--

INSERT INTO `peak_hours` (`id`, `start_time`, `end_time`, `created_at`, `updated_at`) VALUES
(2, '09:00:00', '23:00:00', '2019-08-22 10:03:44', '2019-11-03 10:17:38');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `group_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `guard_name`, `group_name`, `created_at`, `updated_at`) VALUES
(1, 'dashboard-menus', 'Box Menus', 'admin', 'Dashboard', NULL, NULL),
(2, 'wallet-summary', 'Wallet Summary', 'admin', 'Dashboard', NULL, NULL),
(3, 'recent-rides', 'Recent Rides', 'admin', 'Dashboard', NULL, NULL),
(4, 'dispatcher-panel', 'Dispatcher Menu', 'admin', 'Dispatcher Panel', NULL, NULL),
(5, 'dispatcher-panel-add', 'Add Rides', 'admin', 'Dispatcher Panel', NULL, NULL),
(6, 'dispute-list', 'Dispute list', 'admin', 'Dispute', NULL, NULL),
(7, 'dispute-create', 'Create Dispute', 'admin', 'Dispute', NULL, NULL),
(8, 'dispute-edit', 'Edit Dispute', 'admin', 'Dispute', NULL, NULL),
(9, 'dispute-delete', 'Delete Dispute', 'admin', 'Dispute', NULL, NULL),
(10, 'heat-map', 'Heat Map', 'admin', 'Map', NULL, NULL),
(11, 'god-eye', 'God\'s Eye', 'admin', 'Map', NULL, NULL),
(12, 'user-list', 'User list', 'admin', 'Users', NULL, NULL),
(13, 'user-history', 'User History', 'admin', 'Users', NULL, NULL),
(14, 'user-create', 'Create User', 'admin', 'Users', NULL, NULL),
(15, 'user-edit', 'Edit User', 'admin', 'Users', NULL, NULL),
(16, 'user-delete', 'Delete User', 'admin', 'Users', NULL, NULL),
(17, 'provider-list', 'Provider list', 'admin', 'Providers', NULL, NULL),
(18, 'provider-create', 'Create Provider', 'admin', 'Providers', NULL, NULL),
(19, 'provider-edit', 'Edit Provider', 'admin', 'Providers', NULL, NULL),
(20, 'provider-delete', 'Delete Provider', 'admin', 'Providers', NULL, NULL),
(21, 'provider-status', 'Provider Status', 'admin', 'Providers', NULL, NULL),
(22, 'provider-history', 'Ride History', 'admin', 'Providers', NULL, NULL),
(23, 'provider-statements', 'Statements', 'admin', 'Providers', NULL, NULL),
(24, 'provider-services', 'Provider Services', 'admin', 'Providers', NULL, NULL),
(25, 'provider-service-update', 'Provider Service Update', 'admin', 'Providers', NULL, NULL),
(26, 'provider-service-delete', 'Provider Service Delete', 'admin', 'Providers', NULL, NULL),
(27, 'provider-documents', 'Provider Documents', 'admin', 'Providers', NULL, NULL),
(28, 'provider-document-edit', 'Provider Document Edit', 'admin', 'Providers', NULL, NULL),
(29, 'provider-document-delete', 'Provider Document Delete', 'admin', 'Providers', NULL, NULL),
(30, 'dispatcher-list', 'Dispatcher list', 'admin', 'Dispatcher', NULL, NULL),
(31, 'dispatcher-create', 'Create Dispatcher', 'admin', 'Dispatcher', NULL, NULL),
(32, 'dispatcher-edit', 'Edit Dispatcher', 'admin', 'Dispatcher', NULL, NULL),
(33, 'dispatcher-delete', 'Delete Dispatcher', 'admin', 'Dispatcher', NULL, NULL),
(34, 'fleet-list', 'Fleet Owner list', 'admin', 'Fleet Owner', NULL, NULL),
(35, 'fleet-create', 'Create Fleet Owner', 'admin', 'Fleet Owner', NULL, NULL),
(36, 'fleet-edit', 'Edit Fleet Owner', 'admin', 'Fleet Owner', NULL, NULL),
(37, 'fleet-delete', 'Delete Fleet Owner', 'admin', 'Fleet Owner', NULL, NULL),
(38, 'fleet-providers', 'Fleet Owner\'s Providers list', 'admin', 'Fleet Owner', NULL, NULL),
(39, 'account-manager-list', 'Account Manager list', 'admin', 'Account Manager', NULL, NULL),
(40, 'account-manager-create', 'Create Account Manager', 'admin', 'Account Manager', NULL, NULL),
(41, 'account-manager-edit', 'Edit Account Manager', 'admin', 'Account Manager', NULL, NULL),
(42, 'account-manager-delete', 'Delete Account Manager', 'admin', 'Account Manager', NULL, NULL),
(43, 'dispute-manager-list', 'Dispute Manager list', 'admin', 'Dispute Manager', NULL, NULL),
(44, 'dispute-manager-create', 'Create Dispute Manager', 'admin', 'Dispute Manager', NULL, NULL),
(45, 'dispute-manager-edit', 'Edit Dispute Manager', 'admin', 'Dispute Manager', NULL, NULL),
(46, 'dispute-manager-delete', 'Delete Dispute Manager', 'admin', 'Dispute Manager', NULL, NULL),
(47, 'statements', 'Statements', 'admin', 'Statements', NULL, NULL),
(48, 'settlements', 'Settlements', 'admin', 'Settlements', NULL, NULL),
(49, 'ratings', 'Ratings', 'admin', 'Ratings', NULL, NULL),
(50, 'ride-history', 'Ride History', 'admin', 'Rides', NULL, NULL),
(51, 'ride-delete', 'Delete Ride', 'admin', 'Rides', NULL, NULL),
(52, 'schedule-rides', 'Schedule Rides', 'admin', 'Rides', NULL, NULL),
(53, 'promocodes-list', 'Promocodes List', 'admin', 'Promocodes', NULL, NULL),
(54, 'promocodes-create', 'Create Promocode', 'admin', 'Promocodes', NULL, NULL),
(55, 'promocodes-edit', 'Edit Promocode', 'admin', 'Promocodes', NULL, NULL),
(56, 'promocodes-delete', 'Delete Promocode', 'admin', 'Promocodes', NULL, NULL),
(57, 'service-types-list', 'Service Types List', 'admin', 'Service Types', NULL, NULL),
(58, 'service-types-create', 'Create Service Type', 'admin', 'Service Types', NULL, NULL),
(59, 'service-types-edit', 'Edit Service Type', 'admin', 'Service Types', NULL, NULL),
(60, 'service-types-delete', 'Delete Service Type', 'admin', 'Service Types', NULL, NULL),
(61, 'peak-hour-list', 'Peak Hour List', 'admin', 'Service Types', NULL, NULL),
(62, 'peak-hour-create', 'Create Peak Hour', 'admin', 'Service Types', NULL, NULL),
(63, 'peak-hour-edit', 'Edit Peak Hour', 'admin', 'Service Types', NULL, NULL),
(64, 'peak-hour-delete', 'Delete Peak Hour', 'admin', 'Service Types', NULL, NULL),
(65, 'documents-list', 'Documents List', 'admin', 'Documents', NULL, NULL),
(66, 'documents-create', 'Create Document', 'admin', 'Documents', NULL, NULL),
(67, 'documents-edit', 'Edit Document', 'admin', 'Documents', NULL, NULL),
(68, 'documents-delete', 'Delete Document', 'admin', 'Documents', NULL, NULL),
(69, 'cancel-reasons-list', 'Cancel Reason List', 'admin', 'Cancel Reasons', NULL, NULL),
(70, 'cancel-reasons-create', 'Create Reason', 'admin', 'Cancel Reasons', NULL, NULL),
(71, 'cancel-reasons-edit', 'Edit Reason', 'admin', 'Cancel Reasons', NULL, NULL),
(72, 'cancel-reasons-delete', 'Delete Reason', 'admin', 'Cancel Reasons', NULL, NULL),
(73, 'notification-list', 'Notifications List', 'admin', 'Notifications', NULL, NULL),
(74, 'notification-create', 'Create Notification', 'admin', 'Notifications', NULL, NULL),
(75, 'notification-edit', 'Edit Notification', 'admin', 'Notifications', NULL, NULL),
(76, 'notification-delete', 'Delete Notification', 'admin', 'Notifications', NULL, NULL),
(77, 'lost-item-list', 'Lost Item List', 'admin', 'Lost Items', NULL, NULL),
(78, 'lost-item-create', 'Create Lost Item', 'admin', 'Lost Items', NULL, NULL),
(79, 'lost-item-edit', 'Edit Lost Item', 'admin', 'Lost Items', NULL, NULL),
(80, 'role-list', 'Role list', 'admin', 'Role', NULL, NULL),
(81, 'role-create', 'Create Role', 'admin', 'Role', NULL, NULL),
(82, 'role-edit', 'Edit Role', 'admin', 'Role', NULL, NULL),
(83, 'role-delete', 'Delete Role', 'admin', 'Role', NULL, NULL),
(84, 'sub-admin-list', 'Sub Admins List', 'admin', 'Sub Admins', NULL, NULL),
(85, 'sub-admin-create', 'Create Sub Admin', 'admin', 'Sub Admins', NULL, NULL),
(86, 'sub-admin-edit', 'Edit Sub Admin', 'admin', 'Sub Admins', NULL, NULL),
(87, 'sub-admin-delete', 'Delete Sub Admin', 'admin', 'Sub Admins', NULL, NULL),
(88, 'payment-history', 'Payment History List', 'admin', 'Payment', NULL, NULL),
(89, 'payment-settings', 'Payment Settings List', 'admin', 'Payment', NULL, NULL),
(90, 'site-settings', 'Site Settings', 'admin', 'Settings', NULL, NULL),
(91, 'account-settings', 'Account Settings', 'admin', 'Settings', NULL, NULL),
(92, 'transalations', 'Translations', 'admin', 'Settings', NULL, NULL),
(93, 'change-password', 'Change Password', 'admin', 'Settings', NULL, NULL),
(94, 'cms-pages', 'CMS Pages', 'admin', 'Pages', NULL, NULL),
(95, 'help', 'Help', 'admin', 'Pages', NULL, NULL),
(96, 'custom-push', 'Custom Push', 'admin', 'Others', NULL, NULL),
(97, 'db-backup', 'DB Backup', 'admin', 'Others', NULL, NULL),
(98, 'poi-category-list', 'POI Category List', 'admin', 'POI Categories', NULL, NULL),
(99, 'poi-category-create', 'POI Category Create', 'admin', 'POI Categories', NULL, NULL),
(100, 'poi-category-edit', 'POI Category Edit', 'admin', 'POI Categories', NULL, NULL),
(101, 'poi-category-delete', 'POI Category Delete', 'admin', 'POI Categories', NULL, NULL),
(102, 'point-interest-list', 'Point Interest List', 'admin', 'Point Interest', NULL, NULL),
(103, 'point-interest-create', 'Point Interest Create', 'admin', 'Point Interest', NULL, NULL),
(104, 'point-interest-edit', 'Point Interest Update', 'admin', 'Point Interest', NULL, NULL),
(105, 'point-interest-delete', 'Point Interest Delete', 'admin', 'Point Interest', NULL, NULL),
(106, 'point-interest-show', 'Point Interest Show', 'admin', 'Point Interest', NULL, NULL),
(107, 'polygon-shape-list', 'Polygon Shape List', 'admin', 'Poloygon Shape', NULL, NULL),
(108, 'polygon-shape-show', 'Polygon Shape Show ', 'admin', 'Poloygon Shape', NULL, NULL),
(109, 'polygon-shape-update', 'Polygon Shape Update', 'admin', 'Poloygon Shape', NULL, NULL),
(110, 'polygon-shape-delete', 'Polygon Shape Delete', 'admin', 'Poloygon Shape', NULL, NULL),
(111, 'driving-zone-list', 'Driving Zone List', 'admin', 'Driving Zone', NULL, NULL),
(112, 'driving-zone-create', 'Driving Zone Create', 'admin', 'Driving Zone', NULL, NULL),
(113, 'driving-zone-update', 'Driving Zone Update', 'admin', 'Driving Zone', NULL, NULL),
(114, 'driving-zone-show', 'Driving Zone Show', 'admin', 'Driving Zone', NULL, NULL),
(115, 'driving-zone-delete', 'Driving Zone Delete', 'admin', 'Driving Zone', NULL, NULL),
(117, 'advertisement-list', 'Advertisement List', 'admin', 'Advertisement', NULL, NULL),
(118, 'advertisement-create', 'Advertisement Create', 'admin', 'Advertisement', NULL, NULL),
(119, 'advertisement-edit', 'Advertisement Update', 'admin', 'Advertisement', NULL, NULL),
(120, 'advertisement-delete', 'Advertisement Delete', 'admin', 'Advertisement', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(11) NOT NULL,
  `pickId` int(11) NOT NULL,
  `dropId` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `point_interests`
--

CREATE TABLE `point_interests` (
  `id` int(10) UNSIGNED NOT NULL,
  `rule_name` varchar(250) DEFAULT NULL,
  `start_coordinate` text DEFAULT NULL,
  `start_mapdata` text DEFAULT NULL,
  `start_poicategory_id` int(11) DEFAULT NULL,
  `dest_coordinate` text DEFAULT NULL,
  `dest_mapdata` text DEFAULT NULL,
  `dest_poicategory_id` int(11) DEFAULT NULL,
  `ignore_surge_price` tinyint(4) DEFAULT NULL,
  `price` double(8,2) DEFAULT NULL,
  `service_type_id` varchar(11) DEFAULT NULL,
  `direction_state` tinyint(1) DEFAULT NULL COMMENT '1:one diretion, 2 two direction',
  `status` tinyint(4) DEFAULT NULL COMMENT '1:active,0:deactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `start_mapdata_origin` text DEFAULT NULL,
  `dest_mapdata_origin` text DEFAULT NULL,
  `start_mapdata_latlng` text DEFAULT NULL,
  `dest_mapdata_latlng` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `poi_categories`
--

CREATE TABLE `poi_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '1:active, 0: inactive',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `poi_categories`
--

INSERT INTO `poi_categories` (`id`, `type`, `image`, `status`, `created_at`, `updated_at`) VALUES
(3, 'city', 'user/poi/UgE0kJGxkOgLHU9nm9ArfM9WU82aCoivIhFUsMi5.png', 1, '2019-08-19 16:05:56', '2019-08-19 16:05:56'),
(4, 'Airport', 'user/poi/IouJicqz7DhRnqKHASUCXL1KFSyl6pVIN19tdjtw.png', 1, '2019-08-24 15:50:30', '2019-08-24 15:50:30'),
(5, 'Gare', NULL, 1, '2019-08-27 04:21:28', '2019-08-27 04:21:28');

-- --------------------------------------------------------

--
-- Table structure for table `polygon_shapes`
--

CREATE TABLE `polygon_shapes` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `coordinate` text DEFAULT NULL,
  `shape` text DEFAULT NULL,
  `shape_origin` text DEFAULT NULL,
  `poi_category_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `promocodes`
--

CREATE TABLE `promocodes` (
  `id` int(10) UNSIGNED NOT NULL,
  `promo_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `percentage` double(5,2) NOT NULL DEFAULT 0.00,
  `max_amount` double(10,2) NOT NULL DEFAULT 0.00,
  `promo_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expiration` datetime NOT NULL,
  `status` enum('ADDED','EXPIRED') COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promocode_passbooks`
--

CREATE TABLE `promocode_passbooks` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `promocode_id` int(11) NOT NULL,
  `status` enum('ADDED','USED','EXPIRED') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promocode_usages`
--

CREATE TABLE `promocode_usages` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `promocode_id` int(11) NOT NULL,
  `status` enum('ADDED','USED','EXPIRED') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `providers`
--

CREATE TABLE `providers` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gender` enum('MALE','FEMALE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'MALE',
  `country_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rating` decimal(4,2) NOT NULL DEFAULT 5.00,
  `status` enum('document','card','onboarding','approved','banned','balance') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'document',
  `fleet` int(11) NOT NULL DEFAULT 0,
  `latitude` double(15,8) DEFAULT NULL,
  `longitude` double(15,8) DEFAULT NULL,
  `stripe_acc_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stripe_cust_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `paypal_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `login_by` enum('manual','facebook','google') COLLATE utf8_unicode_ci NOT NULL,
  `social_unique_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `otp` mediumint(9) NOT NULL DEFAULT 0,
  `wallet_balance` double(10,2) NOT NULL DEFAULT 0.00,
  `referral_unique_id` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrcode_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `providers`
--

INSERT INTO `providers` (`id`, `first_name`, `last_name`, `email`, `gender`, `country_code`, `mobile`, `password`, `avatar`, `rating`, `status`, `fleet`, `latitude`, `longitude`, `stripe_acc_id`, `stripe_cust_id`, `paypal_email`, `login_by`, `social_unique_id`, `otp`, `wallet_balance`, `referral_unique_id`, `qrcode_url`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'driver', 'test', 'test@driver.com', 'MALE', '+33', '629957457', '$2y$10$tAAunJ3yVeRSFVNK4dnUXuHt5UHlZbQvP6vXrdNP3cKtWSe96Y9bW', 'provider/profile/VW1ar22GRsdV4auDsop3C0wwhms1CVogCJBMyRFG.jpeg', '3.61', 'approved', 0, 40.13743700, 124.39420300, NULL, 'cus_GU5DpGrde5Dm3R', NULL, 'manual', NULL, 0, 0.00, '322A32', 'uploads/1578121062683993683_629957457.png', NULL, '2020-01-04 06:57:42', '2020-02-27 00:32:35');

-- --------------------------------------------------------

--
-- Table structure for table `provider_cards`
--

CREATE TABLE `provider_cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `last_four` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `brand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_default` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `provider_cards`
--

INSERT INTO `provider_cards` (`id`, `user_id`, `last_four`, `card_id`, `brand`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 132, '4242', 'card_1Fx72eIVc7Qx3uu7obetOShf', 'Visa', 1, '2020-01-04 07:27:27', '2020-01-04 07:27:44');

-- --------------------------------------------------------

--
-- Table structure for table `provider_devices`
--

CREATE TABLE `provider_devices` (
  `id` int(10) UNSIGNED NOT NULL,
  `provider_id` int(11) NOT NULL,
  `udid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sns_arn` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('android','ios') COLLATE utf8_unicode_ci NOT NULL,
  `jwt_token` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `provider_devices`
--

INSERT INTO `provider_devices` (`id`, `provider_id`, `udid`, `token`, `sns_arn`, `type`, `jwt_token`, `created_at`, `updated_at`) VALUES
(1, 1, '34qwersafasdreq', 'asdfasdfasdf', NULL, 'ios', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly8xOTIuMTY4LjAuMTA5OjgwMDAvYXBpL3Byb3ZpZGVyL29hdXRoL3Rva2VuIiwiaWF0IjoxNTg2MzQ0ODU5LCJleHAiOjE1ODY3MDQ4NTksIm5iZiI6MTU4NjM0NDg1OSwianRpIjoiYjU5eklWOWdTcVFCRVlndiJ9.d250GYcERYR7yyQLEyO-2F2R18Yxh15nwanLLDbSE_s', '2020-01-04 06:57:42', '2020-04-08 05:20:59');

-- --------------------------------------------------------

--
-- Table structure for table `provider_documents`
--

CREATE TABLE `provider_documents` (
  `id` int(10) UNSIGNED NOT NULL,
  `provider_id` int(11) NOT NULL,
  `document_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `unique_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('ASSESSING','ACTIVE') COLLATE utf8_unicode_ci NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `provider_profiles`
--

CREATE TABLE `provider_profiles` (
  `id` int(10) UNSIGNED NOT NULL,
  `provider_id` int(11) NOT NULL,
  `language` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address_secondary` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `provider_profiles`
--

INSERT INTO `provider_profiles` (`id`, `provider_id`, `language`, `address`, `address_secondary`, `city`, `country`, `postal_code`, `created_at`, `updated_at`) VALUES
(1, 1, 'en', NULL, NULL, NULL, NULL, NULL, '2019-02-27 06:54:44', '2020-02-27 00:33:49');

-- --------------------------------------------------------

--
-- Table structure for table `provider_services`
--

CREATE TABLE `provider_services` (
  `id` int(10) UNSIGNED NOT NULL,
  `provider_id` int(11) NOT NULL,
  `service_type_id` int(11) NOT NULL,
  `status` enum('active','offline','riding','hold','balance') COLLATE utf8_unicode_ci NOT NULL,
  `service_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `service_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `provider_services`
--

INSERT INTO `provider_services` (`id`, `provider_id`, `service_type_id`, `status`, `service_number`, `service_model`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'active', '4ppo3ts', 'Audi R8', '2019-02-26 22:46:26', '2020-02-27 00:32:38');

-- --------------------------------------------------------

--
-- Table structure for table `provider_wallet`
--

CREATE TABLE `provider_wallet` (
  `id` int(10) UNSIGNED NOT NULL,
  `provider_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `transaction_alias` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('C','D') COLLATE utf8_unicode_ci NOT NULL,
  `amount` double(15,8) NOT NULL DEFAULT 0.00000000,
  `open_balance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `close_balance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `payment_mode` enum('BRAINTREE','CARD','PAYPAL','PAYUMONEY','PAYTM') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `push_subscriptions`
--

CREATE TABLE `push_subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `guard` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin_id` int(10) UNSIGNED DEFAULT NULL,
  `endpoint` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `public_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auth_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reasons`
--

CREATE TABLE `reasons` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` enum('USER','PROVIDER') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USER',
  `reason` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `reasons`
--

INSERT INTO `reasons` (`id`, `type`, `reason`, `status`, `created_at`, `updated_at`) VALUES
(1, 'PROVIDER', 'Take long time to reach pickup point', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(2, '', 'Heavy Traffic', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(3, '', 'User choose wrong location', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(4, '', 'My reason not listed', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(5, '', 'User Unavailable', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(6, '', 'My reason not listed', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(7, '', 'Unable to contact driver', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(8, '', 'Expected a shoter wait time', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(9, '', 'Driver denied to come and pikcup', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(10, '', 'Driver denied to go to destination', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26'),
(11, '', 'Driver Charged Extra', 0, '2019-02-26 22:46:26', '2019-02-26 22:46:26');

-- --------------------------------------------------------

--
-- Table structure for table `referral_earnings`
--

CREATE TABLE `referral_earnings` (
  `id` int(10) UNSIGNED NOT NULL,
  `referrer_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1-user,2-provider',
  `amount` double(10,2) NOT NULL DEFAULT 0.00,
  `count` mediumint(9) NOT NULL DEFAULT 0,
  `referral_histroy_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `referral_histroy`
--

CREATE TABLE `referral_histroy` (
  `id` int(10) UNSIGNED NOT NULL,
  `referrer_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1-user,2-provider',
  `referral_id` int(11) NOT NULL,
  `referral_data` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('P','C') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'C',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_filters`
--

CREATE TABLE `request_filters` (
  `id` int(10) UNSIGNED NOT NULL,
  `request_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_waiting_time`
--

CREATE TABLE `request_waiting_time` (
  `id` int(10) UNSIGNED NOT NULL,
  `request_id` int(11) NOT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `ended_at` timestamp NULL DEFAULT NULL,
  `waiting_mins` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `request_waiting_time`
--

INSERT INTO `request_waiting_time` (`id`, `request_id`, `started_at`, `ended_at`, `waiting_mins`, `created_at`, `updated_at`) VALUES
(1, 94, '2019-12-20 13:53:29', '2019-12-20 13:53:30', 1, '2019-12-20 13:53:29', '2019-12-20 13:53:30'),
(2, 101, '2019-12-21 10:31:44', '2019-12-21 10:31:50', 6, '2019-12-21 10:31:44', '2019-12-21 10:31:50'),
(3, 101, '2019-12-21 10:31:54', NULL, 0, '2019-12-21 10:31:54', '2019-12-21 10:31:54'),
(4, 110, '2019-12-21 11:22:24', '2019-12-21 11:22:25', 1, '2019-12-21 11:22:24', '2019-12-21 11:22:25'),
(5, 111, '2019-12-21 11:25:17', NULL, 0, '2019-12-21 11:25:17', '2019-12-21 11:25:17'),
(6, 118, '2019-12-21 12:52:02', NULL, 0, '2019-12-21 12:52:02', '2019-12-21 12:52:02'),
(7, 4, '2019-12-27 04:40:03', '2019-12-27 04:40:10', 7, '2019-12-27 04:40:03', '2019-12-27 04:40:10'),
(8, 4, '2019-12-27 04:40:12', NULL, 0, '2019-12-27 04:40:12', '2019-12-27 04:40:12'),
(9, 15, '2020-01-05 09:13:48', '2020-01-05 09:13:48', 0, '2020-01-05 09:13:48', '2020-01-05 09:13:48'),
(10, 46, '2020-01-06 08:23:38', '2020-01-06 08:23:42', 4, '2020-01-06 08:23:38', '2020-01-06 08:23:42'),
(11, 94, '2020-01-07 16:42:18', '2020-01-07 16:42:21', 3, '2020-01-07 16:42:18', '2020-01-07 16:42:21'),
(12, 158, '2020-01-09 05:10:07', '2020-01-09 05:10:14', 7, '2020-01-09 05:10:07', '2020-01-09 05:10:14'),
(13, 158, '2020-01-09 05:10:28', '2020-01-09 05:10:33', 5, '2020-01-09 05:10:28', '2020-01-09 05:10:33'),
(14, 188, '2020-01-09 13:43:23', '2020-01-09 13:43:27', 4, '2020-01-09 13:43:23', '2020-01-09 13:43:27'),
(15, 211, '2020-01-10 10:25:51', '2020-01-10 10:25:55', 4, '2020-01-10 10:25:51', '2020-01-10 10:25:55');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'ADMIN', 'admin', NULL, NULL),
(2, 'DISPATCHER', 'admin', NULL, NULL),
(3, 'DISPUTE', 'admin', NULL, NULL),
(4, 'ACCOUNT', 'admin', NULL, NULL),
(5, 'FLEET', 'fleet', NULL, NULL),
(6, 'Song', 'admin', '2019-10-25 08:15:29', '2019-10-25 08:15:29');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 4),
(1, 5),
(2, 1),
(2, 4),
(2, 5),
(3, 1),
(3, 4),
(3, 5),
(4, 1),
(4, 2),
(4, 5),
(5, 1),
(5, 2),
(5, 5),
(6, 1),
(6, 3),
(6, 5),
(7, 1),
(7, 3),
(7, 5),
(8, 1),
(8, 3),
(8, 5),
(9, 1),
(9, 3),
(9, 5),
(10, 1),
(10, 5),
(10, 6),
(11, 1),
(11, 5),
(11, 6),
(12, 1),
(12, 5),
(13, 1),
(13, 5),
(14, 1),
(14, 5),
(15, 1),
(15, 5),
(16, 1),
(16, 5),
(17, 1),
(17, 5),
(18, 1),
(18, 5),
(19, 1),
(19, 5),
(20, 1),
(20, 5),
(21, 1),
(21, 5),
(22, 1),
(22, 5),
(23, 1),
(23, 5),
(24, 1),
(24, 5),
(25, 1),
(25, 5),
(26, 1),
(26, 5),
(27, 1),
(27, 5),
(28, 1),
(28, 5),
(29, 1),
(29, 5),
(30, 1),
(30, 5),
(31, 1),
(31, 5),
(32, 1),
(32, 5),
(33, 1),
(33, 5),
(34, 1),
(34, 5),
(35, 1),
(35, 5),
(36, 1),
(36, 5),
(37, 1),
(37, 5),
(38, 1),
(38, 5),
(39, 1),
(39, 5),
(40, 1),
(40, 5),
(41, 1),
(41, 5),
(42, 1),
(42, 5),
(43, 1),
(43, 5),
(44, 1),
(44, 5),
(45, 1),
(45, 5),
(46, 1),
(46, 5),
(47, 1),
(47, 4),
(47, 5),
(48, 1),
(48, 5),
(49, 1),
(49, 5),
(50, 1),
(50, 5),
(51, 1),
(51, 5),
(52, 1),
(52, 5),
(53, 1),
(53, 5),
(54, 1),
(54, 5),
(55, 1),
(55, 5),
(56, 1),
(56, 5),
(57, 1),
(57, 5),
(58, 1),
(58, 5),
(59, 1),
(59, 5),
(60, 1),
(60, 5),
(61, 1),
(61, 5),
(62, 1),
(62, 5),
(63, 1),
(63, 5),
(64, 1),
(64, 5),
(65, 1),
(65, 5),
(66, 1),
(66, 5),
(67, 1),
(67, 5),
(68, 1),
(68, 5),
(69, 1),
(69, 5),
(70, 1),
(70, 5),
(71, 1),
(71, 5),
(72, 1),
(72, 5),
(73, 1),
(73, 5),
(74, 1),
(74, 5),
(75, 1),
(75, 5),
(76, 1),
(76, 5),
(77, 1),
(77, 5),
(78, 1),
(78, 5),
(79, 1),
(79, 5),
(80, 1),
(80, 5),
(81, 1),
(81, 5),
(82, 1),
(82, 5),
(83, 1),
(83, 5),
(84, 1),
(84, 5),
(85, 1),
(85, 5),
(86, 1),
(86, 5),
(87, 1),
(87, 5),
(88, 1),
(88, 5),
(89, 1),
(89, 5),
(90, 1),
(90, 5),
(91, 1),
(91, 2),
(91, 3),
(91, 4),
(91, 5),
(92, 1),
(92, 5),
(93, 1),
(93, 2),
(93, 3),
(93, 4),
(93, 5),
(94, 1),
(94, 5),
(95, 1),
(95, 5),
(96, 1),
(96, 5),
(97, 1),
(97, 5),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(111, 1),
(112, 1),
(113, 1),
(114, 1),
(115, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1);

-- --------------------------------------------------------

--
-- Table structure for table `service_peak_hours`
--

CREATE TABLE `service_peak_hours` (
  `id` int(10) UNSIGNED NOT NULL,
  `service_type_id` int(11) NOT NULL,
  `peak_hours_id` int(11) NOT NULL,
  `min_price` double(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_types`
--

CREATE TABLE `service_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `provider_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marker` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT 0,
  `luggage_capacity` int(11) NOT NULL,
  `fixed` double NOT NULL,
  `price` double NOT NULL,
  `minute` double NOT NULL,
  `hour` double DEFAULT NULL,
  `distance` double NOT NULL,
  `calculator` enum('MIN','HOUR','DISTANCE','DISTANCEMIN','DISTANCEHOUR') COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `waiting_free_mins` int(11) NOT NULL DEFAULT 0,
  `waiting_min_charge` double(10,2) NOT NULL DEFAULT 0.00,
  `status` int(11) NOT NULL DEFAULT 0,
  `fleet_id` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `service_types`
--

INSERT INTO `service_types` (`id`, `name`, `provider_name`, `image`, `marker`, `capacity`, `luggage_capacity`, `fixed`, `price`, `minute`, `hour`, `distance`, `calculator`, `description`, `waiting_free_mins`, `waiting_min_charge`, `status`, `fleet_id`, `created_at`, `updated_at`) VALUES
(1, 'Standard', 'Driver', 'https://memohi.fr/asset/img/cars/sedan.png', 'https://memohi.fr/asset/img/cars/sedan_marker.png', 4, 3, 10, 2, 0, 0, 5, 'DISTANCE', NULL, 15, 0.30, 1, 0, '2019-02-26 22:46:06', '2020-02-23 19:19:55'),
(2, 'Premium', 'Driver', 'https://onlyvtc.com/uploads/8e3bd63208f900430351049c20b991c2aa9bc72b.png', 'https://memohi.fr/asset/img/cars/hatchback_marker.png', 4, 3, 20, 2.5, 0, 0, 5, 'DISTANCE', NULL, 0, 0.00, 1, 0, '2019-02-26 22:46:06', '2020-02-23 18:42:50'),
(3, 'Van', 'Driver', 'https://onlyvtc.com/uploads/0e7c16239c6242d291547519c989ed9daf06b206.png', 'https://memohi.fr/asset/img/cars/suv_marker.png', 7, 7, 20, 2.5, 0, 0, 5, 'DISTANCE', NULL, 15, 0.30, 1, 0, '2019-02-26 22:46:06', '2020-02-24 08:48:14');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`) VALUES
(0, 'demo_mode', '0'),
(2, 'help', '<p>Help page</p>'),
(3, 'page_privacy', '<p>Privacy Policy</p>'),
(4, 'terms', '<p>Terms and Conditions</p>'),
(5, 'cancel', '<p>Cancelation Policy</p>');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `company_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payment_mode` enum('BRAINTREE','CASH','CARD','PAYPAL','PAYPAL-ADAPTIVE','PAYUMONEY','PAYTM') COLLATE utf8_unicode_ci NOT NULL,
  `user_type` enum('INSTANT','NORMAL','COMPANY','PASSANGER','FLEET_NORMAL','FLEET_COMPANY','FLEET_PASSENGER') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gender` enum('MALE','FEMALE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'MALE',
  `country_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company_address` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `company_zip_code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `company_city` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `reg_number` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `device_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_type` enum('android','ios') COLLATE utf8_unicode_ci NOT NULL,
  `login_by` enum('manual','facebook','google') COLLATE utf8_unicode_ci NOT NULL,
  `social_unique_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` double(15,8) DEFAULT NULL,
  `longitude` double(15,8) DEFAULT NULL,
  `stripe_cust_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wallet_balance` double(8,2) NOT NULL DEFAULT 0.00,
  `allow_negative` tinyint(4) NOT NULL DEFAULT 0,
  `wallet_limit` double(15,8) NOT NULL DEFAULT 0.00000000,
  `rating` decimal(4,2) NOT NULL DEFAULT 5.00,
  `otp` mediumint(9) NOT NULL DEFAULT 0,
  `language` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qrcode_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referral_unique_id` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referal_count` mediumint(9) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` int(10) NOT NULL,
  `fleet_company_id` int(10) NOT NULL,
  `fleet_id` int(10) NOT NULL,
  `country` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `company_name`, `payment_mode`, `user_type`, `email`, `gender`, `country_code`, `mobile`, `password`, `picture`, `company_address`, `company_zip_code`, `company_city`, `reg_number`, `device_token`, `device_id`, `device_type`, `login_by`, `social_unique_id`, `latitude`, `longitude`, `stripe_cust_id`, `wallet_balance`, `allow_negative`, `wallet_limit`, `rating`, `otp`, `language`, `qrcode_url`, `referral_unique_id`, `referal_count`, `remember_token`, `created_at`, `updated_at`, `company_id`, `fleet_company_id`, `fleet_id`, `country`) VALUES
(1, 'Test', 'User', '', 'CASH', 'NORMAL', 'test@user.com', 'MALE', '+33', '2025555012', '$2y$10$O5FOWZFHQTmUdurZhN8Uku1t6M.Kxr1BQlM5axvBuCLuRVs3RvnhK', 'user/profile/1579544259559913295.png', '', '', '', '', 'c732409e4597eba02688ec7b115430d083af1166c9fb0516d52622de0caecb74', '5C033AE2-1BA2-497E-A2BF-8427640DB808', 'ios', 'manual', NULL, 0.00000000, 0.00000000, 'cus_FWB2YdNmtqVezf', 0.00, 0, 10.00000000, '5.00', 807070, 'en', 'uploads/1571836436877476614_85284972541.png', NULL, 0, 'lPLRF5k4VHoaYWNlGo5Wc3aF3jc4iY2ASiZXMvlSanEQ2XGdf8Jev3RDUww6', '2019-02-26 22:46:06', '2020-02-27 15:08:57', 0, 0, 0, ''),
(1177, 'Test1', 'Test', '', 'CASH', 'NORMAL', 'scarface123k@hotmail.com', 'MALE', '+33', '667258426', '$2y$10$mbNvwh6NzQkTOG5Y64EFR..NmsdV0FhLas3TW14B0XnXoytEb2TJC', NULL, '', '', '', '', 'cj8u6jv8ixo:APA91bE1DrofnOySj71txcB5lLEr4rJ8j3CVC7uGA0lsNq8tHo_s-R0jN_lZs2c1ccQmRKI9YJvx08Xry90e4fVGgtMok0_Dsd21Q95pWIPElDiM87jrwGQ1tH1Qs7Wr_bPjC6MAEqr2', 'c9fd82901961c3c8', 'android', 'manual', NULL, NULL, NULL, NULL, 0.00, 0, 0.00000000, '5.00', 0, NULL, 'uploads/15824946351588140194_667258426.png', '89B6CC', 0, NULL, '2020-02-23 21:50:35', '2020-02-24 08:34:29', 0, 0, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `user_requests`
--

CREATE TABLE `user_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `booking_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `braintree_nonce` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_id` int(11) NOT NULL DEFAULT 0,
  `current_provider_id` int(11) NOT NULL,
  `fleet_id` int(11) DEFAULT NULL,
  `user_req_recurrent_id` int(11) NOT NULL DEFAULT 0,
  `manual_assigned_at` datetime DEFAULT NULL,
  `timeout` int(11) NOT NULL DEFAULT 0,
  `service_type_id` int(11) NOT NULL,
  `promocode_id` int(11) NOT NULL,
  `rental_hours` int(11) DEFAULT NULL,
  `note` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('SEARCHING','CANCELLED','ACCEPTED','STARTED','ARRIVED','PICKEDUP','DROPPED','COMPLETED','SCHEDULED','MIDSTOPPED') COLLATE utf8_unicode_ci NOT NULL,
  `cancelled_by` enum('NONE','USER','PROVIDER') COLLATE utf8_unicode_ci NOT NULL,
  `cancel_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_mode` enum('BRAINTREE','CASH','CARD','PAYPAL','PAYPAL-ADAPTIVE','PAYUMONEY','PAYTM','WALLET') COLLATE utf8_unicode_ci NOT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `is_track` enum('YES','NO') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NO',
  `distance` double(15,8) NOT NULL,
  `travel_time` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `unit` enum('Kms','Miles') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Kms',
  `otp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `s_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `s_latitude` double(15,8) NOT NULL,
  `s_longitude` double(15,8) NOT NULL,
  `d_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `d_latitude` double(15,8) DEFAULT NULL,
  `d_longitude` double(15,8) DEFAULT NULL,
  `track_distance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `track_latitude` double(15,8) NOT NULL DEFAULT 0.00000000,
  `track_longitude` double(15,8) NOT NULL DEFAULT 0.00000000,
  `destination_log` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `way_points` longtext COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_drop_location` tinyint(1) NOT NULL DEFAULT 1,
  `is_instant_ride` tinyint(1) NOT NULL DEFAULT 0,
  `is_dispute` tinyint(1) NOT NULL DEFAULT 0,
  `assigned_at` timestamp NULL DEFAULT NULL,
  `schedule_at` timestamp NULL DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `finished_at` timestamp NULL DEFAULT NULL,
  `is_scheduled` enum('YES','NO') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'NO',
  `user_rated` tinyint(1) NOT NULL DEFAULT 0,
  `provider_rated` tinyint(1) NOT NULL DEFAULT 0,
  `use_wallet` tinyint(1) NOT NULL DEFAULT 0,
  `surge` tinyint(1) NOT NULL DEFAULT 0,
  `route_key` longtext COLLATE utf8_unicode_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `traveller_type` enum('TRAVELLER','PASSENGER') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TRAVELLER',
  `passenger_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passenger_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_id` int(11) DEFAULT NULL,
  `promo_price` double DEFAULT 0,
  `total_price` double DEFAULT 0,
  `created_role` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `calculate_state` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `surge_price` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_requests`
--

INSERT INTO `user_requests` (`id`, `booking_id`, `user_id`, `braintree_nonce`, `provider_id`, `current_provider_id`, `fleet_id`, `user_req_recurrent_id`, `manual_assigned_at`, `timeout`, `service_type_id`, `promocode_id`, `rental_hours`, `note`, `status`, `cancelled_by`, `cancel_reason`, `payment_mode`, `paid`, `is_track`, `distance`, `travel_time`, `unit`, `otp`, `s_address`, `s_latitude`, `s_longitude`, `d_address`, `d_latitude`, `d_longitude`, `track_distance`, `track_latitude`, `track_longitude`, `destination_log`, `way_points`, `is_drop_location`, `is_instant_ride`, `is_dispute`, `assigned_at`, `schedule_at`, `started_at`, `finished_at`, `is_scheduled`, `user_rated`, `provider_rated`, `use_wallet`, `surge`, `route_key`, `nonce`, `traveller_type`, `passenger_name`, `passenger_phone`, `comment`, `deleted_at`, `created_at`, `updated_at`, `created_by`, `created_id`, `promo_price`, `total_price`, `created_role`, `calculate_state`, `surge_price`) VALUES
(313, 'TRNX777007', 1, NULL, 0, 0, 0, 0, NULL, 0, 2, 0, NULL, '', 'SCHEDULED', 'NONE', NULL, 'CASH', 0, 'YES', 19.30000000, NULL, 'Kms', '6191', '4 Xinliu St, Yuanbao Qu, Dandong Shi, Liaoning Sheng, China', 40.13652000, 124.39575700, 'China, Liaoning Sheng, Dandong Shi, Zhenxing Qu, Wanxing Rd, 银河大街100', 40.00078700, 124.35445000, 0.00000000, 0.00000000, 0.00000000, '[{\"latitude\":\"40.000787\",\"longitude\":\"124.35445\",\"address\":\"China, Liaoning Sheng, Dandong Shi, Zhenxing Qu, Wanxing Rd, \\u94f6\\u6cb3\\u5927\\u8857100\"}]', NULL, 1, 0, 0, '2020-02-27 08:28:38', '2020-02-27 15:27:00', NULL, NULL, 'YES', 0, 0, 0, 0, 'cc~sFy~fvV`AkA^e@hAvA~B|C`AjAxCzDjHlJfLbOdNnQbFnGzCzDt@z@dBxA|IdHrAdArAxAbJpLhNlQlLlO~IdLpIzKbErFpBtCzGfI~BxCrAlAxT|Rh@n@Tn@BzAHl@NVLLRHT?bAQb@WRYLw@Aw@G]Qm@@_@BY\\y@nBqE|CaHbA_CJKh@iAzBcFdB_Eh@mAn@uAfA`AtH|GtF~EjDzC|ChCrErD`DhC~BxBzCnCv@x@|HzIbBzBbBnCvM~Tp@bAjFbH|DfFv@`AhCjCtHpGtFzEp@d@t@d@`Br@pBn@tSdFnJbCjBv@nAv@lSxN`GdExBlAxRlJhFhC|IbElDhAzJnBtDb@pCJ`FBtPCxAGhDa@zF_AbCm@zCgA|BoArAaArF{EzHcHpAwAfBgCrAiCbAkC|@cDjBoInBaJb@gDr@uHLyA?w@jDu]VmCl@uEx@uDfAiD`AuBzE{IT?bOcF|@SzUmBhQ{AzPwAtMgA~OoAvR_B~E_@lAEj@?xCJpC^lCr@dG~BxHzCjOfGtB`AlK~GxB|AhKvGlBz@hFfBt@VtDtAkBlEFtBHTRR', NULL, 'TRAVELLER', NULL, NULL, NULL, NULL, '2020-02-27 08:28:38', '2020-02-27 13:59:45', 'Test User', 1, 0, 39, '', 'distance', 0),
(314, 'TRNX966535', 1, NULL, 0, 1, 0, 0, NULL, 0, 1, 0, NULL, '', 'SCHEDULED', 'NONE', NULL, 'CASH', 0, 'YES', 4.70000000, NULL, 'Kms', '2500', '4 Xinliu St, Yuanbao Qu, Dandong Shi, Liaoning Sheng, China', 40.13652000, 124.39575700, 'China, Liaoning Sheng, Dandong Shi, Zhenxing Qu, Jinshan St, 锦山大街', 40.10519300, 124.36026310, 0.00000000, 0.00000000, 0.00000000, '[{\"latitude\":\"40.10519300000001\",\"longitude\":\"124.3602631\",\"address\":\"China, Liaoning Sheng, Dandong Shi, Zhenxing Qu, Jinshan St, \\u9526\\u5c71\\u5927\\u8857\"}]', NULL, 1, 0, 0, '2020-02-27 10:06:09', '2021-01-31 17:05:00', NULL, NULL, 'YES', 0, 0, 0, 0, 'cc~sFy~fvV`AkA^e@hAvA~B|C`AjAxCzDjHlJfLbOdNnQbFnGzCzDt@z@dBxA|IdHrAdArAxAbJpLhNlQlLlO~IdLpIzKbErFpBtCzGfI~BxCrAlAxT|Rh@n@FL', NULL, 'TRAVELLER', NULL, NULL, NULL, NULL, '2020-02-27 10:06:09', '2020-02-27 14:02:26', 'Test User', 1, 0, 80, '', 'distance', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_request_disputes`
--

CREATE TABLE `user_request_disputes` (
  `id` int(10) UNSIGNED NOT NULL,
  `request_id` int(11) NOT NULL,
  `dispute_type` enum('user','provider') COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `dispute_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dispute_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `refund_amount` double(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('open','closed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open',
  `is_admin` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_request_lost_items`
--

CREATE TABLE `user_request_lost_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `request_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `lost_item_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comments` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comments_by` enum('user','admin') COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('open','closed') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'open',
  `is_admin` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_request_payments`
--

CREATE TABLE `user_request_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `request_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `fleet_id` int(11) DEFAULT NULL,
  `promocode_id` int(11) DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_mode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fixed` double(10,2) NOT NULL DEFAULT 0.00,
  `distance` double(10,2) NOT NULL DEFAULT 0.00,
  `minute` double(10,2) NOT NULL DEFAULT 0.00,
  `hour` double(10,2) NOT NULL DEFAULT 0.00,
  `commision` double(10,2) NOT NULL DEFAULT 0.00,
  `commision_per` double(5,2) NOT NULL DEFAULT 0.00,
  `fleet` double(10,2) NOT NULL DEFAULT 0.00,
  `fleet_per` double(5,2) NOT NULL DEFAULT 0.00,
  `discount` double(10,2) NOT NULL DEFAULT 0.00,
  `discount_per` double(5,2) NOT NULL DEFAULT 0.00,
  `tax` double(10,2) NOT NULL DEFAULT 0.00,
  `tax_per` double(5,2) NOT NULL DEFAULT 0.00,
  `wallet` double(10,2) NOT NULL DEFAULT 0.00,
  `is_partial` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-No,1-Yes',
  `cash` double(10,2) NOT NULL DEFAULT 0.00,
  `card` double(10,2) NOT NULL DEFAULT 0.00,
  `online` double(10,2) NOT NULL DEFAULT 0.00,
  `surge` double(10,2) NOT NULL DEFAULT 0.00,
  `toll_charge` double(10,2) NOT NULL DEFAULT 0.00,
  `round_of` double(10,2) NOT NULL DEFAULT 0.00,
  `peak_amount` double(10,2) NOT NULL DEFAULT 0.00,
  `peak_comm_amount` double(10,2) NOT NULL DEFAULT 0.00,
  `total_waiting_time` int(11) NOT NULL DEFAULT 0,
  `waiting_amount` double(10,2) NOT NULL DEFAULT 0.00,
  `waiting_comm_amount` double(10,2) NOT NULL DEFAULT 0.00,
  `tips` double(10,2) NOT NULL DEFAULT 0.00,
  `total` double(10,2) NOT NULL DEFAULT 0.00,
  `payable` double(8,2) NOT NULL DEFAULT 0.00,
  `provider_commission` double(8,2) NOT NULL DEFAULT 0.00,
  `provider_pay` double(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_request_ratings`
--

CREATE TABLE `user_request_ratings` (
  `id` int(10) UNSIGNED NOT NULL,
  `request_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `user_rating` int(11) NOT NULL DEFAULT 0,
  `provider_rating` int(11) NOT NULL DEFAULT 0,
  `user_comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider_comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_request_recurrents`
--

CREATE TABLE `user_request_recurrents` (
  `id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `user_request_id` int(11) NOT NULL,
  `schedule_at` timestamp NULL DEFAULT NULL,
  `repeated` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_wallet`
--

CREATE TABLE `user_wallet` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `wallet_request_id` int(11) NOT NULL,
  `transaction_alias` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `transaction_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('C','D','CHEQUE','WIREBANK') COLLATE utf8_unicode_ci NOT NULL,
  `amount` double(15,8) NOT NULL DEFAULT 0.00000000,
  `open_balance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `close_balance` double(15,8) NOT NULL DEFAULT 0.00000000,
  `payment_mode` enum('BRAINTREE','CARD','PAYPAL','PAYUMONEY','PAYTM') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_wallet_requests`
--

CREATE TABLE `user_wallet_requests` (
  `id` int(10) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alias_id` varchar(255) NOT NULL,
  `amount` double(15,8) NOT NULL,
  `status` enum('Pending','Accepted','Refused') NOT NULL DEFAULT 'Pending',
  `type` enum('CHEQUE','WIREBANK') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `wallet_passbooks`
--

CREATE TABLE `wallet_passbooks` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `status` enum('CREDITED','DEBITED') COLLATE utf8_unicode_ci NOT NULL,
  `via` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallet_requests`
--

CREATE TABLE `wallet_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `alias_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `request_from` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'user,provider,fleet',
  `from_id` int(11) NOT NULL,
  `from_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` enum('C','D') COLLATE utf8_unicode_ci NOT NULL,
  `amount` double(15,8) NOT NULL DEFAULT 0.00000000,
  `send_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'online,offline',
  `send_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0-Pendig,1-Approved,2-cancel',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `works`
--

CREATE TABLE `works` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `age` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `work` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_email_unique` (`email`);

--
-- Indexes for table `account_password_resets`
--
ALTER TABLE `account_password_resets`
  ADD KEY `account_password_resets_email_index` (`email`),
  ADD KEY `account_password_resets_token_index` (`token`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `admin_wallet`
--
ALTER TABLE `admin_wallet`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `advertisements`
--
ALTER TABLE `advertisements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_pushes`
--
ALTER TABLE `custom_pushes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dispatchers`
--
ALTER TABLE `dispatchers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dispatchers_email_unique` (`email`);

--
-- Indexes for table `dispatcher_password_resets`
--
ALTER TABLE `dispatcher_password_resets`
  ADD KEY `dispatcher_password_resets_email_index` (`email`),
  ADD KEY `dispatcher_password_resets_token_index` (`token`);

--
-- Indexes for table `disputes`
--
ALTER TABLE `disputes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driving_zones`
--
ALTER TABLE `driving_zones`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `eventcontacts`
--
ALTER TABLE `eventcontacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favourite_locations`
--
ALTER TABLE `favourite_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fleets`
--
ALTER TABLE `fleets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fleets_email_unique` (`email`);

--
-- Indexes for table `fleet_cards`
--
ALTER TABLE `fleet_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fleet_password_resets`
--
ALTER TABLE `fleet_password_resets`
  ADD KEY `fleet_password_resets_email_index` (`email`),
  ADD KEY `fleet_password_resets_token_index` (`token`);

--
-- Indexes for table `fleet_wallet`
--
ALTER TABLE `fleet_wallet`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ltm_translations`
--
ALTER TABLE `ltm_translations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `payment_logs`
--
ALTER TABLE `payment_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payu_payments`
--
ALTER TABLE `payu_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `peak_hours`
--
ALTER TABLE `peak_hours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `point_interests`
--
ALTER TABLE `point_interests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `poi_categories`
--
ALTER TABLE `poi_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `polygon_shapes`
--
ALTER TABLE `polygon_shapes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poi_category_polygon_shape_category_id_fk` (`poi_category_id`);

--
-- Indexes for table `promocodes`
--
ALTER TABLE `promocodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promocode_passbooks`
--
ALTER TABLE `promocode_passbooks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promocode_usages`
--
ALTER TABLE `promocode_usages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `providers_email_unique` (`email`),
  ADD UNIQUE KEY `providers_mobile_unique` (`mobile`);

--
-- Indexes for table `provider_cards`
--
ALTER TABLE `provider_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provider_devices`
--
ALTER TABLE `provider_devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provider_documents`
--
ALTER TABLE `provider_documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provider_profiles`
--
ALTER TABLE `provider_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provider_services`
--
ALTER TABLE `provider_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provider_wallet`
--
ALTER TABLE `provider_wallet`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reasons`
--
ALTER TABLE `reasons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `referral_earnings`
--
ALTER TABLE `referral_earnings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `referral_histroy`
--
ALTER TABLE `referral_histroy`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `request_filters`
--
ALTER TABLE `request_filters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `request_waiting_time`
--
ALTER TABLE `request_waiting_time`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `service_peak_hours`
--
ALTER TABLE `service_peak_hours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_types`
--
ALTER TABLE `service_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_key_index` (`key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`);

--
-- Indexes for table `user_requests`
--
ALTER TABLE `user_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_request_disputes`
--
ALTER TABLE `user_request_disputes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_request_lost_items`
--
ALTER TABLE `user_request_lost_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_request_payments`
--
ALTER TABLE `user_request_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_request_ratings`
--
ALTER TABLE `user_request_ratings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_request_recurrents`
--
ALTER TABLE `user_request_recurrents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_wallet`
--
ALTER TABLE `user_wallet`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_wallet_requests`
--
ALTER TABLE `user_wallet_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallet_passbooks`
--
ALTER TABLE `wallet_passbooks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallet_requests`
--
ALTER TABLE `wallet_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `works`
--
ALTER TABLE `works`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `admin_wallet`
--
ALTER TABLE `admin_wallet`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=309;

--
-- AUTO_INCREMENT for table `advertisements`
--
ALTER TABLE `advertisements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=240;

--
-- AUTO_INCREMENT for table `custom_pushes`
--
ALTER TABLE `custom_pushes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dispatchers`
--
ALTER TABLE `dispatchers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `disputes`
--
ALTER TABLE `disputes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `driving_zones`
--
ALTER TABLE `driving_zones`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eventcontacts`
--
ALTER TABLE `eventcontacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favourite_locations`
--
ALTER TABLE `favourite_locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `fleets`
--
ALTER TABLE `fleets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `fleet_cards`
--
ALTER TABLE `fleet_cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fleet_wallet`
--
ALTER TABLE `fleet_wallet`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ltm_translations`
--
ALTER TABLE `ltm_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1979;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_logs`
--
ALTER TABLE `payment_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `payu_payments`
--
ALTER TABLE `payu_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `peak_hours`
--
ALTER TABLE `peak_hours`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `point_interests`
--
ALTER TABLE `point_interests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `poi_categories`
--
ALTER TABLE `poi_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `polygon_shapes`
--
ALTER TABLE `polygon_shapes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `promocodes`
--
ALTER TABLE `promocodes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `promocode_passbooks`
--
ALTER TABLE `promocode_passbooks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promocode_usages`
--
ALTER TABLE `promocode_usages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `providers`
--
ALTER TABLE `providers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT for table `provider_cards`
--
ALTER TABLE `provider_cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `provider_devices`
--
ALTER TABLE `provider_devices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `provider_documents`
--
ALTER TABLE `provider_documents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `provider_profiles`
--
ALTER TABLE `provider_profiles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `provider_services`
--
ALTER TABLE `provider_services`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT for table `provider_wallet`
--
ALTER TABLE `provider_wallet`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- AUTO_INCREMENT for table `reasons`
--
ALTER TABLE `reasons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `referral_earnings`
--
ALTER TABLE `referral_earnings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `referral_histroy`
--
ALTER TABLE `referral_histroy`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_filters`
--
ALTER TABLE `request_filters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `request_waiting_time`
--
ALTER TABLE `request_waiting_time`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `service_peak_hours`
--
ALTER TABLE `service_peak_hours`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `service_types`
--
ALTER TABLE `service_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1178;

--
-- AUTO_INCREMENT for table `user_requests`
--
ALTER TABLE `user_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=315;

--
-- AUTO_INCREMENT for table `user_request_disputes`
--
ALTER TABLE `user_request_disputes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `user_request_lost_items`
--
ALTER TABLE `user_request_lost_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_request_payments`
--
ALTER TABLE `user_request_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `user_request_ratings`
--
ALTER TABLE `user_request_ratings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=506;

--
-- AUTO_INCREMENT for table `user_request_recurrents`
--
ALTER TABLE `user_request_recurrents`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_wallet`
--
ALTER TABLE `user_wallet`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_wallet_requests`
--
ALTER TABLE `user_wallet_requests`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `wallet_passbooks`
--
ALTER TABLE `wallet_passbooks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallet_requests`
--
ALTER TABLE `wallet_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `works`
--
ALTER TABLE `works`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
