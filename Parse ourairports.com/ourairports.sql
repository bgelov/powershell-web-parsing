-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Май 20 2020 г., 21:01
-- Версия сервера: 5.7.30-0ubuntu0.18.04.1
-- Версия PHP: 7.2.24-0ubuntu0.18.04.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `travelpayouts`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ourairports`
--

CREATE TABLE `ourairports` (
  `id` int(11) NOT NULL,
  `ident` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `latitude_deg` varchar(255) NOT NULL,
  `longitude_deg` varchar(255) NOT NULL,
  `elevation_ft` varchar(255) NOT NULL,
  `continent` varchar(2) NOT NULL,
  `iso_country` varchar(2) NOT NULL,
  `iso_region` varchar(255) NOT NULL,
  `municipality` varchar(255) NOT NULL,
  `scheduled_service` varchar(255) NOT NULL,
  `gps_code` varchar(255) NOT NULL,
  `iata_code` varchar(3) NOT NULL,
  `local_code` varchar(255) NOT NULL,
  `home_link` varchar(255) NOT NULL,
  `wikipedia_link` varchar(255) NOT NULL,
  `keywords` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `ourairports`
--
ALTER TABLE `ourairports`
  ADD UNIQUE KEY `id` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
