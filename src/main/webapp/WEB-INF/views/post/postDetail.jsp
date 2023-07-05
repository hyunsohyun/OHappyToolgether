<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 현재 사용자의 ID를 가져옴 -->
<sec:authentication property="name" var="userid" />

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
	<!-- swal2  -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<style>
    #nav {
        display: flex;
        justify-content: space-between;
    }
    
    #comments {
    	background-color: #f7f7f7; 
    	padding : 10px;
    	padding-left: 40px;
   		padding-right: 40px;
   		border-radius: 10px;
   		
    }
    
    #comment-insert{
    	background-color: white; 
    	margin-top: 15px;
    	border-radius: 15px;
    	padding: 20px;
    	padding-right: 50px;
    }
    
</style>

<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
		<main class="container mt-4">


				<div class="container">
				<div id="title" class="mb-3">
					<h2>${post.title}</h2>
				</div>
				
				<div id="postInfo" class="mb-3">
				    <div style="display: flex; justify-content: space-between;">
				        <div class="right">
				            <table style ="width: 600px;">
				                <tr>
				                    <td rowspan="3" style="width: 10%;"><img style="width:50px; border-radius: 50%;" src="/resource/users/${post.writerImage}" /></td>
				                    <td style="width: 80%;"><span style="font-weight: bold;">${post.userid}</span></td>
				                </tr>
				                <tr>
				                    <td>
				                        <span style="color: gray;">
				                            <c:choose>
				                                <c:when test="${not empty post.modifyDate}">${post.modifyDate}</c:when>
				                                <c:otherwise>${post.createDate}</c:otherwise>
				                            </c:choose>
				                            조회: ${post.hit}
				                        </span>
				                    </td>
				                </tr>
				            </table>
				        </div>
				        <c:if test="${userid == post.userid}">
				            <div class="left">
				                <button type="button" class="btn btn-info" id="updateBtn" onclick="updatePost()">글수정</button>
				                <button type="button" class="btn btn-warning" id="deleteBtn" onclick="deletePost()">글삭제</button>
				            </div>
				        </c:if>
				    </div>
				</div>
				
				<!-- 라인이 넣고 싶어서~ -->
				<div class="card border-dark mb-3"></div>
				
				
				<!-- file존 -->
				<c:forEach var="fileList" items="${fileList}">
					<div id="files" class="mb-3 mx-3 float-end rounded" style="background-color: #f5f5f5; padding: 10px;">
			            <i class="fa-solid fa-file" style="color: gray;"></i>&nbsp;
			            <a href="/file/download/${fileList.postId}/${fileList.fileId}" style="text-decoration: none; color: #333;">${fileList.realFileName}</a>
					</div>
				</c:forEach>
								
				<!-- content존 -->
				<div id="content" style="min-height: 500px;" >
					${post.content}
				</div>
				

				<!-- 댓글존 -->
				<div id ="comments" class="mb-3" >
					<h4>Comments</h4>
					<!-- 댓글 리스트존 -->
					<div class="mb-3">
						<table id="commentList" style="width: 100%;">
							<%-- <c:forEach var="comment" items="${commentList}">
								<div>
									<table>
										<tr>
											<td rowspan="3" style="width:10%;"><img src="https://www.hsh"/></td>
											<td style="width:70%;"><span style="font-weight: bold;">${comment.writerId}</span></td>
											<td rowspan="3" Cstyle="width: 20%;">
												<c:if test="${sessionScope.userid eq 'comment.writerId'}">
													<input type='button' value='삭제' class="btn btn-light" onclick='ㅊ(this)'>
													<input type='button' value='수정' class="btn btn-light" onclick='commentDelete(this)'>
												</c:if>
											</td>
										</tr>
										<tr>
											<td>${comment.content}</td>
										</tr>
										<tr>
											<td><span style="color: gray;">
											<c:choose>
												<c:when test="${not empty comment.modifyDate}"> ${comment.modifyDate}</c:when>
					                        	<c:otherwise>${comment.createDate}</c:otherwise>
					                    	</c:choose>
											</span></td>
										</tr>
									</table>
									<br>
								</div>
							</c:forEach> --%>
							</table>
						
						<!-- 댓글입력존 -->
						<div id="comment-insert">
							<div class="mb-3 row">
								<div class="col mt-4" >
									<input type="text" class="form-control" id="commentContent" name="commentContent" placeholder="댓글을 입력해주세요">
								</div>
								<div class="col-auto d-flex align-items-end">
									<input type="button" class="btn btn btn-light" onclick="commentsInsert()" value="등록">
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<%-- <!-- 글수정 삭제 -->
				<div id="writerMode" class="mb-5">
					<div style="display: flex; justify-content: space-between;">
					 	<div class="right"></div>
						<c:if test="${userid == post.userid}">
				            <div class="left">
				                <button type="button" class="btn btn-info" id="updateBtn" onclick="updatePost()">글수정</button>
				                <button type="button" class="btn btn-warning" id="deleteBtn" onclick="deletePost()">글삭제</button>
				            </div>
				        </c:if>
			        </div>
				</div> --%>
				
				<div id="nav" style="display: flex; justify-content: flex-end;" class ="mb-7">
					<button type="button" class="btn btn-sm btn-secondary"" id="before" onclick="before()"><i class="fa-solid fa-arrow-down"></i> 이전글</button>
					<button type="button" class="btn btn-sm btn-light" id="list" onclick="window.location.href='/postList/${boardId}'">목록</button>
					<button type="button" class="btn btn-sm btn-secondary" id="next" onclick="next()"><i class="fa-solid fa-arrow-up"></i> 다음글</button>
				</div>
				
				
				</div>
			</main>
			<%@ include file="/WEB-INF/views/common/footer.jsp"%>
			</div>
			</div>
				
			
			
		
		
	<script src="/js/scripts.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
				
	<script type="text/javascript">
	$(document).ready(function(){
		commentList();//댓글리스트
	})
	
	//글수정 
	function updatePost(){
		const boardId = "${post.boardId}";
		const postId = "${post.postId}";
		window.location.href="/postUpdate?boardId=" + boardId + "&postId=" + postId;
	}
	
	//글삭제
	function deletePost(){
		const boardId = "${post.boardId}";
		const postId = "${post.postId}";
		
		fetch("/post/delete", {
			  method: "DELETE",
			  headers : {
			    "Content-Type": "application/json"
			  },
			  body : JSON.stringify({
			  		boardId : boardId
			  		,postId : postId
				})
			})
			  .then(response => response.json())
			  .then(data => {
				if(data>0){
				    //alert("게시물이 삭제되었습니다.");
				    Swal.fire({
						icon: 'success',
						title: '게시물이 삭제되었습니다.',
						showConfirmButton: false,
						timer: 1500
					})
				}else{
					//alert("게시물 삭제 실패");
					Swal.fire({
						icon: 'success',
						title: '게시물이 삭제 실패',
						showConfirmButton: false,
						timer: 1000
					})
				}
				window.location.href="/postList/" + boardId;
			  })
			  .catch(error => {
			    // 삭제 요청 중 오류가 발생했을 때 수행할 작업
			    console.error("게시물 삭제 중 오류가 발생했습니다:", error);
			  });
	}
	
	//댓글리스트
	function commentList(){
		const postId = "${post.postId}";
		const boardId = "${post.boardId}";
		fetch("/comments/" + boardId + "/" + postId)
		  .then(response => response.json())
		  .then(data => {
		    $('#commentList').empty();
		    data.forEach(value => {
		      let str = '';
		      str += '<tr style="width:100%;">';
		      str += '<td rowspan="3" style="width:10%;text-align: center;"><img style="width:50px; border-radius: 50%;" src="/resource/users/' + value.writerImage + '"/></td>';
		      str += '<td style="width:75%;"><span style="font-weight: bold;">' + value.writerId + '</span></td>';
		      str += '<td rowspan="3" style="width: 15%;">';
		      str += (value.writerId === '${userid}') ? '<i class="btn btn-light fas fa-edit" onclick="commentUpdateMode(' + value.commentId + ', this)"></i><i class="btn btn-light fas fa-trash" onclick="commentDelete(' + value.commentId + ')"></i>' : '';
		      str += '</td></tr>';
		      str += '<tr style="width:80%;"><td id="'+ value.commentId +'">' + value.content + '</td></tr>';
		      str += '<tr style="width:10%;"><td><span style="color: gray;">';
		      str += (value.modifyDate !== null) ? value.modifyDate : value.createDate;
		      str += '</span></td></tr><tr><td></td></tr>';
		      
		      $('#commentList').append(str);
		    });
		  })
		  .catch(error => {
		    console.log(error);
		  });
	}
	
	//댓글작성
	function commentsInsert(){
		if($("#commentContent").val()== null || $("#commentContent").val() == ''){
			Swal.fire({
				icon: 'warning',
				title: '댓글을 입력해주세요',
				showConfirmButton: false,
				timer: 1000
			})
			return;
		}
		
		const postId = "${post.postId}";
		const boardId = "${post.boardId}";
		fetch("/comments", {
			  method: "POST",
			  headers: {
			    "Content-Type": "application/json"
			  },
			  body: JSON.stringify({
				writerId : '${userid}',
			    postId: postId,
			    boardId: boardId,
			    content: $("#commentContent").val()
			  })
			})
		  .then(response => response.json())
		  .then(data => {
			$("#commentContent").val("");
		    commentList();
		  })
		  .catch(error => {
		    console.log(error);
		  });
	}
	
	//댓글 삭제
	function commentDelete(commentId){
		const postId = "${post.postId}";
		const boardId = "${post.boardId}";
		//console.log(commentId);
		fetch("/comments", {
		  method: "DELETE",
		  headers: {
		    "Content-Type": "application/json"
		  },
		  body: JSON.stringify({
		    postId: postId,
		    boardId : boardId,
		    commentId: commentId
		  })
		})
		  .then(response => response.json())
		  .then(data => {
		    if (data > 0) {
		    	Swal.fire({
					icon: 'success',
					title: '댓글이 삭제되었습니다',
					showConfirmButton: false,
					timer: 1000
				})
		    } else {
		      //alert("댓글삭제 실패");
		      Swal.fire({
					icon: 'error',
					title: '댓글이 삭제실패',
					showConfirmButton: false,
					timer: 1000
				})
		    }
		    commentList();
		  })
		  .catch(error => {
		    console.log(error);
		  });
	}
	
	//댓글 수정모드
	function commentUpdateMode(commentId,button){
		let td = $("#" + commentId)[0];
		
		// 텍스트 박스 요소 생성
		let textBox = document.createElement('input');
		textBox.id = 'content' + commentId;
		textBox.type = 'text';
		textBox.value = td.textContent;
		
		 // 텍스트 박스에 부트스트랩 클래스 추가
		textBox.classList.add('form-control');
		 
		 //버튼 삭제하고 생성
		$(button).siblings().remove();
  		$(button).after('<button type="button" class="btn btn-light btn-sm" onclick="commentList()">취소</button>');
  		$(button).after('<button type="button" class="btn btn-light btn-sm" onclick="commemtUpdate(' + commentId + ', this)">수정</button>');
		$(button).remove();

		// 해당 <td> 셀을 찾아 텍스트 박스로 대체
		td.innerHTML = '';
		td.appendChild(textBox);
	}
	
	//댓글 수정
	function commemtUpdate(commentId){
		const boardId = "${post.boardId}";
		const postId = "${post.postId}";
		
		fetch("/comments", {
		  method: "PUT",
		  headers: {
		    "Content-Type": "application/json"
		  },
		  body: JSON.stringify({
		    postId: postId,
		    boardId : boardId,
		    commentId: commentId,
		    content : $("#content"+commentId).val()
		  })
		})
		  .then(response => response.json())
		  .then(data => {
		    if (data> 0) {
		    	Swal.fire({
	                icon: 'success',
	                title: '수정 완료',
	                showConfirmButton: false,
	                timer: 1500
	            })
	            
		    } else {
				Swal.fire({
					icon: 'error',
					title: '수정 실패',
					showConfirmButton: false,
					timer: 1500
				})
		    }
		    commentList();
		  })
		  .catch(error => {
		    console.log(error);
		  });
	}
	
</script>
</body>
</html>
