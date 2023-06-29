<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>

<script type="text/javascript">
	$("#empnosearchbtn").click(function(){
		if($("#empnosearch").val() == "" || $("#empnosearch").val() == null){
			empList();
		}else{
			searchByEmpno($("#empnosearch").val());
		}
	});
</script>
	
<style>
	body{
		background-color: lightgray;
	}
	main{
		margin : 30px;
		background: white;
		padding : 30px;
		box-shadow: 3px 3px 3px  grey;
	}
	#projectManagementTitle{
		margin-left : 30px;
		margin-bottom : 30px;
	}
	.projectinfo{
		float : left;
		width : 400px;
		height : 600px;
		margin-left: 30px;
		border:5px solid green;
		box-shadow: 5px 5px 5px  grey;
	}
	
	#projectmember{
		margin-left: 30px;
		float : left;
		width : 400px;
		height : 600px;
		padding : 20px;
		border: 5px solid black;
	}
	
	#memberlist{
		margin-left: 10px;
		float : left;
		width : 330px;
		height : 400px;
		padding : 20px;
		border: 5px solid black;
	}
	.member-info{
		margin-bottom:20px;
	}
	.member-id{
		margin-right: 30px;
		margin-left: 30px;
	}
	
	.btn-success{ 
		float: right;
		margin-top : 3px;
	}
	
	.btn-danger{
		float: right;
	}
	.card-header{
		height : 60px;
		font-size : 1.5em;
		text-align: center;
	}
	.card-body{
		padding:20px;
	}
	.projectinfo-header{
	}
</style>
<main>
	<div id="projectManagementTitle">
		<h2>프로젝트관리</h2>
	</div>
	
	<div class="card border-dark mb-3 projectinfo">
		<div class="card-header projectinfo-header">프로젝트 정보</div>
		<div class=" card-body">
			<div class="form-group">
				<label for="exampleInputEmail1" class="form-label mt-1">프로젝트
					이름</label> <input type="email" class="form-control" id="exampleInputEmail1"
					aria-describedby="emailHelp" placeholder="Enter email">
				<button type="button" class="btn btn-success">변경</button>
			</div>
			<div class="form-group">
				<label class="form-label mt-4" for="readOnlyInput">참여인원</label> <input
					class="form-control" id="readOnlyInput" type="text"
					placeholder="5명" readonly="">
			</div>
			<div class="form-group">
				<fieldset>
					<label class="form-label mt-4" for="readOnlyInput">게시글 수</label> <input
						class="form-control" id="readOnlyInput" type="text"
						placeholder="13개" readonly="">
				</fieldset>
			</div>
			<div class="form-group">
				<fieldset>
					<label class="form-label mt-4" for="readOnlyInput">KANBAN -
						CARD 개수</label> <input class="form-control" id="readOnlyInput" type="text"
						placeholder="19개" readonly="">
				</fieldset>
			</div>
			<button type="button" class="btn btn-danger">프로젝트 삭제</button>
		</div>
	</div>
	
	<div class="card border-dark mb-3 projectinfo">
		<div class="card-header projectinfo-header">프로젝트 참가자</div>
			<div class=" card-body">
			<div class="form-group">
				<table class="table table-hover">
				  <thead>
				    <tr>
				      <th scope="col">이름</th>
				      <th scope="col">아이디</th>
				      <th scope="col">추방</th>
				    </tr>
				  </thead>
				  <tbody>
				  	
				  	<c:forEach items="${list}" var="l">
					<tr>
						<td>${l.userid}</td>
						<td>${l.name}</td>
						<td><a class="btn btn-outline-primary empdelete">추방</a></td>
					</tr>
					</c:forEach>
				  
				    <tr class="table-active">
				      <th scope="row">남동우</th>
				      <td>DongWooID</td>
				      <td><button type="button" class="btn btn-danger">추방</button></td>
				    </tr>
				    <tr>
				      <th scope="row">Default</th>
				      <td>Column content</td>
				      <td><button type="button" class="btn btn-danger">추방</button></td>
				    </tr>
				    <tr class="table-primary">
				      <th scope="row">Primary</th>
				      <td>Column content</td>
				      <td><button type="button" class="btn btn-danger">추방</button></td>
				    </tr>
				    <tr class="table-secondary">
				      <th scope="row">Secondary</th>
				      <td>Column content</td>
				      <td><button type="button" class="btn btn-danger">추방</button></td>
				    </tr>
				    <tr class="table-success">
				      <th scope="row">Success</th>
				      <td>Column content</td>
				      <td><button type="button" class="btn btn-danger">추방</button></td>
				    </tr>
				    <tr class="table-danger">
				      <th scope="row">Danger</th>
				      <td>Column content</td>
				      <td><button type="button" class="btn btn-danger">추방</button></td>
				    </tr>
				    <tr class="table-warning">
				      <th scope="row">Warning</th>
				      <td>Column content</td>
				      <td><button type="button" class="btn btn-danger">추방</button></td>
				    </tr>
				  </tbody>
				</table>
			</div>				
		</div>
	</div>
	
	<div class="card border-dark mb-3 projectinfo">
		<div class="card-header projectinfo-header">참가자 초대하기</div>
		<div class=" card-body">
						
		  <form class="d-flex">
	        <input class="form-control me-sm-2" type="search" placeholder="Search">
	        <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
	      </form>
		</div>
	</div>
	
</main>