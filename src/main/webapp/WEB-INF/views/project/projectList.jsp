<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>OHappyToolgether</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div class="container mt-2" id="projectContainer">
					<!-- 프로젝트 카드영역-->
					<c:set var="colNum" value='4' />
					<c:forEach var="item" items="${projectList}" begin="0" varStatus="status">
						<c:if test="${status.index%colNum == 0}">
							<div class='row mt-5'>
						</c:if>
						<div class="col-sm-3">
							<div class="card border-dark projectinfo shadow mb-5 rounded">
								<div class="card-header projectinfo-header bg-warning">project id : ${item.projectId}</div>
								<div class="card-body">
									<div>
										<label class="form-label mt-1">${item.projectName}</label>
									</div>
									<div class="form-group d-flex">
										<img src='/resource/projectimg/${item.projectId}.png' class='card-img-top' onerror=this.src='assets/img/error-404-monochrome.svg'>
									</div>
									<a href='projectDetail.do/${item.projectId}' class="btn btn-danger float-end">시작</a>
								</div>
							</div>
						</div>
						<c:if test="${status.index%colNum == colNum-1}">
							</div>
						</c:if>
					</c:forEach>
				</div>
			</main>
		<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
		<script src="js/datatables-simple-demo.js"></script>
		<!-- <script type="text/javascript">
				$(document).ready(
						function() {
							let userid = "${sessionScope.userid}";
							console.log(userid);
							$.ajax({
								url : "project/" + userid,
								type : "GET",
								success : function(list) {
									console.log(list);									
									let projectContainer = $('#projectContainer');
									let colNum = 4; // 한 줄에 보일 카드의 수
									$(projectContainer).empty();
									let str = "";
									$.each(list, function(index, item){										
										if(index%colNum==0) str += "<div class='row'>";
										str += "<div class='col-md-"+ 12/colNum +"'>";
										str += "<div class='card' style='width: 18rem;'>";
										str += "<img src='" + item.projectImage + "' class='card-img-top' onerror=this.src='assets/img/error-404-monochrome.svg'>";
										str += "<div class='card-body'>";
										str += "<h4 class='card-title'>" + item.projectName + "</h4>";
										str += "<p class='card-text'>프로젝트 설명</p>";
										str += "<a href='projectDetail.do/"+ item.projectId +"' class='btn btn-primary'>Go somewhere</a>";
										str += "</div></div></div>";
										if(index%colNum==colNum-1) str += "</div>";										
									});
									$(projectContainer).append(str);
								},
								error : function(request, status, error) {
									alert("code:" + request.status + "\n"
											+ "error:" + error);
								}
							});
						});
				
			</script> -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	</div>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>






