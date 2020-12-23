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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
	<h1>Destination: ${trip.destination}</h1><br><br>
	<h4>This flight will be leaving on ${trip.departure}</h4><br><br>
	<h5>Users on this trip:</h5>
	<table class="table table-sm table-dark">
		<thead scope="col">
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
		<input type="submit" class="btn btn-primary mb-2" value="Join" />
	</form:form>
	
	
	<h3>Rate this trip</h3>
	<form:form action="/trips/${trip.id}/rating" method="post" modelAttribute="rating">
		<form:label path="rate">Rating:</form:label>
		<form:input type="number" path="rate" />
		<input type="submit" class="btn btn-primary mb-2" value="Rate" />
	</form:form>
	
	
	<form action="/home">
		<input type="submit" class="btn btn-primary mb-2" value="Home" />
	</form>
</body>
</html>