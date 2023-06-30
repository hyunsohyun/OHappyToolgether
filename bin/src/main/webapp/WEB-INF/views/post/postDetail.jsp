<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../common/header.jsp"%>
<%@ include file="../common/sidenav.jsp"%>
<main>
	<table>
		<thead>
			<tr>
				<th></th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td></td>
				<td>${post.title}</td>
				<td>${post.userid}</td>
				<td>${post.createDate}</td>
				<td>${post.hit}</td>
			</tr>
		</tbody>
	</table>
</main>
<%@ include file="../common/footer.jsp"%>
<script type="text/javascript">
</script>
