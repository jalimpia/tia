-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2020 at 10:23 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tia_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `course_tbl`
--

CREATE TABLE `course_tbl` (
  `course_id` int(11) NOT NULL,
  `course_code` varchar(50) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `course_desc` varchar(255) NOT NULL,
  `course_units` int(11) NOT NULL,
  `course_img` varchar(255) NOT NULL,
  `course_sem` int(11) NOT NULL,
  `course_publish` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `course_tbl`
--

INSERT INTO `course_tbl` (`course_id`, `course_code`, `course_name`, `course_desc`, `course_units`, `course_img`, `course_sem`, `course_publish`) VALUES
(1, 'CS100', 'Fundamentals of Algorithms', 'This course covers the fundamental concepts and principles of algorithms; program logic formulation using flowcharts and pseudocodes; problem-solving techniques and strategies; algorithm analysis and design; searching and sorting algorithms.', 3, '/images/courses/course_img-1587498814272', 1, 0),
(2, 'CS200', 'Principles of Programming Languages', 'This course covers the significant concepts and principles of programming languages necessary to improve the student’s abilities to develop effective algorithms and use of existing programming constructs, increase their vocabularies of useful programming ', 3, '/images/courses/course_img-1587499145117', 1, 0),
(3, 'CS201A', 'Data Structures and Algorithms Analysis', 'The course focuses on data abstraction, data structure, analysis and design of algorithms, and object-oriented techniques. Classic data structure – lists, queues, stacks, tress, tables, graphs - shall emphasize on the analysis of implementation techniques', 4, '/images/no-thumbnail.jpg', 1, 0),
(5, 'CS301', 'Software Engineering 1', 'Topics included in this course are: development of software intensive system, software quality factors, software engineering principles, system life cycle models and paradigms, requirements definition and analysis, behavioural specification, software desi', 3, '/images/no-thumbnail.jpg', 1, 0),
(6, 'CS302', 'Modeling and Simulation', 'This course introduces a wide range of problem solving techniques, methods, and tools to improve decision-making and efficieny of computer-based systems, such as mathematical optimization, computer simulation, queueing theory and other stochastic-process ', 3, '/images/courses/course_img-1587499399751', 1, 0),
(7, 'CS305', 'Computer Security', 'This course provides an introduction to information security with emphasis on cybersecurity. It provides awareness on social engineering techniques such as phishing and password harvesting. A discussion on risk assessment is also covered in the course. ', 3, '/images/courses/course_img-1587499464110', 1, 0),
(22, 'CS402', 'Internship In Computing', 'The course aims to provide knowledge and skills about the social and ethical responsibility in preparation for professional practice and develop student’s competitiveness and employability by providing opportunities to develop winners’ mindset and actual ', 3, '/images/courses/course_img-1587564064569', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `exam_tbl`
--

CREATE TABLE `exam_tbl` (
  `exam_id` varchar(255) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `exam_title` varchar(255) NOT NULL,
  `exam_items` int(11) NOT NULL,
  `exam_instruction` text NOT NULL,
  `exam_time` int(11) NOT NULL,
  `exam_lo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`exam_lo`)),
  `exam_published` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `items_tbl`
--

CREATE TABLE `items_tbl` (
  `id` int(11) NOT NULL,
  `exam_id` varchar(255) NOT NULL,
  `lo_id` int(11) NOT NULL,
  `item_no` int(11) NOT NULL,
  `question_id` varchar(255) DEFAULT NULL,
  `visibility` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `item_analysis_tbl`
--

CREATE TABLE `item_analysis_tbl` (
  `analysis_id` int(11) NOT NULL,
  `exam_id` varchar(255) NOT NULL,
  `student_id` int(11) NOT NULL,
  `question_identifier` varchar(255) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `learning_tbl`
--

CREATE TABLE `learning_tbl` (
  `lo_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `lo_topic` varchar(255) NOT NULL,
  `lo_desc` text NOT NULL,
  `lo_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `learning_tbl`
--

INSERT INTO `learning_tbl` (`lo_id`, `teacher_id`, `course_id`, `lo_topic`, `lo_desc`, `lo_time`) VALUES
(55, 48, 1, 'Recognize the importance of software engineering', 'Recognize the importance of software engineering', 1);

-- --------------------------------------------------------

--
-- Table structure for table `loading_tbl`
--

CREATE TABLE `loading_tbl` (
  `loading_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `who_assign_id` int(11) NOT NULL,
  `status` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `loading_tbl`
--

INSERT INTO `loading_tbl` (`loading_id`, `course_id`, `teacher_id`, `who_assign_id`, `status`) VALUES
(20, 1, 48, 48, 0),
(29, 1, 53, 48, 0),
(30, 1, 54, 48, 0),
(31, 1, 55, 48, 0),
(32, 1, 56, 48, 0),
(33, 1, 57, 48, 0),
(34, 1, 58, 48, 0),
(35, 1, 59, 48, 0);

-- --------------------------------------------------------

--
-- Table structure for table `question_tbl`
--

CREATE TABLE `question_tbl` (
  `question_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `lo_id` int(11) NOT NULL,
  `exam_id` varchar(255) DEFAULT NULL,
  `question_identifier` varchar(255) NOT NULL,
  `question_name` varchar(255) NOT NULL,
  `question_type` varchar(255) DEFAULT NULL,
  `question_desc` text NOT NULL,
  `question_pa_1` varchar(255) NOT NULL,
  `question_pa_2` varchar(255) NOT NULL,
  `question_pa_3` varchar(255) NOT NULL,
  `question_pa_4` varchar(255) NOT NULL,
  `question_correct` varchar(255) NOT NULL,
  `question_pts` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `taken_exam_tbl`
--

CREATE TABLE `taken_exam_tbl` (
  `taken_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `exam_id` varchar(255) NOT NULL,
  `exam_item` int(11) NOT NULL,
  `exam_score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_tbl`
--

CREATE TABLE `user_tbl` (
  `teacher_id` int(11) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `department` varchar(100) NOT NULL,
  `account_type` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_tbl`
--

INSERT INTO `user_tbl` (`teacher_id`, `fname`, `lname`, `email`, `username`, `password`, `department`, `account_type`) VALUES
(48, 'Jerone', 'Alimpia', 'jeronealimpia@gmail.com', 'jerone', 'admin1234', 'Computer Science', 1),
(53, 'Marione', 'Suana', 'marione@gmail.com', 'marione', 'admin1234', 'Computer Science', 0),
(54, 'Vera', 'Alimpia', 'vera@gmail.com', 'vera', 'admin1234', 'Computer Science', 0),
(55, 'Vella', 'Alimpia', 'j.alimpia@yahoo.com', 'vella', 'admin1234', 'Computer Science', 0),
(56, 'Ana', 'Dichoso', 'ana@gmail.com', 'ana', 'admin1234', 'Computer Science', 1),
(57, 'Juan', 'Dela Cruz', 'juan@gmail.com', 'juan', 'admin1234', 'Computer Science', 0),
(58, 'Alex', 'Xander', 'alex@gmail.com', 'alex', 'admin1234', 'Computer Science', 0),
(59, 'John', 'Paul', 'john@gmail.com', 'john', 'admin1234', 'Computer Science', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course_tbl`
--
ALTER TABLE `course_tbl`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `exam_tbl`
--
ALTER TABLE `exam_tbl`
  ADD PRIMARY KEY (`exam_id`);

--
-- Indexes for table `items_tbl`
--
ALTER TABLE `items_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_analysis_tbl`
--
ALTER TABLE `item_analysis_tbl`
  ADD PRIMARY KEY (`analysis_id`);

--
-- Indexes for table `learning_tbl`
--
ALTER TABLE `learning_tbl`
  ADD PRIMARY KEY (`lo_id`);

--
-- Indexes for table `loading_tbl`
--
ALTER TABLE `loading_tbl`
  ADD PRIMARY KEY (`loading_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `question_tbl`
--
ALTER TABLE `question_tbl`
  ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `taken_exam_tbl`
--
ALTER TABLE `taken_exam_tbl`
  ADD PRIMARY KEY (`taken_id`);

--
-- Indexes for table `user_tbl`
--
ALTER TABLE `user_tbl`
  ADD PRIMARY KEY (`teacher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `course_tbl`
--
ALTER TABLE `course_tbl`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `items_tbl`
--
ALTER TABLE `items_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `item_analysis_tbl`
--
ALTER TABLE `item_analysis_tbl`
  MODIFY `analysis_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=330;

--
-- AUTO_INCREMENT for table `learning_tbl`
--
ALTER TABLE `learning_tbl`
  MODIFY `lo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `loading_tbl`
--
ALTER TABLE `loading_tbl`
  MODIFY `loading_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `question_tbl`
--
ALTER TABLE `question_tbl`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

--
-- AUTO_INCREMENT for table `taken_exam_tbl`
--
ALTER TABLE `taken_exam_tbl`
  MODIFY `taken_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `user_tbl`
--
ALTER TABLE `user_tbl`
  MODIFY `teacher_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `loading_tbl`
--
ALTER TABLE `loading_tbl`
  ADD CONSTRAINT `loading_tbl_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course_tbl` (`course_id`),
  ADD CONSTRAINT `loading_tbl_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `user_tbl` (`teacher_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
