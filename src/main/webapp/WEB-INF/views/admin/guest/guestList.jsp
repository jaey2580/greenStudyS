<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>guestList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css" />
  <style>
    th {
      text-align: center;
      background-color: #eee !important;
    }
  </style>
  <script>
    'use strict';
    
    function deleteCheck(idx) {
    	let ans = confirm("현재 게시글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : '${ctp}/guest/guestDelete',
    		type : 'post',
    		data : {idx : idx},
    		success: (res) => {
    			if(res != 0) {
    				alert("삭제 처리 되었습니다.");
    				location.reload();
    			} else alert("삭제 오류!!!");
    		},
    		error : () => alert('전송오류')
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
	  
	  //게시글 선택 삭제
	  function guestSelectdelete() {
	  	let idxSelectArray = "";
	  	
	  	if(myform.idxFlag.length == 0) {
	  		alert("삭제할 게시글을 1개 이상 선택하세요.");
	  		return false;
	  	}
	  	
	  	for(let i=0; i<myform.idxFlag.length; i++){
	  		if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value+ "/";
	  	}
	  	idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));	  	
	  	
	  	$.ajax({
	  		url : 'guestSelectdelete',
	  		type : 'post',
	  		data : {idxSelectArray : idxSelectArray},
	  		success : (res) => {
	  			if(res != '0') alert("게시글이 삭제되었습니다.")
	  			else alert("삭제실패!")
	  			location.reload();
	  		},
	  		error : () => alert("전송오류")
	  	});
	  	
	  	
	  	
	  }
    
	  function levelArray() {
	  	let pageSize = $("#pageSize").val();
	 		
	  	location.href = "${ctp}/admin/guestList?pag=1&pageSize="+pageSize;
	 
	  }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-3">방명록 리스트(관리자)</h2>
  <div class="row">
  	<div class="col">
  		<input type="button" onclick="allCheck()" value="전체선택" class="btn btn-success btn-sm">
  		<input type="button" onclick="allReset()" value="전체해제" class="btn btn-warning btn-sm">
  		<input type="button" onclick="reverseCheck()" value="선택반전" class="btn btn-info btn-sm">
  		<input type="button" onclick="guestSelectdelete()" value="게시글삭제" class="btn btn-danger btn-sm">
  	</div>
	  <div class="col-auto ms-auto">
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
  		<th>성명</th>
  		<th>방문일자</th>
  		<th>이메일</th>
  		<th>홈페이지</th>
  		<th>IP</th>
  		<th>글내용</th>
  		<th>삭제</th>
  	</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
  	<tr>
  		<td><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/> ${vo.idx}</td>
  		<td>${vo.name}</td>
  		<td>${fn:substring(vo.visitDate,0,19)}</td>
  		<td>${vo.email == '' ? '정보없음' : vo.email}</td>
  		<td>${vo.homePage == '' ? '정보없음' : vo.homePage}</td>
  		<td>${vo.hostIp}</td>
  		<td>${fn:replace(vo.content, newLine, "<br/>")}</td>
  		<td><a href="javascript:deleteCheck(${vo.idx})" class="btn btn-danger btn-sm">삭제</a></td>
  	</tr>
  	</c:forEach>	
  </table>
  </form>
  <div><a href="adminRight" class="btn btn-dark">관리자 대시보드</a></div>
  <!-- 페이징처리(블록페이지 시작) -->
	  <div class="text-center">
	    <ul class="pagination justify-content-center">
	      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a href="guestList?level=${level}&pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">첫페이지</a></li></c:if>
	      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a href="guestList?level=${level}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">이전블록</a></li></c:if>
	      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize) + 1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
	        <c:if test="${i <= pageVO.totPage && pageVO.pag != i}"><li class="page-item"><a href="guestList?level=${level}&pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">${i}</a></li></c:if>
	        <c:if test="${i <= pageVO.totPage && pageVO.pag == i}"><li class="page-item"><a href="guestList?level=${level}&pag=${i}&pageSize=${pageVO.pageSize}" class="page-link active bg-secondary border-secondary"><b>${i}</b></a></li></c:if>
	      </c:forEach>
	      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a href="guestList?level=${level}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">다음블록</a></li></c:if>
	      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a href="guestList?level=${level}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">마지막페이지</a></li></c:if>
	    </ul>
	  </div>
	  <!-- 페이징처리(블록페이지 끝) -->
  
</div>
<p><br/></p>
</body>
</html>