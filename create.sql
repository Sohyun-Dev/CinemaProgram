CREATE DATABASE DB2021Team05;
SHOW DATABASES;
USE DB2021Team05;

CREATE TABLE DB2021_Movie (					#중심 영화 테이블
	Movie_ID INT NOT NULL AUTO_INCREMENT,
	Title VARCHAR(50) NOT NULL,
	Genre ENUM("드라마", "미스터리", "스릴러", "멜로", "범죄", "액션", "코미디", "판타지") ,
	ReleaseDate DATE,
	Production VARCHAR(30),
	Score FLOAT,							#영화의 평균 평점
	Review_cnt INT DEFAULT 100 NOT NULL,	#100명의 평균평점으로 가정한다
PRIMARY KEY(Movie_ID)
);

CREATE TABLE DB2021_Review (				#리뷰를 저장하는 테이블
	Review_ID INT NOT NULL AUTO_INCREMENT,
	Movie_ID INT NOT NULL,
	Date DATE,
	Score FLOAT,
	Writer VARCHAR(20) NOT NULL,			#사용자의 이름
	Review VARCHAR(100),					#사용자가 작성한 리뷰를 저장
PRIMARY KEY(Review_ID),
FOREIGN KEY(Movie_ID) REFERENCES DB2021_Movie(Movie_ID)
);

CREATE TABLE DB2021_Actor (					#배우 테이블
	Actor_ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(30) NOT NULL,
	Sex ENUM("M", "F"),
	Born DATE,								#생년월일
PRIMARY KEY(Actor_ID)
);

CREATE TABLE DB2021_Movie_cast (			#특정 영화에 출연한 배우 테이블
	Movie_ID INT NOT NULL,
	Actor_ID INT NOT NULL,
	Role ENUM("주연", "조연"),
PRIMARY KEY(Movie_ID, Actor_ID),
FOREIGN KEY(Movie_ID) REFERENCES DB2021_Movie(Movie_ID),
FOREIGN KEY(Actor_ID) REFERENCES DB2021_Actor(Actor_ID)
);

CREATE TABLE DB2021_Nominations (			#수상 정보 테이블
	Movie_ID INT NOT NULL,
	Year INT,								#수상년도
	Award VARCHAR(30),						#영화제이름
	Prize VARCHAR(30),
PRIMARY KEY(Movie_ID, Award, Prize),
FOREIGN KEY(Movie_ID) REFERENCES DB2021_Movie(Movie_ID)
);

CREATE TABLE DB2021_Director (				#감독정보
	Director_ID INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(30),
PRIMARY KEY(Director_ID)
);

CREATE TABLE DB2021_Movie_direction (		#특정 영화를 감독한 감독 테이블
	Movie_ID INT NOT NULL ,
	Director_ID INT NOT NULL ,
PRIMARY KEY(Movie_ID, Director_ID),
FOREIGN KEY(Movie_ID) REFERENCES DB2021_Movie(Movie_ID),
FOREIGN KEY(Director_ID) REFERENCES DB2021_Director(Director_ID)
);



CREATE VIEW DB2021_ViewMovie AS				#영화 검색 결과 출력을 위한 view 정의
SELECT Title, Director, Genre, ReleaseDate, Score
FROM DB2021_Movie JOIN (SELECT Movie_ID, Director_ID, DB2021_Director.Name AS Director
						FROM DB2021_Movie_direction JOIN DB2021_Director
						USING(Director_ID)
						) T
USING(Movie_ID);


CREATE VIEW DB2021_ViewReview AS			#리뷰 출력을 위한 view 정의
SELECT Review_ID, Title, Writer, Date, DB2021_Review.Score AS sc, Review
FROM DB2021_Review JOIN DB2021_Movie
USING (Movie_ID);

CREATE INDEX idx_movie ON DB2021_Movie( Movie_ID );            		#인덱스 정의   
CREATE INDEX idx_movie ON DB2021_Movie( Title );
CREATE INDEX idx_director ON DB2021_Director( director_ID );
CREATE INDEX idx_director ON DB2021_Director( name );
CREATE INDEX idx_actor ON DB2021_actor( Actor_ID );


#여기부터는 insert문입니다.

INSERT INTO DB2021_Movie(Movie_ID, Title, Genre, ReleaseDate, Production, Score)
VALUES
(1,'기생충','드라마','2019-05-30','CJ ENM',9.07),
(2,'마녀','미스터리','2018-06-27','워너 브러더스 코리아㈜',8.58),
(3,'아가씨','스릴러','2016-06-01','CJ ENM',7.69),
(4,'옥자','드라마','2017-06-29','(주)NEW',8.77),
(5,'박쥐','멜로','2009-04-30','CJ ENM',6.3),
(6,'신세계','범죄','2013-02-21','(주)NEW',8.93),
(7,'도둑들','범죄','2012-07-25','㈜쇼박스',7.63),
(8,'암살','드라마','2015-07-22','㈜쇼박스',9.1),
(9,'타짜1','범죄','2006-09-28','CJ ENM',9.19),
(10,'집으로','드라마','2002-04-05','(주)팝엔터테인먼트',9.38),
(11,'화차','미스터리','2012-03-08','필라멘트 픽쳐스',8.06),
(12,'카트','드라마','2014-11-13','리틀빅픽처스',8.61),
(13,'도희야','드라마','2014-05-22','무비꼴라쥬',7.28),
(14,'아저씨','액션','2010-08-04','CJ ENM',9.24),
(15,'마더','범죄','2009-05-28','CJ ENM',9.45),
(16,'미나리','드라마','2021-03-03','Plan B',8.33),
(17,'남산의 부장들','드라마','2020-01-22','(주)쇼박스',8.46),
(18,'1987','드라마','2017-12-27','CJ ENM',9.31),
(19,'공작','드라마','2018-08-08','CJ ENM',7.86),
(20,'남한산성','드라마','2017-10-03','CJ ENM',8.17),
(21,'택시운전사','드라마','2017-08-02','(주)쇼박스',9.28),
(22,'밀정','액션','2016-09-07','워너 브러더스 코리아㈜',8.57),
(23,'곡성','스릴러','2016-05-12','이십세기폭스코리아(주)',8.22),
(24,'내부자들','범죄','2015-11-19','(주)쇼박스',9.06),
(25,'베테랑','액션','2015-08-05','CJ ENM',9.24),
(26,'국제시장','드라마','2014-12-17','CJ ENM',9.16),
(27,'지금은맞고그때는틀리다','드라마','2015-09-24','(주)NEW',8.43),
(28,'사도','드라마','2015-09-16','(주)쇼박스',8.49),
(29,'명량','액션','2014-07-30','CJ ENM',8.88),
(30,'변호인','드라마','2013-12-18','(주)NEW',9.29),
(31,'삼진그룹 영어토익반','드라마','2020-10-21','롯데엔터테인먼트',9.03),
(32,'불한당: 나쁜 놈들의 세상','범죄','2017-05-17','CJ ENM',8.15),
(33,'박열','드라마','2017-06-28','메가박스중앙(주)플러스엠',8.48),
(34,'써니','코미디','2011-05-04','CJ ENM',9.11),
(35,'범죄와의 전쟁 : 나쁜놈들 전성시대','범죄','2012-02-02','(주)쇼박스',8.64),
(36,'청년경찰','액션','2017-08-09','롯데엔터테인먼트',9.03),
(37,'추격자','범죄','2008-02-14','(주)쇼박스',9.09),
(38,'부산행','액션','2016-07-20','(주)NEW',8.6),
(39,'윤희에게','멜로','2019-11-14','리틀빅픽처스',9.23),
(40,'비열한 거리','범죄','2006-06-15','CJ ENM',8.79),
(41,'극한직업','코미디','2019-01-23','CJ ENM',9.2),
(42,'신과함께-죄와 벌','판타지','2017-12-20','롯데엔터테인먼트',8.73),
(43,'7번방의 선물','코미디','2013-01-23','(주)NEW',8.83),
(44,'광해 : 왕이 된 남자','드라마','2012-09-13','CJ ENM',9.25),
(45,'해운대','드라마','2009-07-22','CJ ENM',7.45);


insert into db2021_director
values
(1,'봉준호'),
(2,'박훈정'),
(3,'박찬욱'),
(4,'최동훈'),
(5,'이정향'),
(6,'변영주'),
(7,'부지영'),
(8,'정주리'),
(9,'이정범'),
(10,'정이삭'),
(11,'우민호'),
(12,'장진환'),
(13,'윤종빈'),
(14,'황동혁'),
(15,'장훈'),
(16,'김지운'),
(17,'나홍진'),
(18,'류승완'),
(19,'윤제균'),
(20,'홍상수'),
(21,'이준익'),
(22,'김한민'),
(23,'양우석'),
(24,'이종필'),
(25,'변성현'),
(26,'강형철'),
(27,'김주환'),
(28,'연상호'),
(29,'임대형'),
(30,'유하'),
(31,'이병헌'),
(32,'김용화'),
(33,'이환경'),
(34,'추창민');

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



INSERT INTO DB2021_Actor VALUES (1 ,'박소담' ,'F' ,'1991-09-08');
INSERT INTO DB2021_Actor VALUES (2 ,'송강호' ,'M' ,'1967-01-17');
INSERT INTO DB2021_Actor VALUES (3 ,'최우식' ,'M' ,'1990-03-26');
INSERT INTO DB2021_Actor VALUES (4 ,'김다미' ,'F' ,'1995-04-09');
INSERT INTO DB2021_Actor VALUES (5 ,'하정우' ,'M' ,'1978-03-11');
INSERT INTO DB2021_Actor VALUES (6 ,'안서현' ,'F' ,'2004-01-12');
INSERT INTO DB2021_Actor VALUES (7 ,'틸다 스윈튼' ,'F' ,'1960-11-05');
INSERT INTO DB2021_Actor VALUES (8 ,'김민희' ,'F' ,'1982-03-01');
INSERT INTO DB2021_Actor VALUES (9 ,'김태리' ,'F' ,'1990-04-24');
INSERT INTO DB2021_Actor VALUES (10 ,'김옥빈' ,'F' ,'1987-01-03');
INSERT INTO DB2021_Actor VALUES (11 ,'이정재' ,'M' ,'1972-12-15');
INSERT INTO DB2021_Actor VALUES (12 ,'최민식' ,'M' ,'1962-04-27');
INSERT INTO DB2021_Actor VALUES (13 ,'황정민' ,'M' ,'1970-09-01');
INSERT INTO DB2021_Actor VALUES (14 ,'전지현' ,'F' ,'1981-10-30');
INSERT INTO DB2021_Actor VALUES (15 ,'김혜수' ,'F' ,'1970-09-05');
INSERT INTO DB2021_Actor VALUES (16 ,'김윤석' ,'M' ,'1967-01-21');
INSERT INTO DB2021_Actor VALUES (17 ,'조승우' ,'M' ,'1980-03-28');
INSERT INTO DB2021_Actor VALUES (18 ,'유해진' ,'M' ,'1970-01-04');
INSERT INTO DB2021_Actor VALUES (19 ,'유승호' ,'M' ,'1993-08-17');
INSERT INTO DB2021_Actor VALUES (21 ,'이선균' ,'M' ,'1975-03-02');
INSERT INTO DB2021_Actor VALUES (22 ,'염정아' ,'F' ,'1972-07-28');
INSERT INTO DB2021_Actor VALUES (23 ,'문정희' ,'F' ,'1976-01-12');
INSERT INTO DB2021_Actor VALUES (24 ,'배두나' ,'F' ,'1979-10-11');
INSERT INTO DB2021_Actor VALUES (25 ,'김새론' ,'F' ,'2000-07-31');
INSERT INTO DB2021_Actor VALUES (26 ,'원빈' ,'M' ,'1977-11-10');
INSERT INTO DB2021_Actor VALUES (27 ,'김혜자' ,'F' ,'1941-09-14');
INSERT INTO DB2021_Actor VALUES (28 ,'스티븐 연' ,'M' ,'1983-12-21');
INSERT INTO DB2021_Actor VALUES (29 ,'한예리' ,'F' ,'1984-12-23');
INSERT INTO DB2021_Actor VALUES (30 ,'윤여정' ,'F' ,'1947-06-19');
INSERT INTO DB2021_Actor VALUES (31 ,'이병헌' ,'M' ,'1970-07-12');
INSERT INTO DB2021_Actor VALUES (32 ,'이성민' ,'M' ,'1968-12-04');
INSERT INTO DB2021_Actor VALUES (33 ,'곽도원' ,'M' ,'1973-05-17');
INSERT INTO DB2021_Actor VALUES (34 ,'김소진' ,'F' ,'1979-12-12');
INSERT INTO DB2021_Actor VALUES (35 ,'유승목' ,'M' ,'1969-09-14');
INSERT INTO DB2021_Actor VALUES (36 ,'조진웅' ,'M' ,'1976-04-02');
INSERT INTO DB2021_Actor VALUES (37 ,'주지훈' ,'M' ,'1982-05-16');
INSERT INTO DB2021_Actor VALUES (38 ,'김응수' ,'M' ,'1961-03-28');
INSERT INTO DB2021_Actor VALUES (39 ,'정소리' ,'F' ,'1977-01-26');
INSERT INTO DB2021_Actor VALUES (40 ,'박해일' ,'M' ,'1977-01-26');
INSERT INTO DB2021_Actor VALUES (41 ,'고수' ,'M' ,'1978-10-04');
INSERT INTO DB2021_Actor VALUES (42 ,'박희순' ,'M' ,'1970-02-13');
INSERT INTO DB2021_Actor VALUES (43 ,'이다윗' ,'M' ,'1994-03-03');
INSERT INTO DB2021_Actor VALUES (44 ,'류준열' ,'M' ,'1986-09-25');
INSERT INTO DB2021_Actor VALUES (45 ,'박혁권' ,'M' ,'1971-07-11');
INSERT INTO DB2021_Actor VALUES (46 ,'공유' ,'M' ,'1979-07-10');
INSERT INTO DB2021_Actor VALUES (47 ,'한지민' ,'F' ,'1982-11-05');
INSERT INTO DB2021_Actor VALUES (48 ,'엄태구' ,'M' ,'1983-11-09');
INSERT INTO DB2021_Actor VALUES (49 ,'신성록' ,'M' ,'1982-11-23');
INSERT INTO DB2021_Actor VALUES (50 ,'천우희' ,'F' ,'1987-04-20');
INSERT INTO DB2021_Actor VALUES (51 ,'김환희' ,'F' ,'2002-08-25');
INSERT INTO DB2021_Actor VALUES (52 ,'장소연' ,'F' ,'1980-01-28');
INSERT INTO DB2021_Actor VALUES (53 ,'백윤식' ,'M' ,'1947-03-16');
INSERT INTO DB2021_Actor VALUES (54 ,'이경영' ,'M' ,'1960-12-12');
INSERT INTO DB2021_Actor VALUES (55 ,'유아인' ,'M' ,'1986-10-06');
INSERT INTO DB2021_Actor VALUES (56 ,'오달수' ,'M' ,'1968-06-15');
INSERT INTO DB2021_Actor VALUES (57 ,'장윤주' ,'F' ,'1980-11-07');
INSERT INTO DB2021_Actor VALUES (58 ,'김시후' ,'M' ,'1988-01-02');
INSERT INTO DB2021_Actor VALUES (59 ,'정웅인' ,'M' ,'1971-01-20');
INSERT INTO DB2021_Actor VALUES (60 ,'김윤진' ,'F' ,'1973-11-07');
INSERT INTO DB2021_Actor VALUES (61 ,'정진영' ,'M' ,'1964-11-19');
INSERT INTO DB2021_Actor VALUES (62 ,'장영남' ,'F' ,'1973-11-25');
INSERT INTO DB2021_Actor VALUES (63 ,'라미란' ,'F' ,'1975-03-06');
INSERT INTO DB2021_Actor VALUES (64 ,'김슬기' ,'F' ,'1991-10-10');
INSERT INTO DB2021_Actor VALUES (65 ,'정재영' ,'M' ,'1970-11-21');
INSERT INTO DB2021_Actor VALUES (66 ,'최화정' ,'F' ,'1961-02-10');
INSERT INTO DB2021_Actor VALUES (67 ,'유준상' ,'M' ,'1969-11-28');
INSERT INTO DB2021_Actor VALUES (68 ,'고아성' ,'F' ,'1992-08-10');
INSERT INTO DB2021_Actor VALUES (69 ,'문근영' ,'F' ,'1987-05-06');
INSERT INTO DB2021_Actor VALUES (70 ,'전혜진' ,'F' ,'1976-08-10');
INSERT INTO DB2021_Actor VALUES (71 ,'김해숙' ,'F' ,'1955-12-30');
INSERT INTO DB2021_Actor VALUES (72 ,'진지희' ,'F' ,'1999-03-25');
INSERT INTO DB2021_Actor VALUES (73 ,'박소담' ,'F' ,'1991-09-08');
INSERT INTO DB2021_Actor VALUES (74 ,'류승룡' ,'M' ,'1970-11-29');
INSERT INTO DB2021_Actor VALUES (75 ,'진구' ,'M' ,'1980-07-20');
INSERT INTO DB2021_Actor VALUES (76 ,'이정현' ,'F' ,'1980-02-07');
INSERT INTO DB2021_Actor VALUES (77 ,'김영애' ,'F' ,'1951-04-21');
INSERT INTO DB2021_Actor VALUES (78 ,'임시완' ,'M' ,'1988-12-01');
INSERT INTO DB2021_Actor VALUES (79 ,'이솜' ,'F' ,'1990-01-30');
INSERT INTO DB2021_Actor VALUES (80 ,'박혜수' ,'F' ,'1994-11-24');
INSERT INTO DB2021_Actor VALUES (81 ,'백현진' ,'M' ,'1972-06-29');
INSERT INTO DB2021_Actor VALUES (82 ,'이성욱' ,'M' ,'1979-10-03');
INSERT INTO DB2021_Actor VALUES (83 ,'김원해' ,'M' ,'1969-04-06');
INSERT INTO DB2021_Actor VALUES (84 ,'설경구' ,'M' ,'1968-05-01');
INSERT INTO DB2021_Actor VALUES (85 ,'이제훈' ,'M' ,'1984-07-04');
INSERT INTO DB2021_Actor VALUES (86 ,'최희서' ,'F' ,'1986-12-24');
INSERT INTO DB2021_Actor VALUES (87 ,'김인우' ,'M' ,'1969-02-20');
INSERT INTO DB2021_Actor VALUES (88 ,'윤슬' ,'F' ,'1990-10-18');
INSERT INTO DB2021_Actor VALUES (89 ,'권율' ,'M' ,'1982-06-29');
INSERT INTO DB2021_Actor VALUES (90 ,'민진웅' ,'M' ,'1986-08-22');
INSERT INTO DB2021_Actor VALUES (91 ,'심은경' ,'F' ,'1994-05-31');
INSERT INTO DB2021_Actor VALUES (92 ,'강소라' ,'F' ,'1990-02-18');
INSERT INTO DB2021_Actor VALUES (93 ,'민효린' ,'F' ,'1986-02-05');
INSERT INTO DB2021_Actor VALUES (94 ,'박진주' ,'F' ,'1988-12-24');
INSERT INTO DB2021_Actor VALUES (95 ,'김영옥' ,'F' ,'1937-12-05');
INSERT INTO DB2021_Actor VALUES (96 ,'김혜옥' ,'F' ,'1958-05-09');
INSERT INTO DB2021_Actor VALUES (97 ,'마동석' ,'M' ,'1971-03-01');
INSERT INTO DB2021_Actor VALUES (98 ,'김종수' ,'M' ,'1964-11-30');
INSERT INTO DB2021_Actor VALUES (99 ,'박서준' ,'M' ,'1988-12-16');
INSERT INTO DB2021_Actor VALUES (100 ,'강하늘' ,'M' ,'1990-02-21');
INSERT INTO DB2021_Actor VALUES (101 ,'성동일' ,'M' ,'1967-04-27');
INSERT INTO DB2021_Actor VALUES (102 ,'박하선' ,'F' ,'1987-10-22');
INSERT INTO DB2021_Actor VALUES (103 ,'서영희' ,'F' ,'1980-06-13');
INSERT INTO DB2021_Actor VALUES (104 ,'김유정' ,'F' ,'1999-09-22');
INSERT INTO DB2021_Actor VALUES (105 ,'정유미' ,'F' ,'1983-01-18');
INSERT INTO DB2021_Actor VALUES (106 ,'김의성' ,'M' ,'1965-12-17');
INSERT INTO DB2021_Actor VALUES (107 ,'안소희' ,'F' ,'1992-06-27');
INSERT INTO DB2021_Actor VALUES (108 ,'김희애' ,'F' ,'1967-04-23');
INSERT INTO DB2021_Actor VALUES (109 ,'김소혜' ,'F' ,'1997-07-19');
INSERT INTO DB2021_Actor VALUES (110 ,'성유빈' ,'M' ,'2000-07-25');
INSERT INTO DB2021_Actor VALUES (111 ,'조인성' ,'M' ,'1981-07-28');
INSERT INTO DB2021_Actor VALUES (112 ,'천호진' ,'M' ,'1960-09-09');
INSERT INTO DB2021_Actor VALUES (113 ,'남궁민' ,'M' ,'1978-03-12');
INSERT INTO DB2021_Actor VALUES (114 ,'이보영' ,'F' ,'1979-01-12');
INSERT INTO DB2021_Actor VALUES (115 ,'윤제문' ,'M' ,'1970-03-09');
INSERT INTO DB2021_Actor VALUES (116 ,'이하늬' ,'F' ,'1983-03-02');
INSERT INTO DB2021_Actor VALUES (117 ,'진선규' ,'M' ,'1977-09-13');
INSERT INTO DB2021_Actor VALUES (118 ,'이동휘' ,'M' ,'1985-07-22');
INSERT INTO DB2021_Actor VALUES (119 ,'공명' ,'M' ,'1994-05-26');
INSERT INTO DB2021_Actor VALUES (120 ,'신하균' ,'M' ,'1974-05-30');
INSERT INTO DB2021_Actor VALUES (121 ,'오정세' ,'M' ,'1977-02-26');
INSERT INTO DB2021_Actor VALUES (122 ,'차태현' ,'M' ,'1976-03-25');
INSERT INTO DB2021_Actor VALUES (123 ,'김향기' ,'F' ,'2000-08-09');
INSERT INTO DB2021_Actor VALUES (124 ,'김동욱' ,'M' ,'1983-07-29');
INSERT INTO DB2021_Actor VALUES (125 ,'박신혜' ,'F' ,'1990-02-18');
INSERT INTO DB2021_Actor VALUES (126 ,'갈소원' ,'F' ,'2006-08-14');
INSERT INTO DB2021_Actor VALUES (128 ,'한효주' ,'F' ,'1987-02-22');
INSERT INTO DB2021_Actor VALUES (129 ,'박중훈' ,'M' ,'1966-03-22');
INSERT INTO DB2021_Actor VALUES (130 ,'엄정화' ,'F' ,'1969-08-17');
INSERT INTO DB2021_Actor VALUES (131 ,'이민기' ,'M' ,'1985-01-16');
INSERT INTO DB2021_Actor VALUES (132 ,'강예원' ,'F' ,'1980-03-15');
INSERT INTO DB2021_Actor VALUES (133 ,'김인권' ,'M' ,'1978-01-20');


INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (1,1,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (1,3,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (1,2,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (2,3,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (2,4,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (3,5,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (3,9,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (3,8,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (4,6,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (4,7,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (6,11,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (5,2,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (5,10,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (6,12,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (6,13,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (7,16,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (7,15,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (7,11,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (7,14,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (8,14,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (8,11,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (8,5,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (9,17,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (9,15,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (9,18,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (9,16,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (10,19,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (11,8,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (11,21,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (1,21,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (12,23,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (12,22,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (13,24,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (13,25,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (14,25,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (14,26,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (15,27,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (15,26,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (16,28,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (16,29,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (16,30,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (17,31,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (17,32,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (17,33,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (17,34,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,16,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,5,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,18,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,9,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (18,35,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,13,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,32,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,36,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,37,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,38,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (19,39,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (21,2,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (21,18,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (21,44,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (21,45,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,2,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,46,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,47,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,48,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (22,49,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,33,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,13,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,50,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,51,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (23,52,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (24,31,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (24,17,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (24,53,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (24,54,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,13,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,55,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,18,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,56,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,57,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,58,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (25,59,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,13,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,56,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,60,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,61,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,62,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,63,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (26,64,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,65,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,8,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,30,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,66,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,67,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (27,68,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,2,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,55,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,69,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,70,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,71,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,72,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (28,73,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,12,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,74,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,36,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,75,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (29,76,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,2,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,77,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,56,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,33,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (30,78,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,68,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,79,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,80,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,81,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,82,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (31,83,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,84,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,78,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,85,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,70,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (32,52,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,86,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,87,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,88,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,89,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,90,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (33,91,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,92,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,93,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,94,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,95,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,50,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,96,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (34,97,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,12,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,5,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,36,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,98,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,33,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (35,99,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (36,100,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (36,101,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (36,102,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (36,103,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (37,16,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (37,5,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (37,104,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (37,105,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,46,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,106,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,98,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,107,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,3,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (38,108,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (39,109,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (39,110,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (39,111,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,112,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,113,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,114,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,115,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,75,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (40,116,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,74,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,117,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,118,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,119,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,120,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,121,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (41,122,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,5,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,123,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,37,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,124,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,125,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (42,98,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (43,74,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (43,126,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (43,56,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (44,31,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (44,74,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (44,128,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (44,92,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,84,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,129,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,130,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,131,'주연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,132,'조연');
INSERT DB2021_Movie_cast(Movie_ID, Actor_ID, Role) VALUES (45,133,'조연');


INSERT INTO DB2021_Nominations VALUES(10,2002,'대종상 영화제','최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(24,2016, '대종상 영화제', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(26,2015, '대종상 영화제', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(29,2014, '대종상 영화제', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(34,2011,'대종상 영화제', '감독상');
INSERT INTO DB2021_Nominations VALUES(37,2008,'대종상 영화제', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(37,2008, '대한민국 영화대상', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(19,2018, '더 서울어워즈', '영화 대상');
INSERT INTO DB2021_Nominations VALUES(33,2017,'더 서울어워즈', '영화 대상');
INSERT INTO DB2021_Nominations VALUES(13,2015,'들꽃영화상', '시나리오상');
INSERT INTO DB2021_Nominations VALUES(25,2016,'맥스무비 최고의 영화상', '최고의 작품상');
INSERT INTO DB2021_Nominations VALUES(29,2015, '맥스무비 최고의 영화상', '최고의 작품상');
INSERT INTO DB2021_Nominations VALUES(30,2014, '맥스무비 최고의 영화상', '최고의 작품상');
INSERT INTO DB2021_Nominations VALUES(37,2009, '맥스무비 최고의 영화상', '최고의 작품상');
INSERT INTO DB2021_Nominations VALUES(15,2010, '뮌헨 국제영화제', 'Arri 상');
INSERT INTO DB2021_Nominations VALUES(1,2020, '미국 아카데미 시상식', '작품상');
INSERT INTO DB2021_Nominations VALUES(1,2020, '백상예술대상', '영화 대상');
INSERT INTO DB2021_Nominations VALUES(1,2020, '백상예술대상', '영화 작품상');
INSERT INTO DB2021_Nominations VALUES(8,2016, '백상예술대상', '영화 작품상');
INSERT INTO DB2021_Nominations VALUES(10,2003,'백상예술대상', '영화 대상');
INSERT INTO DB2021_Nominations VALUES(11,2012, '백상예술대상', '영화 감독상');
INSERT INTO DB2021_Nominations VALUES(12,2015, '백상예술대상', '영화 시나리오상');
INSERT INTO DB2021_Nominations VALUES(13,2015, '백상예술대상', '영화 신인감독상');
INSERT INTO DB2021_Nominations VALUES(14,2011, '백상예술대상', '영화 작품상');
INSERT INTO DB2021_Nominations VALUES(19,2019, '백상예술대상', '영화 작품상');
INSERT INTO DB2021_Nominations VALUES(23,2017, '백상예술대상', '영화 작품상');
INSERT INTO DB2021_Nominations VALUES(30,2014, '백상예술대상', '영화 작품상');
INSERT INTO DB2021_Nominations VALUES(35,2012, '백상예술대상', '영화 대상');
INSERT INTO DB2021_Nominations VALUES(37,2008, '백상예술대상', '영화 대상');
INSERT INTO DB2021_Nominations VALUES(42,2018, '백상예술대상', '영화 감독상');
INSERT INTO DB2021_Nominations VALUES(35,2012, '부산영화평론가협회상', '대상');
INSERT INTO DB2021_Nominations VALUES(25,2016, '부일영화상', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(29,2014, '부일영화상', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(26,2015, '서울노인영화제', '한국 최고의 영화');
INSERT INTO DB2021_Nominations VALUES(23,2016, '시체스영화제', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(25,2015, '시체스영화제', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(37,2008, '시체스영화제' , '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(38,2016, '시체스영화제', '최우수 감독상');
INSERT INTO DB2021_Nominations VALUES(20,2018, '아시안 필름 어워드', '최우수 촬영상');
INSERT INTO DB2021_Nominations VALUES(1,2019, '청룡영화상', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(7,2012, '청룡영화상', '한국영화 최다관객상');
INSERT INTO DB2021_Nominations VALUES(7,2012, '청룡영화상', '기술상');
INSERT INTO DB2021_Nominations VALUES(8,2015, '청룡영화상', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(8,2015, '청룡영화상', '기술상');
INSERT INTO DB2021_Nominations VALUES(17,2021, '청룡영화상' , '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(23,2016, '청룡영화상', '감독상');
INSERT INTO DB2021_Nominations VALUES(24,2016, '청룡영화상', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(30,2014, '청룡영화상', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(39,2021, '청룡영화상' , '감독상');
INSERT INTO DB2021_Nominations VALUES(41,2019, '청룡영화상', '한국영화 최다관객상');
INSERT INTO DB2021_Nominations VALUES(42,2018, '청룡영화상', '한국영화 최다관객상');
INSERT INTO DB2021_Nominations VALUES(20,2018, '춘사영화제', '감독상');
INSERT INTO DB2021_Nominations VALUES(5,2009, '칸영화제', '심사위원상');
INSERT INTO DB2021_Nominations VALUES(18,2018, '파리한국영화제', '작품상-장편영화');
INSERT INTO DB2021_Nominations VALUES(38,2016, '판타지아 영화제', '최고 작품상');
INSERT INTO DB2021_Nominations VALUES(21,2018, '피렌체 한국영화제', '심사위원상');
INSERT INTO DB2021_Nominations VALUES(17,2020, '한국영화평론가협회상' , '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(28,2015, '한국영화평론가협회상', '최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(39,2020,'한국영화평론가협회상', '감독상');
INSERT INTO DB2021_Nominations VALUES(40,2006,'한국영화평론가협회상', '감독상');
INSERT INTO DB2021_Nominations VALUES(14,2011, '황금촬영상 시상식' , '촬영상-금상');
INSERT INTO DB2021_Nominations VALUES(15,2009, '황금촬영상 시상식', '촬영상-은상');
INSERT INTO DB2021_Nominations VALUES(26,2015, '황금촬영상 시상식' ,' 최우수 작품상');
INSERT INTO DB2021_Nominations VALUES(27,2015,'히혼국제영화제', '최우수 작품상');



