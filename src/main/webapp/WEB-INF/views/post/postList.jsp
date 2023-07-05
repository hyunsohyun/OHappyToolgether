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
	<link href="/css/styles.css" rel="stylesheet" />
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
				<h1 class="mt-4">${boardName}</h1>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a href="/">Dashboard</a></li>
					<li class="breadcrumb-item active">Tables</li>
				</ol>

				<div class="card mb-4">
					<div class="card-header">
						<i class="fas fa-table me-1"></i>${boardName}
					</div>
					
					<div class="card-body">
						<table id="datatablesSimple">
							<thead>
								<tr>
									<th></th>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${list}" var="post" varStatus="status">
									<tr>
										<td>${post.postId}</td>
										<td>${fn:length(list) - status.index}</td>
										<td>${post.title}</td>
										<td>${post.userid}</td>
										<td>${post.createDate}</td>
										<td>${post.hit}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="text-right">
					<input type="button" onclick="location.href='/postInsert/${boardId}'" value="글쓰기" class="btn btn-info">
		        </div>
				<div>
				</div>
			</div>
				
			</main>
			<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
			<script src="/js/datatables-simple-demo.js"></script>
			<script type="text/javascript">
			
				$(document).ready(function() {
				 /*  $('#datatablesSimple').DataTable({
					  // datatable 설정 옵션들...
					  "columnDefs": [
					    {
					      "targets": 0, // postId가 위치한 열의 인덱스
					      "visible": false, // postId 열은 숨김 처리
					    }
					  ]
				}); */
			
				$("#datatablesSimple").on('click', 'tbody tr', function() {
					let postId = $(this).children().eq(0).text();
					//let postId = $(this).children().eq(0).attr("id");
					let boardId = '${boardId}';
					
					//조회수 업데이트
					fetch("/post", {
					  method: "PUT",
					  headers: {
					    "Content-Type": "application/json; charset=UTF-8",
					  },
					  body: JSON.stringify({ postId: postId, boardId: boardId }),
					})
					  .then(response => {
					    if (response.ok) {
					      // 상세 페이지로 이동
					      window.location.href = '/postDetail/${boardId}/' + postId;
					    } else {
					      throw new Error(response.status);
					    }
					  })
					  .catch(error => {
					    alert("code:" + error.message);
					  }); 
				});
				});
			</script>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>
	<script src="/js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>