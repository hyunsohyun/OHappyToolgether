<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>OHappyToolgether</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="/css/projectManagement.css" rel="stylesheet" />	
<link href="/css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>

</head>
<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>

				<div class="projectinfo-container">
					<div class="card projectinfo">
						<div class="card-header projectinfo-header">
							<span class="sub-title-text">프로젝트 정보</span>
						</div>
						<div class="card-body d-flex">
							<div class="project-info-box">
								<div class="d-flex">
									<div class="project-input-name">
										<label class="form-label mt-1">프로젝트 이름</label>
									</div>
									<div class="form-group project-input">
										<div class="d-flex">
											<input type="text" class="form-control" id="projectName"
												disabled>
										</div>
									</div>
								</div>

								<hr class="hr">

								<div class="d-flex mt-3">
									<div class="project-input-name">
										<label class="form-label">프로젝트 참여인원</label>
									</div>
									<div class="form-group project-input ml-2">
										<input type="text" class="form-control"
											id="projectParticipants" disabled>
									</div>
								</div>

								<div class="d-flex mt-3">
									<div class="project-input-name">
										<label class="form-label">관리자 이름</label>
									</div>
									<div class="form-group project-input ml-2">
										<input type="text" class="form-control"
											id="projectManagerName" disabled>
									</div>
								</div>

								<div class="d-flex mt-3">
									<div class="project-input-name">
										<label class="form-label">관리자 ID</label>
									</div>
									<div class="form-group project-input ml-2">
										<input type="text" class="form-control" id="projectManagerId"
											disabled>
									</div>
								</div>

								<div class="d-flex mt-3">
									<div class="project-input-name">
										<label class="form-label">게시판 개수</label>
									</div>
									<div class="form-group project-input ml-2">
										<input type="text" class="form-control" id="projectBoardCount"
											disabled>
									</div>
								</div>

								<hr class="hr2">

							</div>

							<div id="rightSideDiv">
							    <div id="projectImg" class="text-center">
							        <label class="form-label mt-1 projectImgLabel">프로젝트 이미지</label>
							    </div>
							    <div class="text-center">
							        <img src="/resource/projectimg/${sessionScope.project.projectImage}" height="270" width="270" class="img-fluid">
							    </div>
							</div>

						</div>
					</div>
				</div>

				<div class="projectinfo-container2">
					<div class="card mb-3 projectinfo projectMemberManagement">
						<div class="card-header projectinfo-header">
							<span class="sub-title-text">프로젝트 참가자</span>
						</div>
						<div class="card-body">
							<div class="form-group table-size">
								<table class="table table-hover" id="projectMemberTable">
									<thead>
										<tr>
											<th scope="col">이름</th>
											<th scope="col">아이디</th>
										</tr>
									</thead>
									<tbody id="memberList"></tbody>
								</table>
							</div>
							<div id="paginationContainer">
								<ul class="pagination justify-content-center" id="pagination"></ul>
							</div>
						</div>
					</div>

					<div class="card mb-3 projectinfo projectMemberManagement2">
						<div class="card-header projectinfo-header">
							<span class="sub-title-text">최근 게시글</span>
						</div>

						<div class="card-body">

							<div class="table-wrapper">
								<table class="table table-hover">
									<thead>
										<tr>
											<th scope="col">제목</th>
											<th scope="col">작성자</th>
											<th scope="col">작성일</th>
										</tr>
									</thead>
									<tbody id="userTableBody">

									</tbody>
								</table>
							</div>
							<div id="pagination"></div>
						</div>
					</div>

				</div>
		</div>

	</div>

	</main>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="/js/datatables-simple-demo.js"></script>
	<script type="text/javascript">
			</script>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	</div>
	<script src="/js/scripts.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
</body>

<script>


$(document).ready(function() {
	
	
	
	const modal = document.getElementById("modal")
    const projectId = '${sessionScope.projectId}';
    const memberId = '${userid}'; 
    const managerId = '${managerId}'
    const tableBody = $("#memberList");
    const userTableBody = $("#userTableBody");
    const url = "/";
    
    console.log("1 : " + memberId);
    console.log("2 : " +projectId);
    console.log("3 : " +managerId);
    
    
    
    
    const pageSize = 6; 
    
	let projectManagerId="";
        // 프로젝트 정보 가져오기
        let getProjectInfo = function() {
            $.ajax({
                url: url + "project/" + memberId,
                type: "GET",
                contentType: "application/json",
                success: function(response) {
                	console.log("프로젝트 정보 가져오기 성공")
                    let projectName = "";
                    for (let i = 0; i < response.length; i++) {
                        if (response[i].projectId == projectId) {
                            projectName = response[i].projectName;
                            projectManagerId = response[i].managerId;
                            $("#projectName").val(projectName);
                            $("#projectManagerId").val(projectManagerId);
                            break;
                        }
                    }
                },
                error: function(xhr, status, error) {
                    console.log("에러 메시지:", xhr.status);
                }
            });      
            
        };
        getProjectInfo();
        
    

	 
     // 최근 게시글 5개 가져오기
        let getRecentPostList = function() {
          $.ajax({
            url: '/post/recentPostList',
            method: 'GET',
            data: {projectId: ${projectId}},
            success: function(response) {
              // 받아온 HTML을 tbody에 추가
              console.log(response);
              let html = '';
              for (let i = 0; i < response.length; i++) {
                let post = response[i];
                html += '<tr>';
                html += '<td>' + post.title + '</td>';
                html += '<td>' + post.userid + '</td>';
                html += '<td>' + post.createDate + '</td>';
                html += '</tr>';
              }
              $('#userTableBody').html(html);
              //$('#userTableBody').html(response);
            },
            error: function() {
              console.log('데이터를 가져오는데 실패했습니다.');
            }
          });
        }
     	getRecentPostList();

     	
        // 프로젝트 참가자 목록 가져오기
		let getUsers = function(page, pageSize) {
		    $.ajax({
		        url: url +"member/users/" + projectId ,
		        type: "GET",
		        contentType: "application/json",
		        success: function(response) {
		        	console.log("getUsers 성공수행");
		            let startIndex = (page - 1) * pageSize;
		            let endIndex = startIndex + pageSize;
		            let paginatedData = response.slice(startIndex, endIndex);
		
		            let tableBody = $("#memberList");
		            tableBody.empty();
		
		            if (paginatedData.length > 0) {
		                paginatedData.forEach(function(user) {
		                    let row = $("<tr>").addClass("table-active");
		                    $("<td>").text(user.name).appendTo(row);
		                    $("<td>").text(user.userid).appendTo(row);
		                    tableBody.append(row);
		                });
		            }
		
		            // 프로젝트 참여인원 수 표시
		            let participantsInput = $("#projectParticipants");
		            participantsInput.val(response.length + " 명의 인원이 프로젝트에 참가중");
		
		            // 페이징 처리
		            let pagination = $("#pagination");
		            pagination.empty();
		
		            let totalPages = Math.ceil(response.length / pageSize);
		            if (totalPages > 1) {
		              let prevButton = $("<li>").addClass("page-item");
		              let prevLink = $("<a>").addClass("page-link").attr("href", "#").text("이전");
		              prevLink.on("click", function (event) {
		                event.preventDefault(); // 이벤트 기본 동작 방지
		                let currentPage = page > 1 ? page - 1 : 1;
		                getUsers(currentPage, pageSize);
		              });
		              prevButton.append(prevLink);
		              pagination.append(prevButton);
	
		              let startPage = Math.max(page - 2, 1);
		              let endPage = Math.min(page + 2, totalPages);
	
		              for (let i = startPage; i <= endPage; i++) {
		                let pageItem = $("<li>").addClass("page-item");
		                let pageLink = $("<a>").addClass("page-link").attr("href", "#").text(i);
		                if (i === page) {
		                  pageItem.addClass("active");
		                }
		                pageLink.on("click", function (event) {
		                  event.preventDefault(); // 이벤트 기본 동작 방지
		                  getUsers(i, pageSize);
		                });
		                pageItem.append(pageLink);
		                pagination.append(pageItem);
		              }
	
		              let nextButton = $("<li>").addClass("page-item");
		              let nextLink = $("<a>").addClass("page-link").attr("href", "#").text("다음");
		              nextLink.on("click", function (event) {
		                event.preventDefault(); // 이벤트 기본 동작 방지
		                let currentPage = page < totalPages ? page + 1 : totalPages;
		                getUsers(currentPage, pageSize);
		              });
		              nextButton.append(nextLink);
		              pagination.append(nextButton);
		            }
		        },
		        error: function(xhr, status, error) {
		            console.log("에러 메시지:", xhr.status);
		        }
		    });
		};
		
		
        // 프로젝트 관리자 정보 가져오기
        let getProjectManager = function() {
		     $.ajax({
		        url: url + "member/" + projectManagerId,
		        type: "GET",
		        contentType: "application/json",
		        success: function(response) {
		        	console.log("getProjectManager 성공수행");
		            let projectManagerName = "";
		            for (let i = 0; i < response.length; i++) {
		                if (response[i].userid == projectManagerId) {
		                    projectManagerName = response[i].name;
		                    console.log(projectManagerName);
		                }
		            }
		            $("#projectManagerName").val(projectManagerName);
		        },
		        error: function(xhr, status, error) {
		            console.log("에러 메시지:", xhr.status);
		            $("#projectManagerName").val("에러 발생"); 
		        }
		    }); 
		};

		
        // 게시판 수 가져오기
        let getBoardCount = function() {
            $.ajax({
                url: url +  "board/" + projectId,
                type: "GET",
                contentType: "application/json",
                success: function(response) {
                	console.log("getBoardCount 실행성공");
                    let boardCount = response.length;

                    let projectBoardCount = $("#projectBoardCount");
                    projectBoardCount.val(boardCount + " 개의 게시판");
                },
                error: function(xhr, status, error) {
                    console.log("에러 메시지:", xhr.status);
                }
            });
        };

        getProjectInfo();
        getUsers(1, pageSize);
        getProjectManager();
        getBoardCount();
});

</script>

</html>
