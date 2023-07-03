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
		    const projectId = '${sessionScope.projectId}';
		    const memberId = '${userid}'; 
		    const tableBody = $("#memberList");
		    const userTableBody = $("#userTableBody");
		    const pageSize = 6; 
		    

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
		                            console.log("?" + projectName);
		                            $("#projectName").val(projectName);
		                            break;
		                        }
		                    }
		                },
		                error: function(xhr, status, error) {
		                    console.log("에러 메시지:", xhr.status);
		                }
		            });
		        };
		        
		        
		
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
			                    let removeButtonCell = $("<td>");
			                    let removeButton = $("<button>").addClass("btn btn-danger deleteUsersProject").text("추방");
			                    removeButtonCell.append(removeButton);
			                    row.append(removeButtonCell);
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
		                url: "member/" + memberId,
		                type: "GET",
		                contentType: "application/json",
		                success: function(response) {
		                    let projectManagerName = response[0].name;
		                    console.log(projectManagerName);
		
		                    $("#projectManagerName").val(projectManagerName);
		                    $("#projectManagerId").val(memberId);
		                },
		                error: function(xhr, status, error) {
		                    console.log("에러 메시지:", xhr.status);
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
		

		}); 


		document.addEventListener("DOMContentLoaded", function() {
		    // session값 대체 임시
		    const projectId = ${sessionScope.projectId};
		    const memberId = '${userid}'; 
		   // const tableBody = document.getElementById("memberList");
		
		  // 프로젝트 이름 변경
		  document.getElementById("changeProjectNameBtn").addEventListener("click", function() {
		    let projectName = document.getElementById("projectName").value;
		
		    let xhr = new XMLHttpRequest();
		    xhr.open("PUT", "project/" + projectId + "/" + memberId, true);
		    xhr.setRequestHeader("Content-Type", "application/json");
		
		    xhr.onload = function() {
		      if (xhr.status === 200) {
		        alert("변경 성공");
		        console.log("프로젝트명 변경 성공");
		      } else {
		        console.log("에러 메시지:", xhr.status);
		      }
		    };
		
		    xhr.onerror = function() {
		      console.log("요청 에러");
		    };
		
		    xhr.send(JSON.stringify({ projectName: projectName }));
		  });
		
		  // 초대를 위한 유저 목록 가져오기
		  document.getElementById("userSearch").addEventListener("keyup", function(e) {
		    e.preventDefault();
		    let userid = document.getElementById("userSearch").value;
		    let url = (userid != "") ? "member/" + userid : "member";
		
		    let xhr = new XMLHttpRequest();
		    xhr.open("GET", url, true);
		    xhr.setRequestHeader("Content-Type", "application/json");
		
		    xhr.onload = function() {
		      console.log("xhr 데이터")
		      console.log(xhr.reponseText);      
		      if (xhr.status === 200 && !xhr.reponseText) {
		    	  
		        let user = JSON.parse(xhr.responseText);
		        console.log("받은 user 정보:", user);
		        addUserToTable(user);
		      } else {
		        console.log("에러 메시지:", xhr.status);
		        addUserToTable("");
		      }
		    };
		
		    xhr.onerror = function() {
		      console.log("요청 에러");
		      addUserToTable("");
		    };
		
		    xhr.send();
		  });
			
		  //검색으로 받은 Users값에 따른 표시
		  function addUserToTable(user) {
		    let tableBody = document.getElementById("userTableBody");
		    tableBody.innerHTML = "";
		
		    if (Array.isArray(user)) {
		      for (let i = 0; i < user.length; i++) {
		        let currentUser = user[i];
		        let row = document.createElement("tr");
		
		        let nameCell = document.createElement("td");
		        nameCell.textContent = currentUser.name;
		        row.appendChild(nameCell);
		
		        let userIdCell = document.createElement("td");
		        userIdCell.textContent = currentUser.userid;
		        row.appendChild(userIdCell);
		
		        let inviteButtonCell = document.createElement("td");
		        let inviteButton = document.createElement("a");
		        inviteButton.className = "btn btn-outline-primary userInvite";
		        inviteButton.textContent = "초대";
		        inviteButtonCell.appendChild(inviteButton);
		        row.appendChild(inviteButtonCell);
		
		        tableBody.appendChild(row);
		      }
		    } else if (user.userid == null) {
		      tableBody.textContent = "검색 결과가 없습니다.";
		    } else {
		      if (user.userid !== "") {
		        let row = document.createElement("tr");
		
		        let nameCell = document.createElement("td");
		        nameCell.textContent = user.name;
		        row.appendChild(nameCell);
		        
		        let userIdCell = document.createElement("td");
		        userIdCell.textContent = user.userid;
		        row.appendChild(userIdCell);
		
		
		        let inviteButtonCell = document.createElement("td");
		        let inviteButton = document.createElement("a");
		        inviteButton.className = "btn btn-outline-primary userInvite";
		        inviteButton.textContent = "초대";
		        inviteButtonCell.appendChild(inviteButton);
		        row.appendChild(inviteButtonCell);
		
		        tableBody.appendChild(row);
		      }
		    }
		  }
		  
		  
		  //초대하기 기능
		  document.addEventListener("click", function(e) {
		    if (e.target && e.target.classList.contains("userInvite")) {
		      e.preventDefault();
		
		      let tableBody = e.target.closest("tr");
		      let userId = tableBody.querySelector("td:nth-child(2)").textContent;
		      let usersProject = {
		        projectId: projectId,
		        userid: userId
		      };
		
		      let xhr = new XMLHttpRequest();
		      xhr.open("POST", "project/" + projectId + "/" + userId, true);
		      xhr.setRequestHeader("Content-Type", "application/json");
		
		      xhr.onload = function() {
		        if (xhr.status === 200) {
		          console.log("초대");
		          tableBody.innerHTML = "";
		          alert("초대완료");
		          updateProjectParticipantsAsync(); 
		        } else {
		          console.log("에러 메시지:", xhr.status);
		          alert("이미 초대한 유저입니다.");
		        }
		      };
		
		      xhr.onerror = function() {
		        console.log("요청 에러");
		      };
		
		      xhr.send(JSON.stringify(usersProject));
		    }
		  });
		 
		  //초대한 유저 참가자에 비동기적 추가
		  async function updateProjectParticipantsAsync() {
		  try {
		    let xhr = new XMLHttpRequest();
		    xhr.open("GET", "member/users/" + projectId, true);
		    xhr.setRequestHeader("Content-Type", "application/json");
		
		    xhr.onload = function() {
		      if (xhr.status === 200) {
		        let response = JSON.parse(xhr.responseText);
		        let tableBody = document.getElementById("memberList");
		        tableBody.innerHTML = "";
		
		        response.forEach(function(user) {
		          let row = document.createElement("tr");
		          row.classList.add("table-active");
		
		          let nameCell = document.createElement("td");
		          nameCell.textContent = user.name;
		          row.appendChild(nameCell);
		
		          let userIdCell = document.createElement("td");
		          userIdCell.textContent = user.userid;
		          row.appendChild(userIdCell);
		
		          let removeButtonCell = document.createElement("td");
		          let removeButton = document.createElement("button");
		          removeButton.className = "btn btn-danger deleteUsersProject";
		          removeButton.textContent = "추방";
		          removeButtonCell.appendChild(removeButton);
		          row.appendChild(removeButtonCell);
		
		          tableBody.appendChild(row);
		        });
		
		        // 프로젝트 참여인원 수 업데이트
		        let participantsInput = document.getElementById("projectParticipants");
		        participantsInput.value = response.length + " 명의 인원이 프로젝트에 참가중";
		      } else {
		        console.log("에러 메시지:", xhr.status);
		      }
		    };
		
		    xhr.onerror = function() {
		      console.log("요청 에러");
		    };
		
		    xhr.send();
		  } catch (error) {
		    console.log("에러 메시지:", error);
		  }
		}
		
			
		  //참가자 내쫓아 버리기
		  document.addEventListener("click", function(e) {
		    if (e.target && e.target.classList.contains("deleteUsersProject")) {
		      console.log("삭제버튼을 누름");
		      e.preventDefault();
		
		      let userId = e.target.closest("tr").querySelector("td:nth-child(2)").textContent;
		      console.log("")
		      let usersProject = {
		        projectId: projectId,
		        userid: userId
		      };
		      
		      console.log("userID ::" +userId);
		      console.log("memberID ::" +memberId);
		
		      let deleteButton = e.target;
		      if (userId == memberId) {
		        alert("관리자는 추방할 수 없습니다.");
		        return;
		      }
		
		      let xhr = new XMLHttpRequest();
		      xhr.open("DELETE", "project/" + projectId + "/" + userId, true);
		      xhr.setRequestHeader("Content-Type", "application/json");
		
		      xhr.onload = function() {
		        if (xhr.status === 200) {
		          console.log("삭제");
		          deleteButton.closest("tr").remove();
		          alert("추방되었습니다.");
		          updateProjectParticipantsAsync(); 
		        } else {
		          console.log("에러 메시지:", xhr.status);
		        }
		      };
		
		      xhr.onerror = function() {
		        console.log("요청 에러");
		      };
		
		      xhr.send(JSON.stringify(usersProject));
		    }
		  });
			
		  //프로젝트 삭제 (미완)
		  document.getElementById("projectDelteBtn").addEventListener("click", function() {
		    console.log("프로젝트 삭제 버튼을 누름");
		    let xhr = new XMLHttpRequest();
		    xhr.open("DELETE", "project/" + projectId, true);
		    xhr.setRequestHeader("Content-Type", "application/json");
		
		    xhr.onload = function() {
		      if (xhr.status === 200) {
		        console.log("프로젝트 삭제");
		        alert("프로젝트가 삭제되었습니다.");
		        location.href = "/";
		      } else {
		        console.log("에러 메시지:", xhr.status);
		      }
		    };
		
		    xhr.onerror = function() {
		      console.log("요청 에러");
		    };
		
		    xhr.send();
		  });
		});
</script>


<body class="sb-nav-fixed">
  <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <div id="layoutSidenav">
      <%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
        <div id="layoutSidenav_content">
          <main>
            <div id="projectManagementTitle">
              <h2>프로젝트 관리자</h2>
            </div>

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
                          <input type="text" class="form-design1" id="projectName">
                          <button type="button" class="btn btn-primary ml-2" id="changeProjectNameBtn">이름변경</button>
                        </div>
                      </div>
                    </div>

                    <hr class="hr">

                    <div class="d-flex mt-3 ">
                      <div class="project-input-name">
                        <label class="form-label">프로젝트 참여인원</label>
                      </div>
                      <div class="form-group project-input ml-2">
                        <input type="text" class="form-design" id="projectParticipants" disabled>
                      </div>
                    </div>

                    <div class="d-flex mt-3">
                      <div class="project-input-name">
                        <label class="form-label">관리자 이름</label>
                      </div>
                      <div class="form-group project-input ml-2">
                        <input type="text" class="form-design" id="projectManagerName" disabled>
                      </div>
                    </div>

                    <div class="d-flex mt-3">
                      <div class="project-input-name">
                        <label class="form-label">관리자 ID</label>
                      </div>
                      <div class="form-group project-input ml-2">
                        <input type="text" class="form-design" id="projectManagerId" disabled>
                      </div>
                    </div>

                    <div class="d-flex mt-3">
                      <div class="project-input-name">
                        <label class="form-label">게시글 수</label>
                      </div>
                      <div class="form-group project-input ml-2">
                        <input type="text" class="form-design" id="projectBoardCount" disabled>
                      </div>
                    </div>

                    <hr class="hr2">

                    <button type="button" class="btn btn-danger projectDelteBtn float-right mt-3" id="projectDelteBtn">프로젝트 삭제</button>
                  </div>

                  <div id="rightSideDiv">
                    <div id="projectImg">
                      <label class="form-label mt-1 projectImgLabel">프로젝트 이미지</label>
                    </div>
                    <div>
                      <img src="assets/img/together.png" height="340" width="420">
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
                          <th scope="col">추방방방</th>
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
                  <span class="sub-title-text">참가자 초대하기</span>
                </div>
                <div class="card-body">
                  <form class="d-flex">
                    <input class="form-control me-sm-2" type="search" placeholder="id 검색" id="userSearch">
                  </form>
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th scope="col">이름</th>
                        <th scope="col">아이디</th>
                        <th scope="col">초대</th>
                      </tr>
                    </thead>
                    <tbody id="userTableBody">
                      <!-- 페이징 처리로 동적으로 추가될 내용 -->
                    </tbody>
                  </table>
                  <div id="pagination"></div>
                </div>
              </div>
            </div>

        </div>
        </div>
    </main>
</body>

