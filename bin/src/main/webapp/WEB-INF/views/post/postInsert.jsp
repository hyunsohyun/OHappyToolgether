<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>
<main>
	
	<h1 class="mt-4">게시판 글쓰기</h1>
	<ol class="breadcrumb mb-4">
		<li class="breadcrumb-item"><a href="/">Dashboard</a></li>
		<li class="breadcrumb-item active">Tables</li>
	</ol>
		<form method="post" id="testform" name="testform" action="">
			<input type="input" class="form-control" id="Input" name="title" placeholder="제목을 입력해주세요">
			<textarea id="summernote" name="editordata"></textarea>
			<input type ="button" onclick="test()" value ="등록"/>
		</form>
	
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		<!-- include summernote css/js -->
		<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#summernote').summernote();
			});
			
		function test(){
			console.log(testform.title.value);
			console.log(testform.editordata.value);
		}	
	</script>
</main>
