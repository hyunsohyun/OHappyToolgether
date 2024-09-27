<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<div>
			<c:if test="${param.error != null}">
				<p>
					아이디와 비번이 잘못 되었어요
				</p>
			</c:if>
			<c:if test="${param.logout != null}">
					<p>로그아웃 하였습니다</p>
			</c:if>
		</div>
		<form name='f' action='${pageContext.request.contextPath}/login' method='POST'>
				<table>
				<tr>
					<td>User:</td>
					<td><input type='text' name='id' ></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type='password' name='password'/></td>
				</tr>
				<tr>
					<td colspan='2'>
					<input name="submit" type="submit" value="Login"/>
					</td>
				</tr>
				</table>
		</form>
</body>
</html>