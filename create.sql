CREATE DATABASE DB2021Team05;
SHOW DATABASES;
USE DB2021Team05;

CREATE TABLE DB2021_Movie (					#�߽� ��ȭ ���̺�
	Movie_ID INT NOT NULL AUTO_INCREMENT,
	Title VARCHAR(50) NOT NULL,
	Genre ENUM("���", "�̽��͸�", "������", "���", "����", "�׼�", "�ڹ̵�", "��Ÿ��") ,
	ReleaseDate DATE,
	Production VARCHAR(30),
	Score FLOAT,							#��ȭ�� ��� ����
	Review_cnt INT DEFAULT 100 NOT NULL,	#100���� ����������� �����Ѵ�
PRIMARY KEY(Movie_ID)
);

CREATE TABLE DB2021_Review (				#���並 �����ϴ� ���̺�
	Review_ID INT NOT NULL AUTO_INCREMENT,
	Movie_ID INT NOT NULL,
	Date DATE,
	Score FLOAT,
	Writer VARCHAR(20) NOT NULL,			#������� �̸�
	Review VARCHAR(100),					#����ڰ� �ۼ��� ���並 ����
PRIMARY KEY(Review_ID),
FOREIGN KEY(Movie_ID) REFERENCES DB2021_Movie(Movie_ID)
);

CREATE TABLE DB2021_Actor (					#��� ���̺�
	Actor_ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL,
	Sex ENUM("M", "F"),
	Born DATE,								#�������
PRIMARY KEY(Actor_ID)
);

CREATE TABLE DB2021_Movie_cast (			#Ư�� ��ȭ�� �⿬�� ��� ���̺�
	Movie_ID INT NOT NULL,
	Actor_ID INT NOT NULL,
	Role ENUM("�ֿ�", "����"),
PRIMARY KEY(Movie_ID, Actor_ID),
FOREIGN KEY(Movie_ID) REFERENCES DB2021_Movie(Movie_ID),
FOREIGN KEY(Actor_ID) REFERENCES DB2021_Actor(Actor_ID)
);

CREATE TABLE DB2021_Nominations (			#���� ���� ���̺�
	Movie_ID INT NOT NULL,
	Year INT,								#����⵵
	Award VARCHAR(30),						#��ȭ���̸�
	Prize VARCHAR(30),
PRIMARY KEY(Movie_ID, Award, Prize),
FOREIGN KEY(Movie_ID) REFERENCES DB2021_Movie(Movie_ID)
);

CREATE TABLE DB2021_Director (				#��������
	Director_ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(30),
PRIMARY KEY(Director_ID)
);

CREATE TABLE DB2021_Movie_direction (		#Ư�� ��ȭ�� ������ ���� ���̺�
	Movie_ID INT NOT NULL ,
	Director_ID INT NOT NULL ,
PRIMARY KEY(Movie_ID, Director_ID),
FOREIGN KEY(Movie_ID) REFERENCES DB2021_Movie(Movie_ID),
FOREIGN KEY(Director_ID) REFERENCES DB2021_Director(Director_ID)
);



CREATE VIEW DB2021_ViewMovie AS				#��ȭ �˻� ��� ����� ���� view ����
SELECT Title, Director, Genre, ReleaseDate, Score
FROM DB2021_Movie JOIN (SELECT Movie_ID, Director_ID, DB2021_Director.Name AS Director
						FROM DB2021_Movie_direction JOIN DB2021_Director
						USING(Director_ID)
						) T
USING(Movie_ID);


CREATE VIEW DB2021_ViewReview AS			#���� ����� ���� view ����
SELECT Review_ID, Title, Writer, Date, DB2021_Review.Score AS sc, Review
FROM DB2021_Review JOIN DB2021_Movie
USING (Movie_ID);

CREATE INDEX idx_movie ON DB2021_Movie( Movie_ID );            		#�ε��� ����   
CREATE INDEX idx_movie ON DB2021_Movie( Title );
CREATE INDEX idx_director ON DB2021_Director( director_ID );
CREATE INDEX idx_director ON DB2021_Director( name );
CREATE INDEX idx_actor ON DB2021_actor( Actor_ID );


#������ʹ� insert���Դϴ�.

INSERT INTO DB2021_Movie(Movie_ID, Title, Genre, ReleaseDate, Production, Score)
VALUES
(1,'�����','���','2019-05-30','CJ ENM',9.07),
(2,'����','�̽��͸�','2018-06-27','���� �귯���� �ڸ��Ƣ�',8.58),
(3,'�ư���','������','2016-06-01','CJ ENM',7.69),
(4,'����','���','2017-06-29','(��)NEW',8.77),
(5,'����','���','2009-04-30','CJ ENM',6.3),
(6,'�ż���','����','2013-02-21','(��)NEW',8.93),
(7,'���ϵ�','����','2012-07-25','�߼�ڽ�',7.63),
(8,'�ϻ�','���','2015-07-22','�߼�ڽ�',9.1),
(9,'Ÿ¥1','����','2006-09-28','CJ ENM',9.19),
(10,'������','���','2002-04-05','(��)�˿������θ�Ʈ',9.38),
(11,'ȭ��','�̽��͸�','2012-03-08','�ʶ��Ʈ ���Ľ�',8.06),
(12,'īƮ','���','2014-11-13','��Ʋ����ó��',8.61),
(13,'�����','���','2014-05-22','����ö���',7.28),
(14,'������','�׼�','2010-08-04','CJ ENM',9.24),
(15,'����','����','2009-05-28','CJ ENM',9.45),
(16,'�̳���','���','2021-03-03','Plan B',8.33),
(17,'������ �����','���','2020-01-22','(��)��ڽ�',8.46),
(18,'1987','���','2017-12-27','CJ ENM',9.31),
(19,'����','���','2018-08-08','CJ ENM',7.86),
(20,'���ѻ꼺','���','2017-10-03','CJ ENM',8.17),
(21,'�ýÿ�����','���','2017-08-02','(��)��ڽ�',9.28),
(22,'����','�׼�','2016-09-07','���� �귯���� �ڸ��Ƣ�',8.57),
(23,'�','������','2016-05-12','�̽ʼ��������ڸ���(��)',8.22),
(24,'�����ڵ�','����','2015-11-19','(��)��ڽ�',9.06),
(25,'���׶�','�׼�','2015-08-05','CJ ENM',9.24),
(26,'��������','���','2014-12-17','CJ ENM',9.16),
(27,'�������°�׶���Ʋ����','���','2015-09-24','(��)NEW',8.43),
(28,'�絵','���','2015-09-16','(��)��ڽ�',8.49),
(29,'��','�׼�','2014-07-30','CJ ENM',8.88),
(30,'��ȣ��','���','2013-12-18','(��)NEW',9.29),
(31,'�����׷� �������͹�','���','2020-10-21','�Ե��������θ�Ʈ',9.03),
(32,'���Ѵ�: ���� ����� ����','����','2017-05-17','CJ ENM',8.15),
(33,'�ڿ�','���','2017-06-28','�ް��ڽ��߾�(��)�÷�����',8.48),
(34,'���','�ڹ̵�','2011-05-04','CJ ENM',9.11),
(35,'���˿��� ���� : ���۳�� �����ô�','����','2012-02-02','(��)��ڽ�',8.64),
(36,'û�����','�׼�','2017-08-09','�Ե��������θ�Ʈ',9.03),
(37,'�߰���','����','2008-02-14','(��)��ڽ�',9.09),
(38,'�λ���','�׼�','2016-07-20','(��)NEW',8.6),
(39,'���񿡰�','���','2019-11-14','��Ʋ����ó��',9.23),
(40,'���� �Ÿ�','����','2006-06-15','CJ ENM',8.79),
(41,'��������','�ڹ̵�','2019-01-23','CJ ENM',9.2),
(42,'�Ű��Բ�-�˿� ��','��Ÿ��','2017-12-20','�Ե��������θ�Ʈ',8.73),
(43,'7������ ����','�ڹ̵�','2013-01-23','(��)NEW',8.83),
(44,'���� : ���� �� ����','���','2012-09-13','CJ ENM',9.25),
(45,'�ؿ��','���','2009-07-22','CJ ENM',7.45);


insert into db2021_director
values
(1,'����ȣ'),
(2,'������'),
(3,'������'),
(4,'�ֵ���'),
(5,'������'),
(6,'������'),
(7,'������'),
(8,'���ָ�'),
(9,'������'),
(10,'���̻�'),
(11,'���ȣ'),
(12,'����ȯ'),
(13,'������'),
(14,'Ȳ����'),
(15,'����'),
(16,'������'),
(17,'��ȫ��'),
(18,'���¿�'),
(19,'������'),
(20,'ȫ���'),
(21,'������'),
(22,'���ѹ�'),
(23,'��켮'),
(24,'������'),
(25,'������'),
(26,'����ö'),
(27,'����ȯ'),
(28,'����ȣ'),
(29,'�Ӵ���'),
(30,'����'),
(31,'�̺���'),
(32,'���ȭ'),
(33,'��ȯ��'),
(34,'��â��');

INSERT INTO DB2021_Movie_direction VALUES(1, 1);
INSERT INTO DB2021_Movie_direction VALUES(2, 2);
INSERT INTO DB2021_Movie_direction VALUES(3, 3);
INSERT INTO DB2021_Movie_direction VALUES(4, 1);
INSERT INTO DB2021_Movie_direction VALUES(5, 3);
INSERT INTO DB2021_Movie_direction VALUES(6, 2);
INSERT INTO DB2021_Movie_direction VALUES(7, 4);
INSERT INTO DB2021_Movie_direction VALUES(8, 4);
INSERT INTO DB2021_Movie_direction VALUES(9, 4);
INSERT INTO DB2021_Movie_direction VALUES(10, 5);
INSERT INTO DB2021_Movie_direction VALUES(11, 6);
INSERT INTO DB2021_Movie_direction VALUES(12, 7);
INSERT INTO DB2021_Movie_direction VALUES(13, 8);
INSERT INTO DB2021_Movie_direction VALUES(14, 9);
INSERT INTO DB2021_Movie_direction VALUES(15, 1);
INSERT INTO DB2021_Movie_direction VALUES(16, 10);
INSERT INTO DB2021_Movie_direction VALUES(17, 11);
INSERT INTO DB2021_Movie_direction VALUES(18, 12);
INSERT INTO DB2021_Movie_direction VALUES(19, 13);
INSERT INTO DB2021_Movie_direction VALUES(20, 14);
INSERT INTO DB2021_Movie_direction VALUES(21, 15);
INSERT INTO DB2021_Movie_direction VALUES(22, 16);
INSERT INTO DB2021_Movie_direction VALUES(23, 17);
INSERT INTO DB2021_Movie_direction VALUES(24, 11);
INSERT INTO DB2021_Movie_direction VALUES(25, 18);
INSERT INTO DB2021_Movie_direction VALUES(26, 19);
INSERT INTO DB2021_Movie_direction VALUES(27, 20);
INSERT INTO DB2021_Movie_direction VALUES(28, 21);
INSERT INTO DB2021_Movie_direction VALUES(29, 22);
INSERT INTO DB2021_Movie_direction VALUES(30, 23);
INSERT INTO DB2021_Movie_direction VALUES(31, 24);
INSERT INTO DB2021_Movie_direction VALUES(32, 25);
INSERT INTO DB2021_Movie_direction VALUES(33, 21);
INSERT INTO DB2021_Movie_direction VALUES(34, 26);
INSERT INTO DB2021_Movie_direction VALUES(35, 13);
INSERT INTO DB2021_Movie_direction VALUES(36, 27);
INSERT INTO DB2021_Movie_direction VALUES(37, 17);
INSERT INTO DB2021_Movie_direction VALUES(38, 28);
INSERT INTO DB2021_Movie_direction VALUES(39, 29);
INSERT INTO DB2021_Movie_direction VALUES(40, 30);
INSERT INTO DB2021_Movie_direction VALUES(41, 31);
INSERT INTO DB2021_Movie_direction VALUES(42, 32);
INSERT INTO DB2021_Movie_direction VALUES(43, 33);
INSERT INTO DB2021_Movie_direction VALUES(44, 34);
INSERT INTO DB2021_Movie_direction VALUES(45, 19);



INSERT INTO DB2021_Actor VALUES (1 ,'�ڼҴ�' ,'F' ,'1991-09-08');
INSERT INTO DB2021_Actor VALUES (2 ,'�۰�ȣ' ,'M' ,'1967-01-17');
INSERT INTO DB2021_Actor VALUES (3 ,'�ֿ��' ,'M' ,'1990-03-26');
INSERT INTO DB2021_Actor VALUES (4 ,'��ٹ�' ,'F' ,'1995-04-09');
INSERT INTO DB2021_Actor VALUES (5 ,'������' ,'M' ,'1978-03-11');
INSERT INTO DB2021_Actor VALUES (6 ,'�ȼ���' ,'F' ,'2004-01-12');
INSERT INTO DB2021_Actor VALUES (7 ,'ƿ�� ����ư' ,'F' ,'1960-11-05');
INSERT INTO DB2021_Actor VALUES (8 ,'�����' ,'F' ,'1982-03-01');
INSERT INTO DB2021_Actor VALUES (9 ,'���¸�' ,'F' ,'1990-04-24');
INSERT INTO DB2021_Actor VALUES (10 ,'�����' ,'F' ,'1987-01-03');
INSERT INTO DB2021_Actor VALUES (11 ,'������' ,'M' ,'1972-12-15');
INSERT INTO DB2021_Actor VALUES (12 ,'�ֹν�' ,'M' ,'1962-04-27');
INSERT INTO DB2021_Actor VALUES (13 ,'Ȳ����' ,'M' ,'1970-09-01');
INSERT INTO DB2021_Actor VALUES (14 ,'������' ,'F' ,'1981-10-30');
INSERT INTO DB2021_Actor VALUES (15 ,'������' ,'F' ,'1970-09-05');
INSERT INTO DB2021_Actor VALUES (16 ,'������' ,'M' ,'1967-01-21');
INSERT INTO DB2021_Actor VALUES (17 ,'���¿�' ,'M' ,'1980-03-28');
INSERT INTO DB2021_Actor VALUES (18 ,'������' ,'M' ,'1970-01-04');
INSERT INTO DB2021_Actor VALUES (19 ,'����ȣ' ,'M' ,'1993-08-17');
INSERT INTO DB2021_Actor VALUES (21 ,'�̼���' ,'M' ,'1975-03-02');
INSERT INTO DB2021_Actor VALUES (22 ,'������' ,'F' ,'1972-07-28');
INSERT INTO DB2021_Actor VALUES (23 ,'������' ,'F' ,'1976-01-12');
INSERT INTO DB2021_Actor VALUES (24 ,'��γ�' ,'F' ,'1979-10-11');
INSERT INTO DB2021_Actor VALUES (25 ,'�����' ,'F' ,'2000-07-31');
INSERT INTO DB2021_Actor VALUES (26 ,'����' ,'M' ,'1977-11-10');
INSERT INTO DB2021_Actor VALUES (27 ,'������' ,'F' ,'1941-09-14');
INSERT INTO DB2021_Actor VALUES (28 ,'��Ƽ�� ��' ,'M' ,'1983-12-21');
INSERT INTO DB2021_Actor VALUES (29 ,'�ѿ���' ,'F' ,'1984-12-23');
INSERT INTO DB2021_Actor VALUES (30 ,'������' ,'F' ,'1947-06-19');
INSERT INTO DB2021_Actor VALUES (31 ,'�̺���' ,'M' ,'1970-07-12');
INSERT INTO DB2021_Actor VALUES (32 ,'�̼���' ,'M' ,'1968-12-04');
INSERT INTO DB2021_Actor VALUES (33 ,'������' ,'M' ,'1973-05-17');
INSERT INTO DB2021_Actor VALUES (34 ,'�����' ,'F' ,'1979-12-12');
INSERT INTO DB2021_Actor VALUES (35 ,'���¸�' ,'M' ,'1969-09-14');
INSERT INTO DB2021_Actor VALUES (36 ,'������' ,'M' ,'1976-04-02');
INSERT INTO DB2021_Actor VALUES (37 ,'������' ,'M' ,'1982-05-16');
INSERT INTO DB2021_Actor VALUES (38 ,'������' ,'M' ,'1961-03-28');
INSERT INTO DB2021_Actor VALUES (39 ,'���Ҹ�' ,'F' ,'1977-01-26');
INSERT INTO DB2021_Actor VALUES (40 ,'������' ,'M' ,'1977-01-26');
INSERT INTO DB2021_Actor VALUES (41 ,'���' ,'M' ,'1978-10-04');
INSERT INTO DB2021_Actor VALUES (42 ,'�����' ,'M' ,'1970-02-13');
INSERT INTO DB2021_Actor VALUES (43 ,'�̴���' ,'M' ,'1994-03-03');
INSERT INTO DB2021_Actor VALUES (44 ,'���ؿ�' ,'M' ,'1986-09-25');
INSERT INTO DB2021_Actor VALUES (45 ,'������' ,'M' ,'1971-07-11');
INSERT INTO DB2021_Actor VALUES (46 ,'����' ,'M' ,'1979-07-10');
INSERT INTO DB2021_Actor VALUES (47 ,'������' ,'F' ,'1982-11-05');
INSERT INTO DB2021_Actor VALUES (48 ,'���±�' ,'M' ,'1983-11-09');
INSERT INTO DB2021_Actor VALUES (49 ,'�ż���' ,'M' ,'1982-11-23');
INSERT INTO DB2021_Actor VALUES (50 ,'õ����' ,'F' ,'1987-04-20');
INSERT INTO DB2021_Actor VALUES (51 ,'��ȯ��' ,'F' ,'2002-08-25');
INSERT INTO DB2021_Actor VALUES (52 ,'��ҿ�' ,'F' ,'1980-01-28');
INSERT INTO DB2021_Actor VALUES (53 ,'������' ,'M' ,'1947-03-16');
INSERT INTO DB2021_Actor VALUES (54 ,'�̰濵' ,'M' ,'1960-12-12');
INSERT INTO DB2021_Actor VALUES (55 ,'������' ,'M' ,'1986-10-06');
INSERT INTO DB2021_Actor VALUES (56 ,'���޼�' ,'M' ,'1968-06-15');
INSERT INTO DB2021_Actor VALUES (57 ,'������' ,'F' ,'1980-11-07');
INSERT INTO DB2021_Actor VALUES (58 ,'�����' ,'M' ,'1988-01-02');
INSERT INTO DB2021_Actor VALUES (59 ,'������' ,'M' ,'1971-01-20');
INSERT INTO DB2021_Actor VALUES (60 ,'������' ,'F' ,'1973-11-07');
INSERT INTO DB2021_Actor VALUES (61 ,'������' ,'M' ,'1964-11-19');
INSERT INTO DB2021_Actor VALUES (62 ,'�念��' ,'F' ,'1973-11-25');
INSERT INTO DB2021_Actor VALUES (63 ,'��̶�' ,'F' ,'1975-03-06');
INSERT INTO DB2021_Actor VALUES (64 ,'�载��' ,'F' ,'1991-10-10');
INSERT INTO DB2021_Actor VALUES (65 ,'���翵' ,'M' ,'1970-11-21');
INSERT INTO DB2021_Actor VALUES (66 ,'��ȭ��' ,'F' ,'1961-02-10');
INSERT INTO DB2021_Actor VALUES (67 ,'���ػ�' ,'M' ,'1969-11-28');
INSERT INTO DB2021_Actor VALUES (68 ,'��Ƽ�' ,'F' ,'1992-08-10');
INSERT INTO DB2021_Actor VALUES (69 ,'���ٿ�' ,'F' ,'1987-05-06');
INSERT INTO DB2021_Actor VALUES (70 ,'������' ,'F' ,'1976-08-10');
INSERT INTO DB2021_Actor VALUES (71 ,'���ؼ�' ,'F' ,'1955-12-30');
INSERT INTO DB2021_Actor VALUES (72 ,'������' ,'F' ,'1999-03-25');
INSERT INTO DB2021_Actor VALUES (73 ,'�ڼҴ�' ,'F' ,'1991-09-08');
INSERT INTO DB2021_Actor VALUES (74 ,'���·�' ,'M' ,'1970-11-29');
INSERT INTO DB2021_Actor VALUES (75 ,'����' ,'M' ,'1980-07-20');
INSERT INTO DB2021_Actor VALUES (76 ,'������' ,'F' ,'1980-02-07');
INSERT INTO DB2021_Actor VALUES (77 ,'�迵��' ,'F' ,'1951-04-21');
INSERT INTO DB2021_Actor VALUES (78 ,'�ӽÿ�' ,'M' ,'1988-12-01');
INSERT INTO DB2021_Actor VALUES (79 ,'�̼�' ,'F' ,'1990-01-30');
INSERT INTO DB2021_Actor VALUES (80 ,'������' ,'F' ,'1994-11-24');
INSERT INTO DB2021_Actor VALUES (81 ,'������' ,'M' ,'1972-06-29');
INSERT INTO DB2021_Actor VALUES (82 ,'�̼���' ,'M' ,'1979-10-03');
INSERT INTO DB2021_Actor VALUES (83 ,'�����' ,'M' ,'1969-04-06');
INSERT INTO DB2021_Actor VALUES (84 ,'���汸' ,'M' ,'1968-05-01');
INSERT INTO DB2021_Actor VALUES (85 ,'������' ,'M' ,'1984-07-04');
INSERT INTO DB2021_Actor VALUES (86 ,'����' ,'F' ,'1986-12-24');
INSERT INTO DB2021_Actor VALUES (87 ,'���ο�' ,'M' ,'1969-02-20');
INSERT INTO DB2021_Actor VALUES (88 ,'����' ,'F' ,'1990-10-18');
INSERT INTO DB2021_Actor VALUES (89 ,'����' ,'M' ,'1982-06-29');
INSERT INTO DB2021_Actor VALUES (90 ,'������' ,'M' ,'1986-08-22');
INSERT INTO DB2021_Actor VALUES (91 ,'������' ,'F' ,'1994-05-31');
INSERT INTO DB2021_Actor VALUES (92 ,'���Ҷ�' ,'F' ,'1990-02-18');
INSERT INTO DB2021_Actor VALUES (93 ,'��ȿ��' ,'F' ,'1986-02-05');
INSERT INTO DB2021_Actor VALUES (94 ,'������' ,'F' ,'1988-12-24');
INSERT INTO DB2021_Actor VALUES (95 ,'�迵��' ,'F' ,'1937-12-05');
INSERT INTO DB2021_Actor VALUES (96 ,'������' ,'F' ,'1958-05-09');
INSERT INTO DB2021_Actor VALUES (97 ,'������' ,'M' ,'1971-03-01');
INSERT INTO DB2021_Actor VALUES (98 ,'������' ,'M' ,'1964-11-30');
INSERT INTO DB2021_Actor VALUES (99 ,'�ڼ���' ,'M' ,'1988-12-16');
INSERT INTO DB2021_Actor VALUES (100 ,'���ϴ�' ,'M' ,'1990-02-21');
INSERT INTO DB2021_Actor VALUES (101 ,'������' ,'M' ,'1967-04-27');
INSERT INTO DB2021_Actor VALUES (102 ,'���ϼ�' ,'F' ,'1987-10-22');
INSERT INTO DB2021_Actor VALUES (103 ,'������' ,'F' ,'1980-06-13');
INSERT INTO DB2021_Actor VALUES (104 ,'������' ,'F' ,'1999-09-22');
INSERT INTO DB2021_Actor VALUES (105 ,'������' ,'F' ,'1983-01-18');
INSERT INTO DB2021_Actor VALUES (106 ,'���Ǽ�' ,'M' ,'1965-12-17');
INSERT INTO DB2021_Actor VALUES (107 ,'�ȼ���' ,'F' ,'1992-06-27');
INSERT INTO DB2021_Actor VALUES (108 ,'�����' ,'F' ,'1967-04-23');
INSERT INTO DB2021_Actor VALUES (109 ,'�����' ,'F' ,'1997-07-19');
INSERT INTO DB2021_Actor VALUES (110 ,'������' ,'M' ,'2000-07-25');
INSERT INTO DB2021_Actor VALUES (111 ,'���μ�' ,'M' ,'1981-07-28');
INSERT INTO DB2021_Actor VALUES (112 ,'õȣ��' ,'M' ,'1960-09-09');
INSERT INTO DB2021_Actor VALUES (113 ,'���ù�' ,'M' ,'1978-03-12');
INSERT INTO DB2021_Actor VALUES (114 ,'�̺���' ,'F' ,'1979-01-12');
INSERT INTO DB2021_Actor VALUES (115 ,'������' ,'M' ,'1970-03-09');
INSERT INTO DB2021_Actor VALUES (116 ,'���ϴ�' ,'F' ,'1983-03-02');
INSERT INTO DB2021_Actor VALUES (117 ,'������' ,'M' ,'1977-09-13');
INSERT INTO DB2021_Actor VALUES (118 ,'�̵���' ,'M' ,'1985-07-22');
INSERT INTO DB2021_Actor VALUES (119 ,'����' ,'M' ,'1994-05-26');
INSERT INTO DB2021_Actor VALUES (120 ,'���ϱ�' ,'M' ,'1974-05-30');
INSERT INTO DB2021_Actor VALUES (121 ,'������' ,'M' ,'1977-02-26');
INSERT INTO DB2021_Actor VALUES (122 ,'������' ,'M' ,'1976-03-25');
INSERT INTO DB2021_Actor VALUES (123 ,'�����' ,'F' ,'2000-08-09');
INSERT INTO DB2021_Actor VALUES (124 ,'�赿��' ,'M' ,'1983-07-29');
INSERT INTO DB2021_Actor VALUES (125 ,'�ڽ���' ,'F' ,'1990-02-18');
INSERT INTO DB2021_Actor VALUES (126 ,'���ҿ�' ,'F' ,'2006-08-14');
INSERT INTO DB2021_Actor VALUES (128 ,'��ȿ��' ,'F' ,'1987-02-22');
INSERT INTO DB2021_Actor VALUES (129 ,'������' ,'M' ,'1966-03-22');
INSERT INTO DB2021_Actor VALUES (130 ,'����ȭ' ,'F' ,'1969-08-17');
INSERT INTO DB2021_Actor VALUES (131 ,'�̹α�' ,'M' ,'1985-01-16');
INSERT INTO DB2021_Actor VALUES (132 ,'������' ,'F' ,'1980-03-15');
INSERT INTO DB2021_Actor VALUES (133 ,'���α�' ,'M' ,'1978-01-20');


INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (1,1,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (1,3,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (1,2,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (2,3,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (2,4,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (3,5,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (3,9,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (3,8,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (4,6,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (4,7,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (6,11,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (5,2,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (5,10,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (6,12,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (6,13,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (7,16,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (7,15,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (7,11,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (7,14,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (8,14,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (8,11,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (8,5,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (9,17,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (9,15,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (9,18,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (9,16,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (10,19,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (11,8,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (11,21,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (1,21,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (12,23,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (12,22,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (13,24,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (13,25,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (14,25,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (14,26,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (15,27,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (15,26,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (16,28,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (16,29,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (16,30,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (17,31,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (17,32,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (17,33,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (17,34,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,16,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,5,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,18,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,9,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,35,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,13,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,32,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,36,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,37,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,38,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,39,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (21,2,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (21,18,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (21,44,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (21,45,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,2,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,46,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,47,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,48,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,49,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,33,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,13,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,50,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,51,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,52,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (24,31,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (24,17,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (24,53,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (24,54,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,13,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,55,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,18,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,56,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,57,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,58,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,59,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,13,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,56,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,60,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,61,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,62,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,63,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,64,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,65,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,8,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,30,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,66,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,67,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,68,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,2,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,55,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,69,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,70,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,71,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,72,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,73,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,12,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,74,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,36,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,75,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,76,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,2,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,77,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,56,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,33,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,78,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,68,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,79,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,80,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,81,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,82,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,83,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,84,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,78,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,85,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,70,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,52,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,86,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,87,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,88,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,89,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,90,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,91,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,92,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,93,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,94,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,95,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,50,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,96,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,97,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,12,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,5,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,36,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,98,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,33,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,99,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (36,100,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (36,101,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (36,102,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (36,103,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (37,16,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (37,5,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (37,104,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (37,105,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,46,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,106,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,98,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,107,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,3,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,108,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (39,109,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (39,110,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (39,111,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,112,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,113,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,114,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,115,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,75,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,116,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,74,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,117,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,118,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,119,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,120,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,121,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,122,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,5,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,123,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,37,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,124,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,125,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,98,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (43,74,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (43,126,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (43,56,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (44,31,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (44,74,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (44,128,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (44,92,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,84,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,129,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,130,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,131,'�ֿ�');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,132,'����');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,133,'����');


INSERT INTO DB2021_Nominations VALUES(10,2002,'������ ��ȭ��','�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(24,2016, '������ ��ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(26,2015, '������ ��ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(29,2014, '������ ��ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(34,2011,'������ ��ȭ��', '������');
INSERT INTO DB2021_Nominations VALUES(37,2008,'������ ��ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(37,2008, '���ѹα� ��ȭ���', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(19,2018, '�� ��������', '��ȭ ���');
INSERT INTO DB2021_Nominations VALUES(33,2017,'�� ��������', '��ȭ ���');
INSERT INTO DB2021_Nominations VALUES(13,2015,'��ɿ�ȭ��', '�ó�������');
INSERT INTO DB2021_Nominations VALUES(25,2016,'�ƽ����� �ְ��� ��ȭ��', '�ְ��� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(29,2015, '�ƽ����� �ְ��� ��ȭ��', '�ְ��� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(30,2014, '�ƽ����� �ְ��� ��ȭ��', '�ְ��� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(37,2009, '�ƽ����� �ְ��� ��ȭ��', '�ְ��� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(15,2010, '���� ������ȭ��', 'Arri ��');
INSERT INTO DB2021_Nominations VALUES(1,2020, '�̱� ��ī���� �û��', '��ǰ��');
INSERT INTO DB2021_Nominations VALUES(1,2020, '��󿹼����', '��ȭ ���');
INSERT INTO DB2021_Nominations VALUES(1,2020, '��󿹼����', '��ȭ ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(8,2016, '��󿹼����', '��ȭ ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(10,2003,'��󿹼����', '��ȭ ���');
INSERT INTO DB2021_Nominations VALUES(11,2012, '��󿹼����', '��ȭ ������');
INSERT INTO DB2021_Nominations VALUES(12,2015, '��󿹼����', '��ȭ �ó�������');
INSERT INTO DB2021_Nominations VALUES(13,2015, '��󿹼����', '��ȭ ���ΰ�����');
INSERT INTO DB2021_Nominations VALUES(14,2011, '��󿹼����', '��ȭ ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(19,2019, '��󿹼����', '��ȭ ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(23,2017, '��󿹼����', '��ȭ ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(30,2014, '��󿹼����', '��ȭ ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(35,2012, '��󿹼����', '��ȭ ���');
INSERT INTO DB2021_Nominations VALUES(37,2008, '��󿹼����', '��ȭ ���');
INSERT INTO DB2021_Nominations VALUES(42,2018, '��󿹼����', '��ȭ ������');
INSERT INTO DB2021_Nominations VALUES(35,2012, '�λ꿵ȭ��а���ȸ��', '���');
INSERT INTO DB2021_Nominations VALUES(25,2016, '���Ͽ�ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(29,2014, '���Ͽ�ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(26,2015, '������ο�ȭ��', '�ѱ� �ְ��� ��ȭ');
INSERT INTO DB2021_Nominations VALUES(23,2016, '��ü����ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(25,2015, '��ü����ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(37,2008, '��ü����ȭ��' , '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(38,2016, '��ü����ȭ��', '�ֿ�� ������');
INSERT INTO DB2021_Nominations VALUES(20,2018, '�ƽþ� �ʸ� �����', '�ֿ�� �Կ���');
INSERT INTO DB2021_Nominations VALUES(1,2019, 'û�濵ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(7,2012, 'û�濵ȭ��', '�ѱ���ȭ �ִٰ�����');
INSERT INTO DB2021_Nominations VALUES(7,2012, 'û�濵ȭ��', '�����');
INSERT INTO DB2021_Nominations VALUES(8,2015, 'û�濵ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(8,2015, 'û�濵ȭ��', '�����');
INSERT INTO DB2021_Nominations VALUES(17,2021, 'û�濵ȭ��' , '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(23,2016, 'û�濵ȭ��', '������');
INSERT INTO DB2021_Nominations VALUES(24,2016, 'û�濵ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(30,2014, 'û�濵ȭ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(39,2021, 'û�濵ȭ��' , '������');
INSERT INTO DB2021_Nominations VALUES(41,2019, 'û�濵ȭ��', '�ѱ���ȭ �ִٰ�����');
INSERT INTO DB2021_Nominations VALUES(42,2018, 'û�濵ȭ��', '�ѱ���ȭ �ִٰ�����');
INSERT INTO DB2021_Nominations VALUES(20,2018, '��翵ȭ��', '������');
INSERT INTO DB2021_Nominations VALUES(5,2009, 'ĭ��ȭ��', '�ɻ�������');
INSERT INTO DB2021_Nominations VALUES(18,2018, '�ĸ��ѱ���ȭ��', '��ǰ��-����ȭ');
INSERT INTO DB2021_Nominations VALUES(38,2016, '��Ÿ���� ��ȭ��', '�ְ� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(21,2018, '�Ƿ�ü �ѱ���ȭ��', '�ɻ�������');
INSERT INTO DB2021_Nominations VALUES(17,2020, '�ѱ���ȭ��а���ȸ��' , '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(28,2015, '�ѱ���ȭ��а���ȸ��', '�ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(39,2020,'�ѱ���ȭ��а���ȸ��', '������');
INSERT INTO DB2021_Nominations VALUES(40,2006,'�ѱ���ȭ��а���ȸ��', '������');
INSERT INTO DB2021_Nominations VALUES(14,2011, 'Ȳ���Կ��� �û��' , '�Կ���-�ݻ�');
INSERT INTO DB2021_Nominations VALUES(15,2009, 'Ȳ���Կ��� �û��', '�Կ���-����');
INSERT INTO DB2021_Nominations VALUES(26,2015, 'Ȳ���Կ��� �û��' ,' �ֿ�� ��ǰ��');
INSERT INTO DB2021_Nominations VALUES(27,2015,'��ȥ������ȭ��', '�ֿ�� ��ǰ��');



