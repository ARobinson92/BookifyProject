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
	<h1>Trips You Are Attending:</h1>
	<table>
		<thead>
			<tr>
				<th>Destination</th>
				<th>Departure Date</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${trips}" var="trip">
				<tr>
					<td><c:out value="${trip.destination}" /></td>
					<td><c:out value="${trip.departure}" /></td>
					<td><form action="/trips/${trip.id}/remove" method="post">
							<input type="submit" value="Remove Trip" />
						</form></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<h1>Trips You Created:</h1>
	<table>
		<thead>
			<tr>
				<th>Destination</th>
				<th>Departure Date</th>
				<th>Options</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${mytrips}" var="mytrip">
				<c:if test="${mytrip.creatorid == user.id}">
				<tr>
					<td><c:out value="${mytrip.destination}" /></td>
					<td><c:out value="${mytrip.departure}" /></td>
					<td><form action="/trips/${mytrip.id}/edit">
							<input type="submit" value="Edit Trip" />
						</form>
						<form action="/trips/${mytrip.id}/delete" method="post">
							<input type="submit" value="Delete Trip" />
						</form></td>
						
				</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<form action="/home">
		<input type="submit" value="Home" />
	</form>
</body>
</html>