<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>
<main>
	
	<h1 class="mt-4">게시글 수정하기</h1>
	<ol class="breadcrumb mb-4">
		<li class="breadcrumb-item"><a href="/">Dashboard</a></li>
		<li class="breadcrumb-item active">Tables</li>
		</ol>
		<form method="post" id="testform" name="post">
			<input type="hidden" name="boardId" value="${post.boardId}">
			<input type="hidden" name="postId" value="${post.postId}">
			<input type="input" class="form-control" id="Input" name="title"
				placeholder="제목을 입력해주세요">
			<textarea id="summernote" name="content"></textarea>
			<input type="submit" value="등록" />
		</form>
	
		<!-- include summernote css/js -->
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#summernote').summernote();
			});
		</script>
</main>

