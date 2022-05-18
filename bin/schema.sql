create database e_community;

use e_community;

create table role (role_id integer NOT NULL auto_increment,
role_name varchar(32),
constraint pk_role primary key (role_id));

insert into role (role_name) values ('student');
insert into role (role_name) values ('professor');
insert into role (role_name) values ('system administrator');

create table address_zip (zip varchar(10) NOT NULL UNIQUE,
city varchar(24),
state varchar(2),
constraint pk_address_zip primary key (zip));

insert into address_zip values ('11367', 'Flushing', 'NY');

create table address (address_id integer NOT NULL auto_increment,
street varchar(32),
zip varchar(10) NOT NULL,
constraint pk_address primary key (address_id),
constraint fk_address foreign key (zip) references address_zip(zip));

insert into address (street, zip) values ('65-30 Kissena Blvd', '11367');

create table user ( phone varchar(16) NOT NULL UNIQUE,
name varchar(64),
role_id integer NOT NULL,
address_id integer,
constraint fk_user_role foreign key (role_id) references role (role_id),
constraint fk_user_address foreign key (address_id) references address (address_id),
constraint pk_user primary key (phone));

insert into user values ('7189975000', 'President Wu', 3, 1);

create table course (course_ID varchar(8) NOT NULL UNIQUE,
course_name varchar(16) NOT NULL,
required_course_for_major ENUM ('yes', 'no'),
constraint pk_course primary key (course_ID) );

insert into course value ('1647086', 'CS-311-Database', 'yes');

create table course_user (course_ID varchar(8),
phone varchar(16),
constraint pk_course_user primary key (course_ID, phone),
constraint fk_course_user1 foreign key (phone) references user (phone),
constraint fk_course_user2 foreign key (course_ID) references course (course_ID) );

create table posting (post_id integer NOT NULL UNIQUE auto_increment,
post_content varchar(4096), 
author_phone varchar(16) NOT NULL,
visibility  ENUM ('private', 'public'),
course_ID varchar(8) NOT NULL,
constraint pk_posting primary key (post_id),
constraint fk_posting1 foreign key (author_phone) references user (phone),
constraint fk_posting2 foreign key (course_ID) references course (course_ID) );

create table reply_posting_reference (post_id integer NOT NULL,
                                                              reply_post_id integer NOT NULL,
                                                               constraint pk_reply_posting_reference primary key (post_id, reply_post_id) );

create table attachment (attachment_id integer NOT NULL UNIQUE auto_increment,
reference_link varchar(128),
file_content longblob,
post_id integer NOT NULL,
constraint pk_attachment primary key (attachment_id),
constraint fk_attachment_posting foreign key (post_id) references posting (post_id) );



insert into address_zip values ('11023', 'Great Neck', 'NY');
insert into address_zip values ('11021', 'Great Neck', 'NY');
insert into address_zip values ('07726', 'Manalanpan', 'NJ');
insert into address_zip values ('10017', 'New York', 'NY');
insert into address_zip values ('30301', 'Atlanta', 'GA');

insert into address (street, zip) values ('15 Locust Street', '11023');
insert into address (street, zip) values ('50 Brompton Road', '11021');
insert into address (street, zip) values ('25 Elliot Road', '07726');
insert into address (street, zip) values ('279 E 44th Street', '10017');
insert into address (street, zip) values ('15 Atlanta Drive', '30301');

insert into user values('3471145140','Lupin Arsene',1,NULL);
insert into user values('7187355608','Nyarlathotep',1,NULL);
insert into user values('9167776555','John Watson',1,NULL);
insert into user values('5153571113','Funny Valentine',1,NULL);
insert into user values('8001919810','Tuesday Tanuki',1,NULL);

insert into course values('1145141','SocialStudies','yes');
insert into course values('1919810','History','yes');
insert into course values('2233445','Medical','yes');
insert into course values('2123456','Agriculture','yes');
insert into course values('3571113','Art','yes');

insert into course_user (phone, course_id) values('3471145140','3571113');
insert into course_user  (phone, course_id) values('7187355608','1145141');
insert into course_user  (phone, course_id) values('9167776555','2233445');
insert into course_user  (phone, course_id) values('5153571113','1919810');
insert into course_user  (phone, course_id) values('8001919810','2123456');

insert into user values ('3476155408', 'Ismael Boro', 1, 4);
insert into user values ('3477253893', 'Mikle Richman', 2, NULL);
insert into user values ('3477636520', 'Miriam Devin', 2, NULL);
insert into user values ('9136478376', 'Kelly Brown', 3, NULL);
insert into user values ('9152846730', 'Rebeca Smith', 2, NULL);

insert into user values ('7186267099', 'Bob Swagger', 3, 2);
insert into user values ('7182369870', 'Jarred Hubbard', 2, 4);
insert into user values ('7181234567', 'Tania Travis', 1, 3);
insert into user values ('7187884563', 'Angeline Frye', 3, 2);

insert into user values ('3472790886', 'Chuck Norris', 1, NULL);
insert into user values ('3471947829', 'Dave Johnson', 2, NULL);
insert into user values ('6469276047', 'Steve Austin', 1, NULL);
insert into user values ('9172847327', 'Bob Jenkins', 3, NULL);
insert into user values ('9173672830', 'Eric Ericson', 1, NULL);

INSERT INTO user VALUES ("7185838661", "Brian Sukhnandan", 1, 2);
INSERT INTO user VALUES ("7189876543", "Michael Myers", 1, 2);
INSERT INTO user VALUES ("3479876543", "Freddy Krueger", 1, 3);

INSERT INTO course VALUES ("1647087", "CS355", "Yes");
INSERT INTO course VALUES ("2345678", "MUSIC101", "No");
INSERT INTO course VALUES ("3456789", "HIST101", "No");

INSERT INTO course_user (course_ID, phone) VALUES ("3456789", "7189876543");
INSERT INTO course_user (course_ID, phone) VALUES ("2345678", "3479876543");

insert into user values ('6506815100', 'Londyn Forbes', 1, NULL);
insert into user values ('7184781204', 'Kai Shelton', 2, NULL);
insert into user values ('7184240116', 'Jaylah Yang', 1, NULL);
insert into user values ('7187794875', 'Kaliyah Haney', 1, NULL);
insert into user values ('7184760747', 'Tim Burton', 1, NULL);

insert into course values ('9980708', 'Discrete-Math', 'yes');
insert into course values('6273828', 'Literature', 'no');
insert into course values('4607603', 'Data-Structures', 'yes');
insert into course values('8674991', 'Calculus', 'yes');
insert into course values('4559721', 'Comp Architect', 'yes');

insert into course_user values('4607603', '7184760747');
insert into course_user values('4559721', '7184781204');
insert into course_user values('8674991', '6506815100');
insert into course_user values('6273828', '7187794875');
insert into course_user values('9980708', '7184240116');

insert into posting (post_content,author_phone, visibility, course_ID)  values ('Hello, this is a post!', '7184240116', 'public', '9980708');
insert into posting   (post_content,author_phone, visibility, course_ID) values ('Hello Professor, I need help with question 2 on the assignment.', '6506815100', 'private', '8674991');
insert into posting (post_content,author_phone, visibility, course_ID)  values ('Hello classmates, my name is Kaliyah Haney.', '7187794875', 'public', '6273828');
insert into posting (post_content,author_phone, visibility, course_ID) values ('Welcome to CS343 Computer Architecture!', '7184781204', 'public', '4559721');
insert into posting (post_content,author_phone, visibility, course_ID)  values (NULL, '7184760747', 'public', '4607603');

insert into user values ('5553456789','Darly Andies', 1, NULL);
insert into course values('67809','CS-340 OS', 'yes');
insert into course values('3674936','OOP in Java', 'yes');

insert into user values ('3163000123','Mr.Best',3,NULL);
insert into user values ('9165430001','Neko Cat',1,NULL);
insert into user values ('2128887906','Big Man Jhon',2,NULL);
insert into user values ('3139998723','Al Pacino',3,NULL);
insert into user values ('6783451123','Clark Kent',2,NULL);

insert into course values ('98712312','Hackology','no');
insert into course values ('87826337','Cloning','yes');
insert into course values ('87384797','Gravity','no');
insert into course values ('12782724','DataStuff','no');
insert into course values ('32324241','Addition','yes');

insert into course_user values('98712312','9165430001');
insert into course_user values('87384797','2128887906');
insert into course_user values('32324241','6783451123');
insert into course_user values('98712312','3163000123');
insert into course_user values('12782724','9165430001');

insert into posting (post_content,author_phone, visibility, course_ID) values ('Hello, introduction','9165430001','public','12782724');
insert into posting (post_content,author_phone, visibility, course_ID) values ('Totally not superman','6783451123','public','32324241');
insert into posting (post_content,author_phone, visibility, course_ID) values ('Sike, totally am superman','6783451123','private','32324241');
insert into posting (post_content,author_phone, visibility, course_ID) values ('Raise hand to speak','3163000123','public','98712312');
insert into posting (post_content,author_phone, visibility, course_ID) values ('Yes please do raise hand to speak','2128887906','private','87384797');

insert into user values ('5164554720', 'Sam Landerer', 1, 2);
insert into user values ('5164664520', 'Philys Reich', 1, 3);
insert into user values ('9085787668', 'Steven Reich', 2, 4);
insert into user values ('7329950616', 'Josh Reich', 2, 5);
insert into user values ('4046301138', 'Meir Sasson', 1, 6);

insert into course values('6658742', 'ENG-101H', 'no');
insert into course values('4862579', 'CS-323', 'yes');
insert into course values('7458962', 'CS-316', 'yes');
insert into course values('1816726', 'ANTH-104', 'no');
insert into course values('7472462', 'CS-320', 'yes');

insert into course_user values('7458962','5164554720');
insert into course_user values('6658742','9085787668');
insert into course_user values('1816726','5164664520');
insert into course_user values('1816726','4046301138');
insert into course_user values('1647086','5164554720');

insert into posting (post_content,author_phone,visibility,course_ID) values ('testing post content','5164554720','public','7472462');
insert into posting (post_content,author_phone,visibility,course_ID) values ('this is a posting','5164554720','public','7458962');
insert into posting (post_content,author_phone,visibility,course_ID) values ('that post was terrible','4046301138','public','6658742');
insert into posting (post_content,author_phone,visibility,course_ID) values ('test succseful','5164664520','private','1647086');
insert into posting (post_content,author_phone,visibility,course_ID) values ('test failed','9085787668','private','1647086');

insert into attachment (reference_link,file_content,post_id) values ('reflnk124','I am a blob!',1);
insert into attachment (reference_link,file_content,post_id) values ('reflnk187','BLob stuff goes here',1);
insert into attachment (reference_link,file_content,post_id) values ('reflnk194',null,2);
insert into attachment (reference_link,file_content,post_id) values ('reflnk314','BLOB means Binary large object!',3);
insert into attachment (reference_link,file_content,post_id) values ('reflnk876','What goes here?',5);

insert into attachment (reference_link,file_content,post_id) values ('reflnk124','I am a blob!',2);
insert into attachment (reference_link,file_content,post_id) values ('reflnk187','BLob stuff goes here',2);
insert into attachment (reference_link,file_content,post_id) values ('reflnk194',null,3);
insert into attachment (reference_link,file_content,post_id) values ('reflnk314','BLOB means Binary large object!',4);
insert into attachment (reference_link,file_content,post_id) values ('reflnk876','What goes here?',5);

insert into user values('3472324559','Jun',1,NULL);
insert into user values('3472024459','Jhin',1,NULL);

insert into attachment (reference_link, file_content, post_id) values ('41433', 'What is a longblob?', 1);
insert into attachment  (reference_link, file_content, post_id) values('27568', 'This is what I have professor. Is it correct?', 2);
insert into attachment  (reference_link, file_content, post_id) values('32009', 'To reiterate, my name is Kaliyah Haney.', 3);
insert into attachment  (reference_link, file_content, post_id) values('34343', 'Make sure to review your CS240 material', 4);
insert into attachment  (reference_link, file_content, post_id) values(NULL, NULL, 5);

create database SQLRepo;
use SQLRepo;

create table statements ( 
    description varchar(1000),
    statement varchar(1000)
);


insert into statements values ('Create a table','create table mytable (id int, name varchar(20));');
insert into statements values ('Return the post id and the number of attachments to the posting', 'select post_id, count(post_id) count_post_id from attachment group by post_id;');
insert into statements values ('Return the postings by post id without an attachment','select post_id from posting where post_id NOT IN (select post_id from attachment);');
insert into statements values ('Find the posting with the highest number of attachments', 'select post_id b_post_id, count(post_id) b_count_post_id from attachment group by post_id order by count(post_id) desc limit 1;');
insert into statements values ('Find the ratio of the total number of postings without attachment(s) over the total number of postings with attachment(s) for each course.', 'select no_posting_count/posting_count from (select count(post_id) posting_count from posting where post_id in (select distinct post_id from attachment) ) A, (select count(post_id) no_posting_count from posting where post_id NOT in (select distinct post_id from attachment) ) B; ');
insert into statements values ('Find the total number of postings by all students of every course.', 'select course_id, count(post_id) from posting, (select phone from user where role_id =1) A where A.phone = posting.author_phone group by course_id;');
