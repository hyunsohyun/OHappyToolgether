<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<title>OHappyToolgether</title>
	<link
		href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="css/styles.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"	crossorigin="anonymous"></script>
	
	<style>
    .projectinfo-header {
        background-color: #343a40;
        color: #ffffff;
    }

    .projectinfo-container {
        display: flex;
        flex-wrap: wrap;
    }

    .projectinfo {
        flex-basis: 30%;
        margin: 10px;
    }

    .table th,
    .table td {
        text-align: center;
    }
    #changeProjectNameBtn{
    	margin-left: 5px;
    }
    
    .projectDelteBtn{
    	float:right; 
    }


    @media (max-width: 767px) {
        .projectinfo {
            flex-basis: 100%;
        }
    }
</style>
    
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
	
  //session값 대체 임시
  const projectId = ${sessionScope.projectId};
  const memberId = '${sessionScope.userid}';
  const tableBody = document.getElementById("memberList");
  const projectUserId = 'ndw';
  
  // 프로젝트 참가자 표시
  let getUsersAndProjectInfo = function() {
    // 프로젝트 정보 가져오기
    let getProjectInfo = function() {
      let xhr = new XMLHttpRequest();
      xhr.open("GET", "project/" + projectUserId, true);
      xhr.setRequestHeader("Content-Type", "application/json");

      xhr.onload = function() {
        if (xhr.status === 200) {
          let response = JSON.parse(xhr.responseText);
          let projectName = "";

          for (let i = 0; i < response.length; i++) {
            if (response[i].projectId === projectId) {
              projectName = response[i].projectName;
              console.log(projectName);
              document.getElementById("projectName").value = projectName;
              break;
            }
          }
        } else {
          console.log("에러 메시지:", xhr.status);
        }
      };

      xhr.onerror = function() {
        console.log("요청 에러");
      };

      xhr.send();
    };
    
    // 프로젝트 참가자 목록 가져오기
    let getUsers = function() {
      let xhr = new XMLHttpRequest();
      xhr.open("GET", "member/users/" + projectId, true);
      xhr.setRequestHeader("Content-Type", "application/json");
      
      xhr.onload = function() {
        if (xhr.status === 200) {
          tableBody.innerHTML = "";
          
          let response = JSON.parse(xhr.responseText);
          response.forEach(function(user) {
            let row = document.createElement("tr");
            row.className = "table-active";
            
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
        } else {
          console.log("에러 메시지:", xhr.status);
        }
      };
      
      xhr.onerror = function() {
        console.log("요청 에러");
      };
      
      xhr.send();
    };
    
    getProjectInfo();
    getUsers();
  };

  getUsersAndProjectInfo();

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
          refreshUserListAsync();
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
  async function refreshUserListAsync() {
    try {
      let xhr = new XMLHttpRequest();
      xhr.open("GET", "member/users/" + projectId, true);
      xhr.setRequestHeader("Content-Type", "application/json");

      xhr.onload = function() {
        if (xhr.status === 200) {
          let response = JSON.parse(xhr.responseText);
          console.log("사용자 목록 가져오기 성공");
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
      let usersProject = {
        projectId: projectId,
        userid: userId
      };

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
			<main class="container mt-4">
				<div id="projectManagementTitle">
					<h2>프로젝트관리</h2>
				</div>

				<div class="projectinfo-container">
					<div class="card border-dark mb-3 projectinfo">
						<div class="card-header projectinfo-header">프로젝트 정보</div>
						<div class="card-body">
							<div>
								<label for="exampleInputEmail1" class="form-label mt-1">프로젝트
									이름</label>
							</div>
							<div class="form-group d-flex">
								<input type="email" class="form-control" id="projectName"
									aria-describedby="emailHelp" placeholder="Enter email">
								<button type="button" class="btn btn-success ml-2"
									id="changeProjectNameBtn">변경</button>
							</div>
							<button type="button" class="btn btn-danger projectDelteBtn"
								id="projectDelteBtn">프로젝트 삭제</button>
						</div>
					</div>

					<div class="card border-dark mb-3 projectinfo">
						<div class="card-header projectinfo-header">프로젝트 참가자</div>
						<div class="card-body">
							<div class="form-group">
								<table class="table table-hover">
									<thead>
										<tr>
											<th scope="col">이름</th>
											<th scope="col">아이디</th>
											<th scope="col">추방</th>
										</tr>
									</thead>
									<tbody id="memberList">

									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div class="card border-dark mb-3 projectinfo">
						<div class="card-header projectinfo-header">참가자 초대하기</div>
						<div class="card-body">
							<form class="d-flex">
								<input class="form-control me-sm-2" type="search"
									placeholder="id 검색" id="userSearch">
								<button class="btn btn-secondary my-2 my-sm-0" type="submit"
									id="userSearchBtn">검색</button>
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
								</tbody>
							</table>
						</div>
					</div>
				</div>
		</div>
	</div>
	</main>
</body>

