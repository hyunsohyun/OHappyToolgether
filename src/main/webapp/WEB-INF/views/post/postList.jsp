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
				<h1 class="mt-5">${boardName}</h1>
				<ol class="breadcrumb mb-4">
    				<li class="breadcrumb-item"><a href="/projectDetail.do/${projectId}">${project.projectName}</a></li>
					<li class="breadcrumb-item active"><a href="<%=request.getContextPath()%>/postList/${boardId}">${boardName}</a></li>
				</ol>

				<div class="card mb-4">
					
					<div class="card-body">
						<table id="datatablesSimple" class="">
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody class="">
								<c:forEach items="${list}" var="post" varStatus="status">
									<tr data-post-id="${post.postId}">
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
					// Korean
					var lang_kor = {
						"decimal" : "",
						"emptyTable" : "데이터가 없습니다.",
						"info" : "_START_ - _END_ (총 _TOTAL_ 개)",
						"infoEmpty" : "0건",
						"infoFiltered" : "(전체 _MAX_ 건 중 검색결과)",
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
						datatablesSimple.DataTable( {
							// options here
							// data: dataSet,
							// columns: col_kor, // or col_eng
							language : lang_kor, 
							searchable: false,
							order: [[0, 'desc']],
							"columnDefs": [
								{ "width": "10%", "targets": [0,2,4] },  // 번호, 작성자, 조회수
								{ "width": "50%", "targets": 1 },  // 제목
								{ "width": "20%", "targets": 3 },  // 작성일
								{ "className": "dt-center", "targets": [0,2,3,4]}
							]
						} );
					}

				$("#datatablesSimple").on('mouseover', 'tbody tr', function() {
					  $(this).css('cursor', 'pointer');
				});
				
				$("#datatablesSimple").on('click', 'tbody tr', function() {
					// let postId = $(this).children().eq(0).text();
					// //let postId = $(this).children().eq(0).attr("id");
					let postId = $(this).data('post-id');  // .data() 메소드를 사용해 postId를 가져옵니다.
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
						  Swal.fire({
			  	                icon: 'error',
			  	                title: '에러 발생',
			  	                text: error.message,
			  	                showConfirmButton: false,
			  	                timer: 1500
			  	            })  
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