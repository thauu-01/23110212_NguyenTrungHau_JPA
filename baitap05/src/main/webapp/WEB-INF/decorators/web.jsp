<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property="title" /></title>
</head>
<body>
    <%@ include file="/user/header.jsp" %>

    <div class="container mt-4">
        <sitemesh:write property="body" />
    </div>

    <%@ include file="/user/footer.jsp" %>
</body>
</html>
