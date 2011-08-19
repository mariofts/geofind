<head>
	<title>Location [index]</title>
</head>
<body>
	<h1>Listing Locations</h1>

	<table>
		<tr>
			<th>query</th>
			<th></th>
			<th></th>
			<th></th>
		</tr>

		<c:forEach items="${locationList}" var="location">
			<tr>
				<td>${location.query}</td>
				<td><a href="${pageContext.request.contextPath}/locations/${location.id}">show</a></td>
				<td><a href="${pageContext.request.contextPath}/locations/${location.id}/edit">edit</a></td>
				<td>
					<form action="${pageContext.request.contextPath}/locations/${location.id}" method="post">
						<input type="hidden" name="_method" value="delete"/>
						<button type="submit" onclick="return confirm('Are you sure?')">destroy</button>
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>

	<br />
	<a href="${pageContext.request.contextPath}/locations/new">New Location</a> 
</body>