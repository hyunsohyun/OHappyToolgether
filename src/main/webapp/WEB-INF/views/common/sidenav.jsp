<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 현재 사용자의 ID를 가져옴 -->
<sec:authentication property="name" var="userid" />
<c:set var="projectId" value="${sessionScope.projectId}" />
<c:set var="boardList" value="${sessionScope.boardList}" />
<c:set var="managerId" value="${sessionScope.managerId}" />
<div id="layoutSidenav_nav">
	<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
		<div class="sb-sidenav-menu">
			
			<div class="nav">
				<c:if test="${userid != 'anonymousUser'}">
					<!-- <div class="sb-sidenav-menu-heading">Core</div> -->
					<a class="nav-link" href="${pageContext.request.contextPath}/projectList.do">
						<div class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> Project List
					</a>
				</c:if>
				<c:if test="${userid == 'anonymousUser'}">
					<div class="sb-sidenav-menu-heading">Core</div>
					<a class="nav-link" href="${pageContext.request.contextPath}/joinForm">
						<div class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> Member Join<br>
					</a>
				</c:if>

				<c:if test="${projectId != null}">
					
					<a class="nav-link" href="${pageContext.request.contextPath}/projectDetail.do/${project.projectId}" >
						PROJECT_${project.projectName}
					</a>
					
					
					<div class="sb-sidenav-menu-heading" id="">일정관리</div>
	
					<a class="nav-link" href="${pageContext.request.contextPath}/kanban.do">
						<div class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> 칸반보드
					</a>
					
					<a class="nav-link" href="${pageContext.request.contextPath}/fullcalendar.do">
						<div class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> 달력
					</a>
					
					<div class="sb-sidenav-menu-heading" id="boardList">게시판</div>
					<c:if test="${boardList != null}">

						<c:forEach var="board" items="${boardList}">
							<a class='nav-link' href='/postList/${board.boardId}'>
								<div class='sb-nav-link-icon'>
									<i class='fas fa-table'></i>
								</div> ${board.boardName}
								
							</a>
						</c:forEach>

					</c:if>

				</c:if>

			</div>
			<div class='nav' style="display: grid; align-content: end;">
				<div>
					<c:if test="${managerId == userid}">
						<div class="sb-sidenav-menu-heading">관리자메뉴</div>
						<a class="nav-link" href="${pageContext.request.contextPath}/projectManagement.do">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div> ${project.projectName} 관리
						</a>
					</c:if>
				</div>
				
			</div>
			
			
		</div>
		
		
		
		<div class="sb-sidenav-footer">

			<c:if test="${userid != 'anonymousUser'}">
				<form action="/logout" method="POST">
					<button type='submit' class='float-end btn btn-secondary'><i class="fas fa-sign-out-alt" style="color: #f0f2f4;"></i> Logout</button>
				</form>
			</c:if>
			<div class="small">Logged in as:</div>
			<div onclick=""><a href="${pageContext.request.contextPath}/editForm">
			<img style="width:15px;border-radius: 50%;" src="/resource/users/${userImage}"/>
			${userid}</a>
			</div>
		</div>
	</nav>
</div>
