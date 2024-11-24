CREATE DATABASE IF NOT EXISTS `group3s15`;
USE `group3s15`;

-- Drop Tables if they Exist

DROP TABLE IF EXISTS `job_applications`;
DROP TABLE IF EXISTS `job_postings`;
DROP TABLE IF EXISTS `user_accounts`;
DROP TABLE IF EXISTS `jobs`;
DROP TABLE IF EXISTS `branches`;
DROP TABLE IF EXISTS `companies`;
DROP TABLE IF EXISTS `REF_job_position`;
-- companies table
CREATE TABLE `companies` (
  `company_ID` DECIMAL(10,0) NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
  `contact_email` TEXT DEFAULT NULL,
  `main_location` VARCHAR(100) NOT NULL,
  `company_password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`company_ID`),
  UNIQUE KEY `company_name_UK` (`company_name`)
);

-- branches table
CREATE TABLE `branches` (
  `branch_ID` DECIMAL(10,0) NOT NULL,
  `location` VARCHAR(100) NOT NULL,
  `contact_no` TEXT DEFAULT NULL,
  `company_ID` DECIMAL(10,0) DEFAULT NULL,
  PRIMARY KEY (`branch_ID`),
  KEY `branch_company_IX` (`company_ID`),
  CONSTRAINT `fk_branch_company_ID` FOREIGN KEY (`company_ID`) REFERENCES `companies` (`company_ID`) ON DELETE SET NULL
);

-- job position reference table
CREATE TABLE `REF_job_position` (
  `position_ID` DECIMAL(10,0) NOT NULL,
  `position_name` VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (`position_ID`)
);

-- jobs table
CREATE TABLE `jobs` (
  `job_ID` DECIMAL(10,0) NOT NULL,
  `position_ID` DECIMAL(10,0) NOT NULL,
  `company_ID` DECIMAL(10,0) NOT NULL,
  `branch_ID` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`job_ID`),
  KEY `job_position_IX` (`position_ID`),
  KEY `job_company_IX` (`company_ID`),
  KEY `job_branch_IX` (`branch_ID`),
  CONSTRAINT `fk_job_position_ID` FOREIGN KEY (`position_ID`) REFERENCES `REF_job_position` (`position_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_job_company_ID` FOREIGN KEY (`company_ID`) REFERENCES `companies` (`company_ID`) ON DELETE CASCADE,
  CONSTRAINT `fk_job_branch_ID` FOREIGN KEY (`branch_ID`) REFERENCES `branches` (`branch_ID`) ON DELETE CASCADE
);
CREATE TABLE `user_accounts` (
  `account_ID` DECIMAL(10,0) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `contact_no` TEXT DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  `home_address` TEXT DEFAULT NULL,
  `birthday` DATE DEFAULT NULL,
  `education` ENUM ('None', 'High School', 'Bachelors', 'Masters','PhD') default 'None',
  `years_of_experience` DECIMAL(10,0) DEFAULT NULL,
  `primary_language` TEXT NOT NULL,
  `job_ID` DECIMAL(10,0) DEFAULT NULL,
  `company_ID` DECIMAL(10,0) DEFAULT NULL,
  `user_password` VARCHAR(255) NOT NULL,
  `registration_date` DATE DEFAULT NULL,
  PRIMARY KEY (`account_ID`),
  UNIQUE KEY `UA_email_UK` (`email`),
  KEY `UA_name_IX` (`last_name`, `first_name`),
  CONSTRAINT `fk_job_ID` FOREIGN KEY (`job_ID`) REFERENCES `jobs` (`job_ID`) ON DELETE SET NULL,
  CONSTRAINT `fk_company_ID` FOREIGN KEY (`company_ID`) REFERENCES `companies` (`company_ID`) ON DELETE SET NULL
);

-- job postings table
CREATE TABLE `job_postings` (
    `posting_ID` DECIMAL(10,0) NOT NULL,   
    `position_ID` DECIMAL(10,0) NOT NULL,
    `company_ID` DECIMAL(10,0) NOT NULL,
    `branch_ID` DECIMAL(10,0) NOT NULL,
    `education_requirement` ENUM ('None', 'High School', 'Bachelors', 'Masters', 'PhD') DEFAULT 'None',
    `years_of_experience_requirement` DECIMAL(10,0) NOT NULL,
    `posting_date` DATE DEFAULT NULL,  
    `expiry_date` DATE,                        
    `status` ENUM('Active', 'Expired', 'Closed') DEFAULT 'Active',
    PRIMARY KEY (`posting_ID`),
    FOREIGN KEY (`position_ID`) REFERENCES `REF_job_position`(`position_ID`),
    FOREIGN KEY (`company_ID`) REFERENCES `companies`(`company_ID`),
    FOREIGN KEY (`branch_ID`) REFERENCES `branches`(`branch_ID`)
);
-- job applications table

CREATE TABLE `job_applications` (
    `application_ID` DECIMAL(10,0) NOT NULL,
    `posting_ID` DECIMAL(10,0) NOT NULL,  
	`account_ID` DECIMAL(10,0) NOT NULL,                                         
    `application_date` DATE DEFAULT NULL,
    `status` ENUM('Applied', 'Accepted', 'Rejected') DEFAULT 'Applied',
    PRIMARY KEY (`application_ID`),
    FOREIGN KEY (`posting_ID`) REFERENCES `job_postings`(`posting_ID`),
    FOREIGN KEY (`account_ID`) REFERENCES `user_accounts`(`account_ID`)
);



INSERT INTO `job_applications` (application_ID, posting_ID, account_ID, application_date, status) 
VALUES
(1, 2, '0013', '2024-11-02', 'Applied'),
(2, 3, '0014', '2024-11-03', 'Applied'),
(3, 4, '0015', '2024-11-04', 'Applied'),
(4, 5, '0013', '2024-11-05', 'Applied'),
(5, 6, '0014', '2024-11-06', 'Applied'),
(6, 7, '0015', '2024-11-07', 'Applied');

INSERT INTO `job_postings` (posting_ID, position_ID, company_ID, branch_ID, education_requirement, years_of_experience_requirement, posting_date, expiry_date, status) 
VALUES
(1, 1, 1, 1, 'Bachelors', 2, '2024-11-01', '2024-12-01', 'Active'),  
(2, 7, 1, 1, 'Bachelors', 2, '2022-10-01', '2022-11-01', 'Expired'),
(3, 8, 1, 1, 'Masters', 3, '2022-10-01', '2022-11-01', 'Closed'),
(4, 2, 2, 2, 'Masters', 3, '2024-11-01', '2024-12-01', 'Active'),
(5, 3, 3, 3, 'Bachelors', 5, '2024-11-01', '2024-12-01', 'Active'),
(6, 4, 4, 4, 'PhD', 1, '2024-11-01', '2024-12-01', 'Active'),
(7, 5, 5, 5, 'Bachelors', 4, '2024-11-01', '2024-12-01', 'Active'),
(8, 6, 6, 6, 'None', 0, '2024-11-01', '2024-12-01', 'Active'),
(9, 9, 1, 1, 'Bachelors', 2, '2024-11-01', '2024-12-01', 'Active'),
(10, 10, 2, 2, 'Masters', 4, '2024-11-01', '2024-12-01', 'Active'),
(11, 11, 3, 3, 'Bachelors', 3, '2024-11-01', '2024-12-01', 'Active'),
(12, 12, 4, 4, 'PhD', 5, '2024-11-01', '2024-12-01', 'Active'),
(13, 13, 5, 5, 'Bachelors', 1, '2024-11-01', '2024-12-01', 'Active'),
(14, 14, 6, 6, 'Masters', 2, '2024-11-01', '2024-12-01', 'Active');


INSERT INTO `companies` (company_ID, company_name, contact_email, main_location, company_password) 
VALUES
('0001', 'Apple Inc.', 'contact@apple.com', 'Cupertino, CA', '12345'),
('0002', 'Google LLC', 'contact@google.com',  'Mountain View, CA', '123456'),
('0003', 'Facebook, Inc.', 'contact@facebook.com', 'Menlo Park, CA', '1234567'),
('0004', 'Tesla, Inc.', 'contact@tesla.com', 'Palo Alto, CA', '123'),
('0005', 'Netflix, Inc.', 'contact@netflix.com', 'Los Gatos, CA', '1234'),
('0006', 'Cisco Systems, Inc.', 'contact@cisco.com', 'San Jose, CA', '12345678');

INSERT INTO `branches` (branch_ID, location, contact_no, company_ID)
VALUES
('0001', 'Apple Park, Cupertino', 'contact@apple.com', '0001'),
('0002', 'Apple Store, San Francisco', 'contact@apple.com', '0001'),
('0003', 'Apple Store, Palo Alto', 'contact@apple.com', '0001'),
('0004', 'Googleplex, Mountain View', 'contact@google.com', '0002'),
('0005', 'Google Store, San Francisco', 'contact@google.com', '0002'),
('0006', 'Google Cloud Office, Sunnyvale', 'contact@google.com', '0002'),
('0007', 'Facebook HQ, Menlo Park', 'contact@facebook.com', '0003'),
('0008', 'Facebook Office, San Francisco', 'contact@facebook.com', '0003'),
('0009', 'Facebook Office, Mountain View', 'contact@facebook.com', '0003'),
('0010', 'Tesla Showroom, Palo Alto', 'contact@tesla.com', '0004'),
('0011', 'Tesla Service Center, Fremont', 'contact@tesla.com', '0004'),
('0012', 'Tesla Store, San Jose', 'contact@tesla.com', '0004'),
('0013', 'Netflix HQ, Los Gatos', 'contact@netflix.com', '0005'),
('0014', 'Netflix Office, Hollywood', 'contact@netflix.com', '0005'),
('0015', 'Netflix Studio, San Francisco', 'contact@netflix.com', '0005'),
('0016', 'Cisco HQ, San Jose', 'contact@cisco.com', '0006'),
('0017', 'Cisco Office, Milpitas', 'contact@cisco.com', '0006'),
('0018', 'Cisco Office, San Francisco', 'contact@cisco.com', '0006');

INSERT INTO `REF_job_position` (position_ID, position_name)
VALUES
('0001', 'Design Specialist'),
('0002', 'Software Engineer'),
('0003', 'Product Manager'),
('0004', 'Data Scientist'),
('0005', 'UX/UI Designer'),
('0006', 'Marketing Specialist'),
('0007', 'Content Creator'),
('0008', 'Graphic Designer'),
('0009', 'Sales Engineer'),
('0010', 'Network Administrator'),
('0011', 'Cybersecurity Analyst'),
('0012', 'Customer Support Specialist'),
('0013', 'Project Manager'),
('0014', 'Business Analyst'),
('0015', 'Game Developer');


INSERT INTO `jobs` (job_ID, position_ID, company_ID, branch_ID)
VALUES
('0001', '0001', '0001', '0001'),
('0002', '0002', '0001', '0001'),
('0003', '0001', '0002', '0002'),
('0004', '0002', '0002', '0002'),
('0005', '0001', '0003', '0003'),
('0006', '0002', '0003', '0003'),
('0007', '0001', '0004', '0004'),
('0008', '0002', '0004', '0004'), 
('0009', '0001', '0005', '0005'),
('0010', '0002', '0005', '0005'),
('0011', '0001', '0006', '0006'),
('0012', '0002', '0006', '0006');


INSERT INTO `user_accounts` 
(account_ID, first_name, last_name, contact_no, email, home_address, birthday, years_of_experience, education, primary_language, job_ID, company_ID, user_password, registration_date) 
VALUES
('0001', 'Alice', 'Johnson', '123-456-7890', 'alice@apple.com', 'Cupertino, CA', '1992-04-15', '5', 'Bachelors', 'English', '0001', '0001', 'apple123', '2021-05-10'),
('0002', 'Bob', 'Smith', '234-567-8901', 'bob@apple.com', 'San Francisco, CA', '1989-11-30', '6', 'Masters', 'English', '0002', '0001', 'bob@apple', '2020-08-15'),
('0003', 'John', 'Doe', '345-678-9012', 'john.doe@google.com', 'Mountain View, CA', '1990-01-15', '6', 'Masters', 'English', '0003', '0002', 'password1', '2022-03-22'),
('0004', 'Jane', 'Smith', '456-789-0123', 'jane.smith@google.com', 'San Francisco, CA', '1988-02-20', '7', 'Bachelors', 'English', '0004', '0002', 'password2', '2023-01-30'),
('0005', 'Mark', 'Zuckerberg', '567-890-1234', 'mark@facebook.com', 'Palo Alto, CA', '1984-05-14', '10', 'Bachelors', 'English', '0005', '0003', 'mark123', '2020-11-05'),
('0006', 'Sheryl', 'Sandberg', '678-901-2345', 'sheryl@facebook.com', 'Menlo Park, CA', '1969-08-28', '12', 'Masters', 'English', '0006', '0003', 'sheryl123', '2022-07-19'),
('0007', 'Elon', 'Musk', '789-012-3456', 'elon@tesla.com', 'Palo Alto, CA', '1971-06-28', '15', 'PhD', 'English', '0007', '0004', 'elon@tesla', '2023-03-12'),
('0008', 'Gwynne', 'Shotwell', '890-123-4567', 'gwynne@tesla.com', 'Fremont, CA', '1963-09-23', '20', 'Masters', 'English', '0008', '0004', 'gwynne@tesla', '2021-09-25'),
('0009', 'Reed', 'Hastings', '901-234-5678', 'reed@netflix.com', 'Los Gatos, CA', '1960-10-08', '18', 'Masters', 'English', '0009', '0005', 'reed123', '2020-12-15'),
('0010', 'Ted', 'Sarandos', '012-345-6789', 'ted@netflix.com', 'Hollywood, CA', '1964-07-30', '20', 'Bachelors', 'English', '0010', '0005', 'ted@netflix', '2022-02-28'),
('0011', 'Chuck', 'Roberts', '123-987-6543', 'chuck@cisco.com', 'San Jose, CA', '1985-03-15', '8', 'Bachelors', 'English', '0011', '0006', 'chuck@cisco', '2021-06-10'),
('0012', 'Mary', 'Johnson', '234-876-5432', 'mary@cisco.com', 'Milpitas, CA', '1990-11-22', '5', 'Bachelors', 'English', '0012', '0006', 'mary@cisco', '2023-04-01'),
('0013', 'Alice', 'Williams', '123-321-4321', 'alice.williams@example.com', 'Los Angeles, CA', '1995-05-10', '2', 'Bachelors', 'English', NULL, NULL, 'alice123', '2024-11-01'),
('0014', 'Brian', 'Taylor', '234-432-5432', 'brian.taylor@example.com', 'San Diego, CA', '1992-08-20', '3', 'Masters', 'English', NULL, NULL, 'brian123', '2024-11-01'),
('0015', 'Catherine', 'Johnson', '345-543-6543', 'catherine.johnson@example.com', 'Sacramento, CA', '1988-12-15', '4', 'Bachelors', 'English', NULL, NULL, 'catherine123', '2024-11-01');