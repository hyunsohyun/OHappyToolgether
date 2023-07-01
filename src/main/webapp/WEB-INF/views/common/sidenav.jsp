<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="userid" value="${sessionScope.userid}" />
<c:set var="projectId" value="${sessionScope.projectId}" />
<c:set var="boardList" value="${sessionScope.boardList}" />
<div id="layoutSidenav_nav">
	<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
		<div class="sb-sidenav-menu">
			<div class="nav">

				<c:if test="${userid != null}">
					<div class="sb-sidenav-menu-heading">Core</div>
					<a class="nav-link" href="${pageContext.request.contextPath}/projectList.do">
						<div class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> Project List
					</a>
				</c:if>
				<c:if test="${userid == null}">
					<div class="sb-sidenav-menu-heading">Core</div>
					<a class="nav-link" href="${pageContext.request.contextPath}/joinForm.do">
						<div class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> Member Join
					</a>
				</c:if>

				<c:if test="${projectId != null}">
					<a class="nav-link" href="${pageContext.request.contextPath}/projectManagement.do">
						<div class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> 
						Project Management (${projectId})
					</a>

					<div class="sb-sidenav-menu-heading">Kanban Board</div>
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 칸반보드
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>


					<div class="sb-sidenav-menu-heading">Calendar</div>
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
						<div class="sb-nav-link-icon">
							<i class="fas fa-columns"></i>
						</div> 캘린더
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="sb-sidenav-menu-heading" id="boardList">Board List</div>
					<c:if test="${boardList != null}">

						<c:forEach var="board" items="${boardList}">
							<a class='nav-link' href='/postList.do?boardId=${board.boardId}'>
								<div class='sb-nav-link-icon'>
									<i class='fas fa-table'></i>
								</div> ${board.boardName}
								<div class="sb-sidenav-collapse-arrow">
									<i class="fas fa-angle-down"></i>
								</div>
							</a>
						</c:forEach>

					</c:if>

				</c:if>

			</div>
		</div>
		<div class="sb-sidenav-footer">
			<div class="small">Logged in as:</div>
			<c:choose>
				<c:when test="${userid != null}">				
					${userid} <a href="logout.do">로그아웃</a>
				</c:when>
				<c:otherwise>
					Anonymous
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
</div>
