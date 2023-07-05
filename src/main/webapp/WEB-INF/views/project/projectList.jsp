<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 현재 사용자의 ID를 가져옴 -->
<sec:authentication property="name" var="userid" />
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
<!-- swal2  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
					<c:if test="${length == 0 }">
						<div class="col-sm-3">
							<div class="card border-dark shadow mb-5 rounded">
								<div class="card-header bg-secondary">새 프로젝트 추가</div>
								<div class="card-body" id="insertProject" data-bs-toggle="modal" data-bs-target="#projectForm">
									<div>
										<label class="form-label mt-1">프로젝트를 추가하려면 클릭하세요</label>
									</div>
									<div class="form-group d-flex">
										<img src='/assets/img/add-button.png' class='card-img-top' onerror=this.src='assets/img/error-404-monochrome.svg'>
									</div>											
								</div>
							</div>
						</div>
					</c:if>
					<c:forEach var="item" items="${projectList}" begin="0" varStatus="status">
						<c:if test="${status.index%colNum == 0}">
							<div class='row mt-5'>
						</c:if>
						<div class="col-sm-3">
							<div class="card border-dark projectinfo shadow mb-5 rounded" onclick="window.location.href ='projectDetail.do/${item.projectId}'" style="cursor :pointer" >
								<%-- <div class="card-header projectinfo-header bg-warning">Project ID : ${item.projectId}</div> --%>
								<div class="card-body">
									<div>
										<label class="form-label mt-1">${item.projectName}</label>
									</div>
									<div class="form-group d-flex">
										<img src='/resource/projectimg/${item.projectImage}' class='card-img-top' onerror=this.src='assets/img/error-404-monochrome.svg'>
									</div>
									<%-- <a href='projectDetail.do/${item.projectId}' class="btn btn-danger float-end">시작</a> --%>
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
									<div class="card border-dark shadow mb-5 rounded" style="cursor :pointer">
										<!-- <div class="card-header bg-secondary">새 프로젝트 추가</div> -->
										<div class="card-body" id="insertProject" data-bs-toggle="modal" data-bs-target="#projectForm">
											<div>
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
<!-- 모달 창 -->
<div class="modal" id="projectForm" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h1 class="modal-title fs-5">프로젝트 생성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="insertProjectForm">
        <div class="mb-3">
            <label for="managerId" class="col-form-label">프로젝트 매니저:</label>
            <input type="text" class="form-control" id="managerId" name="managerId" value="${userid}" disabled>
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">프로젝트명:</label>
            <input type="text" class="form-control" id="projectName">
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">프로젝트파일:</label>
            <input type="file" class="form-control" id="projectImage"></input>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="insertBtn">생성</button>
      </div>
    </div>
  </div>
</div>
		</main>
		<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
		<script src="js/datatables-simple-demo.js"></script>

		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	</div>
	
	<script src="js/scripts.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){		
		$("#insertBtn").on('click', function(event) {
		      event.preventDefault(); // 폼 기본 동작 방지
		      console.log("#insertBtn 클릭 이벤트 발생");
		      var formData = {
		        "managerId": $("#managerId").val(),
		        "projectName": $("#projectName").val(),
		        "projectImage": $('#projectImage')[0].files[0].name
		      };

		      $.ajax({
		        url: "${pageContext.request.contextPath}/project/insertProject",
		        type: "POST",
		        contentType: "application/json",
		        data: JSON.stringify(formData),
		        dataType : "text",
		        success: function(response) {
	        	  Swal.fire({
	                icon: 'success',
	                title: '생성 완료',
	                showConfirmButton: false,
	                timer: 1500
	              });
	        	  console.log(typeof(response));
	        	  console.log(response);
		          uploadImg(response);

		          setTimeout(function() {
		            	window.location.href = "/projectList.do";
					}, 2000);
		        },
		        error: function(xhr, status, error) {
		        	Swal.fire({
		                icon: 'error',
		                title: '생성 실패',
		                text: '오류 : ' + xhr.responseText,
		                showConfirmButton: false,
		                timer: 1500
		            })
		            setTimeout(function() {
		            	window.location.href = "/projectList.do";
					}, 1500);
		        }
		      });
		    });
		  });

		  function uploadImg(projectId) {
			  var data = new FormData();
			  let file = $('#projectImage')[0].files[0];
			  data.append('uploadFile', file);
			  data.append('projectId', projectId);
			  console.log(data);

			  $.ajax({
			    url: "${pageContext.request.contextPath}/file/projectimg/insert",
			    type: "POST",
			    contentType: false,
			    processData: false,
			    data: data,
			    success: function(response) {
			      // 업로드 성공 시 실행할 동작을 여기에 추가하세요.
			    },
			    error: function(xhr, status, error) {
			    	Swal.fire({
		                icon: 'error',
		                title: '수정 실패',
		                text: '오류 : ' + xhr.responseText,
		                showConfirmButton: false,
		                timer: 1500
		            })
			      return
			    }
			  });
			}
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>






