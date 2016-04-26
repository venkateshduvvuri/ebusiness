insert into project_db.employee values ('John Smith','182 Meyran Street','js1@gmail.com','salesperson',2500,1001);
insert into project_db.employee values ('Melissa Winder','258 Tuscan Ave','mw2@yahoo.com','salesperson',2550,1002);
insert into project_db.employee values ('Rob Stark','890 North Hills','rs12@hotmail.com','salesperson',2250,1003);
insert into project_db.employee values ('Kelly Sherman','456 Petersen Street','ks3@hotmail.com','salesperson',2750,2001);
insert into project_db.employee values ('Don WHiteman','697 Portal Place','dw4@gmail.colm','salesperson',3000,2002);
insert into project_db.employee values ('Lendyl Simmons','590 Westeros Park','ls13@yahoo.com','salesperson',2000,2003);
insert into project_db.employee values ('Carl Staten','452 Highland Ave','cs5@yahoo.com','store manager',4000,1004);
insert into project_db.employee values ('David Miller','864 Forbes Ave','dm6@gmail.com','store manager',4500,2004);
insert into project_db.employee values ('Shaun Pollock','482 South Street','sp7@yahoo.com','region manager',5000,9991);
insert into project_db.employee values ('Chris Gayle','420 West Ave','cg8@hotmail.com','salesperson',2550,3001);
insert into project_db.employee values ('Shahid Afridi','132 Darahh Street','sa14@yahoo.com','salesperson',2000,3002);
insert into project_db.employee values ('Sharukh Khan','896 Mumbai Street','srk9@gmail.com','salesperson',2750,3003);
insert into project_db.employee values ('Paul Collingwood','900 England Place','pc10@gmail.com','store manager',3000,3004);
insert into project_db.employee values ('John Snow','1000 Nights Watch','js11@yahoo.com','region manager',4000,9993);

insert into project_db.region values (15213,'Pittsburgh',9991);
insert into project_db.region values (10001, 'New York',9993);

insert into project_db.store values ('PA0001','4600 Center Ave',3);
insert into project_db.store values ('PA0002','5830 Elwood Street',3);
insert into project_db.store values ('NY0001','222 Central Perk',3);

insert into project_db.employee_store values (1001,'PA0001',1004,15213);
insert into project_db.employee_store values (1002,'PA0001',1004,15213);
insert into project_db.employee_store values (1003,'PA0001',1004,15213);
insert into project_db.employee_store values (1004,'PA0001',1004,15213);
insert into project_db.employee_store values (2001,'PA0001',2004,15213);
insert into project_db.employee_store values (2002,'PA0001',2004,15213);
insert into project_db.employee_store values (2003,'PA0001',2004,15213);
insert into project_db.employee_store values (2004,'PA0001',2004,15213);
insert into project_db.employee_store values (3001,'PA0001',3004,10001);
insert into project_db.employee_store values (3002,'PA0001',3004,10001);
insert into project_db.employee_store values (3003,'PA0001',3004,10001);
insert into project_db.employee_store values (3004,'PA0001',3004,10001);
insert into project_db.employee_store values (9991,'PA0001',2004,10001);
insert into project_db.employee_store values (9993,'PA0001',3004,10001);

insert into project_db.customer values (111111111,'GFUDFSDDHFG','Dipal Shah','234 Melwood Ave','Pittsburgh','PA',15213,'Home');
insert into project_db.customer values (222222222,'TRDBDCHDGF83773','XYZ Enterprise','4600 Center Ave','NewYork','NY',10001,'Business');
insert into project_db.customer values (333333333,'QFYTEW6146H','ABC Company','520 Hamilton Street','Chicago','IL',60290,'Business');
insert into project_db.customer values (444444444,'EYTRUHDFUWTF','Heer Jakharia','201 MG Road','San Jose','CA',95101,'Home');
insert into project_db.customer values (555555555,'GFUYWGFHGFY','Venkatesh Duvvuri','293 Squirrel Hill','Pittsburgh','PA',15210,'Home');
insert into project_db.customer values (666666666,'EFR6W2R7R29GD','Sushma Sattuluri','789 South Hills','Pittsburgh','PA',15213,'Home');
insert into project_db.customer values (777777777,'YYEFG6W5R23','Kewal Shah','234 Melwood Ave','Pittsburgh','PA',15213,'Home');
insert into project_db.customer values (888888888,'GFUWE6383R','Dhun NAgda','115 MArylan Ave','MAryland','MD',20588,'Home');

insert into project_db.customer_business values (222222222,'IT',500000000);
insert into project_db.customer_business values (333333333,'PUBLIC',1000000000);

insert into project_db.customer_home values (111111111,'Married','Female',25,80000);
insert into project_db.customer_home values (444444444,'Single','Female',22,60000);
insert into project_db.customer_home values (555555555,'Single','Male',28,50000);
insert into project_db.customer_home values (666666666,'MArried','Female',29,50000);
insert into project_db.customer_home values (777777777,'Single','Male',22,50000);
insert into project_db.customer_home values (888888888,'Single','Female',18,60000);

insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND1','Chicken Kebab','Tasty Chicken Kebabs',25,25,'Indian','themes/images/dishes/4.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND2','Egg Curry','tasty Egg Curry',20,40,'Indian','themes/images/dishes/5.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('MEX1','Lasagna','Mouthwatering Lasagna',20,50,'Mexican','themes/images/dishes/6.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND3','Masala Dosa','Delicious Dosa',15,40,'Indian','themes/images/dishes/7.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND4','Fish Curry','Authentic Fish Curry',10,40,'Indian','themes/images/dishes/9.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND5','Jalebi Sweet','Sweet Jalebi',20,50,'Indian','themes/images/dishes/8.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('CHI1','Kungpao Chicken','Authentic Chinese',10,30,'Chinese','themes/images/dishes/10.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND6','Rajma Rice','Breathtaking Rajma Pulses',10,35,'Indian','themes/images/dishes/11.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND7','Samosa','Triangle Love Food',20,40,'Indian','themes/images/dishes/1.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND8','Chicken surma','Authentic surma',20,45,'Indian','themes/images/dishes/2.jpg');
insert into project_db.product(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) values ('IND9','Chicken curry','Delicious Chicken Rice',15,30,'Indian','themes/images/dishes/3.jpg');