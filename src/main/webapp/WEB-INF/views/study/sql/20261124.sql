show tables;

/* 도서관리 프로젝트에 사용하는 테이블 설계 */

/* 책(books)테이블 */
create table books (
  bookid    int  not null  auto_increment,  /* 책 고유번호 */
  bookname  varchar(20) not null,           /* 책 이름 */
  publisher varchar(20) not null,           /* 출판사 명 */
  price     int default 0,                  /* 책 가격 */
  primary key(bookid)
);

INSERT INTO books VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO books VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO books VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO books VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO books VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO books VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO books VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO books VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO books VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO books VALUES(10, 'Olympic Champions', 'Pearson', 13000);
INSERT INTO books VALUES(11, '가나다', '삼성당', 17500);
INSERT INTO books VALUES(12, '포토샵CS6', '제우미디어', 25000);
INSERT INTO books VALUES(13, '아시안게임 이야기', '스포츠북', 19500);
INSERT INTO books VALUES(14, '우리들 이야기', '우리출판사', 5000);
INSERT INTO books VALUES(15, '서로 사랑하자', '이상미디어', 18000);
INSERT INTO books VALUES(16, '하나된 마음으로', '대한미디어', 21000);
INSERT INTO books VALUES(17, '나눌수 있을때', '나무수', 9000);
INSERT INTO books VALUES(18, '함박눈 내리는날', '이상미디어', 15000);
INSERT INTO books VALUES(19, '나보다 축구를', '굿스포츠', 23000);
INSERT INTO books VALUES(20, '시작했을때 한번더', '삼성당', 19000);

-- 고객 테이블
create table customer (
  custid   int  not null  auto_increment,   /* 고객 고유번호 */
  name     varchar(20) not null,            /* 고객명 */
  address  varchar(20) not null,            /* 고객 기본주소 */
  phone    varchar(15),                     /* 고객 연락처 */
  primary key(custid) 
);

INSERT INTO customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO customer VALUES (3, '김말숙', '대한민국 강원도', '000-7000-0001');
INSERT INTO customer VALUES (4, '손흥민', '영국 토트넘', '000-8000-0001');
INSERT INTO customer VALUES (5, '박세리', '대한민국 대전',  '001-0011-0012');
INSERT INTO customer VALUES (6, '이순신', '대한민국 아산',  '001-0009-0007');
INSERT INTO customer VALUES (7, '소나무', '대한민국 청주',  '000-1100-0050');

-- 주문테이블
create table orders (
  orderid   int  not null  auto_increment,  /* 주문 고유번호 */
  custid    int  not null,                  /* 고객의 고유번호 */
  bookid    int  not null,                  /* 책의 고유번호 */
  saleprice int  default 0,                 /* 책 할인 가격 */
  orderdate datetime  default now(),        /* 책 주문날짜 */
  primary key(orderid),
  foreign key(custid) references customer(custid) on update cascade on delete restrict,
  foreign key(bookid) references books(bookid) on update cascade on delete restrict
);

INSERT INTO orders VALUES (1, 1, 1, 6000, '2019-08-01'); 
INSERT INTO orders VALUES (2, 1, 3, 21000, '2018-09-03');
INSERT INTO orders VALUES (3, 2, 5, 8000, '2022-11-03'); 
INSERT INTO orders VALUES (4, 3, 6, 6000, '2020-06-04'); 
INSERT INTO orders VALUES (5, 4, 7, 19000, '2019-11-05');
INSERT INTO orders VALUES (6, 1, 2, 12000, '2021-09-07');
INSERT INTO orders VALUES (7, 4, 8, 11000, '2019-03-07');
INSERT INTO orders VALUES (8, 3, 10, 12000, '2021-07-08');
INSERT INTO orders VALUES (9, 2, 10, 9000, '2017-05-09');
INSERT INTO orders VALUES (10, 3, 18, 13000, '2023-10-11');
INSERT INTO orders VALUES (11, 7, 15, 15000, '2023-06-17');
INSERT INTO orders VALUES (12, 7, 20, 16000, '2023-12-19');
INSERT INTO orders VALUES (13, 3, 19, 23000, '2023-06-30');
INSERT INTO orders VALUES (14, 1, 16, 17000, '2023-11-21');
INSERT INTO orders VALUES (15, 4, 15, 13000, '2023-05-12');
INSERT INTO orders VALUES (16, 7, 10, 13000, '2025-09-24');
INSERT INTO orders VALUES (17, 1, 12, 23000, '2025-02-26');
INSERT INTO orders VALUES (18, 2, 11, 13000, '2025-09-16');
INSERT INTO orders VALUES (19, 4, 20, 13000, '2026-03-20');
INSERT INTO orders VALUES (20, 4, 15, 20000, '2026-04-26');

drop table books;
drop table customer;
drop table orders;

select * from books;
select * from customer;
select * from orders;

-- 도서테이블에 거래하는 모든 출판사를 검색하시오.
select bookId, publisher from books; 
select bookId, publisher from books order by publisher;

-- 도서테이블에 거래하는 모든 출판사를 검색하시오.(단, 같은 출판사의 정보는 1회만 출력하세요)
select * from books;
select distinct publisher from books;

-- 고객 이름 중에서 '손흥민' 검색
select * from customer where name='손흥민';

-- 고객 이름 중에서 '손흥민'의 아이디, 성명,전화번호 검색
select custid, name, phone from customer where name='손흥민';

-- 도서목록이 '나'로 시작하는 도서목록을 출력하시오.
select * from books where bookname like '나%';

-- 도서목록이 '나'를 포함하는 도서목록을 출력하시오.
select * from books where bookname like '%나%';

-- 도서 이름 두번째 글자가 '구' 인 도서 목록을 출력하시오
select * from books where bookname like '_구%';

-- 도서 이름 세번째 글자가 '의' 로 시작하는 도서 목록을 출력하시오
select * from books where bookname like '__의%';

-- 고객별로 주문한 도서의 '총 건수'와 '총 판매액'을 구하되, 필드명을 '총수량', '총판매액' 으로 출력하시오.
select count(*) as '총 수량', sum(saleprice) as '총 판매액' from orders;
select orderId, bookId, custId from orders;
select orderId, bookId, custId from orders order by custId;
select custId as '주문번호', count(*) as '총 수량', sum(saleprice) as '총 판매액' from orders group by custId order by custId;

-- 고객별로 출력하기 위하여 'group by' 절로 묶어준다.
select orderId, bookId, custId from orders group by custId order by custId;

-- 1번 이상 구매한 책들의 정보를 출력하시오.(구매날짜 순 출력, 같은 책이면 1번씩만 출력)
select * from orders;
select distinct bookId from orders order by bookId;
select * from orders group by bookid;


-- group by절은 집계함수와 함께 사용한다.
select sum(saleprice), avg(saleprice), max(saleprice), min(saleprice), count(saleprice)  from orders group by bookId;
select orderId , sum(saleprice), avg(saleprice), max(saleprice), min(saleprice), count(saleprice)  from orders group by bookId;

-- join
-- 1번 이상 구매한 책들의 정보(주문번호, 주문날짜, 책아이디, 책이름)
select orderId, orderDate, orders.bookId, books.bookname from orders inner join books on orders.bookid = books.bookid;

-- 1번 이상 구매한 책들의 정보(주문번호, 주문날짜, 책아이디, 책이름, 출판사명)
select orderId,orderdate,orders.bookId,books.bookname,books.publisher from orders inner join books on orders.bookId = books.bookId;
select orderId, orderDate, o.bookId, b.bookname, b.publisher from orders o inner join books b on o.bookid = b.bookid;
select orderId, orderDate, o.bookId, b.bookname, b.publisher from orders o, books b where o.bookid = b.bookid;

-- 1번 이상 구매한 고객들의 정보(구매번호, 고객명, 구매금액, 구매날짜)
select orderId, c.name, o.saleprice, o.orderDate from orders o, customer c where o.custId = c.custId;

-- 1번 이상 구매한 고객들의 정보(구매번호, 고객명, 책이름, 정가, 구매금액, 구매날짜, 출판사)
select o.orderId, c.name, b.bookname, b.price, o.saleprice, o.orderDate, b.publisher from orders o, customer c, books b where o.custid = c.custid and o.bookid = b.bookid;

-- 1번 이상 구매한 고객들의 정보(구매번호, 고객명, 책이름, 정가, 구매금액, 구매날짜, 출판사) - 고객별로 순차검색해서 출력
select o.orderId, c.name, b.bookname, b.price, o.saleprice, o.orderDate, b.publisher from orders o, customer c, books b 
where o.custid = c.custid and o.bookid = b.bookid order by c.name;

-- 1번 이상 구매한 고객들의 정보(고객명, 고객별 구매횟수와 총 금액과 평균구매금액 출력)
select c.name, count(c.name) as '구매횟수', sum(o.saleprice) as '총 금액', avg(o.saleprice) as '평균' from orders o, customer c, books b 
where o.custid = c.custid and o.bookid = b.bookid group by c.name;


-- '책을 구매한 사람의 이름/책이름/구매가격/구매날짜'를 모두출력?
-- 단, 구매자가 구매한 책의 권수를 함께 출력
select c.name as '이름', b.bookname as '책이름', o.saleprice as '구매가격', o.orderdate as '구매날짜',
(select count(*) from orders where orders.custid = c.custid) as '구매횟수'
from orders o, customer c, books b 
where o.custid = c.custid and o.bookid = b.bookid order by c.name;


-- '책을 구매한 사람의 이름/책이름/구매가격/구매날짜'를 모두출력?
-- 단, 구매자가 구매한 책의 '총개수,총가격,총가격평균'을  함께 출력
select c.name as '이름', b.bookname as '책이름', o.saleprice as '구매가격', o.orderdate as '구매날짜',
(select count(*) from orders where orders.custid = c.custid) as '총개수',
(select sum(saleprice) from orders where orders.custid = c.custid) as '총가격',
(select avg(saleprice) from orders where orders.custid = c.custid) as '총가격 평균'
from orders o, customer c, books b 
where o.custid = c.custid and o.bookid = b.bookid order by c.name;


-- '책을 구매한 사람의 이름/책이름/구매가격/구매날짜'를 모두출력?
-- 단, 구매자가 구매한 책의 '총개수,총가격,총가격평균'을  함께 출력
-- 단, 구매한 책이 4권 이상인 자료만 출력?


-- '출판사'가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오?
select * from books where publisher = '굿스포츠' or publisher = '대한미디어';

-- '출판사'가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오?
select * from books where publisher != '굿스포츠' and publisher != '대한미디어';


-- '축구' 또는 '야구'에 관한 도서중 가격이 2만원 이상인 도서의 '도서명, 가격, 출판사명' 출력?
select bookname  as '도서명', price as '가격', publisher as '출판사명' from books where (bookname like "%축구%" or bookname like "%야구%") and price >= 20000;

-- 2023년에만 구매된 책들을 출력?
select * from books b, orders o where b.bookid = o.bookid
and o.orderdate like "2023%";

-- 2023년에 가장 많이 판매된 책을 출력?


-- 2023년 5월 1일부터 최근까지 판매된 책?(최근 내림차순 출력)



-- 각 고객별로 주문한 도서의 총 판매액을 출력하되, 고객 이름순으로 출력하시오(고객명, 총판매액 출력)

