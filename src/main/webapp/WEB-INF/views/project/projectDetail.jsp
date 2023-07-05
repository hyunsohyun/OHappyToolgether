<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<!-- swal2  -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- osh8242
<link href="/css/projectManagement.css" rel="stylesheet" />
<link href="/css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
-->

</head>
<style>
 
 
</style>
<body class="sb-nav-fixed">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="layoutSidenav">
		<%@ include file="/WEB-INF/views/common/sidenav.jsp"%>
		<div id="layoutSidenav_content">
			<main>
			<div class="container mt-2" id="projectContainer" > 
			
				<img src="/resource/projectimg/${project.projectImage}" style="width: 50px; display: inline-block;  border-radius: 50%;">
				<h3 style="display: inline-block;">${project.projectName}</h3>	
				
				
				
					<!-- member 영역 -->
					<div class="card mb-4">
						<div class="card-header projectinfo-header">
							<span class="sub-title-text"><i class="fas fa-users"></i> TEAM MEMBER</span>
						</div>

						
						<div style="margin: auto;">
							<c:set var="colNum" value='5' />
							<c:set var="length" value='${fn:length(memberlist)}' />
							<i class="fa-duotone fa-users"></i>
							<c:forEach var="item" items="${memberlist}" begin="0"
								varStatus="status">
								<c:if test="${status.index%colNum == 0}">
									<div class='row mt-5'>
								</c:if>
								<div class="col-sm-3" style="width: 225px;">
									<div class="card projectinfo shadow mb-5 rounded"
										onclick="window.location.href ='projectDetail.do/${item.userid}'">
										<!-- style="cursor :pointer"  -->
										<div class="card-body">
											<div class="form-group d-flex">
												<img src='/resource/users/${item.image}' class='card-img-top' />
											</div>
											<div>
												<h5 style="text-align: center; font-size: 1.1em;">${item.name}(${item.userid})</h5>
												<h5 style="text-align: center;">
													<i class="fas fa-envelope" style="color: #091b39;"></i>
													${item.email}
												</h5>
											</div>
										</div>
									</div>
								</div>
								<c:if test="${status.index%colNum == colNum-1}">
						</div>
						</c:if>
							<c:if test="${status.last}">
							
								<c:if test="${length%colNum == 0}">
									<div class='row mt-5'>
								</c:if>
								
								
								<c:if test="${length%colNum == 0}">
									</div>
								</c:if>
							</c:if>
												
						</c:forEach>

						</div>
					</div>
					</div>
					<!-- member 끝 -->
					
					
					
					<!-- 최신글 -->
					<div class="row">
						<div class="col-lg-8">
							<div class="card mb-4">
								<div class="card mb-3 projectinfo projectMemberManagement2">
				                  <div class="card-header projectinfo-header">
				                     <span class="sub-title-text"><i class="fas fa-clipboard"></i> RECENT POSTS</span>
				                  </div>
				                  <div class="card-body">
				                     <div class="table-wrapper" id='recentPost'>
				                        <table class="table table-hover">
				                           <thead>
				                              <tr>
				                                 <th scope="col">제목</th>
				                                 <th scope="col">작성자</th>
				                                 <th scope="col">작성일</th>
				                              </tr>
				                           </thead>
				                           <tbody id="userTableBody">
				
				                           </tbody>
				                        </table>
				                     </div>
				                     <div id="pagination"></div>
				                  </div>
				               </div>
							</div>
						</div>
						<!-- 최신글 끝 -->
						
						<!--  날씨 위젯 시작-->
						<div class="col-lg-4">
							<div class="card mb-4">
								<div id="ww_77adeaef7d684" v='1.3' loc='id' a='{"t":"horizontal","lang":"ko","sl_lpl":1,"ids":[],"font":"Arial","sl_ics":"one_a","sl_sot":"celsius","cl_bkg":"image","cl_font":"#FFFFFF","cl_cloud":"#FFFFFF","cl_persp":"#81D4FA","cl_sun":"#FFC107","cl_moon":"#FFC107","cl_thund":"#FF5722"}'>Weather Data Source: <a href="https://wetterlang.de/seoul_wetter_30_tage/" id="ww_77adeaef7d684_u" target="_blank">wetterlang.de</a></div><script async src="https://app1.weatherwidget.org/js/?id=ww_77adeaef7d684"></script>
							</div>
						</div>
						<!-- 날씨 위젯 끝 -->
						
					</div>
					
					
				</div>
		</main>
		<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
		<script src="/js/datatables-simple-demo.js"></script>


		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	</div>

	
	<script src="/js/scripts.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		  
			// 최근 게시글 5개 가져오기
		    $.ajax({
		      url: '/post/recentPostList',
		      method: 'GET',
		      data: { projectId: ${projectId} },
		      success: function(response) {
		        let html = '<div class="text-center">';
		        html += '<table class="table table-hover center">';
		        html += '<tr>';
		        html += '<th style="width:10%; text-align:center;">반호</th>';
		        html += '<th style="width:40%; text-align:center;">제목</th>';
		        html += '<th style="width:20%; text-align:center;">작성자</th>';
		        html += '<th style="width:30%; text-align:center;">작성일</th>';
		        html += '</tr>';
		        for (let i = 0; i < response.length; i++) {
		          let post = response[i];
		          html += '<tr onclick="handleRowClick(' + post.boardId + ',' + post.postId + ')" style="cursor:pointer;">';
		          html += '<td>' + (i + 1) + '</td>';
		          html += '<td>' + post.title + '</td>';
		          html += '<td>' + post.userid + '</td>';
		          html += '<td>' + post.createDate + '</td>';
		          html += '</tr>';
		        }
		        html += '</table>';
		        html += '</div>';
		        $('#recentPost').html(html);
		      },
		      error: function() {
		        console.log('데이터를 가져오는데 실패했습니다.');
		      }
		    });

		});
		
		//게시글 클릭시 게시글 상세 이동 함수
		let handleRowClick = function(boardId, postId) {
	    	window.location.href = '/postDetail/' + boardId + '/' + postId;
	  	}
		
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>






