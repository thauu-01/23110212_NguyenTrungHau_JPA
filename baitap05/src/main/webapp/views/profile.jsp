<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile</title>
</head>
<body>
    <h2>Update Profile</h2>
    <c:if test="${not empty error}">
        <p style="color: red">${error}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/<c:choose><c:when test="${sessionScope.user.roleid == 1}">user</c:when><c:when test="${sessionScope.user.roleid == 2}">manager</c:when><c:otherwise>admin</c:otherwise></c:choose>/profile" method="post" enctype="multipart/form-data">
        <label>Full Name:</label>
        <input type="text" name="fullname" value="${sessionScope.user.fullname}" /><br/>
        <label>Phone:</label>
        <input type="text" name="phone" value="${sessionScope.user.phone}" /><br/>
        <label>Current Image:</label>
        <img src="${pageContext.request.contextPath}/resources/images/users/${sessionScope.user.image}" alt="Profile Image" width="100" onerror="this.src='${pageContext.request.contextPath}/resources/images/default-user.png'"/><br/>
        <label>Upload New Image:</label>
        <input type="file" name="image" accept="image/*" /><br/>
        <input type="submit" value="Update Profile" />
    </form>
    <a href="${pageContext.request.contextPath}/<c:choose><c:when test="${sessionScope.user.roleid == 1}">user</c:when><c:when test="${sessionScope.user.roleid == 2}">manager</c:when><c:otherwise>admin</c:otherwise></c:choose>/home">Back to Home</a>
</body>
</html>