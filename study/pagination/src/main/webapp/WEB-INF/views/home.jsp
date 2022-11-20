<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
 <head>
    <title>Pagination</title>
    <!-- Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
  </head>
<body>

    <article class="article">
      <ul class="contents"></ul>
      <div class="buttons"></div>
    </article>


	<!-- Scripts -->
	<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
	 
</body>
</html>
