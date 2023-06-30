<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div>
		<c:if test="${param.error != null}">
			<p>아이디와 비번이 잘못 되었어요</p>
		</c:if>
		<c:if test="${param.logout != null}">
			<p>로그아웃 하였습니다</p>
		</c:if>
	</div>

	<div class="container px-4 mt-4">
		<div class="col-md-4 offset-md-4">
			<div class="card">
				<div class="card-header">
					<div>User Login</div>
				</div>
				<div class="card-body">
					<form name='f' action='${pageContext.request.contextPath}/login.do'
						method='POST'>
						<div class="form-group">
							<label for="userid" class="form-label mt-4">User ID</label> <input
								type="text" class="form-control" id="userid" name="userid"
								placeholder="Enter your ID">
						</div>
						<div class="form-group">
							<label for="password" class="form-label mt-4">Password</label> <input
								type="password" class="form-control" id="password"
								name="password" placeholder="Password">
						</div>
						<button type="submit" class="btn btn-primary">Submit</button>
					</form>
				</div>
				<div class="card-footer small text-muted">OHappyToolgether</div>
			</div>
		</div>
	</div>



</body>
</html>