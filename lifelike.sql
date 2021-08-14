-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 14, 2021 at 05:08 AM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lifelike`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'Mohit Patel', 'mp434027@gmail.com', '6263726297', 'contact!', '2021-08-03'),
(2, 'Sachin Tendulkar', 'testuser4@ddgmai.oc', '10010010', 'msg', '2021-08-03'),
(3, 'Sachin Tendulkar', 'testuser4@ddgmai.oc', '45454554545', 'afagdgagagadg', '2021-08-04'),
(4, 'Sachin Tendulkar', 'testuser7@gmail.com', '4545455454', 'email sent! haha', '2021-08-04'),
(5, 'Sachin Tendulkar', 'testuser7@gmail.com', '4545455454', 'okay 2nd roune', '2021-08-04'),
(6, 'Sachin Tendulkar', 'testuser4@ddgmai.oc', '45454554', '3rd round', '2021-08-04'),
(7, 'Sachin Tendulkar', 'testuser4@ddgmai.oc', '45454554', '3rd round', '2021-08-04'),
(8, 'Rahul Dravid', 'testplayer@gmail.com', '454545554', '4rd round', '2021-08-04'),
(9, 'Rahul Dravid', 'testplayer@gmail.com', '454545554', '4rd round', '2021-08-04'),
(10, 'Rahul Dravid', 'testplayer@gmail.com', '454545554', '4rd round', '2021-08-04'),
(11, 'Rahul Dravid', 'testuser7@gmail.com', '10010010', 'okidoki', '2021-08-04'),
(12, 'Rahul Dravid', 'testuser7@gmail.com', '10010010', 'okidoki', '2021-08-04');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `sub` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `sub`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'The First Post', 'okay so sub heading', 'first-post', 'Yup first post! great right. I never thought it would be this easy to create a blog, I mean really, that\'s how you create a blog, pretty solid right.', 'post-bg.jpg', '2021-08-05'),
(2, 'Second post, not too shaby huh.', 'So second heading, this white light is blinding.', 'second-post', 'so, about second post its good very good, not the post obviously but the feeling of writing the post', 'post2.jpg', '2021-08-06'),
(3, 'Third post!', 'Third post, hun tired of this cold man.', 'third-post', 'SO this cold is turning out to be bad, what to do, turmeric milk might help.', 'post3.jpg', '2021-08-06'),
(4, 'Fourth post!', 'on a roll, writing posts', 'fourth-post', 'on a roll here, want to complete more than five posts', 'post4.jpg', '2021-08-06'),
(5, 'fifth post,', 'so this is fifth post', 'fifth-post', 'okay! fifth post finally this is good, want to complete this blog as soon as possible', 'post5.jpg', '2021-08-06'),
(6, 'Sixth post', 'Please no error', 'sixth-post', 'no error no error no error', 'sixth.jpg', '2021-08-10');

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
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
