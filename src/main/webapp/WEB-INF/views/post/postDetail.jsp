<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>
<main>
	<h3>포스트 info</h3>
	<table>
		<tr>
			<td>postId</td>
			<td>${post.postId}</td>
		</tr>
		<tr>
			<td>boardId</td>
			<td>${post.boardId}</td>
		</tr>
		<tr>
			<td>title</td>
			<td>${post.title}</td>
		</tr>
		<tr>
			<td>content</td>
			<td>${post.content}</td>
		</tr>
		<tr>
			<td>hit</td>
			<td>${post.hit}</td>
		</tr>
		<tr>
			<td>createDate</td>
			<td>${post.createDate}</td>
		</tr>
		<tr>
			<td>modifyDate</td>
			<td>${post.modifyDate}</td>
		</tr>
		<tr>
			<td>projectId</td>
			<td>${post.projectId}</td>
		</tr>
		<tr>
			<td>userid</td>
			<td>${post.userid}</td>
		</tr>
	</table>
	파일리스트
	<%-- ${filelist.fileId}
	${filelist.postId}
	${filelist.realFileName}
	${filelist.hashFileName}
	${filelist.boardId}
	${filelist.fileId} 
	
	
	댓글 리스트
	${commentList.commentId}
	${commentList.postId}
	${commentList.content}
	${commentList.createDate}
	${commentList.modifyDate}
	${commentList.writerId}
	${commentList.boardId} --%>
	
	<button type="button" class="btn btn-sm" id="deleteBtn" onclick="deletePost()">글삭제</button>

</main>
<%@ include file="../common/footer.jsp"%>
<script type="text/javascript">
	$(document).ready(function( {
		console.log("${filelist}");	
		console.log("${commentList}");		
	)};

	function deletePost(){
		let boardId = "${post.boardId}";
		let postId = "${post.postId}";
		window.location.href="postDelete.do?boardId=" + boardId + "&postId=" + postId;
	}
</script>
