<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <script type="text/javascript">
	$(document).ready(function(){
		$("#userInvite").click(function(){
			console.log("누름");
			if($("#userSearch").val() == "" || $("#userSearch").val() == null){
				empList();
			}else{
				selectUserById($("#userSearch").val());
			}
		});
	});
</script> -->

<script>
    $(document).ready(function() {
    	var projectId = 400; // 프로젝트 ID를 설정
    	var memberId = "osh8242";
        var tableBody = $("#memberList"); // tbody 요소 선택
    	var userId = 'ndw';
        
        $.ajax({
            url: "member/users/" + projectId,
            type: "GET",
            dataType: "json",
            success: function(response) {
                console.log("사용자 목록 가져오기 성공");
                tableBody.empty(); // 기존 데이터 삭제
                
                // 사용자 목록을 순회하며 행을 생성하여 tbody에 추가
                $.each(response, function(index, user) {
                    var row = $("<tr>").addClass("table-active");
                    var nameCell = $("<td>").text(user.name);
                    var userIdCell = $("<td>").text(user.userid);
                    var removeButtonCell = $("<td>").append($("<button>").addClass("btn btn-danger deleteUsersProject").text("추방"));
                    
                    row.append(nameCell);
                    row.append(userIdCell);
                    row.append(removeButtonCell);
                    
                    tableBody.append(row);
                });
            },
            error: function(xhr, status, error) {
                console.log("에러 메시지:", error);
            }
        });
        
        $.ajax({

            url: "project/" + userId,
            type: "GET",
            dataType: "json",
            success: function(response) {
                console.log("프로젝트정보 가져오기 성공");
                var projectName = '';
                for (var i = 0; i < response.length; i++) {
                  if (response[i].projectId === projectId) {
                     projectName = response[i].projectName;
                     console.log(projectName);
                     $("#projectName").val(projectName);
                    break;
                  }
                }
            },
            error: function(xhr, status, error) {
                console.log("에러 메시지:", error);
            }
        });
        
        
        // 버튼 클릭 시 사용자 정보 가져오기
        $("#userSearchBtn").click(function(e) {
            e.preventDefault(); // 폼 전송 방지
            
            var userid = $("#userSearch").val(); // 사용자 ID 입력값 가져오기
            
            // AJAX 요청
            $.ajax({
                url: "member/" + userid,
                type: "GET",
                dataType: "json",
                success: function(response) {
                    // 요청이 성공한 경우
                    var user = response;
                    console.log("받은 user 정보:", user);
                    
                    // 사용자 정보를 테이블에 추가
                    addUserToTable(user);
                },
                error: function(xhr, status, error) {
                    // 요청이 실패한 경우
                    console.log("에러 메시지:", error);  
                    addUserToTable("");
                }
            });
        });
        
        $(document).ready(function() {
        	  // 변경 버튼 클릭 이벤트 핸들러
        	  $("#changeProjectNameBtn").click(function() {
        	    var projectName = $("#projectName").val(); // 변경할 프로젝트명 가져오기
        	    
        	    // AJAX 요청
        	    $.ajax({
        	      url: "project/" + projectId + "/" + memberId,
        	      type: "PUT",
        	      dataType: "json",
        	      contentType: "application/json",
        	      data: JSON.stringify({ projectName: projectName }), // 변경할 프로젝트명 전달
        	      success: function(response) {
        	        console.log("프로젝트명 변경 성공");
        	        // 성공적으로 업데이트된 경우, 필요한 처리를 수행하세요.
        	      },
        	      error: function(xhr, status, error) {
        	        console.log("에러 메시지:", error);
        	        // 업데이트 실패 시 에러 처리를 수행하세요.
        	      }
        	    });
        	  });
        	});
        
        // 버튼 클릭 시 input 안에 있는 프로젝트 명으로 변경
        $("#userSearchBtn").click(function(e) {
            e.preventDefault(); // 폼 전송 방지
            
            var userid = $("#userSearch").val(); // 사용자 ID 입력값 가져오기
            
            // AJAX 요청
            $.ajax({
                url: "member/" + userid,
                type: "GET",
                dataType: "json",
                success: function(response) {
                    // 요청이 성공한 경우
                    var user = response;
                    console.log("받은 user 정보:", user);
                    
                    // 사용자 정보를 테이블에 추가
                    addUserToTable(user);
                },
                error: function(xhr, status, error) {
                    // 요청이 실패한 경우
                    console.log("에러 메시지:", error);  
                    addUserToTable("");
                }
            });
        });
        
        // 테이블에 사용자 정보 추가
        function addUserToTable(user) {
            var tableBody = $("#userTableBody");

            // 기존의 테이블 내용 삭제
            tableBody.empty();

            // 사용자 정보 행 생성
            if (user.userid && user.userid !== "") {
			    console.log(user.name);
			    var row = $("<tr>");
			    var userIdCell = $("<td>").text(user.userid);
			    var nameCell = $("<td>").text(user.name);
			    var inviteButtonCell = $("<td>").append($("<a>").addClass("btn btn-outline-primary userInvite").text("초대"));
			
			    row.append(userIdCell);
			    row.append(nameCell);
			    row.append(inviteButtonCell);
			
			    // 테이블에 행 추가
			    tableBody.append(row);
			}
        }
        
        $(document).on("click", ".userInvite", function(e) {
        	let tableBody = $("#userTableBody");
        	e.preventDefault();
	
            var userId = $(this).closest("tr").find("td:eq(0)").text();
            var projectId = 500;
            var usersProject = {
                projectId: projectId,
                userid: userId
            };

            $.ajax({
                url: "project/" + projectId + "/" + userId,
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(usersProject),
                dataType: "json",
                success: function(response) {
                    console.log("초대");
                    tableBody.empty();
                    alert("초대완료");
                },
                error: function(xhr, status, error) {
                    console.log("에러 메시지:", error);
                    tableBody.empty();
                    alert("이미 초대한 유저입니다.");
                }
            });
        });
        
        $(document).on("click", ".deleteUsersProject", function(e) {
        	console.log("삭제버튼을 누름");
        	let tableBody = $("#userTableBody");
        	e.preventDefault();
	
            var userId = $(this).closest("tr").find("td:eq(1)").text();
            var projectId = 500;
            var usersProject = {
                projectId: projectId,
                userid: userId
            };

            $.ajax({
                url: "project/" + projectId + "/" + userId,
                type: "DELETE",
                contentType: "application/json",
                data: JSON.stringify(usersProject),
                dataType: "json",
                success: function(response) {
                    console.log("삭제");
                    tableBody.empty();
                    alert("추방되었습니다.");
                },
                error: function(xhr, status, error) {
                    console.log("에러 메시지:", error);
                }
            }); 
        });
    });
</script>
	
<!-- <style>
	body{
		background-color: lightgray;
	}
	main{
		margin : 30px;
		background: white;
		padding : 30px;
		box-shadow: 3px 3px 3px  grey;
	}
	#projectManagementTitle{
		margin-left : 30px;
		margin-bottom : 30px;
	}
	.projectinfo{
		float : left;
		width : 400px;
		height : 600px;
		margin-left: 30px;
		border:5px solid green;
		box-shadow: 5px 5px 5px  grey;
	}
	
	#projectmember{
		margin-left: 30px;
		float : left;
		width : 400px;
		height : 600px;
		padding : 20px;
		border: 5px solid black;
	}
	
	#memberlist{
		margin-left: 10px;
		float : left;
		width : 330px;
		height : 400px;
		padding : 20px;
		border: 5px solid black;
	}
	.member-info{
		margin-bottom:20px;
	}
	.member-id{
		margin-right: 30px;
		margin-left: 30px;
	}
	
	.btn-success{ 
		float: right;
		margin-top : 3px;
	}
	
	.btn-danger{
		float: right;
	}
	.card-header{
		height : 60px;
		font-size : 1.5em;
		text-align: center;
	}
	.card-body{
		padding:20px;
	}
	.projectinfo-header{
	}
</style class="card border-dark mb-3"> -->
<%--  <main>
	<div id="projectManagementTitle">
		<h2>프로젝트관리</h2>
	</div>
	
	<div class="card border-dark mb-3 projectinfo">
		<div class="card-header projectinfo-header">프로젝트 정보</div>
		<div class=" card-body">
			<div class="form-group">
				<label for="exampleInputEmail1" class="form-label mt-1">프로젝트
					이름</label> <input type="email" class="form-control" id="exampleInputEmail1"
					aria-describedby="emailHelp" placeholder="Enter email">
				<button type="button" class="btn btn-success">변경</button>
			</div>
			<!-- <div class="form-group">
				<label class="form-label mt-4" for="readOnlyInput">참여인원</label> <input
					class="form-control"  type="text"
					placeholder="5명" readonly="">
			</div> -->
			<button type="button" class="btn btn-danger">프로젝트 삭제</button>
		</div>
	</div>
	
	 <div class="card border-dark mb-3 projectinfo">
		<div class="card-header projectinfo-header">프로젝트 참가자</div>
			<div class=" card-body">
			<div class="form-group">
				<table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">이름</th>
				      <th scope="col">아이디</th>
                      <th scope="col">추방</a></th> <!-- 수정: href="#" 추가 -->
				    </tr>
				  </thead>
				  <tbody id ="memberList">
					 
				  </tbody>
				</table>
			</div>				
		</div>
	</div> 

	<div class="card border-dark mb-3 projectinfo">
    <div class="card-header projectinfo-header">참가자 초대하기</div>
    <div class="card-body">
        <form class="d-flex">
            <input class="form-control me-sm-2" type="search" placeholder="Search" id="userSearch">
            <button class="btn btn-secondary my-2 my-sm-0" type="submit" id="userSearchBtn">Search</button>
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
                <c:forEach items="${list}" var="l">
                    <tr>
                        <td>${l.userid}</td>
                        <td>${l.name}</td>
                        <td><a class="btn userInvite">초대</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</div>


</main>




 --%>
 
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

    /* 반응형 레이아웃을 위한 미디어 쿼리 */
    @media (max-width: 767px) {
        .projectinfo {
            flex-basis: 100%;
        }
    }
</style>

<main class="container mt-4">
    <div id="projectManagementTitle">
        <h2>프로젝트관리</h2>
    </div>

    <div class="projectinfo-container">
        <div class="card border-dark mb-3 projectinfo">
            <div class="card-header projectinfo-header">프로젝트 정보</div>
            <div class="card-body">
                <div class="form-group">
                    <label for="exampleInputEmail1" class="form-label mt-1">프로젝트 이름</label>
                    <input type="email" class="form-control" id="projectName" aria-describedby="emailHelp" placeholder="Enter email">
                    <button type="button" class="btn btn-success" id="changeProjectNameBtn">변경</button>
                </div>
                <button type="button" class="btn btn-danger">프로젝트 삭제</button>
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
                            <!-- Member list rows go here -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="card border-dark mb-3 projectinfo">
            <div class="card-header projectinfo-header">참가자 초대하기</div>
            <div class="card-body">
                <form class="d-flex">
                    <input class="form-control me-sm-2" type="search" placeholder="Search" id="userSearch">
                    <button class="btn btn-secondary my-2 my-sm-0" type="submit" id="userSearchBtn">Search</button>
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
                        <!-- User table rows go here -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

