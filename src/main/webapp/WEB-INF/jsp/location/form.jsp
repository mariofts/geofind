<c:if test="${not empty errors}">
	<c:forEach items="${errors}" var="error">
		${error.category} - ${error.message}<br />
	</c:forEach>
</c:if>

<form action="${pageContext.request.contextPath}/locations" method="post">
  
	<c:if test="${not empty location.id}">
		<input type="hidden" name="location.id" value="${location.id}"/>
		<input type="hidden" name="_method" value="put"/>
	</c:if>

	<div class="field">
		Query:<br />
		<input type="text" name="location.query" value="${location.query}"/>
	</div>

<div class="actions">
	<button type="submit">send</button>
	</div>
</form>

<a href="${pageContext.request.contextPath}/locations">Back</a>
