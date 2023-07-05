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
<!-- swal2  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<style>

	.main-container {
		display: flex;
        height: 100vh;
        align-items: center;
        justify-content: center;
        background: linear-gradient(178.6deg, rgb(20, 36, 50) 11.8%, rgb(124, 143, 161) 83.8%);
	}

    .content-container {
        display: flex;
        height: 654px;
    }

    .card-wrap {
        min-width: 500px;
    }
</style>

<body>

    <div class="main-container font">
        <div class="content-container">
            <div class="card card-wrap">
                <div class="card-header">
                    <div class="text-center">
                        <h2>회원가입</h2>
                        <p>계정이 이미 있는 경우에는 <a href="/loginForm" class="color-green">로그인</a>해주세요. </p>
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
                            <input type="password" class="form-control" id="password" name="password"
                                placeholder="Password">
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

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
	  $(document).ready(function() {
	    $("#joinForm").submit(function(event) {
	      event.preventDefault(); // 폼 기본 동작 방지
	      const formData = {
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
	        	Swal.fire({
	                icon: 'success',
	                title: '회원가입 성공',
	                showConfirmButton: false,
	                timer: 1500
	            })
	            setTimeout(function() {
	            	window.location.href = "/loginForm";
				}, 1500);       
	        },
	        error: function(xhr, status, error) {
	        	Swal.fire({
	                icon: 'error',
	                title: '회원가입 실패',
	                showConfirmButton: false,
	                timer: 1500
	            })
	            setTimeout(function() {
	            	window.location.href = "/loginForm";
				}, 1500);  
	        }
	      });
	    });
	  });
	</script>  
</body>
</html>
	