-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase II: Create Table & Insert Statements [v0] Thursday, October 14, 2021 @ 2:00pm EDT

-- Team 36
-- Kirti Deepak Chhatlani (kchhatlani6)
-- Shreyash Gupta (sgupta755)
-- Dhruv Tukaram Karve (dkarve3)
-- Geetha Priyanka Yerradoddi (gyerradoddi3)

-- Directions:
-- Please follow all instructions for Phase II as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from an SQL Dump file.
-- This file must run without error for credit.

-- ------------------------------------------------------
-- CREATE TABLE STATEMENTS AND INSERT STATEMENTS BELOW
-- ------------------------------------------------------
DROP DATABASE IF EXISTS tourism; 
CREATE DATABASE IF NOT EXISTS tourism; 
USE tourism; 
  
-- Table structure for Accounts 

DROP TABLE IF EXISTS account; 
create table account (  
email varchar(50) not null,   
fname varchar(50) not null,  
lname varchar(50) null,  
passwords varchar(10) not null, 
PRIMARY KEY (email) 
)ENGINE=InnoDB; 

insert into account values
('mmoss1@travelagency.com', 'Mark', 'Moss', 'password1'),
('asmith@travelagency.com', 'Aviva', 'Smith', 'password2'),
('mscott22@gmail.com', 'Michael', 'Scott', 'password3'),
('arthurread@gmail.com', 'Arthur', 'Read', 'password4'),
('jwayne@gmail.com', 'John', 'Wayne', 'password5'),
('gburdell3@gmail.com', 'George', 'Burdell', 'password6'),
('mj23@gmail.com', 'Michael', 'Jordan', 'password7'),
('lebron6@gmail.com', 'Lebron', 'James', 'password8'),
('msmith5@gmail.com', 'Michael', 'Smith', 'password9'),
('ellie2@gmail.com', 'Ellie', 'Johnson', 'password10'),
('scooper3@gmail.com', 'Sheldon', 'Cooper', 'password11'),
('mgeller5@gmail.com', 'Monica', 'Geller', 'password12'),
('cbing10@gmail.com', 'Chandler', 'Bing', 'password13'),
('hwmit@gmail.com', 'Howard', 'Wolowitz', 'password14'),
('swilson@gmail.com', 'Samantha', 'Wilson', 'password16'),
('aray@tiktok.com', 'Addison', 'Ray', 'password17'),
('cdemilio@tiktok.com', 'Charlie', 'Demilio', 'password18'),
('bshelton@gmail.com', 'Blake', 'Shelton', 'password19'),
('lbryan@gmail.com', 'Luke', 'Bryan', 'password20'),
('tswift@gmail.com', 'Taylor', 'Swift', 'password21'),
('jseinfeld@gmail.com', 'Jerry', 'Seinfeld', 'password22'),
('maddiesmith@gmail.com', 'Madison', 'Smith', 'password23'),
('johnthomas@gmail.com', 'John', 'Thomas', 'password24'),
('boblee15@gmail.com', 'Bob', 'Lee', 'password25');


-- Table structure for Admin 

DROP TABLE IF EXISTS admin; 
CREATE TABLE admin ( 
email varchar(50) NOT NULL, 
PRIMARY KEY (email), 
CONSTRAINT admin_ibfk_1 FOREIGN KEY (email) REFERENCES account(email) 
) ENGINE=InnoDB; 

insert into admin values
('mmoss1@travelagency.com'),
('asmith@travelagency.com');

  
-- Table structure for clients 

DROP TABLE IF EXISTS client; 
CREATE TABLE client ( 
  email varchar(50) NOT NULL, 
  phone_number char(12) NOT NULL, 
  PRIMARY KEY (email), 
  UNIQUE KEY (phone_number),
  CONSTRAINT client_ibfk_1 FOREIGN KEY (email) REFERENCES account(email)  
) ENGINE=InnoDB; 

insert into client values
('mscott22@gmail.com', '555-123-4567'),
('arthurread@gmail.com', '555-234-5678'),
('jwayne@gmail.com', '555-345-6789'),
('gburdell3@gmail.com', '555-456-7890'),
('mj23@gmail.com', '555-567-8901'),
('lebron6@gmail.com', '555-678-9012'),
('msmith5@gmail.com', '555-789-0123'),
('ellie2@gmail.com', '555-890-1234'),
('scooper3@gmail.com', '678-123-4567'),
('mgeller5@gmail.com', '678-234-5678'),
('cbing10@gmail.com', '678-345-6789'),
('hwmit@gmail.com', '678-456-7890'),
('swilson@gmail.com', '770-123-4567'),
('aray@tiktok.com', '770-234-5678'),
('cdemilio@tiktok.com', '770-345-6789'),
('bshelton@gmail.com', '770-456-7890'),
('lbryan@gmail.com', '770-567-8901'),
('tswift@gmail.com', '770-678-9012'),
('jseinfeld@gmail.com', '770-789-0123'),
('maddiesmith@gmail.com', '770-890-1234'),
('johnthomas@gmail.com', '404-770-5555'),
('boblee15@gmail.com', '404-678-5555');


  
-- Table structure for owner 

DROP TABLE IF EXISTS owner;
CREATE TABLE owner (
  email varchar(50) NOT NULL, 
  PRIMARY KEY (email), 
  CONSTRAINT owner_ibfk_1 foreign key (email) REFERENCES client(email)  
) ENGINE=InnoDB; 

insert into owner values
('mscott22@gmail.com'),
('arthurread@gmail.com'),
('jwayne@gmail.com'),
('gburdell3@gmail.com'),
('mj23@gmail.com'),
('lebron6@gmail.com'),
('msmith5@gmail.com'),
('ellie2@gmail.com'),
('scooper3@gmail.com'),
('mgeller5@gmail.com'),
('cbing10@gmail.com'),
('hwmit@gmail.com');
  

-- Table structure for customers 

DROP TABLE IF EXISTS customer; 
CREATE TABLE customer ( 
  email varchar(50) NOT NULL, 
  ccnum varchar(19) NOT NULL, 
  cvv integer(3) NOT NULL, 
  exp_date date NOT NULL, 
  current_location varchar(50) NULL, 
  PRIMARY KEY (email), 
  UNIQUE KEY(ccnum),
  CONSTRAINT customer_ibfk_1 FOREIGN KEY (email) REFERENCES client(email)  
) ENGINE=InnoDB; 

insert into customer values
('scooper3@gmail.com', '6518 5559 7446 1663', 551, STR_TO_DATE('Feb 2024 01', '%b %Y %d'), NULL),
('mgeller5@gmail.com', '2328 5670 4310 1965', 644, STR_TO_DATE('Mar 2024 01', '%b %Y %d'), NULL),
('cbing10@gmail.com', '8387 9523 9827 9291', 201, STR_TO_DATE('Feb 2023 01', '%b %Y %d'), NULL),
('hwmit@gmail.com', '6558 8596 9852 5299', 102, STR_TO_DATE('Apr 2023 01', '%b %Y %d'), NULL),
('swilson@gmail.com', '9383 3212 4198 1836', 455, STR_TO_DATE('Aug 2022 01', '%b %Y %d'), NULL),
('aray@tiktok.com', '3110 2669 7949 5605', 744, STR_TO_DATE('Aug 2022 01', '%b %Y %d'), NULL),
('cdemilio@tiktok.com', '2272 3555 4078 4744', 606, STR_TO_DATE('Feb 2025 01', '%b %Y %d'), NULL),
('bshelton@gmail.com', '9276 7639 7883 4273', 862, STR_TO_DATE('Sep 2023 01', '%b %Y %d'), NULL),
('lbryan@gmail.com', '4652 3726 8864 3798', 258, STR_TO_DATE('May 2023 01', '%b %Y %d'), NULL),
('tswift@gmail.com', '5478 8420 4436 7471', 857, STR_TO_DATE('Dec 2024 01', '%b %Y %d'), NULL),
('jseinfeld@gmail.com', '3616 8977 1296 3372', 295, STR_TO_DATE('Jun 2022 01', '%b %Y %d'), NULL),
('maddiesmith@gmail.com', '9954 5698 6355 6952', 794, STR_TO_DATE('Jul 2022 01', '%b %Y %d'), NULL),
('johnthomas@gmail.com', '7580 3274 3724 5356', 269, STR_TO_DATE('Oct 2025 01', '%b %Y %d'), NULL),
('boblee15@gmail.com', '7907 3513 7161 4248', 858, STR_TO_DATE('Nov 2025 01', '%b %Y %d'), NULL);

-- Table structure for airline

DROP TABLE IF EXISTS airline;
CREATE TABLE airline (
  airline_name varchar(30) NOT NULL,
  rating decimal(2,1) DEFAULT NULL,
  PRIMARY KEY (airline_name)
) ENGINE=InnoDB;

insert into airline value
('Delta Airlines', 4.7),
('Southwest Airlines', 4.4),
('American Airlines', 4.6),
('United Airlines', 4.2),
('JetBlue Airways', 3.6),
('Spirit Airlines', 3.3),
('WestJet', 3.9),
('Interjet', 3.7);


-- Table structure for airport

DROP TABLE IF EXISTS airport;
CREATE TABLE airport (
  AirportID char(3) NOT NULL,
  airport_name varchar(50) not null,
  timezone char(3) not null,
  street varchar(20) not null,
  city char(50) not null,
  state char(3) not null,
  zip integer(5) not null,
  UNIQUE KEY (airport_name),
  UNIQUE KEY (street,city,state, zip),
  PRIMARY KEY (AirportID)
) ENGINE=InnoDB;


insert into airport values
('ATL', 'Atlanta Hartsfield Jackson Airport', 'EST', '6000 N Terminal Pkwy', 'Atlanta', 'GA', 30320),
('JFK', 'John F Kennedy International Airport', 'EST', '455 Airport Ave', 'Queens', 'NY', 11430),
('LGA', 'Laguardia Airport', 'EST', '790 Airport St', 'Queens', 'NY', 11371),
('LAX', 'Lost Angeles International Airport', 'PST', '1 World Way', 'Los Angeles', 'CA', 90045),
('SJC', 'Norman Y. Mineta San Jose International Airport', 'PST', '1702 Airport Blvd', 'San Jose', 'CA', 95110),
('ORD', 'O\'Hare International Airport', 'CST', '10000 W O\'Hare Ave', 'Chicago', 'IL', 60666),
('MIA', 'Miami International Airport', 'EST', '2100 NW 42nd Ave', 'Miami', 'FL', 33126),
('DFW', 'Dallas International Airport', 'CST', '2400 Aviation DR', 'Dallas', 'TX', 75261);


-- Table structure for property

DROP TABLE IF EXISTS property;
CREATE TABLE property (
email varchar(50) not null,
name varchar(30) not null,
description varchar(100) DEFAULT NULL,
street varchar(20) not null,
city char(10)  not null,
state char(3) not null,
zip integer(5) not null,
capacity integer(3) not null,
cost_per_night integer(4) not null,
PRIMARY KEY (email, name),
UNIQUE KEY (street, city, state, zip),
CONSTRAINT property_ibfk_1 FOREIGN KEY (email) REFERENCES owner(email)
)ENGINE=InnoDB;

insert into property values
('scooper3@gmail.com', 'Atlanta Great Property', 'This is right in the middle of Atlanta near many attractions!', '2nd St', 'ATL', 'GA', 30008, 4, 600),
('gburdell3@gmail.com', 'House near Georgia Tech', 'Super close to bobby dodde stadium!', 'North Ave', 'ATL', 'GA', 30008, 3, 275),
('cbing10@gmail.com', 'New York City Property', 'A view of the whole city. Great property!', '123 Main St', 'NYC', 'NY', 10008, 2, 750),
('mgeller5@gmail.com', 'Statue of Libery Property', 'You can see the statue of liberty from the porch', '1st St', 'NYC', 'NY', 10009, 5, 1000),
('arthurread@gmail.com', 'Los Angeles Property', '', '10th St', 'LA', 'CA', 90008, 3, 700),
('arthurread@gmail.com', 'LA Kings House', 'This house is super close to the LA kinds stadium!', 'Kings St', 'La', 'CA', 90011, 4, 750),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Huge house that can sleep 12 people. Totally worth it!', 'Golden Bridge Pkwt', 'San Jose', 'CA', 90001, 12, 900),
('lebron6@gmail.com', 'LA Lakers Property', 'This house is right near the LA lakers stadium. You might even meet Lebron James!', 'Lebron Ave', 'LA', 'CA', 90011, 4, 850),
('hwmit@gmail.com', 'Chicago Blackhawks House', 'This is a great property!', 'Blackhawks St', 'Chicago', 'IL', 60176, 3, 775),
('mj23@gmail.com', 'Chicago Romantic Getaway', 'This is a great property!', '23rd Main St', 'Chicago', 'IL', 60176, 2, 1050),
('msmith5@gmail.com', 'Beautiful Beach Property', 'You can walk out of the house and be on the beach!', '456 Beach Ave', 'Miami', 'FL', 33101, 2, 975),
('ellie2@gmail.com', 'Family Beach House', 'You can literally walk onto the beach and see it from the patio!', '1132 Beach Ave', 'Miami', 'FL', 33101, 6, 850),
('mscott22@gmail.com', 'Texas Roadhouse', 'This property is right in the center of Dallas, Texas!', '17th Street', 'Dallas', 'TX', 75043, 3, 450),
('mscott22@gmail.com', 'Texas Longhorns House', 'You can walk to the longhorns stadium from here!', '1125 Longhorns Way', 'Dallas', 'TX', 75001, 10, 600);

-- Table structure for flight

DROP TABLE IF EXISTS flight;
CREATE TABLE flight (
name varchar(50) not null,
flight_num integer(2) not null,
departure_time time(0) not null,
arrival_time time(0) not null,
travel_date date not null,
cost_per_seat integer(3) not null,
capacity integer(3) not null,
from_airport char(3) not null,
to_airport char(3) not null,
PRIMARY KEY (name,flight_num),
CONSTRAINT flight_ibfk_1 FOREIGN KEY (name) REFERENCES airline(airline_name),
CONSTRAINT flight_ibfk_2 FOREIGN KEY (from_airport) REFERENCES airport(AirportID),
CONSTRAINT flight_ibfk_3 FOREIGN KEY (to_airport) REFERENCES airport(AirportID)
)ENGINE=InnoDB;

insert into flight values
('Delta Airlines', 1, ' 10:00', ' 12:00', '2021-10-18', 400, 150, 'ATL', 'JFK'),
('Southwest Airlines', 2, ' 10:30', ' 14:30', '2021-10-18', 350, 125, 'ORD', 'MIA'),
( 'American Airlines', 3, ' 13:00', ' 16:00', '2021-10-18', 350, 125, 'MIA', 'DFW'),
( 'United Airlines', 4, ' 16:30', ' 18:30', '2021-10-18', 400, 100, 'ATL', 'LGA'),
( 'JetBlue Airways',5, ' 11:00', ' 13:00', '2021-10-19', 400, 130, 'LGA', 'ATL'),
('Spirit Airlines', 6,  ' 12:30', ' 21:30', '2021-10-19', 650, 140, 'SJC', 'ATL'),
( 'WestJet',7, ' 13:00', ' 16:00', '2021-10-19', 700, 100, 'LGA', 'SJC'),
('Interjet', 8,  ' 19:30', ' 21:30', '2021-10-19', 350, 125, 'MIA', 'ORD'),
('Delta Airlines', 9,  ' 8:00', ' 10:00', '2021-10-20', 375, 150, 'JFK', 'ATL'),
( 'Delta Airlines', 10, ' 9:15', ' 18:15', '2021-10-20', 700, 110, 'LAX', 'ATL'),
('Southwest Airlines',11,  '12:07', ' 19:07', '2021-10-20', 600, 95, 'LAX', 'ORD'),
( 'United Airlines', 12, ' 15:35', ' 17:35', '2021-10-20', 275, 115, 'MIA', 'ATL');


DROP TABLE IF EXISTS Rates;
CREATE TABLE Rates (
  Owner_email varchar(50) NOT NULL,
  Customer_email varchar(50) NOT NULL,
  Score integer(1) DEFAULT NULL,
  PRIMARY KEY (Owner_email,Customer_email),
  CONSTRAINT Rates_ibfk_1 FOREIGN KEY (Owner_email) REFERENCES owner (email),
  CONSTRAINT Rates_ibfk_2 FOREIGN KEY (Customer_email) REFERENCES customer (email)
) ENGINE=InnoDB;

insert into Rates values
('gburdell3@gmail.com','swilson@gmail.com',5),
('cbing10@gmail.com','aray@tiktok.com',5),
('mgeller5@gmail.com','bshelton@gmail.com',3),
('arthurread@gmail.com','lbryan@gmail.com',4),
('arthurread@gmail.com','tswift@gmail.com',4),
('lebron6@gmail.com','jseinfeld@gmail.com',1),
('hwmit@gmail.com','maddiesmith@gmail.com',2);


DROP TABLE IF EXISTS is_rated_by;
CREATE TABLE is_rated_by (
  Owner_email varchar(50) NOT NULL,
  Customer_email varchar(50) NOT NULL,
  Score integer(1) DEFAULT NULL,
  PRIMARY KEY (Owner_email,Customer_email),
  CONSTRAINT is_rated_by_ibfk_1 FOREIGN KEY (Owner_email) REFERENCES owner (email),
  CONSTRAINT is_rated_by_ibfk_2 FOREIGN KEY (Customer_email) REFERENCES customer (email)
) ENGINE=InnoDB;

insert into is_rated_by values
('gburdell3@gmail.com','swilson@gmail.com',5),
('cbing10@gmail.com','aray@tiktok.com',5),
('mgeller5@gmail.com','bshelton@gmail.com',4),
('arthurread@gmail.com','lbryan@gmail.com',4),
('arthurread@gmail.com','tswift@gmail.com',3),
('lebron6@gmail.com','jseinfeld@gmail.com',2),
('hwmit@gmail.com','maddiesmith@gmail.com',5);



DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
  Customer_email varchar(50) NOT NULL,
  Owner_email varchar(50) NOT NULL,
  property_name varchar(50) NOT NULL,
  content varchar(300) DEFAULT NULL,
  Score integer(1) DEFAULT NULL,
  PRIMARY KEY (Customer_email,Owner_email,property_name),
  CONSTRAINT Review_by_ibfk_1 FOREIGN KEY (Customer_email) REFERENCES customer (email),
  CONSTRAINT Review_ibfk_2 FOREIGN KEY (Owner_email, property_name) REFERENCES property (email, name)
) ENGINE=InnoDB;

insert into Review values
('swilson@gmail.com','gburdell3@gmail.com','House near Georgia Tech','This was so much fun. I went and saw the coke factory, the falcons play, GT play, and the Georgia aquarium. Great time! Would highly recommend!',5),
('aray@tiktok.com','cbing10@gmail.com','New York City Property','This was the best 5 days ever! I saw so much of NYC!',5),
('bshelton@gmail.com','mgeller5@gmail.com','Statue of Libery Property','This was truly an excellent experience. I really could see the Statue of Liberty from the property!',4),
('lbryan@gmail.com','arthurread@gmail.com','Los Angeles Property','I had an excellent time!',4),
('tswift@gmail.com','arthurread@gmail.com','Beautiful San Jose Mansion','We had a great time, but the house wasn\'t fully cleaned when we arrived',3),
('jseinfeld@gmail.com','lebron6@gmail.com','LA Lakers Property','I was disappointed that I did not meet lebron james',2),
('maddiesmith@gmail.com','hwmit@gmail.com','Chicago Blackhawks House','This was awesome! I met one player on the chicago blackhawks!',5);




DROP TABLE IF EXISTS Reserve;
CREATE TABLE Reserve (
  Customer_email varchar(50) NOT NULL,
  Owner_email varchar(50) NOT NULL,
  property_name varchar(50) NOT NULL,
  start_date date NOT NULL,
  end_date date DEFAULT NULL,
  num_guests integer(3) NOT NULL,
  PRIMARY KEY (Customer_email,Owner_email,property_name),
  CONSTRAINT Reserve_ibfk_1 FOREIGN KEY (Customer_email) REFERENCES customer (email),
  CONSTRAINT Reserve_ibfk_2 FOREIGN KEY (Owner_email, property_name) REFERENCES property (email, name)
) ENGINE=InnoDB;

insert into reserve values
('swilson@gmail.com', 'gburdell3@gmail.com', 'House near Georgia Tech', '2021-10-19', '2021-10-25', 3),
('aray@tiktok.com', 'cbing10@gmail.com', 'New York City Property', '2021-10-18', '2021-10-23', 2),
('cdemilio@tiktok.com', 'cbing10@gmail.com', 'New York City Property', '2021-10-24', '2021-10-30', 2),
('bshelton@gmail.com', 'mgeller5@gmail.com', 'Statue of Libery Property', '2021-10-18', '2021-10-22', 4),
('lbryan@gmail.com', 'arthurread@gmail.com', 'Los Angeles Property', '2021-10-19', '2021-10-25', 2),
('tswift@gmail.com', 'arthurread@gmail.com', 'Beautiful San Jose Mansion', '2021-10-19', '2021-10-22', 10),
('jseinfeld@gmail.com', 'lebron6@gmail.com', 'LA Lakers Property', '2021-10-19', '2021-10-24', 4),
('maddiesmith@gmail.com', 'hwmit@gmail.com', 'Chicago Blackhawks House', '2021-10-19', '2021-10-23', 2),
('aray@tiktok.com', 'mj23@gmail.com', 'Chicago Romantic Getaway', '2021-11-01', '2021-11-07', 2),
('cbing10@gmail.com', 'msmith5@gmail.com', 'Beautiful Beach Property', '2021-10-18', '2021-10-25', 2),
('hwmit@gmail.com', 'ellie2@gmail.com', 'Family Beach House', '2021-10-18', '2021-10-28', 5);



DROP TABLE IF EXISTS is_close_to;
CREATE TABLE is_close_to (
  Owner_email varchar(50) NOT NULL,	
  property_name varchar(50) NOT NULL,
  AirportID char(3) NOT NULL,
  distance_in_miles integer(3) NOT NULL,
  PRIMARY KEY (AirportID, Owner_email, property_name),
  CONSTRAINT is_close_to_ibfk_1 FOREIGN KEY (AirportID) REFERENCES airport (AirportID),
  CONSTRAINT is_close_to_ibfk_2 FOREIGN KEY (Owner_email, property_name) REFERENCES property (email, name)
) ENGINE=InnoDB;

insert into is_close_to values
('scooper3@gmail.com', 'Atlanta Great Property', 'ATL', 12),
('gburdell3@gmail.com', 'House near Georgia Tech', 'ATL', 7),
('cbing10@gmail.com', 'New York City Property', 'JFK', 10),
('mgeller5@gmail.com', 'Statue of Libery Property', 'JFK', 8),
('cbing10@gmail.com', 'New York City Property', 'LGA', 25),
('mgeller5@gmail.com', 'Statue of Libery Property', 'LGA', 19),
('arthurread@gmail.com', 'Los Angeles Property', 'LAX', 9),
('arthurread@gmail.com', 'LA Kings House', 'LAX', 12),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'SJC', 8),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'LAX', 30),
('lebron6@gmail.com', 'LA Lakers Property', 'LAX', 6),
('hwmit@gmail.com', 'Chicago Blackhawks House', 'ORD', 11),
('mj23@gmail.com', 'Chicago Romantic Getaway', 'ORD', 13),
('msmith5@gmail.com', 'Beautiful Beach Property', 'MIA', 21),
('ellie2@gmail.com', 'Family Beach House', 'MIA', 19),
('mscott22@gmail.com', 'Texas Roadhouse', 'DFW', 8),
('mscott22@gmail.com', 'Texas Longhorns House', 'DFW', 17);



DROP TABLE IF EXISTS book;
CREATE TABLE book (
  Customer_email varchar(50) NOT NULL,
  flight_name varchar(50) NOT NULL,
  flight_num integer(20) NOT NULL,
  num_seats integer (20) NOT NULL,
  PRIMARY KEY (Customer_email,flight_name, flight_num),
  CONSTRAINT book_ibfk_1 FOREIGN KEY (Customer_email) REFERENCES Customer (email),
  CONSTRAINT book_ibfk_2 FOREIGN KEY (flight_name, flight_num) REFERENCES flight (name,flight_num)
) ENGINE=InnoDB;

insert into book values
('swilson@gmail.com', 'JetBlue Airways', 5, 3),
('aray@tiktok.com', 'Delta Airlines', 1, 2),
('bshelton@gmail.com', 'United Airlines', 4, 4),
('lbryan@gmail.com', 'WestJet', 7, 2),
('tswift@gmail.com', 'WestJet', 7, 2),
('jseinfeld@gmail.com', 'WestJet', 7, 4),
('maddiesmith@gmail.com', 'Interjet', 8, 2),
('cbing10@gmail.com', 'Southwest Airlines', 2, 2),
('hwmit@gmail.com', 'Southwest Airlines', 2, 5);


DROP TABLE IF EXISTS Prop_amentities;
CREATE TABLE Prop_amentities (
  email varchar(50) NOT NULL,
  property_name varchar(50) NOT NULL,
  amenity_name varchar(100) NOT NULL,
  PRIMARY KEY (email, property_name, amenity_name),
  CONSTRAINT Prop_amentities_ibfk_1 FOREIGN KEY (email, property_name) REFERENCES property (email, name)
) ENGINE=InnoDB;

insert into prop_amentities values
('scooper3@gmail.com', 'Atlanta Great Property', 'A/C & Heating'),
('scooper3@gmail.com', 'Atlanta Great Property', 'Pets allowed'),
('scooper3@gmail.com', 'Atlanta Great Property', 'Wifi & TV'),
('scooper3@gmail.com', 'Atlanta Great Property', 'Washer and Dryer'),
('gburdell3@gmail.com', 'House near Georgia Tech', 'Wifi & TV'),
('gburdell3@gmail.com', 'House near Georgia Tech', 'Washer and Dryer'),
('gburdell3@gmail.com', 'House near Georgia Tech', 'Full Kitchen'),
('cbing10@gmail.com', 'New York City Property', 'A/C & Heating'),
('cbing10@gmail.com', 'New York City Property', 'Wifi & TV'),
('mgeller5@gmail.com', 'Statue of Libery Property', 'A/C & Heating'),
('mgeller5@gmail.com', 'Statue of Libery Property', 'Wifi & TV'),
('arthurread@gmail.com', 'Los Angeles Property', 'A/C & Heating'),
('arthurread@gmail.com', 'Los Angeles Property', 'Pets allowed'),
('arthurread@gmail.com', 'Los Angeles Property', 'Wifi & TV'),
('arthurread@gmail.com', 'LA Kings House', 'A/C & Heating'),
('arthurread@gmail.com', 'LA Kings House', 'Wifi & TV'),
('arthurread@gmail.com', 'LA Kings House', 'Washer and Dryer'),
('arthurread@gmail.com', 'LA Kings House', 'Full Kitchen'),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'A/C & Heating'),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Pets allowed'),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Wifi & TV'),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Washer and Dryer'),
('arthurread@gmail.com', 'Beautiful San Jose Mansion', 'Full Kitchen'),
('lebron6@gmail.com', 'LA Lakers Property', 'A/C & Heating'),
('lebron6@gmail.com', 'LA Lakers Property', 'Wifi & TV'),
('lebron6@gmail.com', 'LA Lakers Property', 'Washer and Dryer'),
('lebron6@gmail.com', 'LA Lakers Property', 'Full Kitchen'),
('hwmit@gmail.com', 'Chicago Blackhawks House', 'A/C & Heating'),
('hwmit@gmail.com', 'Chicago Blackhawks House', 'Wifi & TV'),
('hwmit@gmail.com', 'Chicago Blackhawks House', 'Washer and Dryer'),
('hwmit@gmail.com', 'Chicago Blackhawks House', 'Full Kitchen'),
('mj23@gmail.com', 'Chicago Romantic Getaway', 'A/C & Heating'),
('mj23@gmail.com', 'Chicago Romantic Getaway', 'Wifi & TV'),
('msmith5@gmail.com', 'Beautiful Beach Property', 'A/C & Heating'),
('msmith5@gmail.com', 'Beautiful Beach Property', 'Wifi & TV'),
('msmith5@gmail.com', 'Beautiful Beach Property', 'Washer and Dryer'),
('ellie2@gmail.com', 'Family Beach House', 'A/C & Heating'),
('ellie2@gmail.com', 'Family Beach House', 'Pets allowed'),
('ellie2@gmail.com', 'Family Beach House', 'Wifi & TV'),
('ellie2@gmail.com', 'Family Beach House', 'Washer and Dryer'),
('ellie2@gmail.com', 'Family Beach House', 'Full Kitchen'),
('mscott22@gmail.com', 'Texas Roadhouse', 'A/C & Heating'),
('mscott22@gmail.com', 'Texas Roadhouse', 'Pets allowed'),
('mscott22@gmail.com', 'Texas Roadhouse', 'Wifi & TV'),
('mscott22@gmail.com', 'Texas Roadhouse', 'Washer and Dryer'),
('mscott22@gmail.com', 'Texas Longhorns House', 'A/C & Heating'),
('mscott22@gmail.com', 'Texas Longhorns House', 'Pets allowed'),
('mscott22@gmail.com', 'Texas Longhorns House', 'Wifi & TV'),
('mscott22@gmail.com', 'Texas Longhorns House', 'Washer and Dryer'),
('mscott22@gmail.com', 'Texas Longhorns House', 'Full Kitchen');


-- Table structure for attractions

DROP TABLE IF EXISTS attractions;
CREATE TABLE attractions (
  AirportID char(3) NOT NULL,
  attraction_name varchar(100) not null,
  PRIMARY KEY (AirportID, attraction_name),
  CONSTRAINT attractions_ibfk_1 FOREIGN KEY (AirportID) REFERENCES airport(AirportID)
) ENGINE=InnoDB;

insert into attractions values
('ATL', 'The Coke Factory'),
('ATL', 'The Georgia Aquarium'),
('JFK', 'The Statue of Liberty'),
('JFK', 'The Empire State Building'),
('LGA', 'The Statue of Liberty'),
('LGA', 'The Empire State Building'),
('LAX', 'Lost Angeles Lakers Stadium'),
('LAX', 'Los Angeles Kings Stadium'),
('SJC', 'Winchester Mystery House'),
('SJC', 'San Jose Earthquakes Soccer Team'),
('ORD', 'Chicago Blackhawks Stadium'),
('ORD', 'Chicago Bulls Stadium');



