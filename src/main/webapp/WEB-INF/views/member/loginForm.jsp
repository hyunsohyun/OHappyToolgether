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
<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
				<div>
					<c:if test="${param.error != null}">
						<p>아이디와 비번이 잘못 되었어요</p>
					</c:if>
					<c:if test="${param.logout != null}">
						<p>로그아웃 하였습니다</p>
					</c:if>
				</div>

				<div class="container px-4 mt-4">
					<div class="col-md-4 offset-md-4 mt-5">
						<div class="card">
							<div class="card-header">
								<i class="fas fa-user"></i>
								User Login
							</div>
							<div class="card-body">
								<form name='f' action='/login' method='POST'>
									<div class="form-group">
										<label for="userid" class="form-label mt-4">User ID</label> <input type="text" class="form-control" id="userid" name="userid" placeholder="Enter your ID">
									</div>
									<div class="form-group">
										<label for="password" class="form-label mt-4">Password</label> <input type="password" class="form-control" id="password" name="password" placeholder="Password">
									</div>
									<div class="form-group mt-4">
										<button type="submit" class="btn btn-primary">Submit</button>
										<a href="joinMember.do">
											<button type="button" class="btn btn-primary float-end">Join</button>
										</a>										
									</div>
								</form>
							</div>
							<div class="card-footer small text-muted">OHappyToolgether</div>
						</div>
					</div>
				</div>
			</main>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>
	<script src="/js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
