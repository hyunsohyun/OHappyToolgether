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
					<c:set var="length" value='${fn:length(projectList)}'/>
					<c:forEach var="item" items="${projectList}" begin="0" varStatus="status">
						<c:if test="${status.index%colNum == 0}">
							<div class='row mt-5'>
						</c:if>
						<div class="col-sm-3">
							<div class="card border-dark projectinfo shadow mb-5 rounded">
								<div class="card-header projectinfo-header bg-warning">Project ID : ${item.projectId}</div>
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
						<c:if test="${status.last}">
						
							<c:if test="${length%colNum == 0}">
								<div class='row mt-5'>
							</c:if>
							
								<div class="col-sm-3">
									<div class="card border-dark shadow mb-5 rounded">
										<div class="card-header">새 프로젝트 추가</div>
										<div class="card-body">
											<div id="insertProject">
												<label class="form-label mt-1">프로젝트를 추가하려면 클릭하세요</label>
											</div>
											<div class="form-group d-flex">
												<img src='/assets/img/add-button.png' class='card-img-top' onerror=this.src='assets/img/error-404-monochrome.svg'>
											</div>											
										</div>
									</div>
								</div>						
							
							<c:if test="${length%colNum == 0}">
								</div>
							</c:if>
						</c:if>
											
					</c:forEach>		
				</div>
			</main>
		<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
		<script src="js/datatables-simple-demo.js"></script>

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	</div>
	<script src="js/scripts.js">
		$("#insertProject").click(function(){
		    $.ajax({
		      url: '/insertProject',
		      type: 'POST',
		      success: function(data) {
		        // This function is called if the request succeeds.
		        // 'data' is the data returned from the server.
		        // You can add code here to handle the returned data.
		        console.log('Request succeeded. Returned data: ' + data);
		      },
		      error: function(xhr, status, error) {
		        // This function is called if the request fails.
		        // 'xhr' is the XMLHttpRequest object, 'status' is the status code,
		        // 'error' is the error message.
		        // You can add code here to handle the error.
		        console.log('Request failed. Status: ' + status + '. Error: ' + error);
		      }
		    });
		  });
	
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>






