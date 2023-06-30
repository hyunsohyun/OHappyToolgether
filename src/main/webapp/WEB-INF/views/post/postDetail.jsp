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
	
	<hr>
	파일리스트
	<%-- 
	${filelist.postId}
	${filelist.realFileName}
	${filelist.hashFileName}
	${filelist.boardId}
	${filelist.fileId}--%>
	<table>
		<c:forEach var="fileList" items="${fileList}">
			<tr>
				<td>fileid</td>
				<td>${fileList.fileId}</td>
			</tr>
			<tr>
				<td>realFileName</td>
				<td>${fileList.realFileName}</td>
			</tr>
			
		</c:forEach>
	</table>
	<button type="button" class="btn btn-sm" id="deleteBtn" onclick="deletePost()">글삭제</button>
	<div>
		<!-- 댓글 리스트존 -->
		<div>
			<table id="commentList">
				<c:forEach var="commentList" items="${commentList}">
					<tr>
						<td>작성자</td>
						<td>${commentList.writerId}</td>
						<td>내용</td>
						<td>${commentList.content}</td>
					</tr>
					
				</c:forEach>
			</table>
		</div>
		<!-- 댓글입력존 -->
		<div>
			<form>
				<input type="text" id="commentContent">
				<input type="button" onclick="commentsInsert()" value="댓글등록">
			</form>
		</div>
	</div>
	<%-- 
	${commentList.commentId}
	${commentList.postId}
	${commentList.content}
	${commentList.createDate}
	${commentList.modifyDate}
	${commentList.writerId}
	${commentList.boardId} --%>
	
	

</main>
<%@ include file="../common/footer.jsp"%>
<script type="text/javascript">
	
	$(document).ready(function(){
		commentList();
	})
	
	//글삭제
	function deletePost(){
		let boardId = "${post.boardId}";
		let postId = "${post.postId}";
		window.location.href="postDelete.do?boardId=" + boardId + "&postId=" + postId;
	}
	
	///////////////////////////////////
	//댓글리스트
	function commentList(){
		const postId = "${post.postId}";
		
		$.ajax({
            url : "comments/" + postId,
            dataType : "json",
            success : function(data) {
               $('#commentList').empty();
               $.each(data, function(key, value) {
					console.log(value.commentId);
					let str = "<tr>";
					str += "<td>작성자</td>";
					str += "<td>" + value.writerId + "</td>";
					str += "<td>내용</td>";
                  	str += "<td>" + value.content + "</td>";
                    str += "</tr>";
                   $('#commentList').append(str);
               });
               
            }
         });
	}
	
	//댓글작성
	function commentsInsert(){
		const postId = "${post.postId}";
		
		$.ajax({
            url : "comments",
            type : 'POST',
            dataType : "json",
            data : JSON.stringify({ postId : postId,
            		 content : $("#commentContent").val()
            		}),
            contentType:  'application/json; charset=UTF-8',
            success : function(data) {
            	commentList();
            }
         });
	}
	
</script>
