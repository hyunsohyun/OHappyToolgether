<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>
<main>
	<h1 class="mt-4">게시판</h1>
	<ol class="breadcrumb mb-4">
		<li class="breadcrumb-item"><a href="/">Dashboard</a></li>
		<li class="breadcrumb-item active">Tables</li>
	</ol>
	
	<div class="card mb-4">
		<div class="card-header">
			<i class="fas fa-table me-1"></i>게시판이름ㄹㄹㄹ
		</div>
		<div>
			<button type="button" class="btn btn-sm btn-warning" id="deleteBtn" onclick="postInsert.do">글쓰기</button>
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
						<tr onclick="postDetail.do?postId=${list.postId}">
							<td></td>
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
</main>
<%@ include file="../common/footer.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="js/datatables-simple-demo.js"></script>
<script type="text/javascript">
	$('#example').DataTable();
</script>
