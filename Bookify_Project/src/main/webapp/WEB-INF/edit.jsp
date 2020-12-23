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
	<h1>
		<c:out value="${trip.destination}" />
	</h1>
	<p>
		<c:out value="${error}" />
	</p>
	<form:form action="/trips/${trip.id}/edit" method="POST"
		modelAttribute="trip">
			<form:label path="destination">Destination</form:label>
			<form:errors path="destination" />
			<form:input path="destination" placeholder="${trip.destination}" />
			<form:label path="departure">Departure</form:label>
			<form:errors path="departure" />
			<form:input type="date" path="departure"
				placeholder="${trip.departure}" />
		<p>
			<input type="submit" value="Update" />
		</p>
	</form:form>
	<form action="/trips/${trip.id}/delete" method="POST">
		<p>
			<input type="submit" value="Delete" />
		</p>
	</form>
</body>
</html>