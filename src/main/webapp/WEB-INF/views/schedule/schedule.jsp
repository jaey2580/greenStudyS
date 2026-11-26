<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>schedule.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <style>
  	#td1,#td8,#td15,#td22,#td29,#td36 {color:red;}
  	#td7,#td14,#td21,#td28,#td35 {color:blue;}
  	
  	td.today {
  		background-color: #f5fbfd;
  		font-weight: bold;
  	}
  	.table th {
  		background-color: #f8f8f8;
  	}
  	
  	.table {.
  		width: 100%;
  		table-layout: fixed;
  	}
  	
  	td:hover {background-color: #eee;}
  	
  	td {
  		text-align: left;
  		vertical-align: top !important;
  		height: 200%;
  	}
  	
  	
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <div class="text-center">
  	<button type="button" onclick="location.href='schedule?yy=${yy-1}&mm=${mm}'" class="btn btn-transparent btn-sm" title="이전년도">◀◀</button>
  	<button type="button" onclick="location.href='schedule?yy=${yy}&mm=${mm-1}'" class="btn btn-transparent btn-sm" title="이전월">◀</button>
		${yy}.${mm+1}
  	<button type="button" onclick="location.href='schedule?yy=${yy}&mm=${mm+1}'" class="btn btn-transparent btn-sm" title="다음월">▶</button>
  	<button type="button" onclick="location.href='schedule?yy=${yy+1}&mm=${mm}'" class="btn btn-transparent btn-sm" title="다음년도">▶▶</button>
  	<button type="button" onclick="location.href='schedule'" class="btn btn-transparent btn-sm" title="오늘날짜"><i class="fa-solid  fa-house"></i></button>
  </div>
  <div class="mt-4">
  	<table class="table table-bordered text-center" style="height: 100%">
			<thead>
				<tr>
					<th style="color:red;">일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th style="color:blue">토</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<!-- 시작일 빈칸을 이전달의 날짜로 채운다. -->
					<c:set var="cnt" value="1" />
					<c:forEach var="preDay"	begin="${preLastDay - (startWeek - 2)}" end="${preLastDay}">
						<td>
							<span style="color: grey">${preDay}</span>
						</td>
						<c:set var="cnt" value="${cnt+1}" />
					</c:forEach>
					
					<!-- 달력의 실제 날짜 출력하기 -->
					<c:forEach var="i" begin="1" end="${lastDay}" varStatus="st">
						<c:set var="todaySw" value="${(toYear == yy && toMonth == mm && toDay == st.count) ?  1 : 0}" />
						<td id="td${cnt}" ${todaySw == 1 ? 'class="today"' : ''}>
							<c:set var="ymd" value="${yy}-${mm+1}-${st.count}" />
							<a href="scheduleMenu?ymd=${ymd}&mid=${sMid}">${st.count}<br/>
								<c:forEach var="vo" items="${vos}" >
									<c:if test="${fn:substring(vo.SDate, 8, 10) == st.count}">
									 - ${vo.part}(${vo.partCnt})<br/>
									</c:if>
								</c:forEach>							
							</a>
							
						</td>
						<c:if test="${cnt % 7 == 0}"></tr><tr></c:if> 
						<c:set var="cnt" value="${cnt=cnt+1}" />
					</c:forEach>
					
					<!-- 이번달 마지막 날짜 다음의 빈공간을 다음달의 날짜로 채운다. -->
					<c:if test="${nextStartWeek != 1}">
						<c:forEach var="i" begin="${nextStartWeek}" end="7" varStatus="st">
							<td>
								<span style="color: grey">${st.count}</span>
							</td>
						</c:forEach>
					</c:if>
				</tr>
			</tbody>
  	</table>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>