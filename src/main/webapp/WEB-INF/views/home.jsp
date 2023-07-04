<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 현재 사용자의 ID를 가져옴 -->
<sec:authentication property="name" var="userid" />
<c:set var="projectId" value="${sessionScope.projectId}" />
<c:set var="boardList" value="${sessionScope.boardList}" />
<c:set var="managerId" value="${sessionScope.managerId}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"	crossorigin="anonymous"></script>
<link href="css/main.css" rel="stylesheet" />
</head>

<body>
	<div class="container">
		<div class="content">
			<div class="square twitch" style="margin-bottom: 50px;">
				<span class="one"></span>
				<span class="two"></span>
				<span class="three"></span>
				<div class="circle">
					<h1 class="OHappyToolgether">OHappy Toolgether</h1>
					<p>Douzone 5 (Team 3)</p>
					<p>Second Project</p>
				</div>
			</div>

			<div class="center-buttons">
			
				<c:if test="${userid == 'anonymousUser'}">
					<a href="/loginForm" class="button">로그인</a>
				</c:if>
				
				<c:if test="${userid == 'anonymousUser'}">
					<a href="/joinForm" class="button">회원가입</a>
				</c:if>
				
				<c:if test="${userid != 'anonymousUser'}">
					<a href="${pageContext.request.contextPath}/projectList.do" class="button" >
					프로젝트
					</a>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>