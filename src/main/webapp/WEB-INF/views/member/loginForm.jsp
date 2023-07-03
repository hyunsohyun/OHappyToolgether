<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>OHappyToolgether</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="/css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<style>
	.main-container {
		display: flex;
        height: 100%;
        align-items: center;
        justify-content: center;
        background: linear-gradient(178.6deg, rgb(20, 36, 50) 11.8%, rgb(124, 143, 161) 83.8%);
	}

    .content-container {
        display: flex;
    }

    .card-wrap {
        min-width: 500px;
    }
</style>

<body>
    <div class="main-container">
        <div class="content-container">
			<div class="card">
				<div class="card-header">
					<div class="text-center">
						<h3>로그인</h3>
					</div>
				</div>
				<div class="card-body">
					<form name='f' action='/login' method='POST'>
						<div class="form-group">
							<label for="userid" class="form-label mt-4">아이디</label> <input type="text" class="form-control" id="userid" name="userid" placeholder="Enter your ID">
						</div>
						<div class="form-group">
							<label for="password" class="form-label mt-4">비밀번호</label> <input type="password" class="form-control" id="password" name="password" placeholder="Password">
						</div>
						<div class="form-group mt-4">
							<button type="submit" class="btn btn-primary">로그인</button>
							<a href="joinForm">
								<button type="button" class="btn btn-primary float-end">회원가입</button>
							</a>										
						</div>
					</form>
				</div>
				<div class="card-footer small text-muted text-center">OHappyToolgether</div>
			</div>
		</div>
	</div>
</body>
</html>