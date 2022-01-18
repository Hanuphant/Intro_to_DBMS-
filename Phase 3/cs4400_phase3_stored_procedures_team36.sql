-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase III: Stored Procedures & Views [v0] Tuesday, November 9, 2021 @ 12:00am EDT
-- Team 36
-- Kirti Deepak Chhatlani(kchhatlani6)
-- Shreyash Gupta(sgupta755)
-- Dhruv Tukaram Karve(dkarve3)
-- Geetha Priyanka Yerradoddi(gyerradoddi3)
-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names and GT usernames for all members above.


-- ID: 1a
-- Name: register_customer
drop procedure if exists register_customer;
delimiter //
create procedure register_customer (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12),
    in i_cc_number varchar(19),
    in i_cvv char(3),
    in i_exp_date date,
    in i_location varchar(50)
) 
sp_main: begin

if not exists (select Email from accounts where Email = i_email) 
and not exists (select Email from clients where Email = i_email) 
and not exists (select Phone_Number from clients where Phone_Number = i_phone_number) 
and not exists (select CcNumber from customer where CcNumber = i_cc_number) then
    insert into accounts (Email, First_Name, Last_Name, Pass) values (i_email,i_first_name,i_last_name,i_password);
    insert into clients (Email, Phone_Number) values (i_email,i_phone_number);
    insert into customer (Email, CcNumber, Cvv, Exp_Date, Location) values (i_email,i_cc_number,i_cvv,i_exp_date,i_location);
end if;
if exists (select Email from accounts where Email = i_email) 
and exists (select Email from clients where Email = i_email) 
and exists (select * from owners where Email = i_email) 
and not exists(select * from customer where Email = i_email) 
and not exists (select CcNumber from customer where CcNumber = i_cc_number) then
    insert into customer (Email, CcNumber, Cvv, Exp_Date, Location) values (i_email,i_cc_number,i_cvv,i_exp_date,i_location);
end if;

end //
delimiter ;


-- ID: 1b
-- Name: register_owner
drop procedure if exists register_owner;
delimiter //
create procedure register_owner (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12)
) 
sp_main: begin

if not exists(select Email from accounts where Email=i_email) 
and not exists(select Email from clients where Email=i_email) 
and not exists (select Phone_Number from clients where Phone_Number=i_phone_number) then
    insert into accounts (Email, First_Name, Last_Name, Pass) values (i_email,i_first_name,i_last_name,i_password);
    insert into clients (Email, Phone_Number) values (i_email,i_phone_number) ;
    insert into owners (Email) values (i_email);
end if;

if exists (select Email from accounts where Email=i_email) 
and exists (select Phone_Number from clients where Phone_Number = i_phone_number) 
and not exists (select Email from owners where Email = i_email) then
    insert into owners (Email) values (i_email);
end if;

end //
delimiter ;


-- ID: 1c
-- Name: remove_owner
drop procedure if exists remove_owner;
delimiter //
create procedure remove_owner ( 
    in i_owner_email varchar(50)
)
sp_main: begin

if not exists (select * from property where Owner_Email = i_owner_email) then
	delete from owners where Email = i_owner_email;
	if not exists (select * from customer where Email = i_owner_email) then
    	delete from clients where Email = i_owner_email;
    	delete from accounts where Email = i_owner_email;
	end if;
	delete from customers_rate_owners where Owner_Email = i_owner_email;
	delete from owners_rate_customers where Owner_Email = i_owner_email;
end if;


end //
delimiter ;


-- ID: 2a
-- Name: schedule_flight
drop procedure if exists schedule_flight;
delimiter //
create procedure schedule_flight (
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_from_airport char(3),
    in i_to_airport char(3),
    in i_departure_time time,
    in i_arrival_time time,
    in i_flight_date date,
    in i_cost decimal(6, 2),
    in i_capacity int,
    in i_current_date date
)
sp_main: begin

	if(i_airline_name not in (select Airline_Name from airline))
    then leave sp_main; end if;
    
    if(concat(i_flight_num,i_airline_name) in (select concat(Flight_Num, Airline_Name) from flight))
    then leave sp_main; end if;
    
	if not i_from_airport=i_to_airport and i_flight_date>i_current_date then
    	insert into flight (Flight_Num, Airline_Name, From_Airport, To_Airport, Departure_Time, Arrival_Time, Flight_Date, Cost, Capacity) values (i_flight_num,i_airline_name,i_from_airport,i_to_airport,i_departure_time,i_arrival_time,i_flight_date,i_cost,i_capacity);
	end if;


end //
delimiter ;


-- ID: 2b
-- Name: remove_flight
drop procedure if exists remove_flight;
delimiter //
create procedure remove_flight ( 
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
) 
sp_main: begin

delete from book where Flight_Num=i_flight_num and Airline_Name=i_airline_name;
delete from flight where Flight_Num=i_flight_num and Flight_Date >= i_current_date and Airline_Name=i_airline_name;



end //
delimiter ;


-- ID: 3a
-- Name: book_flight
drop procedure if exists book_flight;
delimiter //
create procedure book_flight (
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_num_seats int,
    in i_current_date date
)
sp_main: begin

if i_num_seats <= (select num_empty_seats from view_flight where flight_id = i_flight_num and airline = i_airline_name) then
	if i_current_date < (select flight_date from flight where Flight_Num = i_flight_num and Airline_Name = i_airline_name) then
    	if not exists (select * from book where Airline_Name = i_airline_name and Flight_Num = i_flight_num and Customer = i_customer_email) then
        	if not exists (select Was_Cancelled from book where Customer = i_customer_email and Was_Cancelled = 0) then # and Query for multiple bookings in one day
            	insert into book (Customer, Flight_Num, Airline_Name, Num_Seats, Was_Cancelled)
            	values (i_customer_email, i_flight_num, i_airline_name, i_num_seats, 0);
					
        	end if;
    	else
        	if (select Was_Cancelled FROM book WHERE Airline_Name=i_airline_name and Flight_Num=i_flight_num and Customer = i_customer_email) = 0 then
            	update book
                	set Num_Seats = Num_Seats + i_num_seats
                	where Flight_Num = i_flight_num and Airline_Name = i_airline_name and Customer = i_customer_email;
            	
        	end if;
    	end if;
	end if;
end if;

end //
delimiter ;

-- ID: 3b
-- Name: cancel_flight_booking
drop procedure if exists cancel_flight_booking;
delimiter //
create procedure cancel_flight_booking ( 
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
)
sp_main: begin

if exists (select Customer from book where Customer = i_customer_email) then
	if i_current_date < (select flight_date from flight where Flight_Num = i_flight_num and Airline_Name = i_airline_name) then
    	update book
        	set Was_Cancelled = 1
    	where Customer = i_customer_email and Flight_Num = i_flight_num and Airline_Name = i_airline_name;
	end if;
end if;


end //
delimiter ;


-- ID: 3c
-- Name: view_flight
create or replace view view_flight (
    flight_id,
    flight_date,
    airline,
    destination,
    seat_cost,
    num_empty_seats,
    total_spent
) as

SELECT 
	flight.Flight_Num as flight_id, 
    Flight_Date as flight_date, 
    flight.Airline_Name as airline, 
    flight.To_Airport as destination, 
    flight.Cost as seat_cost, 
    (flight.Capacity - ifnull(sum(book.num_seats * if(book.was_cancelled, 0, 1)), 0)) as num_empty_seats, 
    ifnull(sum(flight.cost * book.num_seats * if(book.was_cancelled, 0.2, 1)), 0) as total_spent 
FROM flight 
left outer join book on flight.Flight_Num = book.Flight_Num and flight.airline_name = book.airline_name
group by flight.flight_num, flight.airline_name;



-- ID: 4a
-- Name: add_property
drop procedure if exists add_property;
delimiter //
create procedure add_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_description varchar(500),
    in i_capacity int,
    in i_cost decimal(6, 2),
    in i_street varchar(50),
    in i_city varchar(50),
    in i_state char(2),
    in i_zip char(5),
    in i_nearest_airport_id char(3),
    in i_dist_to_airport int
) 
sp_main: begin

if (i_owner_email not in (select Email from owners))
then leave sp_main; end if;
if not exists (select * from property where Street = i_street and City = i_city and State = i_state and Zip = i_zip) then
	if not exists (select * from property where Property_Name = i_property_name and Owner_Email = i_owner_email) then
    	insert into property (Property_Name, Owner_Email, Descr, Capacity, Cost, Street, City, State, Zip)
                	values (i_property_name,i_owner_email,i_description,i_capacity,i_cost,i_street,i_city,i_state,i_zip);

    	if i_nearest_airport_id is not null then
        	if exists (select Airport_Id from airport where Airport_Id = i_nearest_airport_id) then
            	insert into is_close_to (Property_Name, Owner_Email, Airport, Distance)
                	values (i_property_name,i_owner_email,i_nearest_airport_id,i_dist_to_airport);

        	end if;
    	end if;
	end if;
end if;

  
end //
delimiter ;


-- ID: 4b
-- Name: remove_property
drop procedure if exists remove_property;
delimiter //
create procedure remove_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_current_date date
)
sp_main: begin

if (i_property_name in (SELECT property.Property_Name
FROM property
    NATURAL LEFT JOIN reserve 
WHERE reserve.Property_Name IS NULL))
then 
	delete from amenity where Property_Name = i_property_name and Property_Owner = i_owner_email;
	delete from is_close_to where Property_Name = i_property_name and Owner_Email = i_owner_email;
	delete from property where Owner_Email = i_owner_email and Property_Name = i_property_name;
else 

	if (select count(*) from reserve where Owner_Email = i_owner_email and Property_Name = i_property_name and Was_Cancelled = 1)> 0 
			then set @y = (select count(*) from reserve where 
			Owner_Email = i_owner_email and Property_Name = i_property_name and Was_Cancelled = 1);
	end if;

	if ((select count(*) from reserve 
		where (i_current_date < Start_Date or i_current_date > End_date) and 
		(Property_Name = i_property_name and Owner_Email = i_owner_email and Was_Cancelled = 0)) > 0)
		then set @x =(select count(*) from reserve 
						where (i_current_date < Start_Date or i_current_date > End_date) and 
						(Property_Name = i_property_name and Owner_Email = i_owner_email and Was_Cancelled = 0));
	end if;
	set @z = (@x + @y);

	if ( @z = (select count(*) from reserve where Property_Name = i_property_name and Owner_Email = i_owner_email))
	then 
		delete from amenity where Property_Name = i_property_name and Property_Owner = i_owner_email;
		delete from is_close_to where Property_Name = i_property_name and Owner_Email = i_owner_email;
		delete from reserve where Property_Name = i_property_name and Owner_Email = i_owner_email;
		delete from property where Owner_Email = i_owner_email and Property_Name = i_property_name;
	else leave sp_main;
	end if;
end if;
    
end //
delimiter ;

-- ID: 5a
-- Name: reserve_property
drop procedure if exists reserve_property;
delimiter //
create procedure reserve_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_start_date date,
    in i_end_date date,
    in i_num_guests int,
    in i_current_date date
)
sp_main: begin

if (i_start_date < i_current_date)
		then leave sp_main; end if;

if (i_customer_email in (select Customer from reserve))
		then if ((select count(*) from reserve where Customer = i_customer_email) != (select count(*) from (select * from reserve where Customer = i_customer_email) as t where i_end_date < Start_Date or i_start_date > End_Date))
			then leave sp_main; end if; end if;

set @a = (select sum(Num_Guests) from reserve where Property_Name = i_property_name and Was_Cancelled = 0 and (Start_Date <= i_start_date) and (i_start_date<= End_Date));
if (@a is null) then set @a = 0; end if;

set @a1 = (select sum(Num_Guests) from reserve where Property_Name = i_property_name and Was_Cancelled = 0 and (i_start_date <= Start_Date) and (Start_Date<= i_end_date));
if (@a1 is null) then set @a1 = 0; end if;

set @b = (select sum(Num_Guests) from reserve where Property_Name = i_property_name and Was_Cancelled = 0 and (Start_Date <= i_end_date) and (i_end_date <= End_Date));
if (@b is null) then set @b = 0; end if;

set @b1 = (select sum(Num_Guests) from reserve where Property_Name = i_property_name and Was_Cancelled = 0 and(i_start_date <= End_Date) and (End_Date <= i_end_date));
if (@b1 is null) then set @b1 = 0; end if;

set @c = (select Capacity from property where Property_Name =  i_property_name);
set @max = (SELECT 0.5 * ((@a + @b) + ABS(@a - @b)));
set @max1 = (SELECT 0.5 * ((@a1 + @b1) + ABS(@a1 - @b1)));
set @cap  = @c - (SELECT 0.5 * ((@max + @max1) + ABS(@max - @max1)));

if( @cap >= i_num_guests)
	then insert into reserve values(i_property_name, i_owner_email, i_customer_email, i_start_date, i_end_date, i_num_guests, 0);
	else leave sp_main; end if;

end //
delimiter ;


	-- ID: 5b
	-- Name: cancel_property_reservation
	drop procedure if exists cancel_property_reservation;
	delimiter //
	create procedure cancel_property_reservation (
		in i_property_name varchar(50),
		in i_owner_email varchar(50),
		in i_customer_email varchar(50),
		in i_current_date date
	)
	sp_main: begin

	 if ((select Start_Date from reserve where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email) < i_current_date)
			then leave sp_main; end if;

	update reserve
	set Was_Cancelled = 1
	where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email;

	end //
	delimiter ;


-- ID: 5c
-- Name: customer_review_property
drop procedure if exists customer_review_property;
delimiter //
create procedure customer_review_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_content varchar(500),
    in i_score int,
    in i_current_date date
)
sp_main: begin

if ( select count(*) from review where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email is not null)
	then leave sp_main; end if;

if ((select Was_Cancelled from reserve
	where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email) = 1)
    then leave sp_main; end if;

if((select Start_Date from reserve
where Property_Name = i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email) > i_current_date)
	then leave sp_main; end if;

insert into review values (i_property_name, i_owner_email, i_customer_email,i_content, i_score);
    
end //
delimiter ;


-- ID: 5d
-- Name: view_properties
create or replace view view_properties (
    property_name, 
    average_rating_score, 
    description, 
    address, 
    capacity, 
    cost_per_night
) as
SELECT property.Property_Name as property_name, avg(Score) as average_rating_score, Descr as description, concat(Street,', ', City,', ', State,', ', Zip) as address, Capacity as capacity, Cost as cost_per_night 
FROM property left outer join review on property.Property_name = review.Property_Name
group by property_name;



-- ID: 5e
-- Name: view_individual_property_reservations
drop procedure if exists view_individual_property_reservations;
delimiter //
create procedure view_individual_property_reservations (
    in i_property_name varchar(50),
    in i_owner_email varchar(50)
)
sp_main: begin
    drop table if exists view_individual_property_reservations;
    create table view_individual_property_reservations (
        property_name varchar(50),
        start_date date,
        end_date date,
        customer_email varchar(50),
        customer_phone_num char(12),
        total_booking_cost decimal(6,2),
        rating_score int,
        review varchar(500)
    ) as
	select Property_Name,Start_Date, End_Date, Customer as Customer_Email, Phone_Number as Customer_Phone_num,
	(DATEDIFF(End_Date, Start_Date)+1)*Cost as Total_Booking_Cost,
    Score as Rating_Score, Content as Review from 
	(select * from (select * from reserve natural join property) as t join clients on Email = Customer) as w NATURAL LEFT OUTER JOIN review
	where  Property_Name = i_property_name and Owner_Email = i_owner_email;
    
    update view_individual_property_reservations
    set Total_Booking_Cost = 0.2*Total_Booking_Cost
    where Customer_Email in (select Customer from reserve where Was_Cancelled = 1)
    and Property_Name in (select  Property_Name from reserve where Was_Cancelled = 1)
    and Start_Date in (select Start_Date from reserve where Was_Cancelled = 1)
    and End_Date in (select End_Date from reserve where Was_Cancelled = 1); 

end //
delimiter ;


-- ID: 6a
-- Name: customer_rates_owner
drop procedure if exists customer_rates_owner;
delimiter //
create procedure customer_rates_owner (
    in i_customer_email varchar(50),
    in i_owner_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin

if (select count(*) from Customers_Rate_Owners where Owner_Email = i_owner_email and Customer = i_customer_email) > 0
then leave sp_main; end if; 

if 0 not in (select Was_Cancelled from reserve 
where Owner_Email = i_owner_email and Customer = i_customer_email)
then leave sp_main; end if;

if (select count(*) from (select Start_Date from reserve 
where Owner_Email = i_owner_email and Customer = i_customer_email) as t where i_current_date >= Start_Date) = 0
then leave sp_main; end if;

insert into Customers_Rate_Owners value (i_customer_email,i_owner_email,i_score);


end //
delimiter ;


-- ID: 6b
-- Name: owner_rates_customer
drop procedure if exists owner_rates_customer;
delimiter //
create procedure owner_rates_customer (
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin

if (select count(*) from Owners_Rate_Customers where Owner_Email = i_owner_email and Customer = i_customer_email) > 0
then leave sp_main; end if; 

if 0 not in (select Was_Cancelled from reserve 
where Owner_Email = i_owner_email and Customer = i_customer_email)
then leave sp_main; end if;

if (select count(*) from (select Start_Date from reserve 
where Owner_Email = i_owner_email and Customer = i_customer_email) as t where i_current_date >= Start_Date) = 0
then leave sp_main; end if;

insert into Owners_Rate_Customers value (i_owner_email,i_customer_email,i_score);


end //
delimiter ;


-- ID: 7a
-- Name: view_airports
create or replace view view_airports (
    airport_id, 
    airport_name, 
    time_zone, 
    total_arriving_flights, 
    total_departing_flights, 
    avg_departing_flight_cost
) as

select 
airport_id, airport_name, 
time_zone, 
ifnull(total_arriving_flights,0) as total_arriving_flights, 
ifnull(total_departing_flights,0) as total_departing_flights, 
avg_departing_flight_cost

from (select * from (select airport.Airport_Id as airport_id,
airport.Airport_Name as airport_name,
airport.Time_Zone as time_zone,
count(flight.From_Airport) as total_departing_flights
from airport left outer join flight on airport_id = flight.From_Airport
group by flight.From_Airport) as f left outer join (select To_Airport, count(*) as total_arriving_flights from flight
group by To_Airport) as g
on Airport_Id = To_Airport) as h left outer join (select From_Airport , avg(Cost) as avg_departing_flight_cost from flight
group by From_Airport) as j
on From_Airport = Airport_Id
;


-- ID: 7b
-- Name: view_airlines
create or replace view view_airlines (
    airline_name, 
    rating, 	
    total_flights, 
    min_flight_cost
) as
SELECT airline.Airline_Name as airline_name, Rating as rating, count(*) as total_flights, min(Cost) as min_flight_cost 
FROM airline natural left join flight
group by flight.Airline_Name;



-- ID: 8a
-- Name: view_customers
create or replace view view_customers (
    customer_name, 
    avg_rating, 
    location, 
    is_owner, 
    total_seats_purchased
) as

select 
concat(First_Name,' ',Last_Name) as customer_name,
avg_rating,
location,
if(owners.Email=d.Email, 1, 0) as is_owner, 
total_seats_purchased
 
from (select First_Name, Last_Name, avg (Score) as avg_rating, Location, ifnull(total,0) as total_seats_purchased,Email from (select First_Name, Last_Name, Location, Score, Email from 
(select * from accounts natural join customer) as w left outer join owners_rate_customers on Email = Customer) as r
left outer join 
(select sum(Num_Seats) as total,Customer from book
group by Customer) as y
on Email = Customer
group by Email) as d
natural left join owners;


-- ID: 8b
-- Name: view_owners
create or replace view view_owners (
    owner_name, 
    avg_rating, 
    num_properties_owned, 
    avg_property_rating
) as

SELECT 
	t2.owner_name, t3.average_rating, ifnull(t4.num_props_owned, 0) as num_props_owned, t5.avg_property_rating
    from
	(
		(select email from owners) as t1
		left join (select concat(first_name, ' ', last_name) as owner_name, email from accounts group by email) as t2 on t1.email = t2.email
		left join (select avg(score) as average_rating, owner_email from customers_rate_owners group by owner_email) as t3 on t1.email = t3.owner_email
        left join (select count(*) as num_props_owned, owner_email from property group by owner_email) as t4 on t1.email = t4.owner_email
        left join (select avg(score) as avg_property_rating, owner_email from review group by owner_email) as t5 on t1.email = t5.owner_email
    );


-- ID: 9a
-- Name: process_date
drop procedure if exists process_date;
delimiter //
create procedure process_date ( 
    in i_current_date date
)
sp_main: begin

UPDATE customer t
NATURAL JOIN 
(select State , Email from customer join (select Customer, State from airport join 
(select * from book natural join (select Airline_Name, To_Airport from flight where i_current_date = Flight_Date) as w) as e
on Airport_Id = To_Airport where Was_Cancelled != 1) as x on  Email = x.Customer) s
SET t.Location = s.State;

end //
delimiter ;
