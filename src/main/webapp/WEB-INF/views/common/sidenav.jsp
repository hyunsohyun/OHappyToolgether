<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="projectId" value="${sessionScope.projectId}" />
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
					
					<div class="sb-sidenav-menu-heading">Calendar</div>
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
						data-bs-target="#collapseLayouts" aria-expanded="false"
						aria-controls="collapseLayouts">
						<div class="sb-nav-link-icon">
							<i class="fas fa-calendar"></i>
						</div> 캘린더
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="sb-sidenav-menu-heading" id="boardList">Board
						List</div>

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
<script type="text/javascript">
$(document).ready(
		function() {
			let projectId = "${sessionScope.projectId}";
			console.log(projectId);
			$.ajax({
				url : "/board/" + projectId,
				type : "GET",
				success : function(list) {
					console.log(list);									
					let boardList = $('#boardList');					
					let str = "";
					$.each(list, function(index, item){										
						str += "<a class='nav-link' href='/postList.do?boardId=" + item.boardId + "'>";
						str += "<div class='sb-nav-link-icon'>";
						str += "<i class='fas fa-table'></i>";
						str += "</div>" + item.boardName + "</a>";
					});
					$(boardList).after(str);
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n"
							+ "error:" + error);
				}
			});
		});
</script>