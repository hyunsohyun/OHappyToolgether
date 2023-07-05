<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 현재 사용자의 ID를 가져옴 -->
<sec:authentication property="name" var="userid" />

<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<title>OHappyToolgether</title>
	<link
		href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="css/projectManagement.css" rel="stylesheet" />
	<link href="css/styles.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"	crossorigin="anonymous"></script>

    
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>


$(document).ready(function() {
	
	const modal = document.getElementById("modal")
    const projectId = '${sessionScope.projectId}';
    const memberId = '${userid}'; 
    const managerId = '${managerId}'
    const tableBody = $("#memberList");
    const userTableBody = $("#userTableBody");
    const pageSize = 6; 
    
	let projectManagerId="";
    // 프로젝트 정보
    let getUsersAndProjectInfo = function() {
        // 프로젝트 정보 가져오기
        let getProjectInfo = function() {
            $.ajax({
                url: "project/" + memberId,
                type: "GET",
                contentType: "application/json",
                success: function(response) {
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
	
     // 최근 게시글 5개 가져오기
        let getRecentPostList = function() {
          $.ajax({
            url: '/post/recentPostList',
            method: 'GET',
            data: { projectId: 100 },
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
		        url: `member/users/${projectId}`,
		        type: "GET",
		        contentType: "application/json",
		        success: function(response) {
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
		        url: "member/" + projectManagerId,
		        type: "GET",
		        contentType: "application/json",
		        success: function(response) {
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


        // 게시글 수 가져오기
        let getBoardCount = function() {
            $.ajax({
                url: "board/" + projectId,
                type: "GET",
                contentType: "application/json",
                success: function(response) {
                    let boardCount = response.length;

                    let projectBoardCount = $("#projectBoardCount");
                    projectBoardCount.val(boardCount + " 개의 게시글");
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
    };

    getUsersAndProjectInfo();
    currentPage =1;
    let getUsers = function(page, pageSize) {
		    $.ajax({
		        url: `member/users/${projectId}`,
		        type: "GET",
		        contentType: "application/json",
		        success: function(response) {
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
		
		let getBoardCount = function() {
            $.ajax({
                url: "board/" + projectId,
                type: "GET",
                contentType: "application/json",
                success: function(response) {
                    let boardCount = response.length;

                    let projectBoardCount = $("#projectBoardCount");
                    projectBoardCount.val(boardCount + " 개의 게시글");
                },
                error: function(xhr, status, error) {
                    console.log("에러 메시지:", xhr.status);
                }
            });
        };


}); 
</script>

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
                      <input type="text" class="form-control" id="projectName" disabled>
                    </div>
                  </div>
                </div>

                <hr class="hr">

                <div class="d-flex mt-3">
                  <div class="project-input-name">
                    <label class="form-label">프로젝트 참여인원</label>
                  </div>
                  <div class="form-group project-input ml-2">
                    <input type="text" class="form-control" id="projectParticipants" disabled>
                  </div>
                </div>

                <div class="d-flex mt-3">
                  <div class="project-input-name">
                    <label class="form-label">관리자 이름</label>
                  </div>
                  <div class="form-group project-input ml-2">
                    <input type="text" class="form-control" id="projectManagerName" disabled>
                  </div>
                </div>

                <div class="d-flex mt-3">
                  <div class="project-input-name">
                    <label class="form-label">관리자 ID</label>
                  </div>
                  <div class="form-group project-input ml-2">
                    <input type="text" class="form-control" id="projectManagerId" disabled>
                  </div>
                </div>

                <div class="d-flex mt-3">
                  <div class="project-input-name">
                    <label class="form-label">게시글 수</label>
                  </div>
                  <div class="form-group project-input ml-2">
                    <input type="text" class="form-control" id="projectBoardCount" disabled>
                  </div>
                </div>

                <hr class="hr2">
                
              </div>

              <div id="rightSideDiv">
                <div id="projectImg">
                  <label class="form-label mt-1 projectImgLabel">프로젝트 이미지</label>
                </div>
                <div>
                  <img src="assets/img/tiger.png" height="270" width="270" class="img-fluid">
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
		    <div id="modal" class="modal-overlay" style="display: none;">
		        <div class="modal-window">
		            <div class="title">
		                <h2>게시판생성</h2>
		            </div>
		            <hr class="hr3">
		            <div class="close-area">X</div>
		            <div class="content">
						<label class="form-label mt-1">게시판 이름</label>
		                  </div>
		                  <div class="form-group">
		                    <div class="d-flex">
		                      <input type="text" class="form-control-board" id="boardInsertName">
		                      <button type="button" class="btn btn-primary ml-2" id="boardInsertBtn">게시판 생성</button>
		                    </div>		                    
		                  </div>
		            </div>
		        </div>
		    </div>
        </div>

      </div>
    </div>
</main>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>


