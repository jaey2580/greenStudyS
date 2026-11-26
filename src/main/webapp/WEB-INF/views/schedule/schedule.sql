show tables;

create table schedule (
	idx int not null auto_increment,
	mid varchar(20) not null, /* 일정 등록한 사람 아이디 */
	sDate datetime not null, /* 일정 등록날짜 */
	part varchar(20) not null, /* 1.모임 2.업무 3.학습 4.여행 9.공지사항(전체공지) 0.기타 */
	content text not null, /* 일정 상세 내용 */
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc schedule

insert into schedule values (default, 'hkd1234', '2026-11-25', '학습', '프로젝트 기획');
insert into schedule values (default, 'hkd1234', '2026-11-30', '모임', '고등학교 동창회');
insert into schedule values (default, 'hkd1234', '2026-11-30', '모임', '개발팀 모임');
insert into schedule values (default, 'hkd1234', '2026-11-30', '학습', '개인 프로젝트 발표');
insert into schedule values (default, 'hkd1234', '2026-12-05', '여행', '발리 여행');
insert into schedule values (default, 'atom1234', '2026-11-26', '여행', '제주도 가족 여행');
insert into schedule values (default, 'atom1234', '2026-11-30', '학습', '프로젝트 발표');


select * from schedule;

select * from schedule where mid='hkd1234' group by part order by part;

select *, count(*) as partCnt from schedule where mid='hkd1234' group by sDate,part order by sdate, part;


