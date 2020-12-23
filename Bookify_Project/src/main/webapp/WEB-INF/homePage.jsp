<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bookify</title>
</head>
<body>
	<div>
		<h1>
			Welcome to Bookify
		</h1>
		<ul>
			<li><a href="/logout">Logout</a></li>
			<li><a href="/users/${user.id}">My Trips</a></li>
		</ul>
	</div>
	<div>
		<h1>Current Trips:</h1>
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
						<td><form action="/trips/${trip.id}">
								<input type="submit" value="Show Trip Details">
							</form></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>
		<h1>Create A New Trip:</h1>
		<form:form action="/trips" method="post" modelAttribute="trip">
			<p>
				<form:label path="destination">Destination:</form:label>
				<form:errors path="destination" />
				<form:input path="destination" />
			</p>
			<p>
				<form:label path="departure">Departure Date:</form:label>
				<form:errors path="departure" />
				<form:input path="departure" type="date" />
			</p>
			<input type="submit" value="Submit" />
		</form:form>
	</div>
</body>
</html>