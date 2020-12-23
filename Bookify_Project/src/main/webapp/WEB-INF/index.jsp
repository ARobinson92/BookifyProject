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
	<div class="topbanner">
		<h1>Bookify</h1>
	</div>
	<div class="topbar">
		<h2>Please Log In or Register for an Account:</h2>
	</div>
	<div class="bodycolumn">
		<p>
			<c:out value="${error}" />
		</p>
		<form method="post" action="/login">
			<p>
				<label for="email">Email</label> <input type="text" id="email"
					name="email" />
			</p>
			<p>
				<label for="password">Password</label> <input type="password"
					id="password" name="password" />
			</p>
			<input type="submit" value="Login!" />
		</form>
	</div>
	<div class="bodycolumn">
		<p>
			<form:errors path="user.*" />
		</p>

		<form:form method="POST" action="/registration" modelAttribute="user">
			<p>
				<form:label path="email">Email:</form:label>
				<form:input type="email" path="email" />
			</p>
			<p>
				<form:label path="password">Password:</form:label>
				<form:password path="password" />
			</p>
			<p>
				<form:label path="passwordConfirmation">Password Confirmation:</form:label>
				<form:password path="passwordConfirmation" />
			</p>
			<input type="submit" value="Register!" />
		</form:form>
	</div>
</body>
</html>