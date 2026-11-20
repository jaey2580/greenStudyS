<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
<title>greenStudyS</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/6/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {font-family: "Lato", sans-serif}
.mySlides {display: none}
</style>
</head>
<body>

<!-- Nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- Page content -->
<div class="w3-content" style="max-width:2000px;margin-top:46px"></div>

  <!-- Automatic Slideshow Images -->
<jsp:include page="/WEB-INF/views/include/slide.jsp" />
 
  <!-- The Band Section -->
  <div class="w3-container w3-content w3-center w3-padding-64" style="max-width:800px" id="band">
    <h2 class="w3-wide">HOME</h2>
    <p class="w3-opacity"><i>A Spring Framework Practice Website</i></p>
    <p>Welcome to My Spring Practice Website!</p>
		<p>This website was created to practice Spring Framework and web development.</p>
		<p>Click on an image below to visit its board</p>
    <div class="w3-row w3-padding-32">
      <div class="w3-third">
        <p>GUEST</p>
        <img src="${ctp}/images/45.jpg" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%" onclick="location.href='${ctp}/guest/guestList'">
      </div>
      <div class="w3-third">
        <p>BOARD</p>
        <img src="${ctp}/images/45.jpg" class="w3-round w3-margin-bottom" alt="Random Name" style="width:60%" onclick="location.href='${ctp}/board/boardList'">
      </div>
      <div class="w3-third">
        <p>PDS</p>
        <img src="${ctp}/images/45.jpg" class="w3-round" alt="Random Name" style="width:60%" onclick="location.href='${ctp}/pds/pdsList'">
      </div>
    </div>
  </div>

  <!-- The Tour Section -->
  <div class="w3-black" id="tour">
    <div class="w3-container w3-content w3-padding-64" style="max-width:800px">
      <h2 class="w3-wide w3-center">STUDY</h2>
      <p class="w3-opacity w3-center"><i>Browse Study Posts</i></p><br>

      <div class="w3-row-padding w3-padding-32" style="margin:0 -16px">
        <div class="w3-quarter w3-margin-bottom">
          <img src="${ctp}/images/46.jpg" alt="New York" style="width:100%" class="w3-hover-opacity">
          <div class="w3-container w3-white">
            <p><b>AJAX Practice</b></p>
            <p>Practice AJAX Requests</p>
            <button class="w3-button w3-black w3-margin-bottom" onclick="location.href='${ctp}/study/ajaxForm'">Go to Page</button>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <img src="${ctp}/images/47.jpg" alt="Paris" style="width:100%" class="w3-hover-opacity">
          <div class="w3-container w3-white">
            <p><b>DB test</b></p>
            <p>Database Connection Test</p>
            <button class="w3-button w3-black w3-margin-bottom" onclick="location.href='${ctp}/user/userList/idxOrderDesc'">Go to Page</button>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <img src="${ctp}/images/48.jpg" alt="San Francisco" style="width:100%" class="w3-hover-opacity">
          <div class="w3-container w3-white">
            <p><b>Mybatis Test</b></p>
            <p>MyBatis Integration Test</p>
            <button class="w3-button w3-black w3-margin-bottom" onclick="location.href='${ctp}/user2/user2Main'">Go to Page</button>
          </div>
        </div>
        <div class="w3-quarter w3-margin-bottom">
          <img src="${ctp}/images/49.jpg" alt="San Francisco" style="width:100%" class="w3-hover-opacity">
          <div class="w3-container w3-white">
            <p><b>Mail Practice</b></p>
            <p>Email Sending Practice</p>
            <button class="w3-button w3-black w3-margin-bottom" onclick="location.href='${ctp}/study/mailForm'">Go to Page</button>
          </div>
        </div>
      </div>
    </div>
  </div>


<!-- Image of location/map -->
<img src="${ctp}/images/map.jpg" class="w3-image w3-greyscale-min" style="width:100%">

<!-- Footer -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>

