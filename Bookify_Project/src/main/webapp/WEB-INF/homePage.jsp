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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
	<div>
		<h1>
			Welcome to Bookify
		</h1>
		<ul>
			<li><a href="/logout" class="badge badge-logout">Logout</a></li>
			<li><a href="/users/${user.id}" class="badge badge-myTrips">My Trips</a></li>
		</ul>
	</div>
	<div>
		<h1>Current Trips:</h1>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">Destination</th>
					<th scope="col">Departure Date</th>
					<th scope="col">Options</th>
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