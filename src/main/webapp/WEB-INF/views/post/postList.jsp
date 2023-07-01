<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
			<div class="container">
				<h1 class="mt-4">게시판</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a href="/">Dashboard</a></li>
					<li class="breadcrumb-item active">Tables</li>
				</ol>

				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-table me-1"></i>${boardName}
					</div>
					<div>
						<button type="button" class="btn btn-sm btn-warning" id="deleteBtn" onclick="location.href='/postInsert.do?boardId=${boardId}'">글쓰기</button>
					</div>
					<div class="card-body">
						<table id="datatablesSimple">
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${list}">
									<tr>
										<td>${list.postId}</td>
										<td>${list.title}</td>
										<td>${list.userid}</td>
										<td>${list.createDate}</td>
										<td>${list.hit}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
				
			</main>
			<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
			<script src="js/datatables-simple-demo.js"></script>
			<script type="text/javascript">
				$("#datatablesSimple").on('click', 'tbody tr', function() {
					let postId = $(this).children().eq(0).text();

					//조회수 업데이트
					$.ajax({
					    url: "post",
					    type: "PUT",
					    dataType : "json",
					    data: JSON.stringify({ postId: postId }),
					    contentType:  'application/json; charset=UTF-8',
					    success: function() {
					        // 상세 페이지 이동
					        window.location.href = 'postDetail.do?boardId=' + ${boardId} + '&postId=' + postId;
					    },
					    error: function(request, status, error) {
					        alert("code:" + request.status + "\n" + "error:" + error);
					    }
					});
					//window.location.href = 'postDetail.do?boardId=' + ${boardId} + '&postId=' + postId;
				});
			</script>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>