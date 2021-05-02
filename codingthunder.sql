-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2021 at 09:41 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(20) NOT NULL,
  `name` text NOT NULL,
  `phn_num` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phn_num`, `email`, `msg`, `date`) VALUES
(1, 'First Post', '1236547896', 'firstpost@gmail.com', 'Hello, I am first entry', '2021-04-11 02:02:29'),
(2, 'Shivansh Goyal', '1234567890', 'shivansh@gmail.com', 'We Won ', NULL),
(3, 'Tony Stark', '8576384756', 'tony@hotmail.com', 'Genious, Billionaire, Playboy, Philanthrophist', '2021-04-11 03:56:56'),
(4, 'Mr. Amir', '34325423563', 'amir@hotmail.com', 'Hello Shivansh', '2021-04-11 23:55:49'),
(5, 'Gaurav Taneja', '9876567876', 'tanejagaurav@gmail.com', 'Your blogs are really great', '2021-04-12 01:24:44'),
(6, 'Rashbhari Taneja', '23452435252', 'rashi@yahoomail.com', 'Hey Guys, today is november', '2021-04-12 07:06:13'),
(7, 'sgssgsdg', '54252545343', 'dgvsg@gf.sds', 'vbxcvbx', '2021-04-13 01:40:40'),
(8, 'svscv', '452452423423', 'vzxcv@sd.vcgh', 'bdfhgdf', '2021-04-13 01:56:03'),
(9, 'ggfsdg', '31234141', 'gsg@gmail.gdf', 'bfxcfbzb', '2021-04-13 02:02:14'),
(10, 'ggfsdg', '31234141', 'gsg@gmail.gdf', 'bfxcfbzb', '2021-04-13 02:09:30'),
(11, 'Tom Holland', '3123414123', 'tom@gmail.com', 'Your website looks Preety!!', '2021-04-13 02:10:56'),
(12, 'Shikhar Goyal', '7987125499', 'shikhar@gmail.com', 'hi shivansh you have made a good blogging site.', '2021-04-19 22:04:01'),
(13, 'Harry potter', '2345687612', 'harry@gmail.com', 'Your site looks good', '2021-04-28 05:45:13'),
(14, 'Harry potter', '2345687612', 'harry@gmail.com', 'Your site looks good', '2021-04-28 05:45:31');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(20) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'Lets learn about Stock Market fixed', 'This is the First Post', 'first-post', 'Stock (also capital stock) is all of the shares into which ownership of a corporation is divided.In American English, the shares are collectively known as \"stock\". A single share of the stock represents fractional ownership of the corporation in proportion to the total number of shares. This typically entitles the stockholder to that fraction of the company\'s earnings, proceeds from liquidation of assets (after discharge of all senior claims such as secured and unsecured debt),or voting power, often dividing these up in proportion to the amount of money each stockholder has invested. Not all stock is necessarily equal, as certain classes of stock may be issued for example without voting rights, with enhanced voting rights, or with a certain priority to receive profits or liquidation proceeds before or after other classes of shareholders.', 'stocks.jpg', '2021-04-23 19:49:42'),
(2, 'Lets learn about Freelancing', 'Coolest Post you will ever read', 'second-post', 'Freelance (sometimes spelled free-lance or free lance),freelancer, or freelance worker, are terms commonly used for a person who is self-employed and not necessarily committed to a particular employer long-term. Freelance workers are sometimes represented by a company or a temporary agency that resells freelance labor to clients; others work independently or use professional associations or websites to get work.', 'freelance.jpg', '2021-04-19 21:30:53'),
(3, 'Lets learn about Blogging', 'Phenomenal post', 'third-post', 'A blog (a truncation of \"weblog\") is a discussion or informational website published on the World Wide Web consisting of discrete, often informal diary-style text entries (posts). Posts are typically displayed in reverse chronological order, so that the most recent post appears first, at the top of the web page. Until 2009, blogs were usually the work of a single individual,[citation needed] occasionally of a small group, and often covered a single subject or topic. In the 2010s, \"multi-author blogs\" (MABs) emerged, featuring the writing of multiple authors and sometimes professionally edited.', 'blogging.jpg', '2021-04-19 21:32:40'),
(4, 'Lets learn about Digital Marketing', 'Everyone must read about it', 'forth-post', 'Digital marketing is the component of marketing that utilizes internet and online based digital technologies such as desktop computers, mobile phones and other digital media and platforms to promote products and services. Its development during the 1990s and 2000s, changed the way brands and businesses use technology for marketing. As digital platforms became increasingly incorporated into marketing plans and everyday life, and as people increasingly use digital devices instead of visiting physical shops, digital marketing campaigns have become prevalent, employing combinations of search engine optimization (SEO), search engine marketing (SEM), content marketing, influencer marketing, content automation, campaign marketing, data-driven marketing, e-commerce marketing, social media marketing, social media optimization, e-mail direct marketing, display advertising, e–books, and optical disks and games have become commonplace. ', 'digital-marketing-2.jpg', '2021-04-19 21:34:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
