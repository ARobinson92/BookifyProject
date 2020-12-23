<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bookify</title>
</head>
<body>
	<h1>Destination: ${trip.destination}</h1>
	<h2>This flight will be leaving on ${trip.departure}</h2>
	<h2>Users on this trip:</h2>
	<table>
		<thead>
			<tr>
				<th>Name</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${users}" var="user">
				<tr>
					<td><c:out value="${user.email}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<h2>Would you like to join this trip?</h2>
	<form:form action="/trips/${trip.id}" method="post">
		<input type="submit" value="Join" />
	</form:form>
	<form action="/home">
		<input type="submit" value="Home" />
	</form>
</body>
</html>