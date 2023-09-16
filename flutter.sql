-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4306
-- Generation Time: May 08, 2023 at 04:51 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flutter`
--

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `companyName` varchar(20) NOT NULL,
  `contactPersonName` varchar(20) NOT NULL,
  `companyIndustry` text NOT NULL,
  `contactPersonPhoneNumber` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `companyAddress` varchar(20) NOT NULL,
  `companySize` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `img` text NOT NULL,
  `longitude` text NOT NULL,
  `latitude` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `companyName`, `contactPersonName`, `companyIndustry`, `contactPersonPhoneNumber`, `email`, `companyAddress`, `companySize`, `password`, `img`, `longitude`, `latitude`) VALUES
(6, 'aaaaaaa', 'aaaaaaaaaaa', 'option2option3', '0122255478', 'marina@gmail.com', 'safasfa', 'Mini', '123456789', '', '31.1137432', '29.9924479'),
(7, 'bbbbbb', 'bbbbbb', 'option1option2', '012345646879', 'martina@gmail.com', 'dsdfaasf', 'Small', '123456789', '', '31.1824813', '29.9952793'),
(8, 'kotomoto', 'tottttttaaaaaaaaaaaa', 'option2', '456456456', 'mina@gmail.com', 'fsafsafa', 'Mini', '123456789', '', '31.1824813', '29.9952793');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`) VALUES
(1, 'mina'),
(2, 'abanoub');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
