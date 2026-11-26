show tables;

/* 신고테이블(complaint) */
/*
	신고 처리하기(신고취소(S)/신고가리기(H)/삭제하기(D))
	complaintSw : H(감추기-board테이블의 complaint필드값을 'HI' , complaint테이블의 progress필드값을 '처리완료(H)')
	complaintSw : S(보이기-신고해제-board테이블의 complaint필드값을 'NO' , complaint테이블의 progress필드값을 '처리완료(S)')
	complaintSw : D(삭제하기-board테이블의 해당레코드 삭제처리 , complaint테이블의 progress필드값을 '처리완료(D)')
*/

create table complaint(
  idx  int not null auto_increment,	/* 신고테이블 고유번호 */
  part varchar(15) not null,				/* 신고 분류(게시판:board, 자료실:pds, 방명록:guest) */
  partIdx int not null,							/* 신고분류항목 글의 고유번호 */
  cpMid varchar(20) not null,				/* 신고자 아이디 */
  cpContent text not null,					/* 신고 사유 */
  cpDate datetime default now(),		/* 신고한 날짜 */
  progress varchar(10) default '신고접수', /* 진행상황 : '신고접수/처리완료(S)/처리완료(H)/처리완료(D)' S:문제없음(보이기), H:가리기, D:삭제하기 */
  primary key(idx),
  foreign key(cpMid) references member(mid)
);

