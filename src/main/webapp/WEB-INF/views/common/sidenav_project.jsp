<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="layoutSidenav_nav">
	<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
		<div class="sb-sidenav-menu">
			<div class="nav">
				<div class="sb-sidenav-menu-heading">Core</div>
				<a class="nav-link"
					href="${pageContext.request.contextPath}/projectList.do">
					<div class="sb-nav-link-icon">
						<i class="fas fa-tachometer-alt"></i>
					</div> Project List
				</a>


				<div class="sb-sidenav-menu-heading">Kanban Board</div>
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
					data-bs-target="#collapseLayouts" aria-expanded="false"
					aria-controls="collapseLayouts">
					<div class="sb-nav-link-icon">
						<i class="fas fa-columns"></i>
					</div> 칸반보드
					<div class="sb-sidenav-collapse-arrow">
						<i class="fas fa-angle-down"></i>
					</div>
				</a>

				<div class="collapse" id="collapsePages"
					aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
					<nav class="sb-sidenav-menu-nested nav accordion"
						id="sidenavAccordionPages">
						<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#pagesCollapseAuth" aria-expanded="false"
							aria-controls="pagesCollapseAuth"> Authentication
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="pagesCollapseAuth"
							aria-labelledby="headingOne"
							data-bs-parent="#sidenavAccordionPages">
							<nav class="sb-sidenav-menu-nested nav">
								<a class="nav-link" href="login.html">Login</a> <a
									class="nav-link" href="register.html">Register</a> <a
									class="nav-link" href="password.html">Forgot Password</a>
							</nav>
						</div>
						<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
							data-bs-target="#pagesCollapseError" aria-expanded="false"
							aria-controls="pagesCollapseError"> Error
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</a>
						<div class="collapse" id="pagesCollapseError"
							aria-labelledby="headingOne"
							data-bs-parent="#sidenavAccordionPages">
							<nav class="sb-sidenav-menu-nested nav">
								<a class="nav-link" href="401.html">401 Page</a> <a
									class="nav-link" href="404.html">404 Page</a> <a
									class="nav-link" href="500.html">500 Page</a>
							</nav>
						</div>
					</nav>
				</div>
				<div class="sb-sidenav-menu-heading">Calendar</div>
				<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
					data-bs-target="#collapseLayouts" aria-expanded="false"
					aria-controls="collapseLayouts">
					<div class="sb-nav-link-icon">
						<i class="fas fa-columns"></i>
					</div> 캘린더
					<div class="sb-sidenav-collapse-arrow">
						<i class="fas fa-angle-down"></i>
					</div>
				</a>
				<div class="sb-sidenav-menu-heading" id="boardList">Board List</div>

			
			
			</div>		
		</div>
		<div class="sb-sidenav-footer">
			<div class="small">Logged in as:</div>
			<c:set var="userid" value="${sessionScope.userid}" />
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
