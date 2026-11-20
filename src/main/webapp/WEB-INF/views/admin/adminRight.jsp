<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
 	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>adminLeft.jsp</title>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>관리자 대시보드</h2>
  <hr/>
  <!-- <div><iframe src="https://www.imbc.com" width="1200px" height="450px"></iframe></div> -->
	<div class="row">
		<div class="col-auto">
			<div class="list-group" style="width: 200px">
		    <a href="#" class="list-group-item list-group-item-secondary" aria-current="true">회원관리👤</a>
		    <a href="memberList" class="list-group-item list-group-item-action">회원리스트</a>
		    <a href="newMemberList" class="list-group-item list-group-item-action">신규회원리스트</a >
		    <a href="memberDeleteList" class="list-group-item list-group-item-action">탈퇴신청회원</a>
		  </div>
		 </div> 
		 <div class="col-auto">
			<div class="list-group" style="width: 200px">
		    <a href="#" class="list-group-item list-group-item-secondary" aria-current="true">게시판관리📋</a>
		    <a href="guestList" class="list-group-item list-group-item-action">방명록</a >
		    <a href="" class="list-group-item list-group-item-action">게시판</a>
		    <a href="" class="list-group-item list-group-item-action">자료실</a>
		  </div>
		 </div> 
  </div>
</div>
<p><br/></p>
</body>
</html>