-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 29 2018 г., 12:50
-- Версия сервера: 10.1.28-MariaDB
-- Версия PHP: 5.6.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `getachieve`
--

-- --------------------------------------------------------

--
-- Структура таблицы `artifact`
--

CREATE TABLE `artifact` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `artifact_piece`
--

CREATE TABLE `artifact_piece` (
  `id` int(10) UNSIGNED NOT NULL,
  `artifact_id` int(10) UNSIGNED NOT NULL,
  `idx` smallint(6) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `geo_materials`
--

CREATE TABLE `geo_materials` (
  `id` bigint(20) NOT NULL,
  `coord` point NOT NULL,
  `material_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `collected` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `geo_materials`
--

INSERT INTO `geo_materials` (`id`, `coord`, `material_id`, `user_id`, `collected`) VALUES
(1, '\0\0\0\0\0\0\0ОdjШђ5I@™Ыч‡±›>@', 6, 1, 0),
(2, '\0\0\0\0\0\0\0ЌЭWHm4I@Ё‡\r»”ћ>@', 7, 1, 0),
(3, '\0\0\0\0\0\0\0\\>Є5I@:ъFҐњ>@', 4, 1, 0),
(4, '\0\0\0\0\0\0\0„ёХ \n5I@+Йќ+љ>@', 2, 1, 0),
(5, '\0\0\0\0\0\0\0н@cG_4I@qjo	#ћ>@', 4, 1, 0),
(6, '\0\0\0\0\0\0\0uKЭ[І3I@ “1г™>@', 2, 1, 0),
(7, '\0\0\0\0\0\0\0ЙPЫ§_4I@>ѕ@{ќ>@', 2, 1, 0),
(8, '\0\0\0\0\0\0\0¦цїЇS3I@ХЧК¶™љ>@', 7, 1, 0),
(9, '\0\0\0\0\0\0\0§¶н3I@їEHY–ќ>@', 2, 1, 0),
(10, '\0\0\0\0\0\0\0O=ђДd5I@x4ЈYљ>@', 1, 1, 0),
(11, '\0\0\0\0\0\0\0Х1…4I@†К;^іћ>@', 5, 1, 0),
(12, '\0\0\0\0\0\0\0™2‰Эk3I@’ы€%ћ>@', 2, 1, 0),
(13, '\0\0\0\0\0\0\0ЩJ}“4I@“h›>@', 7, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `materials`
--

CREATE TABLE `materials` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `generation` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `materials`
--

INSERT INTO `materials` (`id`, `name`, `image`, `generation`) VALUES
(1, 'sand', 'sand.jpg', 0),
(2, 'fire', 'fire.jpg', 0),
(3, 'glass', 'glass.jpg', 1),
(4, 'stone', 'stone.jpg', 0),
(5, 'tree', 'tree.jpg', 0),
(6, 'cement', 'cement.jpg', 0),
(7, 'air', 'air.jpg', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `material_synthesis`
--

CREATE TABLE `material_synthesis` (
  `child_id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED NOT NULL,
  `cnt` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `material_synthesis`
--

INSERT INTO `material_synthesis` (`child_id`, `parent_id`, `cnt`) VALUES
(1, 3, 1),
(2, 3, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `tasks`
--

CREATE TABLE `tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `coord` point NOT NULL,
  `min_level` smallint(6) NOT NULL,
  `keys_amount` smallint(6) NOT NULL,
  `points_reward` mediumint(9) NOT NULL,
  `carma_reward` mediumint(9) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `task_artifact_piece_reward`
--

CREATE TABLE `task_artifact_piece_reward` (
  `task_id` int(10) UNSIGNED NOT NULL,
  `artifact_piece_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `task_artifact_required`
--

CREATE TABLE `task_artifact_required` (
  `task_id` int(10) UNSIGNED NOT NULL,
  `artifact_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `task_material_required`
--

CREATE TABLE `task_material_required` (
  `task_id` int(10) UNSIGNED NOT NULL,
  `material_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `task_material_reward`
--

CREATE TABLE `task_material_reward` (
  `task_id` int(10) UNSIGNED NOT NULL,
  `material_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `tiles_materials`
--

CREATE TABLE `tiles_materials` (
  `id` bigint(20) NOT NULL,
  `lat_south` decimal(4,2) NOT NULL,
  `lon_west` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tiles_materials`
--

INSERT INTO `tiles_materials` (`id`, `lat_south`, `lon_west`) VALUES
(1, '50.40', '30.60');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(60) NOT NULL,
  `karma` mediumint(9) NOT NULL,
  `fraction` enum('creator','fanatic') NOT NULL,
  `password` char(60) NOT NULL,
  `email` varchar(255) NOT NULL,
  `level` smallint(6) NOT NULL,
  `points` mediumint(9) NOT NULL,
  `keys` smallint(6) NOT NULL,
  `gat` int(11) NOT NULL,
  `coins` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `social` varchar(255) DEFAULT NULL,
  `social_id` varchar(255) DEFAULT NULL,
  `role` enum('lead','minor','indy') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `karma`, `fraction`, `password`, `email`, `level`, `points`, `keys`, `gat`, `coins`, `image`, `social`, `social_id`, `role`) VALUES
(1, 'radalex', 0, 'creator', '222', 'urafan@gmail.com', 1, 0, 0, 0, 0, NULL, NULL, NULL, 'lead');

-- --------------------------------------------------------

--
-- Структура таблицы `user_materials`
--

CREATE TABLE `user_materials` (
  `id` int(10) UNSIGNED NOT NULL,
  `material_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `cnt` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `user_materials`
--

INSERT INTO `user_materials` (`id`, `material_id`, `user_id`, `cnt`) VALUES
(2, 6, 1, 1),
(4, 3, 1, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `user_tasks`
--

CREATE TABLE `user_tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `completed_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `artifact`
--
ALTER TABLE `artifact`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `artifact_piece`
--
ALTER TABLE `artifact_piece`
  ADD PRIMARY KEY (`id`),
  ADD KEY `artifact_piece_fk0` (`artifact_id`);

--
-- Индексы таблицы `geo_materials`
--
ALTER TABLE `geo_materials`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `material_synthesis`
--
ALTER TABLE `material_synthesis`
  ADD PRIMARY KEY (`child_id`,`parent_id`);

--
-- Индексы таблицы `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `task_material_reward`
--
ALTER TABLE `task_material_reward`
  ADD PRIMARY KEY (`material_id`);

--
-- Индексы таблицы `tiles_materials`
--
ALTER TABLE `tiles_materials`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user_materials`
--
ALTER TABLE `user_materials`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user_tasks`
--
ALTER TABLE `user_tasks`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `artifact`
--
ALTER TABLE `artifact`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `artifact_piece`
--
ALTER TABLE `artifact_piece`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `geo_materials`
--
ALTER TABLE `geo_materials`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `tiles_materials`
--
ALTER TABLE `tiles_materials`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `user_materials`
--
ALTER TABLE `user_materials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `user_tasks`
--
ALTER TABLE `user_tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `artifact_piece`
--
ALTER TABLE `artifact_piece`
  ADD CONSTRAINT `artifact_piece_fk0` FOREIGN KEY (`artifact_id`) REFERENCES `artifact` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
