<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
</head>
<body class="sb-nav-fixed">

    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <div id="layoutSidenav">
        <%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
        <div id="layoutSidenav_content">
            <main>
                <div class="container px-4 mt-4" style="width: 200%">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div class="card-header">
                                <div class="text-center">
                                    <h2>회원가입</h2>
                                    <p>계정이 이미 있는 경우에는 <a href="/loginForm.do" class="color-green">로그인</a>해주세요. </p>
                                    <p>가입 후 아이디는 변경할 수 없습니다.</p>
                                </div>
                            </div>
                            <div class="card-body">
                                <form id="joinForm" action="/" method="POST">
                                    <div class="form-group">
                                        <label for="userid" class="form-label mt-4">아이디</label>
                                        <input type="text" class="form-control" id="userid" name="userid" placeholder="Enter your ID">
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="form-label mt-4">비밀번호</label>
                                        <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                                    </div>
                                    <div class="form-group">
                                        <label for="name" class="form-label mt-4">이름</label>
                                        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name">
                                    </div>
                                    <div class="form-group">
                                        <label for="email" class="form-label mt-4">이메일</label>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email">
                                    </div>
                                    <div class="form-group mt-4 text-center">
                                        <button type="submit" class="btn btn-primary">가입하기</button>
                                    </div>
                                </form>
                            </div>
                            <div class="card-footer small text-muted text-center">OHappyToolgether</div>
                        </div>
                    </div>
                </div>
            </main>
            <%@ include file="/WEB-INF/views/common/footer.jsp"%>
        </div>
    </div>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
	  $(document).ready(function() {
	    $("#joinForm").submit(function(event) {
	      event.preventDefault(); // 폼 기본 동작 방지
	      var formData = {
	        "userid": $("#userid").val(),
	        "password": $("#password").val(),
	        "name": $("#name").val(),
	        "email": $("#email").val()
	      };
	      console.log(formData.userid);
	
	      $.ajax({
	        url: "${pageContext.request.contextPath}/member/joinForm.do",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify(formData),
	        success: function(response) {
	          alert("회원 가입이 완료되었습니다.");
	          window.location.href = "/loginForm";
	        },
	        error: function(xhr, status, error) {
	          alert("회원 가입에 실패했습니다. 오류: " + xhr.responseText);
	        }
	      });
	    });
	  });
	</script>  
