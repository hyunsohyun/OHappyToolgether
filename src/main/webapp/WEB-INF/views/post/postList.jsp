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

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

	<!-- DataTables CSS -->
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css"/>

	<!-- DataTables -->
	<script src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>

	<!--  -->
	<link href="/css/styles.css" rel="stylesheet" />

	<!--  -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>

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
										<!-- <div style="display: none;">${post.postId}</div> -->
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

			<script type="text/javascript">
			
				$(document).ready(function() {
					console.log(1);
					// Korean
					var lang_kor = {
						"decimal" : "",
						"emptyTable" : "데이터가 없습니다.",
						"info" : "_START_ - _END_ (총 _TOTAL_ 명)",
						"infoEmpty" : "0명",
						"infoFiltered" : "(전체 _MAX_ 명 중 검색결과)",
						"infoPostFix" : "",
						"thousands" : ",",
						"lengthMenu" : "_MENU_ 개씩 보기",
						"loadingRecords" : "로딩중...",
						"processing" : "처리중...",
						"search" : "검색 : ",
						"zeroRecords" : "검색된 데이터가 없습니다.",
						"paginate" : {
							"first" : "첫 페이지",
							"last" : "마지막 페이지",
							"next" : "다음",
							"previous" : "이전"
						},
						"aria" : {
							"sortAscending" : " :  오름차순 정렬",
							"sortDescending" : " :  내림차순 정렬"
						}
					};

					const datatablesSimple = $('#datatablesSimple');

					if (datatablesSimple.length) {  // jQuery 객체의 length 속성으로 확인
						console.log(2);
						datatablesSimple.DataTable( {
							// options here
							// data: dataSet,
							// columns: col_kor, // or col_eng
							language : lang_kor, 
							searchable: false,
							"columnDefs": [
								{ "width": "10%", "targets": 0 },  // 번호
								{ "width": "50%", "targets": 1 },  // 제목
								{ "width": "10%", "targets": 2 },  // 작성자
								{ "width": "20%", "targets": 3 },  // 작성일
								{ "width": "10%", "targets": 4 },  // 조회수
							]
						} );
					}
			
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