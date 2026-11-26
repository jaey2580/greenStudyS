show tables;

-- 리뷰테이블
create table review(
	idx int not null auto_increment, /* 리뷰 고유번호 */ 
	part varchar(20) not null, 			 /* 분야(게시판: board, 자료실: pds) */
	partIdx int not null,  					 /* 해당 분야의 고유번호 */
	mid varchar(20) not null, 			 /* 리뷰 올린이 */
	nickName varchar(20), 					 /* 리뷰 올린 닉네임 */
	star int not null default 0,		 /* 별점 부여 점수 */
	content text, 									 /* 리뷰 내용 */
	rDate datetime default now(),		 /* 리뷰 등록일자 */
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc review;
drop table review;

select avg(star) from review;
select count(*) ,sum(star), avg(star) from review where part="pds" and partIdx = 16;


-- 리뷰테이블의 댓글 테이블
create table reviewReply(
	replyIdx int not null auto_increment,
	reviewIdx int not null,
	replyMid varchar(20)	not null,
	replyNickName varchar(20)	not null,
	replyContent text not null,
	replyDate datetime default now(),
	primary key(replyIdx),
	foreign key(reviewIdx) references review(idx),
	foreign key(replyMid) references member(mid)
);

desc reviewReply;

select * from review order by idx desc;

insert into reviewReply values (default, 6, 'admin', '관리맨', '연습1', now());
insert into reviewReply values (default, 7, 'btom1234', '비톰맨', '연습2', now());
insert into reviewReply values (default, 7, 'ctom1234', '씨톰맨', '씨톰맨1', now());

select * from reviewReply;
drop table reviewReply;

-- 서브쿼리: sql문 안에 또 쿼리를 쓰는것
-- 리뷰 7번글의 모든 대댓글 보기
select * from review where part="pds" and idx=7;
select * from review inner join reviewReply where part="pds" and idx=7 and review.idx = reviewReply.reviewIdx;
select * from review v inner join reviewReply r where v.part="pds" and v.idx=7 and v.idx = r.reviewIdx;
select * from review v inner join reviewReply r on v.part="pds" and v.idx=7 and v.idx = r.reviewIdx; /*표준*/
select * from review v, reviewReply r where v.part="pds" and v.idx=7 and v.idx = r.reviewIdx;

select v.idx, v.part, v.nickName, v.rDate, v.star, v.content from review v, reviewReply r where v.part="pds" and v.idx=7 and v.idx = r.reviewIdx;
select v.* from review v, reviewReply r where v.part="pds" and v.idx=7 and v.idx = r.reviewIdx;
select v.idx, v.part, v.nickName, v.rDate, v.star, v.content, r.replyIdx, r.replyNickName, r.replyDate, r.replyContent from review v, reviewReply r where v.part="pds" and v.idx=7 and v.idx = r.reviewIdx;

select v.idx, v.part, v.nickName, v.rDate, v.star, v.content, r.replyIdx, r.replyNickName, r.replyDate, r.replyContent from review v left join reviewReply r on v.part="pds" and v.idx=7 and v.idx = r.reviewIdx;
select * from review v left join reviewReply r on part="pds" and partIdx=7 and idx = reviewIdx;
select * from review v left join reviewReply r on part="pds" and partIdx=16 and idx = reviewIdx order by idx desc, replyIdx desc;

select * from (select * from review where partIdx=17) as v left join reviewReply r 
on v.part="pds" and v.partIdx=17 and v.idx = r.reviewIdx order by v.idx desc, r.replyIdx desc;


