<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<script>
		'use strict';
		
		function levelChange(e,eidx){
			let level = $(e).val();
			let idx = eidx;
			let ans = confirm("현재 회원의 등급을 변경하시겠습니까?");

		if(!ans) return false;
	
		
		let query = {
				idx : idx,
				levelItem : level
		}
		
			$.ajax({
				url : "memberLevelChange",
				type : "post",
				data : query,
				success : (res) => {
					if(res != '0') {
						alert("등급 변경이 완료되었습니다.");
						location.reload();
					}
					else return false;
				},
				error : () => alert("전송에러")
			});
		}
		
	 	// 전체선택
	  function allCheck() {
	    for(let i=0; i<myform.idxFlag.length; i++) {
	      myform.idxFlag[i].checked = true;
	    }
	  }
	
	  // 전체취소
	  function allReset() {
	    for(let i=0; i<myform.idxFlag.length; i++) {
	      myform.idxFlag[i].checked = false;
	    }
	  }
	
	  // 선택반전
	  function reverseCheck() {
	    for(let i=0; i<myform.idxFlag.length; i++) {
	      myform.idxFlag[i].checked = !myform.idxFlag[i].checked;
	    }
	  }
	  //선택항목에 대하여 레벨 변경 처리
	  function levelSelectCheck() {
	  	let levelItem = document.getElementById("levelItem").value;
	  	let levelItemText = $("#levelItem option:selected").text();
	  	let idxSelectArray = "";
	  	
	  	
	  	if(myform.idxFlag.length == 0) {
	  		alert("등급을 변경할 항목을 1개 이상 선택하세요.");
	  		return false;
	  	}
	  	
	  	for(let i=0; i<myform.idxFlag.length; i++){
	  		if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value+ "/";
	  	}
	  	idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));	  	
	  	
	  	let query = {
	  			idxSelectArray : idxSelectArray,
	  			levelItem : levelItem
	  	}
	  	
	  	$.ajax({
	  		url : 'memberLevelSelectCheck',
	  		type : 'post',
	  		data : query,
	  		success : (res) => {
	  			if(res != '0') alert("회원 등급이 "+levelItemText+"로 변경되었습니다.")
	  			else alert("등급변경 실패!")
	  			location.reload();
	  		},
	  		error : () => alert("전송오류")
	  	});
	  }
	  
	  function levelArray() {
	  	let pageSize = $("#pageSize").val();
	 		
	  	location.href = "${ctp}/admin/newMemberList?pag=1&pageSize="+pageSize;
	 
	  }
	</script>
  <title>memberList.jsp(관리자)</title>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-2">신 규 회 원 리 스 트(관리자)</h2>
  <div class="text-center mb-4">오늘을 기준으로 가입한지 7일 이내의 회원</div>
  <div class="row">
  	<div class="col">
  		<input type="button" onclick="allCheck()" value="전체선택" class="btn btn-success">
  		<input type="button" onclick="allReset()" value="전체해제" class="btn btn-warning">
  		<input type="button" onclick="reverseCheck()" value="선택반전" class="btn btn-info">
  		<select name="levelItem" id="levelItem" class="form-select d-inline-block w-auto">
    		<!-- <option value="0">관리자</option> -->
    		<option value="1">우수회원</option>
    		<option value="2" selected>정회원</option>
    		<option value="3">준회원</option>
    		<option value="99">탈퇴신청회원</option>
    	</select>
  		<input type="button" onclick="levelSelectCheck()" value="등급변경" class="btn btn-primary btn-sm">
  	</div>
  	<div class="col-auto">
	   	<select name="pageSize" id="pageSize" class="form-select w-auto" onchange="levelArray()">
    	  <option value="5" ${pageVO.pageSize==5  ? 'selected' : ''}>5</option>
    	  <option value="10" ${pageVO.pageSize==10 ? 'selected' : ''}>10</option>
    	  <option value="15" ${pageVO.pageSize==15 ? 'selected' : ''}>15</option>
    	  <option value="20" ${pageVO.pageSize==20 ? 'selected' : ''}>20</option>
    	  <option value="25" ${pageVO.pageSize==30 ? 'selected' : ''}>30</option>
    	</select>
  	</div>
  </div>
  <form name="myform">
	  <table class="table table-hover mt-2 text-center">
	    <tr class="table-secondary">
	      <th>번호</th>
	      <th>닉네임</th>
	      <th>아이디</th>
	      <th>성명</th>
	      <th>이메일</th>
	      <th>가입일</th>
	      <th>비고</th>
	    </tr>
	    <c:forEach var="vo" items="${vos}" varStatus="st">
		    <tr>
		      <td>
		      	<input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/>
	      		${vo.idx}
	      	</td>
		      <td>${vo.nickName}</td>
			      <td><a href="memberContent?mid=${vo.mid}">${vo.mid}</a></td>
			      <td>${vo.name}</td>
			      <td>${vo.email}</td>
			      <td class="text center">
			      	${fn:substring(vo.startDate, 0, 10)}
		      	</td>
			      <td>
			      	<select name="level" id="level" class="form-select" onchange="levelChange(this,${vo.idx})">
			      	<!-- <select name="level" id="level" class="form-select"> -->
			      		<option value="0" ${vo.level == 0 ? 'selected' : ''}>관리자</option>
			      		<option value="1" ${vo.level == 1 ? 'selected' : ''}>우수회원</option>
			      		<option value="2" ${vo.level == 2 ? 'selected' : ''}>정회원</option>
			      		<option value="3" ${vo.level == 3 ? 'selected' : ''}>준회원</option>
			      		<option value="9" ${vo.level == 99 ? 'selected' : ''}>탈퇴신청회원</option>
			      	</select>
			      </td>
		    </tr>
	    </c:forEach>
	  </table>
	  <div><a href="adminRight" class="btn btn-dark">관리자 대시보드</a></div> 
 	  <!-- 페이징처리(블록페이지 시작) -->
	  <div class="text-center">
	    <ul class="pagination justify-content-center">
	      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a href="newMemberList?level=${level}&pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">첫페이지</a></li></c:if>
	      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a href="newMemberList?level=${level}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">이전블록</a></li></c:if>
	      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize) + 1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
	        <c:if test="${i <= pageVO.totPage && pageVO.pag != i}"><li class="page-item"><a href="newMemberList?level=${level}&pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">${i}</a></li></c:if>
	        <c:if test="${i <= pageVO.totPage && pageVO.pag == i}"><li class="page-item"><a href="newMemberList?level=${level}&pag=${i}&pageSize=${pageVO.pageSize}" class="page-link active bg-secondary border-secondary"><b>${i}</b></a></li></c:if>
	      </c:forEach>
	      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a href="newMemberList?level=${level}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">다음블록</a></li></c:if>
	      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a href="newMemberList?level=${level}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">마지막페이지</a></li></c:if>
	    </ul>
	  </div>
	  <!-- 페이징처리(블록페이지 끝) -->
	  
  </form>
</div>
<p><br/></p>
</body>
</html>