 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
	<!-- 썸머노트 --> 
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
	
	
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
	<!-- Navbar Brand-->
	<a class="navbar-brand ps-3" href="/"><img src="/assets/img/ohappytoolgether.png" style="width:165px; margin:auto;"></a>
	<!-- Sidebar Toggle-->
	<button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
		id="sidebarToggle" href="#!">
		<i class="fas fa-bars"></i>
	</button>

	<!--프로젝트 리스트 -->
	<form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
		<select class="form-select bg-dark text-light" aria-label="Select option" style="width: 200px; font-size:11pt; border: 1px solid gray;" onchange="selectProject(this.value)">
		  <option value="">선택해주세요</option>
		  <c:forEach var="project" items="${sessionScope.projectList}">
		  <option value="${project.projectId}" ${project.projectId == sessionScope.projectId ? 'selected' : ''}>
		    ${project.projectName}
		  </option>
		</c:forEach>
		</select>
	</form>
	
	<!-- Navbar-->
	<ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
		<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown"
			aria-expanded="false">
			<i class="fas fa-user fa-fw"></i></a>
			<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
				<li style="display: flex; justify-content: center;"><img style="width:130px;border-radius: 50%;" src="/resource/users/${userImage}"/></li>
				<br>
				<li><a class="dropdown-item" href="${pageContext.request.contextPath}/editForm" style="text-align: center;"><i class="fas fa-edit" style="color: #6e7277;"></i> 내 정보 </a></li>
				<li><hr class="dropdown-divider" /></li>
				<li class="text-center"><form action="/logout" method="POST">
					<button type='submit' class='dropdown-item'>Logout</button>
				</form></li>
			</ul>
		</li>
	</ul>
</nav> 

<!-- projectList selectbox -->
<script type="text/javascript">
	function selectProject(projectId) {
		if(projectId =='') window.location.href ="/projectList.do";
		else window.location.href = "/projectDetail.do/"+projectId;
	}
</script>
