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
	<h3>파일리스트</h3>
	<table>
		<c:forEach var="fileList" items="${fileList}">
			<tr>
				<td>${fileList.fileId}</td>
				<td>${fileList.postId}</td>
				<td>${fileList.realFileName}</td>
				<td>${fileList.filePath}</td>
				<td>${fileList.boardId}</td>
			</tr>
			
		</c:forEach>
	</table>
	<button type="button" class="btn btn-sm btn-warning" id="deleteBtn" onclick="deletePost()">글삭제</button>
	<button type="button" class="btn btn-sm btn-warning" id="deleteBtn" onclick="updatePost()">글삭제</button>

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
						<td><input type='button' value='파일삭제' onclick='fileDelete(this)'></td>
						<td></td>
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
	
</div>
</main>
<script type="text/javascript">
	
	$(document).ready(function(){
		commentList();
	})
	
	///////////////////////////////////
	//글삭제
	function deletePost(){
		const boardId = "${post.boardId}";
		const postId = "${post.postId}";
		window.location.href="postDelete?boardId=" + boardId + "&postId=" + postId;
	}
	
	///////////////////////////////////
	//파일 리스트
	function fileList(){
					
	}
	
	///////////////////////////////////
	//댓글리스트
	function commentList(){
		const postId = "${post.postId}";
		const boardId = "${post.boardId}";
		
		$.ajax({
            url : "comments/" + postId,
            dataType : "json",
            success : function(data) {
               $('#commentList').empty();
               $.each(data, function(key, value) {
					//console.log(value.commentId);
					let str = "<tr>";
					str += "<td>작성자</td>";
					str += "<td>" + value.writerId + "</td>";
					str += "<td>내용</td>";
                  	str += "<td>" + value.content + "</td>";
                  	str += "<td><input type='button' value='삭제' onclick='commemtDelete(" + value.commentId + ")'></td>";
                  	str += "<td><input type='button' value='수정' onclick='commemtUpdateMode(this)'></td>";
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
            url : "/comments",
            type : 'POST',
            dataType : "json",
            data : JSON.stringify({
            		postId : postId,
            		 content : $("#commentContent").val()
            		}),
            contentType:  'application/json; charset=UTF-8',
            success : function(data) {
            	//비우기
            	$("commentContent").val("");
            	commentList();
            }
         });
	}
	
	//댓글 삭제
	function commemtDelete(commentId){
		const postId = "${post.postId}";
		//console.log(commentId);
		$.ajax({
            url : "comments",
            type : 'DELETE',
            dataType : "json",
            data : JSON.stringify({ 
            	postId : postId,
            	commentId : commentId
       		}),
       		contentType:  'application/json; charset=UTF-8',
            success : function(data) {
            	 if(data>0){
            		alert("댓글삭제 완료");
            	}else{
            		alert("댓글삭제 실패")
            	}
            	commentList();
            }
         });
	}
	
	//댓글 수정으로 바꾸기
	function commemtUpdateMode(gg){
		console.log(gg);
		alert("gdg");
	}
	
	//댓글 수정
	function commemtUpdate(commentId){
		const postId = "${post.postId}";
		//console.log(commentId);
		$.ajax({
            url : "comments",
            type : 'PUT',
            dataType : "json",
            data : JSON.stringify({ 
            	postId : postId,
            	content : $("#commentContent").val(),
            	commentId : commentId
       		}),
       		contentType:  'application/json; charset=UTF-8',
            success : function(data) {
            	 if(data>0){
            		alert("댓글수정 완료");
            	}else{
            		alert("댓글수정 실패")
            	}
            	commentList();
            },
       		error: function(request, status, error) {
		        alert("code:" + request.status + "\n" + "error:" + error);
		    }
         });
		
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>
		</div>
	</div>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
