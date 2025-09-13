<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Profile</title>
</head>
<body>
    <h2>Profile Details</h2>
    <p><strong>Username:</strong> ${sessionScope.user.username}</p>
    <p><strong>Full Name:</strong> ${sessionScope.user.fullname}</p>
    <p><strong>Phone:</strong> ${sessionScope.user.phone}</p>
    <p><strong>Role:</strong> <c:choose><c:when test="${sessionScope.user.roleid == 1}">User</c:when><c:when test="${sessionScope.user.roleid == 2}">Manager</c:when><c:otherwise>Admin</c:otherwise></c:choose></p>
    <p><strong>Image:</strong></p>
    <img src="${pageContext.request.contextPath}/resources/images/users/${sessionScope.user.image}" alt="Profile Image" width="200" onerror="this.src='${pageContext.request.contextPath}/resources/images/default-user.png'"/>
    <br/>
    <a href="${pageContext.request.contextPath}/<c:choose><c:when test="${sessionScope.user.roleid == 1}">user</c:when><c:when test="${sessionScope.user.roleid == 2}">manager</c:when><c:otherwise>admin</c:otherwise></c:choose>/profile">Edit Profile</a>
    <a href="${pageContext.request.contextPath}/<c:choose><c:when test="${sessionScope.user.roleid == 1}">user</c:when><c:when test="${sessionScope.user.roleid == 2}">manager</c:when><c:otherwise>admin</c:otherwise></c:choose>/home">Back to Home</a>
</body>
</html>